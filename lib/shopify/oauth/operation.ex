defmodule Shopify.OAuth.Operation do
  @type t ::
          %__MODULE__{
            method: Shopify.OAuth.http_method_t(),
            params: map,
            path: String.t()
          }

  defstruct method: nil, params: %{}, path: nil
end
