defmodule Shopify.OAuth.Config do
  @type t ::
          %__MODULE__{
            headers: Shopify.OAuth.http_headers_t(),
            host: String.t(),
            http_client: module,
            http_client_opts: any,
            json_codec: module,
            path: String.t(),
            port: String.t(),
            protocol: String.t(),
            retry: boolean,
            retry_opts: Keyword.t(),
            shop: String.t()
          }
  defstruct headers: [],
            host: "myshopify.com",
            http_client: Shopify.OAuth.Client.Hackney,
            http_client_opts: [],
            json_codec: Jason,
            path: "/admin",
            port: nil,
            protocol: "https",
            retry: false,
            retry_opts: [],
            shop: nil

  @spec new(map) :: t
  def new(config \\ %{}) do
    struct(%__MODULE__{}, config)
  end
end
