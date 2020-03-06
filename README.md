# GitHub Action for Assign to One Project

[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/srggrs/assign-one-project-github-action)][docker]
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/srggrs/assign-one-project-github-action)][docker]
[![Docker Pulls](https://img.shields.io/docker/pulls/srggrs/assign-one-project-github-action)][docker]
[![Docker Stars](https://img.shields.io/docker/stars/srggrs/assign-one-project-github-action)][docker]
[![GitHub license](https://img.shields.io/github/license/srggrs/assign-one-project-github-action.svg)][license]

[docker]: https://hub.docker.com/r/srggrs/assign-one-project-github-action
[license]: https://github.com/srggrs/assign-one-project-github-action/blob/master/LICENSE

Automatically add an issue or pull request to specific [GitHub Project](https://help.github.com/articles/about-project-boards/) when you __create__ them. By default, the issues are assigned to the `To do` column and the pull requests to the `In progress` one, so make sure you have those columns in your project dashboard.

## Acknowledgment & Motivations

This action has been modified from the original action from [masutaka](https://github.com/masutaka/github-actions-all-in-one-project). I needed to fix it as the original docker container would not build. Also I think the GitHub Action syntax changed a bit.

## Inputs

### `project`

**Required** The url of the project to be assigned to.

### `column_name`

The column name of the project, defaults to `'To do'` for issues and `'In progress'` for pull requests.

## Example usage

Examples of action:

### Repository project

```yaml
name: Auto Assign Project

on: [pull_request, issues]
env:
  GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

jobs:
  assign_one_project:
    runs-on: ubuntu-latest
    name: Assign to One Project
    steps:
    - name: Run assignment to one project
      uses: srggrs/assign-one-project-github-action@1.1.0
      if: github.event.action == 'labeled' && contains(github.event.issue.labels.*.name, 'test')
      with:
        project: 'https://github.com/SunRunAway/assign-one-project-github-action/projects/1'
        column_name: 'TODO'
```

### Organisation or User project

Generate a token from the Organisation settings or User Settings and add it as a secret in the repository secrets as `MY_GITHUB_TOKEN`

```yaml
name: Auto Assign Project

on: [pull_request, issues]
env:
  MY_GITHUB_TOKEN: ${{ secrets.MY_GITHUB_TOKEN }}

jobs:
  assign_one_project:
    runs-on: ubuntu-latest
    name: Assign to One Project
    steps:
    - name: Run assignment to one project
      uses: srggrs/assign-one-project-github-action@1.1.0
      if: github.event.action == 'labeled' && contains(github.event.issue.labels.*.name, 'test')
      with:
        project: 'https://github.com/SunRunAway/assign-one-project-github-action/projects/1'
        column_name: 'TODO'
```
