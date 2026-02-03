import Foundation

final class LegacyAPI {
  func doWork(completion: @escaping (String) -> Void) {
    // Pretend this calls back on a background thread, like many legacy APIs do.
    DispatchQueue.global().async {
      completion("result")
    }
  }
}

@MainActor
final class UIController {
  private let api = LegacyAPI()
  private(set) var labelText: String = "(empty)"

  func start() {
    api.doWork { [weak self] result in
      // We still need an explicit hop to MainActor; the callback may not be on main.
      Task { @MainActor in
        self?.labelText = "UI updated with \(result)"
        tprint(self?.labelText ?? "(nil)")
      }
    }
  }
}

public func runMainActorCallbackHopDemo() async {
  tprint("\n— runMainActorCallbackHopDemo")
  let c = await MainActor.run { UIController() }
  await MainActor.run { c.start() }
  await nap(100)
}
