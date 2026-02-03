import Foundation

struct StatusSnapshot: Sendable {
  let hits: Int
  let label: String
}

final class MutableBox {
  var hits = 0
}

struct UnsafeBox: @unchecked Sendable {
  let box: MutableBox
}

actor StatusBoard {
  private var hits = 0

  func hit() {
    hits += 1
  }

  // nonisolated means no await; it does not grant access to isolated state.
  nonisolated var label: String {
    "StatusBoard(\(ObjectIdentifier(self)))"
  }

  // This is always safe because it's static and immutable.
  static let kind = "StatusBoard"

  // Uncomment to see the compiler error.
//   nonisolated var owie: Int { hits }

  // Footgun: a nonisolated stored property that exposes shared mutable state.
  nonisolated let unsafeBox: UnsafeBox

  init() {
    unsafeBox = UnsafeBox(box: MutableBox())
  }

  func snapshot() -> StatusSnapshot {
    StatusSnapshot(hits: hits, label: label)
  }
}

public func runNonisolatedDemo() async {
  tprint("\n— runNonisolatedDemo")
  let board = StatusBoard()

  // These calls do not need `await`.
  tprint("kind = \(StatusBoard.kind)")
  tprint("label = \(board.label)")

  await board.hit()
  await board.hit()

  let snapshot = await board.snapshot()
  tprint("safe snapshot hits = \(snapshot.hits)")

  let unsafe = board.unsafeBox
  let expected = 1_000

  await withTaskGroup(of: Void.self) { group in
    for _ in 0..<expected {
      group.addTask { unsafe.box.hits += 1 }
    }
  }

  tprint("unsafe box expected = \(expected), actual = \(unsafe.box.hits)")
}
