defmodule ParkerTest.Fetcher do
  use ExUnit.Case
  doctest Parker.Fetcher

  test "starts a fetcher" do
    {:ok, _fetcher} = GenStage.start_link(Parker.Fetcher,
      [targets: [], adapter: ParkerTest.Adapter.FakeHTTPAdapter], [])
  end

  test "fetcher calls the adapter" do
    {:ok, fetcher} = GenStage.start_link(Parker.Fetcher,
      [targets: ["http://example.com"], adapter: ParkerTest.Adapter.FakeHTTP], [])
    {:ok, _cons} = ParkerTest.Consumer.start_link(fetcher)
    assert_receive {:received, events}
    assert events == [{:ok, %Parker.Element{body: "<html><body><p>TEST<p></body></html>",
                                            meta: [],
                                            uid: "http://example.com"}}]
  end

  test "fetcher handles errors" do
    {:ok, fetcher} = GenStage.start_link(Parker.Fetcher,
      [targets: ["http://errors.info"], adapter: ParkerTest.Adapter.FakeHTTP], [])
    {:ok, _cons} = ParkerTest.Consumer.start_link(fetcher)
    assert_receive {:received, error}
    assert error == [error: %{response: nil, status: :failed}]
  end
end
