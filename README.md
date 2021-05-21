# Getting started
1. [Template out][template] your repository in Org: **`commit-app-playground`** as a **`Public`** repository.
_<br/><sub>It must be both public and in the org in order to access deployment credentials from Github actions</sub>_

1. [Edit the `zero-project.yml`][edit] with `name` (it must be alpha-numeric and dashes only to be a valid k8s-namespace) then commit the change.
_<br/><sub>Once Github action successfully run you will nolonger see this readme in your repository but instead of your own example project.</sub>_

1. Once you commit the change containing `zero-project.yml`, Github actions will be triggered and rewrite the repository becoming the templated repo. Your `namespace`/`deployment`/`svc`/`image-name` use the **`name`** specified in `zero-project.yml`

1. You are suggested to clone the repo **ONLY after you have committed the `zero-project.yml` change**, since the Github actions will rewrite the git history and will become a non-fast forward change.
---
#### Credits
<sub>- [stefanbuck](https://github.com/stefanbuck/cookiecutter-template) for inspiration of cookiecutter and Github actions to template out a repo</sub>

[edit]: ../../edit/main/zero-project.yml
[template]: ../../generate
