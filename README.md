# Instructor repository (demo)

This organization is the live companion to the paper "A Modern Approach to Teaching Statistics and Data Science using Git and GitHub", which documents a scripted instructor workflow built on the [ghclass](https://github.com/rundel/ghclass) R package. The organization mirrors the structure the paper describes, populated only with placeholder scaffolding: a reader can point the read-side ghclass functions (`org_repos()`, `repo_n_commits()`, `action_runs()`, `repo_contributors()`, and so on) at a real, public organization and see them work without needing real student data or a course of their own.

Everything here is fabricated. The six students (Alice, Bob, Carol, Dave, Elizabeth, Fred) do not exist, their emails are on `example.edu`, and the assignment content is intentionally generic placeholder text. Where a fabricated handle happens to coincide with a real GitHub account, that account has no involvement here: no user was ever invited to this organization and no collaborator was ever added to a repository.

Visibility is the other deliberate departure from a real course. Every repository here is public so the organization can serve as a reference. In an actual course this instructor repository and every student repository are private, always; we usually make the assignment templates private as well, though that one is an instructor choice rather than a requirement.

## Layout

This repository plays the role of the private instructor repository described in the paper, with one folder per workflow stage:

- `Organization/` holds the course roster (`github_roster.csv`) and the setup script (`invite.R`) that validates handles, invites students, and configures the organization. In a real course the roster holds PII and stays out of version control; here it is committed because every row is fabricated.
- `Assignments/` holds one distribution script per assignment: `hw1.R` (team assignment: seeded team formation, distribution from the template, per-team README customization, monitoring, and post-distribution corrections) and `midterm1.R` (individual assignment, one repository per student).
- `Grading/` holds the collection and feedback script (`hw1.R`) and a generic gradebook template. Running the script generates the `Grading/hw1/` working folder (cloned submissions, downloaded artifacts, a scores CSV, and scaffolded comment files); that folder holds student work and grades, so it stays out of version control and is not part of this repository.

## Repositories in this organization

- `hw1` and `midterm1` are the assignment templates; `hw1-key` is the answer key that `org_grade_assignment()` clones alongside submissions.
- `hw1_lab01_team01` and `hw1_lab01_team02` are the distributed team repositories; `midterm1_<name>` are the six individual repositories. Each carries the CI badge and, for hw1, the per-team contact list inserted into its README.

## Rebuilding

The organization was built from scratch by a provisioning script, `provision_demo.R`, kept alongside these repository sources in the staging area they were pushed from: it applies the organization settings, pushes the template repositories, and mirrors them into the team and individual repositories. Because the roster handles are fabricated, it deliberately skips every invitation step; the scripts in `Organization/` and `Assignments/` show what those steps look like in a real course. To try the full write-side workflow yourself, create a throwaway organization, change the `org` variable, and swap in a roster of accounts you control. Do not run the invitation or assignment scripts against the fabricated roster, since some of those handles belong to unrelated real accounts.

The continuous integration in the templates is the real thing: the `checklist` R package (<https://github.com/rundel/checklist>) running inside the public course Docker image (`ghcr.io/dukestatsci/r_gh_actions`), on GitHub-hosted runners.
