# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

OurStories (display name 我们的故事) is a small personal iOS app: a swipeable deck of photo + text "story" cards, plus a map pinning each story's location. It is a keepsake of a couple's shared memories — keep features in that spirit (an earlier "I say yes" proposal popup and email were removed on purpose). Swift 5, UIKit, no third-party dependencies. The deployment target is `$(RECOMMENDED_IPHONEOS_DEPLOYMENT_TARGET)` (iOS 17 with Xcode 27). User-facing strings and story content are in Chinese.

## Commands

```sh
# Build for simulator (substitute an installed simulator name)
xcodebuild -project OurStories.xcodeproj -scheme OurStories \
  -destination 'platform=iOS Simulator,name=iPhone 17' build

# Run all tests
xcodebuild -project OurStories.xcodeproj -scheme OurStories \
  -destination 'platform=iOS Simulator,name=iPhone 17' test

# Run a single test
xcodebuild -project OurStories.xcodeproj -scheme OurStories \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  -only-testing:OurStoriesTests/OurStoriesTests/testEveryStoryImageExists test
```

- `xcodebuild` needs full Xcode. If `xcode-select -p` points at `/Library/Developer/CommandLineTools`, prefix commands with `DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer`.
- If the simulator reports "runtime is not available" although `xcrun simctl runtime list` shows it Ready, restart the service: `killall -9 com.apple.CoreSimulator.CoreSimulatorService`.
- The project uses classic (non-synchronized) groups, so a new source file must also be added to `project.pbxproj`.
- The `OurStories` scheme is not checked in as a shared scheme file; Xcode autogenerates it. There is no linter configured.
- This Xcode has no standalone Simulator app; the simulator display is shown in `Xcode.app/Contents/Applications/DeviceHub.app` or by running from Xcode. `xcrun simctl boot/install/launch` work as usual.

## Tests

- `OurStoriesTests` — story data (every story has text, a valid coordinate and an image that resolves), `TypeOnTextView.typeOnSteps(for:)`, and `CardDeckView` index logic. Run these after editing `Story.swift`.
- `OurStoriesUITests` — walks the deck and opens the map (attaching screenshots to the result bundle), and checks the deck starts over after the last story (about 40s, it taps through every card). They find controls by accessibility identifier: `previous`, `reset`, `next`, `music`, `map`, and the page badge by its `"1 / N"` label — keep those when changing the UI.

## Git workflow

Trunk-based: short-lived `feature/<name>` branches off `master`, merged back through a pull request on GitHub (`XiangXu/OurStories`). Commit in small logical commits. `origin` is an HTTPS URL with no stored credentials, so `git push` fails; push over SSH instead: `git push git@github.com:XiangXu/OurStories.git <branch>`.

## Architecture

**No storyboards for UI** (only `LaunchScreen.storyboard`). The app uses the scene lifecycle: `Info.plist` declares `SceneDelegate`, which builds the window by hand with `UINavigationController(rootViewController: MainViewController())` as root. All views are built in code with lazy/closure-initialised properties and laid out with the `UIView.anchor(top:left:bottom:right:padding…:width:height:)` helper in `Utils/UIView+Helper.swift` — use that helper rather than raw constraints or Interface Builder.

**All content is hardcoded in `Model/Story.swift`.** `Story.storyGenerate()` returns the full, ordered array of stories (location, text, image name, coordinate). There is no persistence or networking. Both screens call it independently:

- `MainViewController` — a `CardDeckView` card deck, one `CardView` per story, with previous / reset / next buttons. When the deck runs out it starts over from the first story. The navigation bar has a music toggle on the left and the map button on the right.
- `MapViewController` — an `MKMapView` with one `VisitPlace` marker per story. A phone cannot show every pin at once, so it opens fitted to the stories within 2,500 km of the median coordinate; the rest are reached by panning.

So adding or editing a story means editing only the array in `Story.swift` (plus adding the image); card order is array order.

**Card deck.** `View/CardDeckView.swift` is an in-app replacement for the Koloda pod: a data source supplies card views, the top card is dragged with a pan gesture, and `swipe(_:)`, `revertAction()` and `resetCurrentCardIndex()` drive it from the buttons. It keeps at most three card views alive and updates its index synchronously, so the delegate callbacks fire before the animations finish.

**Images.** Stories reference images as `"N.png"`, which resolves to the numbered image set `N` in `Assets.xcassets`. The file inside an image set does not necessarily match the set name (e.g. `1.imageset` contains `2.png`, some sets hold `.heic`), so go by the image set name. Many later stories currently reuse `1.png`/`3.png` as placeholders.

**Typewriter text.** `CardView.contentTextField` is a `TypeOnTextView` (`Utils/UITextView-Helper.swift`) that reveals text one character per 0.15s timer tick. In story text, `$` is a control character: it is not printed and consumes one tick (a pause); runs of spaces are emitted within a single tick. The per-tick logic is the pure function `TypeOnTextView.typeOnSteps(for:)`, which is what the unit tests cover. Typing is kicked off in `cardDeck(_:didShowCardAt:)`, which calls `resetTypeOn()` first — keep that reset/start pairing when touching card lifecycle code.

**Background music.** `MusicHelper.sharedHelper` loops `Resources/jay.mp3`. It starts in `MainViewController.viewDidLoad` and the music-note button in the navigation bar pauses and resumes it.

**Theming.** The look is a warm "memory album": the palette lives in `Utils/UIColor+Helper.swift` as dynamic light/dark colours (`rose` accent, `appBackground`, `cardBackground`, `titleText`, `bodyText`) — use those rather than system or hardcoded colours. `rose` is also the window tint (`SceneDelegate`). Icons are SF Symbols, fonts are system fonts (iOS ships no Chinese serif face, so `Songti` is not an option without bundling a font), and the navigation bar keeps the system appearance apart from the title font set in `AppDelegate`. Story text gets its line spacing through `TypeOnTextView.typeOnAttributes`, because appending to `text` would drop paragraph styles.

**App icon.** `Assets.xcassets/AppIcon.appiconset/AppIcon.png` is a single 1024px image (no alpha), drawn by `scripts/make-icon.swift` (`swift scripts/make-icon.swift out.png`, then flatten the alpha channel before replacing the file).

**Docs.** `README.md` is the user-facing guide and embeds screenshots from `docs/`; update both when the UI changes noticeably. The old button images (`smile`, `heart`, `vibe`, `earth`) remain in the asset catalog but are unused.
