defmodule Shopify.OAuth.Helpers.HeadersTest do
  use ExUnit.Case, async: true

  alias Shopify.OAuth.{ Config, Helpers }

  test "new/1" do
    additional_header = { "x-additional-header", true }

    headers = Helpers.Headers.new(Config.new(%{ headers: [additional_header] }))

    assert Enum.member?(headers, { "content-type", "application/json" })
    assert Enum.member?(headers, additional_header)
  end
end
