# midterm1: collect, grade, export scores, return feedback.
# org_grade_assignment() generates the midterm1/ working folder (cloned
# submissions, comment scaffolds); scores and comments are filled in by hand
# and stay out of version control since they hold student work and grades.

library(ghclass)

org = "ghclass-paper"

## Collect

org_grade_assignment("midterm1", org, "midterm1_")

## Export scores to the gradebook, guarded against silent mismatches

scores = readr::read_csv("midterm1/scores.csv")
roster = readr::read_csv("../Organization/github_roster.csv") |>
  dplyr::mutate(repo = paste0("midterm1_", github))

upload = dplyr::left_join(roster, scores, by = "repo")

stopifnot(!any(is.na(upload$score)))

# Additional processing is likely needed here to match the format expected
# by your school's LMS / gradebook
readr::write_csv(upload, "midterm1/midterm1_upload.csv")

## Return qualitative feedback as an issue in each repository

comments = fs::dir_ls("midterm1/comments", glob = "*.md")
repos    = paste0(org, "/", fs::path_ext_remove(fs::path_file(comments)))

issue_create(repos, title = "midterm1 feedback", body = purrr::map_chr(comments, readr::read_file))
