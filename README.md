# Reactor.Process

[![Build Status](https://drone.harton.dev/api/badges/james/reactor_process/status.svg)](https://drone.harton.dev/james/reactor_process)
[![Hex.pm](https://img.shields.io/hexpm/v/reactor_process.svg)](https://hex.pm/packages/reactor_process)
[![Hippocratic License HL3-FULL](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-FULL&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/full.html)

A [Reactor](https://github.com/ash-project/reactor) extension that provides steps for working with supervisors and processes.

## Example

The following example uses Reactor to start a supervisor and add children to it.

```elixir
defmodule StartAllReposReactor do
  use Reactor, extensions: [Reactor.Process]

  start_supervisor :supervisor

  step :all_repos do
    run fn _ ->
      Application.get_env(:my_app, :ecto_repos)
    end
  end

  map :migrate_all_repos do
    source result(:all_repos)

    step :migrate do
      argument :repo, element(:migrate_all_repos)
      run &migrate_repo/2
    end

    start_child :start_child do
      supervisor result(:supervisor)
      child_spec element(:migrate_all_repos)
    end
  end

  return :supervisor

  defp migrate_repo(args, _context) do
    Ecto.Migrator.with_repo(args.repo, fn repo ->
      with :ok <- repo_create(repo) do
        Ecto.Migrator.run(repo, :up, all: true)
        {:ok, repo}
      end
    end)
  end

  defp repo_create(repo) do
    case repo.__adapter__().storage_up(repo.config()) do
      :ok -> :ok
      {:error, :already_up} -> :ok
      {:error, reason} -> {:error, reason}
    end
  end
end

Reactor.run!(StartAllReposReactor, %{directory: "./to_reverse"})
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `reactor_process` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:reactor_process, "~> 0.18.0"}
  ]
end
```

Documentation for the latest release is available on [HexDocs](https://hexdocs.pm/reactor_process).

## Github Mirror

This repository is mirrored [on Github](https://github.com/jimsynz/reactor_process)
from it's primary location [on my Forgejo instance](https://harton.dev/james/reactor_process).
Feel free to raise issues and open PRs on Github.

## License

This software is licensed under the terms of the
[HL3-FULL](https://firstdonoharm.dev), see the `LICENSE.md` file included with
this package for the terms.

This license actively proscribes this software being used by and for some
industries, countries and activities. If your usage of this software doesn't
comply with the terms of this license, then [contact me](mailto:james@harton.nz)
with the details of your use-case to organise the purchase of a license - the
cost of which may include a donation to a suitable charity or NGO.
