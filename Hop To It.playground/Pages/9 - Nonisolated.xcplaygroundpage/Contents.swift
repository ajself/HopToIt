//: # 9 — `nonisolated`
//:
//: `nonisolated` means you can call something without `await`.
//: It does not let you read or write actor state from outside isolation.
//:
//: This page shows a safe pattern (stable label + snapshot)
//: and a footgun (nonisolated shared mutable state).

import Foundation

Task {
  await runNonisolatedDemo()
  tprint("Done.")
}
