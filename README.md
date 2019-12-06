# GitHub Action for Assing to One Project

Automatically add an issue or pull request to specific [GitHub Project](https://help.github.com/articles/about-project-boards/) when you __create__ them. By default the issues are assinged to the `To do` column and the pull requests to the `In progress` one, so make sure you have those columns in your project dashboard.

## Ackowlegment & Motivations

This action has been modified from the original action from [masutaka](https://github.com/masutaka/github-actions-all-in-one-project). I needed to fix it as the original docker container would not build. Also I think the GitHub Action syntax changed a bit.

## Inputs

### `project`

**Required** The url of the project to be assigned to.

### `GITHUB_TOKEN`

**Required** The enviromental variable for query github API.

## Example usage

Example of local action:

```yaml
name: Auto Assign Project Local

on: [pull_request, issues]
env:
  GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

jobs:
  assign_one_project:
    runs-on: ubuntu-latest
    name: Assign to One Project
    steps:
    - name: Checkout
      uses: actions/checkout@v1

    - name: Run assignment
      uses: ./ # Uses an action in the root directory
      with:
        project: 'https://github.com/srggrs/assign-one-project-github-action/projects/2'
```
