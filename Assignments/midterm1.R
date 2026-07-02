# midterm1: individual assignment distribution, one repository per student.
# Illustrative: the fabricated handles do not exist on GitHub, so the
# invitation step cannot run against this roster.

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
