# XcodeProjSorter

A command-line tool to sort Xcode's `.xcodeproj` file. It sorts following sessions:
- `PBXGroup`
- `PBXResourcesBuildPhase`
- `PBXSourcesBuildPhase`

## Build

After running `swift build -c release` command, you can find the executable in `.build/release`.

## Usage

`xcodeproj-sorter <path-to-xcodeproj-file>`
