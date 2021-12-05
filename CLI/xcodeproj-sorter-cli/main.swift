//
//  main.swift
//  xcodeproj-sorter
//
//  Created by Nelson on 2021/12/2.
//

import ArgumentParser
import XcodeProjSorter

struct XcodeProjectSorterCLI: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "xcodeproj-sorter",
        abstract: "A command-line tool to sort given Xcode project file.",
        version: "0.2.0"
    )

    @Flag(name: .shortAndLong, help: "Sort file name with case insensitive.")
    var caseInsensitive = false

    @Flag(name: .shortAndLong, help: "Sort file name using numeric value, that is, 2.txt < 7.txt < 25.txt.")
    var numeric = false

    @Argument(help: "The absolute path for .xcodeproj file.")
    var path: String

    func run() throws {
        var options: String.CompareOptions = []
        if caseInsensitive {
            options.insert(.caseInsensitive)
        }
        if numeric {
            options.insert(.numeric)
        }

        let sorter = try XcodeProjSorter(fileAtPath: path, options: options)
        try sorter.sort()
    }
}

XcodeProjectSorterCLI.main()
