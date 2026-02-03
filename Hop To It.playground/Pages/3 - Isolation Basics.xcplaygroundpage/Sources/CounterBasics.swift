import Foundation

actor Counter {
  private var value = 0

  func increment() {
    value += 1
  }

  func get() -> Int {
    value
  }
}

public func runCounterBasicsDemo() async {
  tprint("\n— runCounterBasicsDemo")
  let counter = Counter()

  await withTaskGroup(of: Void.self) { group in
    for _ in 0..<1_000 {
      group.addTask { await counter.increment() }
    }
  }

  let value = await counter.get()
  tprint("Counter value = \(value) (expected 1000)")
}
