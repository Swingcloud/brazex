defmodule Brazex.HttpClient do
  @moduledoc false
  @type response :: {:ok, map()} | {:error, map()}
  @callback post(String.t(), String.t()) :: response
  @callback post(String.t(), String.t(), map() | nil) :: response
  @callback get(String.t()) :: response

  def post(url, body \\ "", options \\ nil) do
    case HTTPoison.post(url, body, options) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, %{}}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, %{error: "Not found"}}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{error: reason}}
    end
  end

  def get(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, %{error: "Not found"}}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{error: reason}}
    end
  end
end
