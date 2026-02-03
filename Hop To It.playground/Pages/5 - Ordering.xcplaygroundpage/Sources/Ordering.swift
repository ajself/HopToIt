import Foundation

actor Logger {
  func log(_ message: String) {
    tprint("log: \(message)")
  }
}

public func runOrderingIsNotGuaranteedDemo() async {
  tprint("\n— runOrderingIsNotGuaranteedDemo")
  let logger = Logger()

  // Often prints out of order because task scheduling is nondeterministic.
  for i in 0..<10 {
    Task { await logger.log("message \(i)") }
  }

  // Let the spawned tasks finish.
  await nap(200)
}
