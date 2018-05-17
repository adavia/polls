defmodule Snappy.Repo.Migrations.AddPollsTable do
  use Ecto.Migration

  def change do
  	create table("polls") do
  		add :title, :string
  		add :description, :text
  		add :user_id, references(:users, on_delete: :nothing)

     	timestamps()
  	end

  	create index(:polls, [:user_id])
  end
end
