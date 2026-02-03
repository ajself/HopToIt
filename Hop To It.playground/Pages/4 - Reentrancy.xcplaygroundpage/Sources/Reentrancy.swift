import Foundation

// MARK: - Reentrancy pitfall (actor ≠ serial queue)

actor BankAccountBad {
  private var balance: Int

  init(balance: Int) {
    self.balance = balance
  }

  func withdraw(_ amount: Int) async -> Bool {
    // Looks safe, but it's only data-race safe; the logic can still fail.
    guard balance >= amount else { return false }

    // Suspension point: the actor can process other messages now.
    await nap(50)

    balance -= amount
    return true
  }

  func getBalance() -> Int { balance }
}

public func runReentrancyBugDemo() async {
  tprint("\n— runReentrancyBugDemo")
  let account = BankAccountBad(balance: 100)

  // Two concurrent withdrawals of 80 should never both succeed.
  async let a = account.withdraw(80)
  async let b = account.withdraw(80)

  let (ra, rb) = await (a, b)
  let final = await account.getBalance()

  tprint("withdraw results: a=\(ra) b=\(rb)")
  tprint("final balance: \(final)  (BUG: can become -60)")
}

// MARK: - A pragmatic fix: reserve before the first await

actor BankAccountReserve {
  private var balance: Int

  init(balance: Int) {
    self.balance = balance
  }

  func withdraw(_ amount: Int) async -> Bool {
    guard balance >= amount else { return false }

    // Reserve the balance before the first await.
    balance -= amount

    // Do async work after reserving (authorization, network, etc.).
    await nap(50)

    // In real life, you'd add a compensating action if authorization fails.
    return true
  }

  func getBalance() -> Int { balance }
}

public func runReentrancyReserveFixDemo() async {
  tprint("\n— runReentrancyReserveFixDemo")
  let account = BankAccountReserve(balance: 100)

  async let a = account.withdraw(80)
  async let b = account.withdraw(80)

  let (ra, rb) = await (a, b)
  let final = await account.getBalance()

  tprint("withdraw results: a=\(ra) b=\(rb)")
  tprint("final balance: \(final)  (expected 20, with one failure)")
}
