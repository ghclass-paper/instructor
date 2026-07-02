# Course setup: configure the org, validate the roster, invite students.

library(ghclass)

org = "ghclass-paper"

# Configure the organization before anyone is invited
org_set_repo_permission(org, "none")
org_set_workflow_permissions(org, "write")

org_sitrep(org)

# In a real course this file holds PII and stays out of version control;
# here every row is fabricated.
roster = readr::read_csv("github_roster.csv")

responded = dplyr::filter(roster, !is.na(github))
valid = user_exists(responded$github)
stopifnot(all(valid))

need = setdiff(responded$github, c(org_members(org), org_pending(org)))
org_invite(org, need)
