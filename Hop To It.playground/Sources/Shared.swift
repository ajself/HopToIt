import Foundation

/// Short pause helper that keeps async demos readable.
public func nap(_ milliseconds: Int) async {
  try? await Task.sleep(for: .milliseconds(milliseconds))
}

/// Timestamped print that stays readable while you skim logs.
private let tprintFormat = Date.FormatStyle()
  .hour(.twoDigits(amPM: .omitted))
  .minute(.twoDigits)
  .second(.twoDigits)
  .secondFraction(.fractional(3))

public func tprint(_ message: String) {
  let stamp = Date.now.formatted(tprintFormat)
  print("[\(stamp)]", message)
}
