defmodule ParkerTest.Adapter.FakeHTTP do
  @behaviour Parker.Fetcher.Adapter

  def get("http://example.com") do
    {:ok, %Parker.Element{uid: "http://example.com",
                          meta: [],
                          body: "<html><body><p>TEST<p></body></html>"}}
  end

  def get("http://errors.info") do
    {:error, %{response: nil, status: :failed}}
  end
end
