defmodule City.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias City.Accounts.User

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :status, :integer
    field :username, :string
     # Virtual fields:
     field :password, :string, virtual: true
     field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :password_confirmation, :status, :username])
    |> validate_required([:email, :password, :password_confirmation, :status, :username])
    |> validate_format(:email, ~r/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/)
    |> validate_length(:password, min: 8) # Check that password length is >= 8
    |> validate_confirmation(:password) # Check that password === password_confirmation
    |> unique_constraint(:email)
    |> put_password_hash # Add put_password_hash to changeset pipeline
  end

  

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
          changeset
    end
  end


end
