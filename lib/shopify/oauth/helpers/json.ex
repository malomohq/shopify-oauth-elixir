defmodule Shopify.OAuth.Helpers.JSON do
  @moduledoc false

  alias Shopify.OAuth.{ Config }

  @spec decode(String.t(), Config.t()) :: map
  def decode(string, config) do
    case config.json_codec.decode(string) do
      { :ok, result } ->
        result
      { :error, _reason } ->
        %{}
    end
  end


  @spec encode(map, Config.t()) :: String.t()
  def encode(map, config) do
    case config.json_codec.encode(map) do
      { :ok, result } ->
        result
      { :error, _reason } ->
        ""
    end
  end
end
