# Tasks

## TODO List

- [ ] Set session token management for active tokens
- [ ] Send notification of timeout inactivity when user on idle
- [ ] Will be setting token expiration to 14days, need to find a better solution for refreshing tokens on user activity
- [ ] Set UUID for for all models [Source 4 On References]('./references_sources.md')
- [ ] Set DeviseHelper Devise Error messages for trying to json send error messages on login
- [ ] Try utilizing super on most methods to avoid dealing with redundant code, and let resource path location do it's thing regardless. It's not going anywhere
- [ ] Setup JBuilder or JSONapi
- [ ]

## FIXME List

- [ ] DeviseHelper#devise_error_messages! is only meant for erb error handling outputs, need to find an alternative for managing login errors, and other requests
- [ ] AUD is necessary to avoid duplicating keys from user devise on login
- [ ] Clear all commented code!
- [ ] Nilify blanks isn't nilifying records...
- [ ] OJ gem not properly installed, required to be set in an initializer, no specified file, amusing is devise, leaving as is for future fix [Source_1](https://github.com/ohler55/oj/blob/develop/pages/Rails.md) [Source_2](https://github.com/ohler55/oj)
