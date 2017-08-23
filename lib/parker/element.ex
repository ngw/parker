defmodule Parker.Element do
  @moduledoc ~S"""
  The struct representing a resource.
  """
  alias Parker.Element

  @typedoc """
  The `Parker.Element` struct type.
  Fields' meaning:
  - `:uid` - unique id
  - `:meta` - metadata
  - `:priority` - integer
  - `:body` - body
  """
  @type t :: %Element{
    uid: String.t,
    meta: struct,
    priority: Integer.t,
    body: String.t
  }
  defstruct [
    :uid,
    :priority,
    meta: %{},
    body: ""
  ]
end
