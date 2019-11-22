defmodule Brazex.HttpClientTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  describe "#get" do
    test "successfully get the data" do
      Brazex.HttpClientMock
      |> expect(:get, fn "https://example.com" -> {:ok, %{message: "success"}} end)

      assert {:ok, %{message: "success"}} = Brazex.HttpClientMock.get("https://example.com")
    end

    test "error with 404 response" do
      Brazex.HttpClientMock
      |> expect(:get, fn "https://website_not_found.com" ->
        {:error, %{error: "404 Not found"}}
      end)

      assert {:error, %{error: "404 Not found"}} =
               Brazex.HttpClientMock.get("https://website_not_found.com")
    end

    test "error with error response" do
      Brazex.HttpClientMock
      |> expect(:get, fn "https://example.com" ->
        {:error, %{error: "Something went wrong"}}
      end)

      assert {:error, %{error: "Something went wrong"}} =
               Brazex.HttpClientMock.get("https://example.com")
    end
  end

  describe "#post" do
    test "successfully post the data" do
      Brazex.HttpClientMock
      |> expect(:post, fn "https://example.com", _ -> {:ok, %{message: "success"}} end)

      assert {:ok, %{message: "success"}} = Brazex.HttpClientMock.post("https://example.com", "")
    end

    test "error with 404 response" do
      Brazex.HttpClientMock
      |> expect(:post, fn "https://website_not_found.com", "" ->
        {:error, %{error: "404 Not found"}}
      end)

      assert {:error, %{error: "404 Not found"}} =
               Brazex.HttpClientMock.post("https://website_not_found.com", "")
    end

    test "error with error response" do
      Brazex.HttpClientMock
      |> expect(:post, fn "https://example.com", "" ->
        {:error, %{error: "Something went wrong"}}
      end)

      assert {:error, %{error: "Something went wrong"}} =
               Brazex.HttpClientMock.post("https://example.com", "")
    end
  end
end
