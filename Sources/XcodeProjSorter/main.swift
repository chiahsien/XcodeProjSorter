import ArgumentParser

struct XcodeProjectSorter: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "xcodeproj-sorter",
        abstract: "Sort given Xcode project file.",
        version: "0.1.0"
    )

    @Argument(help: "The absolute path for .xcodeproj file.")
    var path: String

    func run() throws {
        let sorter = Sorter()
        try sorter.sort(fileAtPath: path)
    }
}

XcodeProjectSorter.main()
