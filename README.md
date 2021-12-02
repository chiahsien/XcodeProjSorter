# XcodeProjSorter

A library to sort Xcode's `.xcodeproj` file. It sorts following sessions:
- `PBXGroup`
- `PBXResourcesBuildPhase`
- `PBXSourcesBuildPhase`

## Command Line Tool

You can find the command-line tool project under `CLI` directory and build it by yourself. Or, you can download it from [releases](https://github.com/chiahsien/XcodeProjSorter/releases) page.

## Usage

`xcodeproj-sorter <path-to-xcodeproj-file>`

You can use it to sort Xcode project file before committing it to git version control. Sorting project file can reduce merging conflict possibility.

### 1.
Create a `Tools` directory in project root directory, and put `xcodeproj-sorter` into `Tools` directory.

### 2.
Put following codes into `.git/hooks/pre-commit`.

```bash
#!/bin/sh
#
# Following script is to sort Xcode project files, and add them back to version control.
# The reason to sort project file is that it can reduce project.pbxproj file merging conflict possibility.
#
echo 'Sorting Xcode project files'

GIT_ROOT=$(git rev-parse --show-toplevel)
sorter="$GIT_ROOT/Tools/xcodeproj-sorter"
modifiedProjectFiles=( $(git diff --name-only --cached | grep "project.pbxproj") )

for filePath in ${modifiedProjectFiles[@]}; do
  fullFilePath="$GIT_ROOT/$filePath"
  $sorter $fullFilePath
  git add $fullFilePath
done

echo 'Done sorting Xcode project files'

exit 0
```

### 3.
Put following line into `.gitattributes` then commit it.

```
*.pbxproj merge=union
```

## License

MIT license.
