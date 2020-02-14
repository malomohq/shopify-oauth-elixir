defmodule Shopify.OAuth do
  alias Shopify.OAuth.{ Config, Operation, Request, Response }

  @type http_headers_t :: [{ String.t(), String.t() }]

  @type http_method_t :: :delete | :get | :post | :put

  @type response_t :: { :ok, Response.t() } | { :error, Response.t() | any }

  @doc """
  Send a request to Shopify.
  """
  @spec request(Operation.t(), Config.t()) :: response_t
  def request(operation, config) do
    Request.send(operation, Config.new(config))
  end
end
