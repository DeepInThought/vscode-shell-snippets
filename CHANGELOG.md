# Visual Studio Code Shell Snippets Changelog

[CHANGELOG.md](https://raw.githubusercontent.com/DeepInThought/vscode-shell-snippets/master/CHANGELOG.md).

## Version 0.3.0

- Fixed bug where extension would always be disabled.
- Changed snippets to new JSON files to match usage.
- Added extension TypeScript file for future usage.
- Removed useless dependencies in the package.json file.
- Improved all of the entries in the snippets files.
  They now pass shellcheck and work as intended.
- Improved description and choices for entries.

## Version 0.2.0

- [Vulnerabilies] Security vulnerabilities detected in dependencies.  
  - Dependency event-stream associated with [flatmap-stream](https://github.com/dominictarr/event-stream/issues/116) was found malicious.
