# Getting started
1. [Template out][template] your repository in Org: **`commit-app-playground`** as a **`Public`** repository.
_<br/><sub>It must be both public and in the org in order to access deployment credentials from Github actions</sub>_

1. [Edit the `zero-project.yml`][edit] with `name` (it must be alpha-numeric and dashes only to be a valid k8s-namespace) then commit the change.

1. Once you commit the change containing `zero-project.yml`, Github actions will be triggered and rewrite the repository becoming the templated repo, Your `namespace`/`deployment`/`svc`/`image-name` use the **`name`** you have in `zero-project.yml`

## Credits
- https://github.com/stefanbuck/cookiecutter-template

[edit]: ../../edit/main/zero-project.yml
[template]: ../../generate