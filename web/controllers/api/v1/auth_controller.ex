defmodule PhoenixElmBoilerplate.V1.AuthController do
  use PhoenixElmBoilerplate.Web, :controller
  plug Ueberauth

  alias PhoenixElmBoilerplate.UserAuthService

  def callback(%Plug.Conn{assigns: %{ueberauth_failure: fails}} = conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> render(PhoenixElmBoilerplate.SessionView, "401.json", message: hd(fails.errors).message)
  end

  def callback(%Plug.Conn{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    locale = conn.assigns[:locale]
    case UserAuthService.get_or_insert(auth, locale) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)
        conn
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

end
