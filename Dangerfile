## SwiftLint

swiftlint.binary_path = 'Pods/SwiftLint/swiftlint'
swiftlint.max_num_violations = 20
swiftlint.lint_files(
  fail_on_error: true,
  inline_mode: true,
  additional_swiftlint_args: "--strict"
)

## CHANGELOG

has_lib_changes = !(git.modified_files + git.added_files).grep(/Modules\/ADUtils/).empty?
if !git.modified_files.include?("CHANGELOG.md") && has_lib_changes
  warn("Please include a CHANGELOG entry.")
end
