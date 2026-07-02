# hw1: collect, grade, export scores, return feedback.
# org_grade_assignment() generates the hw1/ working folder (clones, CI
# artifacts, comment scaffolds); scores and comments are filled in by hand
# and stay out of version control since they hold student work and grades.

library(ghclass)

org = "ghclass-paper"

## Collect

org_grade_assignment(
  "hw1", org, "hw1_",
  artifacts = c(html = "hw1-html"),
  key_repo  = "ghclass-paper/hw1-key"
)

## Export scores to the gradebook, guarded against silent mismatches

scores = readr::read_csv("hw1/scores.csv")
roster = readr::read_csv("../Assignments/hw1_roster.csv")

upload = readr::read_csv("gradebook_template.csv") |>
  dplyr::left_join(dplyr::left_join(scores, roster, by = "team"), by = "email")

stopifnot("score" %in% names(upload), !any(is.na(upload$score)))
readr::write_csv(upload, "hw1/hw1_upload.csv")

## Return qualitative feedback as an issue in each repository

comments = fs::dir_ls("hw1/comments", glob = "*.md")
repos    = paste0(org, "/", fs::path_ext_remove(fs::path_file(comments)))

issue_create(repos, title = "hw1 feedback", body = purrr::map_chr(comments, readr::read_file))
