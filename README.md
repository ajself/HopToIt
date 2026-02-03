# Hop To It: No Deadlocks, No Data Races, No Promises

A small Swift Playground on actors: what they are, how they behave, and where the common pitfalls live.

## How to use
- Open `Hop To It.playground` in Xcode.
- Use the page navigator on the left to choose a topic.
- Editor > Show Rendered Markup for the business casual level experience of markdown rendering 👔.
- Editor > Show Raw Markup for plain 'ol markdown in it's purest form... plain text 👕.
- Run a page and watch the console output.

<details>
  <summary>Try it, you might like it.</summary>
  <img width="200" height="916" alt="Give-it-a-whirl" src="https://github.com/user-attachments/assets/bc03a04f-caeb-4aea-b453-74aaf2b9932a" />
</details>

## Contents
1. Actors Overview
2. Typical Usage
3. Isolation Basics
4. Reentrancy
5. Ordering
6. Actor Hopping
7. MainActor and Callbacks
8. Sendable
9. Nonisolated

## Notes
- Many examples are intentionally short and a little noisy to make ordering visible.
- Some demos are nondeterministic. Re-run a page if the behavior does not show up the first time.

## Helpful reading
- [Swift Actors Pitfalls (Fractal)](https://www.fractal-dev.com/blog/swift-actors-pitfalls)
- [SwiftLee: Actors in Swift](https://www.avanderlee.com/swift/actors/)
- [SwiftRocks: How Actors Work Internally in Swift](https://swiftrocks.com/how-actors-work-internally-in-swift)
- [SwiftLee: Approachable Concurrency in Swift 6.2](https://www.avanderlee.com/concurrency/approachable-concurrency-in-swift-6-2-a-clear-guide/)
- [Swift Forums: SE-0306 acceptance note](https://forums.swift.org/t/accepted-with-modification-se-0306-actors/47662)
- [Apple WWDC21: Protect mutable state with Swift actors](https://developer.apple.com/videos/play/wwdc2021/10133/)
- [Apple WWDC22: Eliminate data races using Swift Concurrency](https://developer.apple.com/videos/play/wwdc2022/110351/)
- [Apple WWDC21: Swift concurrency: Behind the scenes](https://developer.apple.com/videos/play/wwdc2021/10254/)
