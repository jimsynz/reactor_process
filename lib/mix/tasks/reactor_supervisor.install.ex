if Code.ensure_loaded?(Igniter) do
  defmodule Mix.Tasks.ReactorSupervisor.Install do
    @moduledoc """
    Installs Reactor.Supervisor into a project.  Should be called with `mix igniter.install reactor_supervisor`.
    """

    alias Igniter.{Mix.Task, Project.Formatter}

    use Task

    @doc false
    @impl Task
    def igniter(igniter, _argv) do
      igniter
      |> Formatter.import_dep(:reactor_supervisor)
    end
  end
else
  defmodule Mix.Tasks.ReactorSupervisor.Install do
    @moduledoc """
    Installs Reactor.Supervisor into a project.  Should be called with `mix igniter.install reactor_supervisor`.
    """

    use Mix.Task

    def run(_argv) do
      Mix.shell().error("""
      The task 'reactor_supervisor.install' requires igniter to be run.

      Please install igniter and try again.

      For more information, see: https://hexdocs.pm/igniter
      """)

      exit({:shutdown, 1})
    end
  end
end
