defmodule Brazex.HttpClientTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  describe "#get" do
    Brazex.HttpClientMock
    |> expect(:get, fn "https://example.com" -> {:ok, %{}} end)

    assert {:ok, %{}} = Brazex.HttpClientMock.get("https://example.com")
  end
end
