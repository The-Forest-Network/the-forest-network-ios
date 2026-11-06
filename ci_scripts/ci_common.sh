#!/bin/sh

# Return on failures
# Fail when expanding unset variables
# Trace each command before executing it
set -eEu

install_xcode_cloud_brew_dependencies () {
    brew update && brew install xcodegen pkl getsentry/tools/sentry-cli
}

setup_github_actions_environment() {
    xcode_select_for_github_actions
    
    unset HOMEBREW_NO_INSTALL_FROM_API
    export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
    
    brew update && brew install xcodegen swiftlint git-lfs pkl
    install_swiftformat
}

install_swiftformat() {
    # Pinned to an exact release instead of tracking --HEAD (upstream Element's approach) or Homebrew's
    # latest stable. A newer SwiftFormat adds rules that flag untouched code, so CI would start failing
    # with zero code changes. Bump deliberately (reformatting the repo to match), not automatically.
    # Homebrew has no versioned formula, so install the release binary and check it against its published hash.
    local version="0.63.1"
    local sha256="385ef1a263ba28685157b98c5536b9c9105e124518f28b7ef8a2bee4b167eaeb"
    local install_directory="$RUNNER_TEMP/swiftformat-$version"
    
    mkdir -p "$install_directory"
    curl -fsSL "https://github.com/nicklockwood/SwiftFormat/releases/download/$version/swiftformat.zip" -o "$install_directory/swiftformat.zip"
    echo "$sha256  $install_directory/swiftformat.zip" | shasum -a 256 -c -
    unzip -o -q "$install_directory/swiftformat.zip" -d "$install_directory"
    
    # Later steps pick this up ahead of any Homebrew copy.
    echo "$install_directory" >> "$GITHUB_PATH"
}

setup_github_actions_translations_environment() {
    xcode_select_for_github_actions
    
    unset HOMEBREW_NO_INSTALL_FROM_API
    export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

    brew update && brew install swiftgen mint localazy/tools/localazy

    mint install Asana/locheck
}

xcode_select_for_github_actions() {
    # We need to select it globally for our custom tools to use the same Xcode version.
    sudo xcode-select -s /Applications/Xcode_26.5.0.app
}

generate_what_to_test_notes() {
    if [[ -d "$CI_APP_STORE_SIGNED_APP_PATH" ]]; then
        TESTFLIGHT_DIR_PATH=TestFlight
        TESTFLIGHT_NOTES_FILE_NAME=WhatToTest.en-US.txt
        
        LATEST_TAG=""
        if [ "$CI_WORKFLOW" = "Release" ]; then
            # Use -v to invert grep, searching for non-nightlies
            LATEST_TAG=$(git tag --sort=-creatordate | grep -v 'nightly' | head -n1)
        elif [ "$CI_WORKFLOW" = "Nightly" ]; then
            LATEST_TAG=$(git tag --sort=-creatordate | grep 'nightly' | head -n1)
        fi

        if [[ -z "$LATEST_TAG" ]]; then
            echo "generate_what_to_test_notes: Failed fetching previous tag"
            return 0 # Continue even though this failed
        fi

        echo "generate_what_to_test_notes: latest tag is $LATEST_TAG"

        mkdir $TESTFLIGHT_DIR_PATH

        NOTES="$(git log --pretty='- %an: %s' "$LATEST_TAG"..HEAD)"

        echo "generate_what_to_test_notes: Generated notes:\n"$NOTES""

        echo "$NOTES" > $TESTFLIGHT_DIR_PATH/$TESTFLIGHT_NOTES_FILE_NAME
    fi
}

fetch_unshallow_repository() {
    # Xcode Cloud shallow clones the repo. We need to deepen it to fetch tags, commit history and be able to rebase main on develop at the end of releases.
    git fetch --unshallow --quiet
}
