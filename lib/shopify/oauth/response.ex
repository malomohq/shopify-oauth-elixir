defmodule Shopify.OAuth.Response do
  alias Shopify.OAuth.{ Client, Config, Helpers }

  @type t ::
          %__MODULE__{
            body: map | String.t(),
            headers: Shopify.OAuth.http_headers_t(),
            private: map,
            status_code: pos_integer
          }

  defstruct body: nil,
            headers: nil,
            private: %{},
            status_code: nil

  @spec new(Client.response_t(), Config.t(), map) :: t
  def new(response, private, config) do
    %__MODULE__{
      body: Helpers.JSON.decode(response[:body], config),
      headers: response[:headers],
      private: private,
      status_code: response[:status_code]
    }
  end
end
