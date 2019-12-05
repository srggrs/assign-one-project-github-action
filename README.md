# GitHub Action for Assing to One Project

[![License](https://img.shields.io/github/license/srggrs/assign-one-project-github-action.svg?style=flat-square)][license]

[license]: https://github.com/srggrs/assign-one-project-github-action/blob/master/LICENSE

Automatically add an issue or pull request to specific [GitHub Project](https://help.github.com/articles/about-project-boards/) when you __create__ them. By default the issues are assinged to the `To do` column and the pull requests to the `In progress` one, so make sure you have those columns in your project dashboard.

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
