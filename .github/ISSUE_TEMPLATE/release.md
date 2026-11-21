---
name: Release checklist
about: Steps to ship an iOS build to TestFlight and the App Store.
title: "Release <version> (build <number>)"
labels: ''
assignees: ''

---

Copy this checklist into a new issue for each App Store submission. Delete anything that doesn't apply.

## Before the build

- [ ] Every PR for the release is merged into `develop`.
- [ ] `CURRENT_PROJECT_VERSION` in `project.yml` is higher than any build already uploaded (bump it, run `xcodegen`, re-record snapshots with the `record-snapshots` label).
- [ ] After the bot's snapshot commit, click "Approve and run workflows" on the PR; checks don't start on their own.
- [ ] Anything the app links to is live: terms, privacy policy, support page, support email (send a test message).
- [ ] The App Review demo account signs in on a fresh device against production, including any identity-confirmation step. Keep its credentials and recovery key out of chat and issues.

## Build

- [ ] Open a `develop` → `main` PR with exactly one `pr-` label (e.g. `pr-misc`). Merge it with a **merge commit** (not squash or rebase).
- [ ] Check out `main` at the merge commit. `git status` is clean, including `Package.resolved`; opening Xcode can modify it, so check again after packages resolve.
- [ ] Archive with the Xcode version the project currently builds with (the newest Xcode may not compile it).
- [ ] Upload to App Store Connect and wait for processing.
- [ ] Answer export compliance for the build. `ITSAppUsesNonExemptEncryption` is deliberately unset, so answer per build as the project's compliance notes say.
- [ ] Tag the archived commit `<version>-<build>` and push only that tag (`git push origin <tag>`, never `--tags`).

## Test the uploaded build

- [ ] Install from TestFlight on a physical device.
- [ ] Sign in on a fresh install, including the terms sheet.
- [ ] Report a message, block a user, and unblock them.
- [ ] Settings → About links (terms, contact) open.
- [ ] Push notifications, calls and anything else this release touched.

## App Store Connect

- [ ] Select the build on the version.
- [ ] "What's New" text is written.
- [ ] Screenshots meet current size requirements, and more than half show the app in use.
- [ ] App Review Notes: demo credentials, how to reach each feature under review, and a screen recording on a physical device where Apple asked for one.
- [ ] EULA, privacy policy URL, support URL, age rating and App Privacy answers are correct.
- [ ] Territories and any region-specific restrictions are correct.
- [ ] Submit for review.

## While in review

- [ ] Demo account and servers (homeserver, auth service) stay up.
- [ ] Watch the support mailbox and the App Store Connect inbox; reply to reports and Apple's questions promptly.
- [ ] If rejected: fix, bump the build number, re-run this checklist from the top, and reply in Resolution Center.

## After approval

- [ ] Release the version (or let the scheduled release go out).
- [ ] Publish a GitHub Release from the tag (optional; `--generate-notes` uses the `pr-` labels).
- [ ] Merge `main` back into `develop` if the branches diverged.
- [ ] Close this issue.
