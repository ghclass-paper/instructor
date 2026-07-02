# midterm1: individual assignment distribution, one repository per student.
# Mirrors the paper's distribute-individual chunk (sec-distribute).
#
# NOTE: the roster handles are fabricated and do not exist on GitHub, so the
# user invitation step of org_create_assignment() is illustrative here. The
# demo organization is built by the provisioning script in the paper's
# companion materials, which creates the same repositories without adding
# any users.

library(ghclass)

org = "ghclass-paper"

repo_set_template("ghclass-paper/midterm1")

exam = readr::read_csv("../Organization/github_roster.csv") |>
  dplyr::filter(!is.na(github)) |>
  dplyr::mutate(repo = paste0("midterm1_", github))

readr::write_csv(exam, "midterm1_roster.csv")

org_create_assignment(
  org         = org,
  repo        = exam$repo,
  user        = exam$github,
  source_repo = "ghclass-paper/midterm1",
  add_badges  = TRUE
)
