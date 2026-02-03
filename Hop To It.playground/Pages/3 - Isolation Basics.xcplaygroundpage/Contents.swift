//: # 3 — Isolation Basics
//:
//: Actors protect their mutable state by allowing only one task at a time
//: to run actor-isolated code.
//:
//: Run this page to see that 1,000 concurrent increments still produce the right final value.

import Foundation

Task {
  await runCounterBasicsDemo()
  tprint("Done.")
}
