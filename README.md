## My Notes
 - Achieved all functionality for this project. Completed one reach goal which was low-level caching.
 - Refactors
   - Edge case: User can select a time on todays date that is before the current time
   - Get image path fully from API and not hardcoded
   - Pagination in service
   - All reviews shown
   - User Experience Improvements
      - Old parties (past date) moved to a separate area
      - HTML/CSS to make the viewing party's cards and on the movie show page
   - Reassess columns in Viewing Party
   - Listing movies in search might not need to have the full movie object made or somehow passes that movie object to the next page
   - Extensions I'd like to implement
      - OAuth
      - Invites need to be accepted

# Viewing Party

This is a forked repo for the [Viewing Party Lite project](https://backend.turing.edu/module3/projects/viewing_party_lite/index) used for Turing's Backend Module 3.

### About this Project

Viewing Part Lite is an application in which users can explore movie options and create a viewing party event for themselves and other users of the application.

## Local Setup for any other use

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:create`


## Using Rubocop
- Run `bundle exec rubocop` to check for violations

## Versions

- Ruby 2.7.4

- Rails 5.2.8

Example wireframes to follow are found [here](https://backend.turing.io/module3/projects/viewing_party_lite/wireframes)

## Pull Request Template

## Pull request type
Please check the type of change your PR introduces:
- [ ] Bugfix
- [ ] Feature
- [ ] Code style update (formatting, renaming)
- [ ] Refactoring (no functional changes, no api changes)
- [ ] Build related changes
- [ ] Breaking change (fix or feature that would cause existing functionality to not work as expected)
- [ ] Other (please describe):
## Problem/feature
_What problem are you trying to solve?_
## Solution
_How did you solve the problem?_
## Other changes (e.g. bug fixes, UI tweaks, small refactors)
## Checklist
- [ ] Code compiles correctly
- [ ] Tests for the changes have been added (for bug fixes/features)
- [ ] All tests passing
- [ ] Extended the README / documentation, if necessary 
