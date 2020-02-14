defmodule Shopify.OAuth.Client.Hackney do
  alias Shopify.OAuth.{ Client }

  @behaviour Shopify.OAuth.Client

  @spec request(
          Shopify.OAuth.http_method_t(),
          String.t(),
          Shopify.OAuth.http_headers_t(),
          String.t(),
          any
        ) :: { :ok, Client.response_t() } | { :error, any }
  def request(method, url, headers, body, opts) do
    opts = opts ++ [:with_body]

    response =
      :hackney.request(
        method,
        url,
        headers,
        body,
        opts
      )

    case response do
      { :ok, status_code, headers } ->
        { :ok, %{ body: "", headers: headers, status_code: status_code } }
      { :ok, status_code, headers, body } ->
        { :ok, %{ body: body, headers: headers, status_code: status_code } }
      _otherwise ->
        response
    end
  end
end
