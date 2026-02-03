import Foundation

actor Database {
  func loadUser(id: Int) async -> String {
    // Simulate a small query.
    await nap(5)
    return "user-\(id)"
  }

  func loadUsers(ids: [Int]) async -> [String] {
    // Simulate a more efficient batched query.
    await nap(15)
    return ids.map { "user-\($0)" }
  }
}

@MainActor
final class ViewModel {
  private let db = Database()
  private(set) var users: [String] = []

  /// Naive: hop main -> db -> main on each iteration.
  func loadIndividually(ids: [Int]) async {
    users = []
    for id in ids {
      let u = await db.loadUser(id: id)
      users.append(u)
    }
  }

  /// Better: reduce hops with a single batch.
  func loadBatched(ids: [Int]) async {
    users = await db.loadUsers(ids: ids)
  }
}

public func runActorHoppingDemo() async {
  tprint("\n— runActorHoppingDemo")
  let ids = Array(0..<50)

  let vm = await MainActor.run { ViewModel() }

  let start1 = Date()
  await vm.loadIndividually(ids: ids)
  let dur1 = Date().timeIntervalSince(start1)

  let start2 = Date()
  await vm.loadBatched(ids: ids)
  let dur2 = Date().timeIntervalSince(start2)

  tprint(String(format: "individual: %.3fs, batched: %.3fs", dur1, dur2))
}
