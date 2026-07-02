# hw1: team formation, distribution, customization, monitoring, corrections.
# Mirrors the paper's teams, distribute, customize, monitor, contributions,
# and correct chunks (sec-distribute and sec-working).
#
# NOTE: the roster handles are fabricated and do not exist on GitHub, so the
# user and team invitation steps of org_create_assignment() are illustrative
# here. The demo organization is built by the provisioning script in the
# paper's companion materials, which creates the same repositories and teams
# without adding any users.

library(ghclass)

org = "ghclass-paper"

## Form teams

roster = readr::read_csv("../Organization/github_roster.csv") |>
  dplyr::filter(!is.na(github)) |>
  team_roster(
    size = 3,
    by   = "section",
    name = "hw1_lab{section}_team{team_id}",
    pad  = 2,
    seed = 20250901
  )

readr::write_csv(roster, "hw1_roster.csv")

## Distribute

repo_set_template("ghclass-paper/hw1")

org_create_assignment(
  org         = org,
  repo        = roster$team,
  user        = roster$github,
  team        = roster$team,
  source_repo = "ghclass-paper/hw1",
  add_badges  = TRUE
)

## Customize: per-team contact list in each README

contacts = roster |>
  dplyr::group_by(team) |>
  dplyr::summarize(body = paste0("- ", name, " (", email, ")", collapse = "\n"))

repo_modify_file(
  repo    = paste0(org, "/", contacts$team),
  path    = "README.md",
  pattern = "## Team members",
  content = paste0("\n", contacts$body),
  method  = "after"
)

## Monitor while the assignment is live

repos = org_repos(org, "hw1_")

repo_n_commits(repos)
action_runs(repos, branch = "main")

repo_contributors("ghclass-paper/hw1_lab01_team01")
repo_pushes("ghclass-paper/hw1_lab01_team01")

## Correct after distribution: a forgotten data file and a moved due date

repo_add_file(repos, file = "data/late_addition.csv", repo_folder = "data")

repo_modify_file(
  repos,
  path    = "README.md",
  pattern = "Due: .*",
  content = "Due: 2025-09-22",
  method  = "replace"
)
