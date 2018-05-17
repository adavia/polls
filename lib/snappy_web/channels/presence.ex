defmodule SnappyWeb.Presence do
  use Phoenix.Presence,
    otp_app: :snappy,
    pubsub_server: Snappy.PubSub
end