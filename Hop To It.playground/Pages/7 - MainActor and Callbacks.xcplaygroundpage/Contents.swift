//: # 7 — `@MainActor` Is Not a Runtime Force-Field
//:
//: `@MainActor` is an isolation contract enforced at Swift concurrency boundaries.
//: Legacy callbacks (delegates, completion handlers) can arrive on background threads,
//: so you still need an explicit hop back to `MainActor`.

import Foundation

Task {
  await runMainActorCallbackHopDemo()
  tprint("Done.")
}
