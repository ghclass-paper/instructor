# Course setup: validate the roster, invite students, configure the org.
# Mirrors the paper's invite and org-config chunks (sec-setup).
#
# NOTE: this demo's roster is fabricated and some handles coincide with real
# GitHub accounts we have no relationship with, so the invite below is
# illustrative and is intentionally not run against this roster. The demo
# organization is built by ../provision_demo.R, which skips all invitations.

library(ghclass)

org = "ghclass-paper"

# In a real course this file holds PII and stays out of version control;
# here every row is fabricated.
roster = readr::read_csv("github_roster.csv")

responded = dplyr::filter(roster, !is.na(github))
valid = user_exists(responded$github)
stopifnot(all(valid))

need = setdiff(responded$github, c(org_members(org), org_pending(org)))
org_invite(org, need)

org_set_repo_permission(org, "none")
org_set_workflow_permissions(org, "write")

org_sitrep(org)
