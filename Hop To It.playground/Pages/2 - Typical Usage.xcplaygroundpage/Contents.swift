//: # 2 — Typical Usage (Swift 6.2)
//:
//: ## What problem does an actor solve?
//: - Shared mutable state across tasks leads to data races.
//: - Manual locking and queues are easy to get wrong and hard to review.
//: - Actors let the compiler enforce *isolation* around mutable state.
//:
//: ## When do I reach for an actor?
//: - A cache / registry / index shared by multiple features.
//: - A deduplicating "in-flight requests" map.
//: - A gate or rate limiter (only allow N operations).
//: - A lightweight coordinator for mutable bookkeeping.
//:
//: ## What changes at the call site?
//: - Outside the actor, you typically use `await` to access isolated members.
//: - Every `await` is a suspension point (we use this in later pages).
//:
//: This page includes a practical actor you can reuse: a small cache that:
//: - caches results
//: - deduplicates concurrent requests for the same key
//:
//: Then we call it from multiple concurrent tasks.
//:
//: Run the page and skim the console output.

import Foundation

Task {
  await runTypicalActorUsageCacheAndDedupDemo()
  tprint("Done.")
}
