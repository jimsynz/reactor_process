defmodule Support.StubServer do
  @moduledoc false
  use GenServer

  @doc false
  @impl true
  def init(options) do
    case options[:on_init] do
      fun when is_function(fun, 0) -> fun.()
      result -> result
    end
  end
end
