import Foundation

// MARK: - Typical actor: cache + in-flight request deduplication

/// A small cache actor that stores string payloads by key.
/// It also deduplicates concurrent fetches so only one "network" operation
/// runs per key at a time.
///
/// This is a common actor use case: shared mutable state with light coordination.
actor PayloadCache {
  private var cached: [String: String] = [:]
  private var inFlight: [String: Task<String, Never>] = [:]

  func get(_ key: String) -> String? {
    cached[key]
  }

  func value(for key: String) async -> String {
    // Fast path: return cached value.
    if let cached = cached[key] { return cached }

    // If a request is already in flight for this key, await it.
    if let task = inFlight[key] {
      return await task.value
    }

    // Otherwise start a new one and record it.
    let task = Task<String, Never> {
      tprint("fetching \(key)…")
      await nap(50) // pretend network/disk
      return "payload(\(key))"
    }
    inFlight[key] = task

    // Wait for the fetch.
    let value = await task.value

    // Update the cache and clear in-flight tracking.
    cached[key] = value
    inFlight[key] = nil

    return value
  }

  func clear() {
    cached.removeAll()
  }
}

// MARK: - Demo

public func runTypicalActorUsageCacheAndDedupDemo() async {
  tprint("\n— runTypicalActorUsageCacheAndDedupDemo")
  let cache = PayloadCache()

  // Simulate concurrent callers asking for the same key.
  await withTaskGroup(of: String.self) { group in
    for i in 0..<8 {
      group.addTask {
        let key = (i % 2 == 0) ? "A" : "A"  // all callers request A
        let value = await cache.value(for: key)
        return "caller\(i) got \(value)"
      }
    }

    for await line in group {
      tprint(line)
    }
  }

  // Next access should be a cache hit (no "fetching…").
  let again = await cache.value(for: "A")
  tprint("subsequent read: \(again)")
}
