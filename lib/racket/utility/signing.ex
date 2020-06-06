defmodule Racket.Utility.Signing do
  @spec sign(String.t, map()) :: map()
  def sign(key, headers) do
    #TODO: Order headers alphabetically
    Map.put_new(headers, :sign, hmac_sha256(key, payload(headers)))
  end

  @spec payload(map()) :: String.t
  def payload(headers) do
    Map.keys(headers)
    |> Enum.map(fn key -> "#{key}=#{headers[key]}" end)
    |> Enum.join("&")
  end

  @spec hmac_sha256(String.t, String.t) :: String.t
  def hmac_sha256(key, payload) do
    :crypto.hmac(:sha256, key, payload) |> Base.encode16
  end
end
