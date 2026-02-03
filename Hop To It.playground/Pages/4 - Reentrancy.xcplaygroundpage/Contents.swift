//: # 4 — Reentrancy Pitfall
//:
//: Key idea: actor isolation does *not* make a method atomic.
//: Atomic: an operation that happens all at once, so nothing else can interleave with it.
//: Every `await` is a suspension point where the actor can process other messages.
//:
//: Run this page a few times. The "bad" example can produce a negative balance.
//: (No data race — still logically incorrect.)

import Foundation

Task {
  await runReentrancyBugDemo()
  await runReentrancyReserveFixDemo()
  tprint("Done.")
}
