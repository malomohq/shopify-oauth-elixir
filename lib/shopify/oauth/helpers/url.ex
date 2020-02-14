defmodule Shopify.OAuth.Helpers.URL do
  @moduledoc false

  alias Shopify.OAuth.{ Config, Operation }

  @spec to_string(Operation.t(), Config.t()) :: String.t()
  def to_string(operation, config) do
    operation
    |> to_uri(config)
    |> URI.to_string()
  end

  @spec to_uri(Operation.t(), Config.t()) :: URI.t()
  def to_uri(operation, config) do
    %URI{}
    |> Map.put(:path, "#{config.path}#{operation.path}")
    |> Map.put(:port, config.port)
    |> Map.put(:scheme, config.protocol)
    |> put_host(config)
    |> put_query(operation)
  end

  defp put_host(uri, %{ shop: shop } = config) when not is_nil(shop) do
    Map.put(uri, :host, "#{shop}.#{config.host}")
  end

  defp put_host(uri, config) do
    Map.put(uri, :host, config.host)
  end

  defp put_query(uri, %{ method: :get } = operation) do
    Map.put(uri, :query, URI.encode_query(operation.params))
  end

  defp put_query(uri, _operation) do
    uri
  end
end
