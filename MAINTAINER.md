
## How to release a version

- create release branch `release/vA.B.C`
- run `bundle exec fastlane prepare_release`, this will update the version number in the podspec based on the release branch.
- merge PR -> the CI action will trigger a pod release and tag the commit
- once the PR is merged, merge the branch `release/vA.B.C` into master
