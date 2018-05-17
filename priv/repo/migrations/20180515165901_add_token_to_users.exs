defmodule Snappy.Repo.Migrations.AddTokenToUsers do
  use Ecto.Migration

  def change do
  	alter table(:users) do
  		add :token, :string
  		add :provider, :string
  	end
  end
end
