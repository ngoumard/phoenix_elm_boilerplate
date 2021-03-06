defmodule PhoenixElmBoilerplate.SessionView do
  use PhoenixElmBoilerplate.Web, :view

  def render("show.json", %{jwt: jwt, user_id: user_id}) do
    %{
      jwt: jwt,
      user_id: user_id
    }
  end

  def render("401.json", %{message: message}) do
    %{
      errors: [
        %{
          id: "UNAUTHORIZED",
          title: "401 Unauthorized",
          detail: message,
          status: 401
        }
      ]
    }
  end

  def render("403.json", %{message: message}) do
    %{
      errors: [
        %{
          id: "FORBIDDEN",
          title: "403 Forbidden",
          detail: message,
          status: 403,
        }
      ]
    }
  end
end
