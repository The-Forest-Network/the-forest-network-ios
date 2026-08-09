import ArgumentParser
import CommandLineTools
import Foundation

struct SetupProject: ParsableCommand {
    static let configuration = CommandConfiguration(abstract: "A tool to setup the required components to efficiently run and contribute to Element X iOS")
    
    func run() throws {
        try setupGitHooks()
        try brewInstall()
        try mintPackagesInstall()
        try xcodegen()
    }
    
    func setupGitHooks() throws {
        try Zsh.run(command: "git config core.hooksPath .githooks")
    }
    
    func brewInstall() throws {
        try Zsh.run(command: "brew install xcodegen swiftgen git-lfs sourcery mint pkl kiliankoe/formulae/swift-outdated localazy/tools/localazy peripheryapp/periphery/periphery")
        
        // Install swiftformat pinned to the latest stable release, making sure to avoid conflicts with an existing HEAD installation.
        try Zsh.run(command: "source ci_scripts/ci_common.sh && install_swiftformat")
    }
    
    func mintPackagesInstall() throws {
        try Zsh.run(command: "mint install Asana/locheck")
    }
    
    func xcodegen() throws {
        try Zsh.run(command: "xcodegen")
    }
}
