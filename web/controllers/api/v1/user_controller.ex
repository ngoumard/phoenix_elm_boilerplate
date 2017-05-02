defmodule PhoenixElmBoilerplate.V1.UserController do
  use PhoenixElmBoilerplate.Web, :controller
  import Comeonin.Bcrypt, only: [checkpw: 2]

  alias PhoenixElmBoilerplate.{User, UserService}

  def create(conn, params = %{"email" => _, "password" => _}) do
    locale = conn.assigns[:locale]
    params =
      params
      |> Map.put("locale", locale)

    changeset = User.signup_changeset(%User{}, params)

    case Repo.transaction(UserService.insert(conn, changeset, params, locale)) do
      {:ok, %{user: user}} ->
        conn = login(user, conn)
        {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)

        conn
        |> put_status(:created)
        |> render(PhoenixElmBoilerplate.SessionView, "show.json", jwt: jwt, user_id: user.id)

      {:error, _failed_operation, failed_value, _changes_so_far} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixElmBoilerplate.UserView, "error.json", changeset: failed_value)
    end
  end

  defp login(user, conn), do: Plug.Conn.assign(conn, :current_user, user)

  def me(conn, _) do
    current_user = conn.assigns[:current_user]

    conn
    |> put_status(:ok)
    |> render(PhoenixElmBoilerplate.UserView, "show.json", user: current_user)
  end

  def update(conn, params) do
    current_user = conn.assigns[:current_user]

    changeset = User.update_changeset(current_user, params)

    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render(PhoenixElmBoilerplate.UserView, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixElmBoilerplate.UserView, "error.json", changeset: changeset)
    end
  end
end
