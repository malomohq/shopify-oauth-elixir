defmodule Shopify.OAuth do
  alias Shopify.OAuth.{ Config, Operation, Request, Response }

  @type http_headers_t :: [{ String.t(), String.t() }]

  @type http_method_t :: :delete | :get | :post | :put

  @type response_t :: { :ok, Response.t() } | { :error, Response.t() | any }

  @doc """
  Create an access token.
  """
  @spec create_access_token(map) :: Operation.t()
  def create_access_token(params) do
    %Operation{ method: :post, params: params, path: "/oauth/access_token" }
  end

  @doc """
  Send a request to Shopify.
  """
  @spec request(Operation.t(), Config.t()) :: response_t
  def request(operation, config) do
    Request.send(operation, Config.new(config))
  end

  @doc """
  Ensures an HTTP query string passes HMAC verification.

  See `verify_hmac/3` for more details.

  ## Example

      query = "code=0907a61c0c8d55e99db179b68161bc00&hmac=700e2dadb827fcc8609e9d5ce208b2e9cdaab9df07390d2cbca10d7c328fc4bf&shop=some-shop.myshopify.com&state=0.6784241404160823&timestamp=1337178173"
      shared_secret = "hush"

      {:ok, hmac} = Shopify.OAuth.verify_hmac(query, shared_secret)
  """
  @spec verify_hmac(String.t(), String.t()) ::
          { :ok, String.t() } | { :error, String.t() }
  def verify_hmac(query, shared_secret) do
    decoded_query = URI.decode_query(query)

    { hmac, decoded_message } = Map.pop(decoded_query, "hmac")

    message = URI.encode_query(decoded_message)

    verify_hmac(hmac, message, shared_secret)
  end

  @doc """
  Verifies the Shopify HMAC signature.

  This function will compute an SHA256 HMAC digest based on the provided
  `message` and `shared_secret`. The digest is then compared to the `hmac`
  signature. If they match, verification has passed. Otherwise verification
  has failed.

  ## Example

      hmac = "700e2dadb827fcc8609e9d5ce208b2e9cdaab9df07390d2cbca10d7c328fc4bf"
      message = "code=0907a61c0c8d55e99db179b68161bc00&shop=some-shop.myshopify.com&timestamp=1337178173"
      shared_secret = "hush"

      {:ok, hmac} = Shopify.HMAC.verify(hmac, message, shared_secret)
  """
  @spec verify_hmac(String.t(), String.t(), String.t()) ::
          { :ok, String.t() } | { :error, String.t() }
  def verify_hmac(hmac, message, shared_secret) do
    digest =
      :crypto.hmac(:sha256, shared_secret, message)
      |> Base.encode16()
      |> String.downcase()

    case digest do
      ^hmac ->
        { :ok, digest }
      _otherwise ->
        { :error, digest }
    end
  end
end
