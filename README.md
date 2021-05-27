# Getting started
1. [Create a copy of this template repository][template]. Make sure you create it in the organization **`commit-app-playground`** as a **`Public`** repository.
_<br/><sub>It must be both public and in the correct org in order to access deployment credentials from Github actions</sub>_
_<br/><sub>You will most likely need both a frontend and backend project, so you can pick a name that will make it easy to identify like &lt;your project name&gt;\_backend</sub>_

1. [Edit the `zero-project.yml`][edit] and fill your project name into the `name` field. It must be alphanumeric and dashes only. You can also set `frontendSubdomain` to `static` if your frontend will be a static site rather than a single-page app.
<br/>Commit the change.
_<br/><sub>Your Kubernetes namespace, service, etc. will use the name you choose here.</sub>_
_<br/><sub>Once the Github Action successfully runs you will no longer see this readme in your repository, but instead your own example project.</sub>_

1. Once you commit the change, Github Actions will be triggered and rewrite the repository.
<br/>**Only after this job runs** can you check out this repository locally to begin work.

1. After the initial setup job runs, and after you merge new code to the main branch, the deployment ci job will run and deploy your code.

---
#### Credits
<sub>- [stefanbuck](https://github.com/stefanbuck/cookiecutter-template) for the inspiration of using Github actions to template out a repo</sub>

[edit]: ../../edit/main/zero-project.yml
[template]: ../../generate
