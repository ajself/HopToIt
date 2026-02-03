//: # 6 — Actor Hopping (Performance Smell)
//:
//: Frequent crossings between `@MainActor` and another actor can add overhead,
//: especially in loops. Batching reduces the number of hops.

import Foundation

Task {
  await runActorHoppingDemo()
  tprint("Done.")
}
