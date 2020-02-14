defmodule Shopify.OAuth.Helpers.Headers do
  @moduledoc false

  alias Shopify.OAuth.{ Config }

  @spec new(Config.t()) :: Shopify.OAuth.http_headers_t()
  def new(config) do
    []
    ++ [{ "content-type", "application/json" }]
    ++ config.headers
  end
end
