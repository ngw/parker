defmodule Parker.Adapter do
  @moduledoc ~S"""
  An Adapter is used by a Fetcher to retrieve a resource and create
  a Parker.Element out of it.
  """
  @callback get(String.t) :: {:ok, term} | {:error, term}
end
