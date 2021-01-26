# GitHub Action for Assign to One Project

[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/srggrs/assign-one-project-github-action)][docker]
[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/srggrs/assign-one-project-github-action)][docker]
[![Docker Pulls](https://img.shields.io/docker/pulls/srggrs/assign-one-project-github-action)][docker]
[![Docker Stars](https://img.shields.io/docker/stars/srggrs/assign-one-project-github-action)][docker]
[![GitHub license](https://img.shields.io/github/license/srggrs/assign-one-project-github-action.svg)][license]

[docker]: https://hub.docker.com/r/srggrs/assign-one-project-github-action
[license]: https://github.com/srggrs/assign-one-project-github-action/blob/master/LICENSE

Automatically add an issue or pull request to specific [GitHub Project](https://help.github.com/articles/about-project-boards/) when you __create__ and/or __label__ them. By default, the issues are assigned to the `To do` column and the pull requests to the `In progress` one, so make sure you have those columns in your project dashboard. But the workflow allowed you to specify the column name as input, so you can assign the issues/PRs based on a set of conditions to a specific column of a specific project.

## Acknowledgment & Motivations

This action has been modified from the original action from [masutaka](https://github.com/masutaka/github-actions-all-in-one-project). I needed to fix it as the original docker container would not build. Also I think the GitHub Action syntax changed a bit.

I would like to thank @SunRunAway for adding the labelling functionality and custom column input.

## Inputs

### `project`

**Required** The url of the project to be assigned to.

### `column_name`

The column name of the project, defaults to `'To do'` for issues and `'In progress'` for pull requests.

## Example usage

Examples of action:

### Repository project

```yaml
name: Auto Assign to Project(s)

on:
  issues:
    types: [opened, labeled]
  pull_request:
    types: [opened, labeled]
env:
  GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}

jobs:
  assign_one_project:
    runs-on: ubuntu-latest
    name: Assign to One Project
    steps:
    - name: Assign NEW issues and NEW pull requests to project 2
      uses: srggrs/assign-one-project-github-action@1.2.0
      if: github.event.action == 'opened'
      with:
        project: 'https://github.com/srggrs/assign-one-project-github-action/projects/2'

    - name: Assign issues and pull requests with `bug` label to project 3
      uses: srggrs/assign-one-project-github-action@1.2.0
      if: |
        contains(github.event.issue.labels.*.name, 'bug') ||
        contains(github.event.pull_request.labels.*.name, 'bug')
      with:
        project: 'https://github.com/srggrs/assign-one-project-github-action/projects/3'
        column_name: 'Labeled'
```

#### __Notes__
Be careful of using the conditions above (opened and labeled issues/PRs) because in such workflow, if the issue/PR is opened and labeled at the same time, it will be assigned to __both__ projects!


You can use any combination of conditions. For example, to assign new issues or issues labeled with 'mylabel' to a project column, use:
```yaml
...

if: |
  github.event == 'issue' &&
  (
    github.event.action == 'opened' ||
    contains(github.event.issue.labels.*.name, 'mylabel')
  )
...
```

### Organisation or User project

Generate a token from the Organisation settings or User Settings and add it as a secret in the repository secrets as `MY_GITHUB_TOKEN`

```yaml
name: Auto Assign to Project(s)

on:
  issues:
    types: [opened, labeled]
  pull_request_target:
    types: [opened, labeled]
env:
  MY_GITHUB_TOKEN: ${{ secrets.MY_GITHUB_TOKEN }}

jobs:
  assign_one_project:
    runs-on: ubuntu-latest
    name: Assign to One Project
    steps:
    - name: Assign NEW issues and NEW pull requests to project 2
      uses: srggrs/assign-one-project-github-action@1.2.0
      if: github.event.action == 'opened'
      with:
        project: 'https://github.com/srggrs/assign-one-project-github-action/projects/2'

    - name: Assign issues and pull requests with `bug` label to project 3
      uses: srggrs/assign-one-project-github-action@1.2.0
      if: |
        contains(github.event.issue.labels.*.name, 'bug') ||
        contains(github.event.pull_request.labels.*.name, 'bug')
      with:
        project: 'https://github.com/srggrs/assign-one-project-github-action/projects/3'
        column_name: 'Labeled'
```
