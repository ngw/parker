defmodule ParkerTest.Adapter.HTTP.HTTPipe do
  use ExUnit.Case

  @moduletag :external

  test "gets an url" do
    {:ok, element} = Parker.Adapter.HTTP.HTTPipe.get("http://example.com")
    assert Regex.match?(~r/Example Domain/, element.body)
  end

  test "errors when url is non existant" do
    {:error, conn} = Parker.Adapter.HTTP.HTTPipe.get("http://non_existant")
    assert conn.status == :failed
    assert Regex.match?(~r/Hackney encountered an error/, conn.error.message)
  end
end
