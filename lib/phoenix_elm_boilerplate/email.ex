defmodule PhoenixElmBoilerplate.Email do
  use Bamboo.Phoenix, view: PhoenixElmBoilerplate.EmailView
  alias PhoenixElmBoilerplate.{User}

  defp welcome_email_subject(%User{locale: locale}) do
    case locale do
      "fr" -> "Bienvenue"
      "en" -> "Welcome"
    end
  end

  def welcome_email(user) do
    new_email
    |> from("PhoenixElmBoilerplate<hello@email.io>")
    |> put_header("Reply-To", "hello@email.io")
    |> to("#{user.email}")
    |> subject("#{welcome_email_subject(user)}")
    |> render("welcome_email_#{if (user.locale), do: user.locale, else: "en"}.text")
  end

end
