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
  |> Shopify.OAuth.request(%{host: "some-shop.myshopify.com"})
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
* `:retry` - whether to automatically retry failed API calls. May bee `true` or
  `false`. Defaults to `false`.
* `:retry_opts` - options used when performing retries. Defaults to `[]`.
  * `:max_attempts` - the maximum number of retry attempts. Defaults to `3`.
