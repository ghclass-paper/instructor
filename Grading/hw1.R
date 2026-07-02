# hw1: collection, grading, gradebook export, and feedback.
# Mirrors the paper's grade-collect, gradebook, and feedback chunks
# (sec-grading).
#
# org_grade_assignment() generates the hw1/ working folder: it clones every
# hw1_ repository and the answer key, downloads each repository's rendered CI
# artifact, and scaffolds one empty comment file per repository. The scores
# CSV and the comment files are then filled in by hand; that folder holds
# student work and grades, so it stays out of version control (see
# ../.gitignore) and is not part of this repository.

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
