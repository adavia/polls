defmodule Snappy.Votes.Poll do
	use Ecto.Schema
	import Ecto.Changeset
	alias Snappy.Votes.Poll

	schema "polls" do
		field :title, :string
		field :description, :string
		belongs_to :user, Snappy.Accounts.User
		has_one :image, Snappy.Votes.Image
		has_many :options, Snappy.Votes.Option
		has_many :vote_records, Snappy.Votes.VoteRecord
		has_many :messages, Snappy.Votes.Message

		# Virtual
		field :poll_options, :string, virtual: true

		timestamps()
	end

	def changeset(%Poll{} = poll, attrs) do
		poll
		|> cast(attrs, [:title, :description, :user_id, :poll_options])
		|> validate_required([:title, :user_id, :poll_options])
	end
end