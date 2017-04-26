defmodule PhoenixElmBoilerplate.UserService do
  use PhoenixElmBoilerplate.Web, :service

  alias PhoenixElmBoilerplate.{Repo, User, Email, Mailer}

  def insert(conn, changeset, params, locale) do
    Multi.new
    |> Multi.insert(:user, changeset)
    |> Multi.run(:send_welcome_email, &(send_welcome_email(conn, params, &1[:user])))
  end
  
  def send_welcome_email(conn, params, user) do
    user
    |> Email.welcome_email
    |> Mailer.deliver_later
    {:ok, conn}
  end
end
