import Foundation

/// A reference type with mutable state. This is not Sendable by default.
final class CounterBox {
  var value: Int
  init(_ value: Int) { self.value = value }
}

/// Marking this as @unchecked Sendable just silences the compiler.
/// It does not make the mutation safe.
final class UncheckedCounterBox: @unchecked Sendable {
  var value: Int
  init(_ value: Int) { self.value = value }
}

public func runUncheckedSendablePromiseDemo() async {
  tprint("— runUncheckedSendablePromiseDemo")

  // Swap to CounterBox to see the compiler complain about non-Sendable capture.
//  let box = CounterBox(0)
  let box = UncheckedCounterBox(0)
  let expected = 1_000

  await withTaskGroup(of: Void.self) { group in
    for _ in 0..<expected {
      group.addTask {
        let current = box.value
        await Task.yield()
        box.value = current + 1
      }
    }
  }

  tprint("expected = \(expected), actual = \(box.value)")
  tprint("If this isn't equal, that's the data race your @unchecked promise hid.")
}
