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
        version: "0.1.0"
    )

    @Argument(help: "The absolute path for .xcodeproj file.")
    var path: String

    func run() throws {
        let sorter = XcodeProjSorter()
        try sorter.sort(fileAtPath: path)
    }
}

XcodeProjectSorterCLI.main()
