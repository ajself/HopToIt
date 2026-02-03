//: # 5 — Ordering Is Not Guaranteed
//:
//: An actor runs one message at a time, but the order messages arrive
//: depends on task scheduling. Spawning tasks in a loop is a quick way to see it.

import Foundation

Task {
  await runOrderingIsNotGuaranteedDemo()
  tprint("Done.")
}
