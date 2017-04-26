defmodule PhoenixElmBoilerplate.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias PhoenixElmBoilerplate.{Repo, User}

  def for_token(user = %User{}), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token("User:" <> id), do: {:ok, Repo.get(User, id)}
  def from_token(_), do: {:error, "Unknown resource type"}
end

defmodule PhoenixElmBoilerplate.GuardianErrorHandler do
  use PhoenixElmBoilerplate.Web, :controller
  def unauthenticated(conn, _params) do
    conn
    |> put_status(:unauthorized)
    |> render(PhoenixElmBoilerplate.SessionView, "401.json", message: "unauthenticated")
  end
end
