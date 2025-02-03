import Config

config :spark, formatter: [remove_parens?: true]

config :git_ops,
  mix_project: Reactor.Supervisor.MixProject,
  changelog_file: "CHANGELOG.md",
  repository_url: "https://harton.dev/james/reactor_supervisor",
  manage_mix_version?: true,
  manage_readme_version: true,
  version_tag_prefix: "v"
