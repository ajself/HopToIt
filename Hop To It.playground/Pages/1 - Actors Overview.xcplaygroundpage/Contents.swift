//: # 1 — Actors: a working mental model
//:
//: An actor is a reference type that protects mutable state.
//: Only one task runs actor-isolated code at a time; callers `await`.
//:
//: Keep in mind: actors are reentrant after `await`, and message order isn't guaranteed.
//:
//: Reentrant means a function can be entered again while a previous call is still suspended and
//: hasn’t finished. In Swift actors, any await is a suspension point; once you hit it, the actor
//: is free to start handling other messages. That’s reentrancy.
//:
//: Actor method reenters after await:
//: ```swift
//:actor BankAccount {
//:  private var balance = 100
//:
//:  func withdraw(_ amount: Int) async -> Bool {
//:    guard balance >= amount else { return false }
//:    await Task.yield() // suspension point → reentrancy can happen here
//:    balance -= amount
//:    return true
//:  }
//:}
//:
//:let account = BankAccount()
//:
//:Task {
//:  async let a = account.withdraw(80)
//:  async let b = account.withdraw(80)
//:  let (ra, rb) = await (a, b)
//:  print(ra, rb) // can both be true because of reentrancy
//:}
//:
//: ```
//: Actors aren’t “the new DispatchQueue.” They solve a different problem: data isolation and
//: correctness across concurrency boundaries. DispatchQueue is a scheduling tool. You still use
//: queues for some legacy APIs, non‑async contexts, or when you’re explicitly managing execution
//: order/QoS outside Swift concurrency.
//: Run this page to see a tiny reentrancy peek.
//:
//: Helpful reading: https://www.fractal-dev.com/blog/swift-actors-pitfalls
import Foundation

actor TinyCounter {
  private var value = 0

  func increment(id: Int) async {
    tprint("task \(id) started")
    await nap(30)
    value += 1
    tprint("task \(id) finished -> \(value)")
  }

  func get() -> Int { value }
}

Task {
  let counter = TinyCounter()

  await withTaskGroup(of: Void.self) { group in
    for id in 1...4 {
      group.addTask { await counter.increment(id: id) }
    }
  }

  tprint("final value = \(await counter.get())")
}
