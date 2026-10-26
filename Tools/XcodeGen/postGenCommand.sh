#!/bin/bash

# This script is invoked by xcodegen for running post commands

# Move file header template in project shared data folder
cp IDETemplateMacros.plist ../../TheForestNetwork.xcodeproj/xcshareddata/

# Rewrite schemes the way Xcode saves them
swift normalizeSchemes.swift ../../TheForestNetwork.xcodeproj/xcshareddata/xcschemes
