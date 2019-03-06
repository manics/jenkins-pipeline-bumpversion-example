# Jenkins Pipeline BumpVersion Example

Version: 0.0.0

This is an example of using Jenkins Pipelines to automatically version and tag a repository.

1. Fork this repository.
2. Run this Jenkins Pipeline by adding the forked repository to a Jenkins installation with a node labelled `docker`.
3. Add a [GitHub deploy key](https://developer.github.com/v3/guides/managing-deploy-keys/#deploy-keys) to your repository
4. Add an Jenkins credential called `github-push` with your GitHub SSH key.
   Tick the box to allow write access.
   This will be used to update the GitHub fork with a new version.
5. Run the pipeline.

The pipeline will run, then prompt you for input.
If you agree to bump the version the version at the top of this file will be bumped, the repository will tagged, and pushed to GitHub.
You have the following options:

- `patch`: Bump the patch version, add `-SNAPSHOT`, e.g. `1.2.3` →  `1.2.4-SNAPSHOT`
- `minor`: Bump the minor version add `-SNAPSHOT`, e.g. `1.2.3` →  `1.3.0-SNAPSHOT`
- `major`: Bump the major version add `-SNAPSHOT`, e.g. `1.2.3` →  `2.0.0-SNAPSHOT`
- `release`: Remove `-SNAPSHOT`, e.g. `2.0.0-SNAPSHOT` → `2.0.0`
- `skip`: Do nothing
