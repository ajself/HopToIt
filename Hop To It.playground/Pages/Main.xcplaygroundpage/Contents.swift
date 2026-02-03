//: # Hop To It: No Deadlocks, No Data Races, No Promises
//: ### Swift Actors Playground (Swift 6.2)
//:
//: This is a guided walk through actor basics and the pitfalls that show up in real code.
//: For the full README, open the Welcome page.
//:
//: Suggested order:
//: 0. Welcome — readme and how to use the playground
//: 1. Actors Overview — mental model + where actors fit
//: 2. Typical Usage — typical actor usage (cache + dedup)
//: 3. Isolation Basics — actor isolation basics
//: 4. Reentrancy — actor reentrancy pitfall + fix
//: 5. Ordering — ordering is not guaranteed
//: 6. Actor Hopping — actor hopping + batching
//: 7. MainActor and Callbacks — MainActor + legacy callback hop
//: 8. Sendable — Sendable / @unchecked Sendable
//: 9. Nonisolated — nonisolated meaning

import Foundation
