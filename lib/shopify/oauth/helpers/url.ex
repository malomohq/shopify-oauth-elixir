defmodule Shopify.OAuth.Helpers.URL do
  @moduledoc false

  alias Shopify.OAuth.{ Config }

  @spec to_string(Config.t()) :: String.t()
  def to_string(config) do
    config
    |> to_uri()
    |> URI.to_string()
  end

  @spec to_uri(Config.t()) :: URI.t()
  def to_uri(config) do
    uri = %URI{ path: config.path, port: config.port, scheme: config.protocol }
    uri = put_host(uri, config)

    uri
  end

  defp put_host(uri, %{ shop: shop } = config) when not is_nil(shop) do
    Map.put(uri, :host, "#{shop}.#{config.host}")
  end

  defp put_host(uri, config) do
    Map.put(uri, :host, config.host)
  end
end
