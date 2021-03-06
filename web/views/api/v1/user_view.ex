defmodule PhoenixElmBoilerplate.UserView do
  use PhoenixElmBoilerplate.Web, :view

  def render("login.json", %{jwt: jwt, user_id: user_id}) do
    %{
      jwt: jwt,
      user_id: user_id
    }
  end

  def render("show.json", %{user: user}) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      locale: user.locale,
      email: user.email
    }
  end

  def render("error.json", %{changeset: changeset}) do
    errors = Enum.map(changeset.errors, fn {field, detail} ->
      %{} |> Map.put(field, render_detail(detail))
    end)

    %{
      errors: errors
    }
  end

  defp render_detail({message, values}) do
    Enum.reduce(values, message, fn {k, v}, acc -> String.replace(acc, "%{#{k}}", to_string(v)) end)
  end

  defp render_detail(message) do
    message
  end
end
