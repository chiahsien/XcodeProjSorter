//
//  Sorter.swift
//  
//
//  Created by Nelson on 2021/11/28.
//

import Foundation
import PathKit
import XcodeProj

public final class XcodeProjSorter {
    public init() { }
    public func sort(fileAtPath: String) throws {
        let path = Path(fileAtPath)
        let project = try XcodeProj(path: path)
        let pbxproj = project.pbxproj

        sortGroups(pbxproj: pbxproj)
        sortProjects(pbxproj: pbxproj)
        sortSourcesBuildPhase(pbxproj: pbxproj)
        sortResourcesBuildPhase(pbxproj: pbxproj)

        try project.write(path: path)
    }
}

extension XcodeProjSorter {
    // Project Navigator
    func sortGroups(pbxproj: PBXProj) {
        for group in pbxproj.groups {
            group.children.sort { lhs, rhs in
                if lhs is PBXGroup && !(rhs is PBXGroup) {
                    return true
                } else if !(lhs is PBXGroup) && rhs is PBXGroup {
                    return false
                } else {
                    let lhsName = lhs.name ?? lhs.path ?? ""
                    let rhsName = rhs.name ?? rhs.path ?? ""
                    return numericSort(lhs: lhsName, rhs: rhsName)
                }
            }
        }

        for group in pbxproj.variantGroups {
            group.children.sort { lhs, rhs in
                let lhsName = lhs.name ?? lhs.path ?? ""
                let rhsName = rhs.name ?? rhs.path ?? ""
                return numericSort(lhs: lhsName, rhs: rhsName)
            }
        }
    }

    func sortProjects(pbxproj: PBXProj) {
        for project in pbxproj.projects {
            // Targets
            project.targets.sort { lhs, rhs in
                return numericSort(lhs: lhs.name, rhs: rhs.name)
            }
            // Swift Packages
            project.packages.sort { lhs, rhs in
                let lhsName = lhs.name ?? ""
                let rhsName = rhs.name ?? ""
                return numericSort(lhs: lhsName, rhs: rhsName)
            }
        }
    }

    // Compile Sources Phase
    func sortSourcesBuildPhase(pbxproj: PBXProj) {
        for sourceBuildPhase in pbxproj.sourcesBuildPhases {
            sourceBuildPhase.files?.sort { lhs, rhs in
                let lhsName = lhs.file?.name ?? lhs.file?.path ?? ""
                let rhsName = rhs.file?.name ?? rhs.file?.path ?? ""
                return numericSort(lhs: lhsName, rhs: rhsName)
            }
        }
    }

    // Copy Bundle Resources Phase
    func sortResourcesBuildPhase(pbxproj: PBXProj) {
        for resourcesBuildPhase in pbxproj.resourcesBuildPhases {
            resourcesBuildPhase.files?.sort { lhs, rhs in
                let lhsName = lhs.file?.name ?? lhs.file?.path ?? ""
                let rhsName = rhs.file?.name ?? rhs.file?.path ?? ""
                return numericSort(lhs: lhsName, rhs: rhsName)
            }
        }
    }

    func numericSort(lhs: String, rhs: String, result: ComparisonResult = .orderedAscending) -> Bool {
        return lhs.compare(rhs, options: .numeric) == result
    }
}
