defmodule Parker.Adapter.HTTP.HTTPipe do
  @behaviour Parker.Adapter

  def get(url) do
    case HTTPipe.get(url) do
      {:ok, conn} -> {:ok, %Parker.Element{uid:  url,
                                           meta: conn.response.headers,
                                           body: conn.response.body}}
      {:error, reason} -> {:error, reason}
    end
  end
end
