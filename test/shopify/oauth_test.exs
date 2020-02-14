defmodule Shopify.OAuthTest do
  use ExUnit.Case, async: true

  test "verify_hmac/2" do
    query = "code=0907a61c0c8d55e99db179b68161bc00&hmac=700e2dadb827fcc8609e9d5ce208b2e9cdaab9df07390d2cbca10d7c328fc4bf&shop=some-shop.myshopify.com&state=0.6784241404160823&timestamp=1337178173"

    hmac = "700e2dadb827fcc8609e9d5ce208b2e9cdaab9df07390d2cbca10d7c328fc4bf"

    shared_secret = "hush"

    assert { :ok, ^hmac } = Shopify.OAuth.verify_hmac(query, shared_secret)
  end

  test "verify_hmac/3" do
    hmac = "700e2dadb827fcc8609e9d5ce208b2e9cdaab9df07390d2cbca10d7c328fc4bf"

    message = "code=0907a61c0c8d55e99db179b68161bc00&shop=some-shop.myshopify.com&state=0.6784241404160823&timestamp=1337178173"

    shared_secret = "hush"

    assert { :ok, ^hmac } = Shopify.OAuth.verify_hmac(hmac, message, shared_secret)
  end
end
