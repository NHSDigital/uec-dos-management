# Guide: Git Branching Strategy

- [Guide: Git Branching Strategy](#guide-git-branching-strategy)
  - [Git branching strategy diagram](#git-branching-strategy-diagram)
  - [Branch naming conventions](#branch-naming-conventions)
  - [To start work on a new ticket](#to-start-work-on-a-new-ticket)
  - [To test a ticket](#to-test-a-ticket)
  - [Identify release candidates](#identify-release-candidates)
  - [Once release candidates are merged to main](#once-release-candidates-are-merged-to-main)
  - [Hotfix process](#hotfix-process)
  - [Rebase](#rebase)
  - [References](#references)

## Git branching strategy diagram

![Git branching strategy diagram](../diagrams/Git_branching_strategy.drawio.png)

## Branch naming conventions

- We prefer task over 'feature' as task better encapsulates the short-lived nature of transient branches.
- It is a task to be delivered (on the way to delivering a full feature) rather than the full feature.
- Consequently temporary branches created from main should follow this naming pattern: `task/JIRA_REF_Min_three_word_desc`
  - Where the minimum three word description starts with an initial capital
  - And the max length for a branch name is 60 characters.

- Valid branch names would be
  - `task/DR_1_Update_s3_terraform`
  - `task/DR_9_Add_new_data_item`

- Invalid branch names might be
  - `feature/DR_1_Update_s3_terraform` (doesn't start with task)
  - `task/DR-1_Update_s3_terraform` (Jira ref doesn’t use underscore)
  - `task/Update_s3_terraform` (doesn't include Jira ref)
  - `task/DR_1_update_s3_terraform` (first word after Jira ref not capitalised)

## To start work on a new ticket

- Create a new task branch from develop
- When development is complete, then create a pull request to merge back into develop.

## To test a ticket

Before Merging to develop:

- Developers test that the functionality is met by using unit and integration tests, as part of their PR.
- If there are test failures (e.g. failing integration tests), then resolve the issues as part of the original ticket.

After Merging to develop:

- Testers then commence testing of the ticket.
- If an issue is found during manual testing, an issue is raised.
  - This issue needs to be fixed within the original ticket, so that ticket is moved back into progress.
  - The ticket cannot moved to done until the linked bug/issue is fixed.
- If the bug is different from the functionality of the original ticket:
  - The bug is handled outside of that ticket.
  - The bug can sometimes be taken into the next sprint, depending on its severity and priority.

## Identify release candidates

Identify Tickets and Commits for Release

- The team will identify the tickets and their subsequent commits to include in the release.

Create Confluence Document

- A Confluence document is created to record each release:
  - Use JIRA to produce the release notes to hold in Confluence. See [Atlassian Support: Create Release Notes](https://support.atlassian.com/jira-cloud-administration/docs/create-release-notes/)
  - This document records the list of tickets in the release, planning descriptions, and technical details.

Pre-PR Procedures

- Before raising a PR from develop to main:
  - Developers call for a code freeze to ensure no unconfirmed merges are made to develop.
  - Confirm all tickets in the release have been QA’d and signed off.

Raising a PR from develop to main

- Ensure team consensus on the contents of the release PR versus the release document.
- Where relevant, use feature flagging to merge code to main in the “off” position.

Post-Approval

- Once the PR is approved, merge to main.

## Once release candidates are merged to main

- Tag main with the release version.
- Currently, the process of tagging releases will be performed manually. However, this could be automated when we start releasing.

## Hotfix process

- Used when any issue(s) on main requires an urgent fix
- Create a hotfix branch from main
- Create and merge the PR into main
- Once the hotfix has been deployed, then merge the hotfix into the develop branch

## Rebase

- If you need to update a task branch with updates pushed to main since you created your branch, then rebase - do NOT merge main into your branch.
- This results in a cleaner commit history and usually makes code easier to review

## References

- [Atlassian gitflow workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [Software engineering quality framework](https://github.com/NHSDigital/software-engineering-quality-framework/blob/main/patterns/little-and-often.md)
