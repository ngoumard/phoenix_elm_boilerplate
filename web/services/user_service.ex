defmodule PhoenixElmBoilerplate.UserService do
  use PhoenixElmBoilerplate.Web, :service

  alias PhoenixElmBoilerplate.{Repo, User}

  def insert(conn, changeset, params, locale) do
    Multi.new
    |> Multi.insert(:user, changeset)
    # |> Multi.run(:send_welcome_email, &(send_welcome_email(conn, params, &1[:user])))
  end
  # TODO : Add welcome email
  # def send_welcome_email(conn, params, user) do
  #   user
  #   |> Email.welcome_email
  #   |> Mailer.deliver_later
  #   {:ok, conn}
  # end
end
