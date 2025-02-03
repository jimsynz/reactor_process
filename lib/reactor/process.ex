defmodule Reactor.Process do
  @moduledoc """
  An extensions which provides steps for working with supervisors.
  """

  use Spark.Dsl.Extension,
    dsl_patches:
      Enum.map(
        [],
        &%Spark.Dsl.Patch.AddEntity{section_path: [:reactor], entity: &1.__entity__()}
      )
end
