defmodule Brazex.User do
  @moduledoc """
    Import User Data to Braze
  """

  def http_client, do: Application.get_env(:brazex, :http_client)

  def track(external_id, attributes, opts \\ []) when is_list(opts) do
    url = Keyword.get(opts, :url)
    api_key = Keyword.get(opts, :api_key)

    "#{url}/users/track"
    |> http_client().post(format_request(external_id, attributes, api_key))
  end

  defp format_request(external_id, attributes, api_key) do
    %{
      api_key: api_key,
      attributes: [
        Map.merge(attributes, %{external_id: external_id})
      ]
    }
    |> Jason.encode!()
  end
end

defmodule Brazex.Response do
  @moduledoc false

  @derive Jason.Encoder
  defstruct message: nil,
            attributes_processed: nil,
            events_processed: nil,
            purchased_processed: nil,
            errors: nil

  @type t :: %__MODULE__{
          message: String.t(),
          attributes_processed: integer(),
          events_processed: integer(),
          purchased_processed: integer(),
          errors: list()
        }
end

defmodule Brazex do
  @moduledoc """
  Documentation for Brazex.
  """

  @doc """
  Import User data to Braze

  ## Examples

      iex> Brazex.hello()
      :world

  """
  def hello do
    :world
  end
end
