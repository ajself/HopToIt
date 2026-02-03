//: # 8 — `Sendable` and `@unchecked Sendable`
//:
//: `Sendable` is the compiler's way of asking, "Is it safe to move this value
//: across concurrency boundaries?"
//:
//: `@unchecked Sendable` says, "Trust me." This example shows how that can go wrong.
//:
//: Run this page a few times. The final value can come out lower than expected.

import Foundation

Task {
  await runUncheckedSendablePromiseDemo()
  tprint("Done.")
}
