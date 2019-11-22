defmodule Brazex.HttpClient do
  @moduledoc false
  @type response :: {:ok, map()} | {:error, map()}
  @callback post(String.t(), String.t()) :: response
  @callback post(String.t(), String.t(), map() | nil) :: response
  @callback get(String.t()) :: response

  def post(url, body \\ "", options \\ nil) do
    url
    |> HTTPoison.post(body, options)
    |> parse_response()
  end

  def get(url) do
    url
    |> HTTPoison.get()
    |> parse_response()
  end

  defp parse_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, %{error: "404 Not found"}}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{error: reason}}
    end
  end
end
