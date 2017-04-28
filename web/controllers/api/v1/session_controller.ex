defmodule PhoenixElmBoilerplate.V1.SessionController do
  use PhoenixElmBoilerplate.Web, :controller
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  alias PhoenixElmBoilerplate.{GuardianSerializer, Repo, User}

  def create(conn, params = %{"email" => email, "password" => password}) do
    case login_by_email_and_pass(params) do
      {:ok, user} ->
        {:ok, jwt, claims} = user |> Guardian.encode_and_sign(:token)

        conn
        |> Plug.Conn.assign(:current_user, user)
        |> put_status(:created)
        |> render(PhoenixElmBoilerplate.SessionView, "show.json", jwt: jwt, user_id: user.id)

      {:error, reason} -> handle_unauthenticated(conn, reason)
    end
  end

  defp handle_unauthenticated(conn, reason) do
    conn
    |> put_status(:unauthorized)
    |> render(PhoenixElmBoilerplate.SessionView, "401.json", message: reason)
  end

  defp login_by_email_and_pass(%{"email" => email, "password" => password}) do
    user = Repo.get_by(User, email: String.downcase(email))
    cond do
      user && checkpw(password, user.encrypted_password) ->
        {:ok, user}
      user ->
        {:error, gettext("Your password doesn't match the email")}
      true ->
        dummy_checkpw()
        {:error, "We couldn't find a user with the email #{email}."}
    end
  end
end
