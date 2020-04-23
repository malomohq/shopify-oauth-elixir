# Shopify.OAuth

## Installation

`Shopify.OAuth` is published on [Hex](https://hex.pm/packages/shopify_oauth).
Add it to your list of dependencies in `mix.exs`;

```elixir
defp deps do
  { :shopify_oauth, "~> 1.0" }
end
```

`Shopify.OAuth` requires you to provide an HTTP client and a JSON codec.
`hackney` and `jason` are used by default. If you wish to use these defaults you
will need to specify `hackney` and `jason` as dependencies as well.

## Usage

```elixir
{:ok, response} =
  %{client_id: "49f754092e83a76bf4e49ab6feb3f8b9", client_secret: "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", code: "f5be881c575fedf9491d26aff123ace7"}
  |> Shopify.OAuth.create_access_token()
  |> Shopify.OAuth.request(%{shop: "some-shop"})
```

### Verifying HMAC Signatures

`Shopify.OAuth` provides `verify_hmac/2` and `verify_hmac/3` functions for
verifying HMAC signatures returned by the Shopify API.

Please see the Shopify [Authentication with OAuth](https://shopify.dev/tutorials/authenticate-with-oauth#verification)
documentation for the technical details regarding HMAC verification.

**`verify_hmac/2`**

```elixir
query = "code=0907a61c0c8d55e99db179b68161bc00&hmac=700e2dadb827fcc8609e9d5ce208b2e9cdaab9df07390d2cbca10d7c328fc4bf&shop=some-shop.myshopify.com&state=0.6784241404160823&timestamp=1337178173"
shared_secret = "hush"

{:ok, hmac} = Shopify.OAuth.verify_hmac(query, shared_secret)
```

**`verify_hmac/3`**

```elixir
hmac = "700e2dadb827fcc8609e9d5ce208b2e9cdaab9df07390d2cbca10d7c328fc4bf"
message = "code=0907a61c0c8d55e99db179b68161bc00&shop=some-shop.myshopify.com&timestamp=1337178173"
shared_secret = "hush"

{:ok, hmac} = Shopify.OAuth.verify_hmac(hmac, message, shared_secret)
```

## Configuration

Configuration is passed as a map to the second argument of
`Shopify.OAuth.request/2`.

* `:host` - HTTP host to make requests to. Defaults to `myshopify.com`.
* `:http_client` - the HTTP client used for making requests. Defaults to
  `Shopify.OAuth.Client.Hackney`.
* `:http_client_opts` - additional options passed to `:http_client`. Defaults to
  `[]`.
* `:json_codec` - codec for encoding and decoding JSON payloads. Defaults to
  `Jason`.
* `:path` - path to prefix on each request. Defaults to `/admin`.
* `:port` - the HTTP port used when making a request
* `:protocol` - the HTTP protocol used when making a request. Defaults to
  `https`.
* `:retry` - whether to automatically retry failed API calls. May be `true` or
  `false`. Defaults to `false`.
* `:retry_opts` - options used when performing retries. Defaults to `[]`.
  * `:max_attempts` - the maximum number of retry attempts. Defaults to `3`.
* `:shop` - subdomain of the shop that a request is to be made to
