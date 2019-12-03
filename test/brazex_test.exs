defmodule BrazexTest do
  use ExUnit.Case
  doctest Brazex

  alias Brazex.User

  import Mox

  setup :verify_on_exit!

  describe "#track" do
    test "import successfully" do
      Brazex.HttpClientMock
      |> expect(:post, fn "https://rest.iad-01.braze.com/users/track", _ ->
        {:ok, %{message: "success"}}
      end)

      User.track("0E17C156-06BD-4DCF-A2B1-3CB7D60A42B2", %{favortie_color: "blue"},
        url: "https://rest.iad-01.braze.com",
        api_key: "api-key"
      )
    end
  end

  test "greets the world" do
    assert Brazex.hello() == :world
  end
end
