defmodule PhoenixElmBoilerplate.User do
  use PhoenixElmBoilerplate.Web, :model
  import PhoenixElmBoilerplate.ValidationHelpers
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :locale, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string

    has_many :authorizations, PhoenixElmBoilerplate.Authorization

    timestamps
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :email, :locale, :last_name])
  end

  def signup_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:email, :password, :locale])
    |> validate_required([:email, :password, :locale])
    |> update_change(:email, &String.downcase/1)
    |> validate_email_format(:email)
    |> unique_constraint(:email, message: "Email already taken")
    |> validate_length(:password, min: 5, max: 128)
    |> validate_inclusion(:locale, PhoenixElmBoilerplate.Gettext.supported_locales)
    |> generate_encrypted_password
  end

  def update_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name])
  end

  defp generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(current_changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        current_changeset
    end
  end
end
