local BankDeposit = game.ReplicatedStorage.Remotes:WaitForChild("BankDeposit", 10)
assert(BankDeposit, "BankDeposit remote not found. Game is most likely to have been updated.")

return {
    {
        "Checkbox",
        "Generate money using Bank",
        loop = function(f, dt)
            BankDeposit:FireServer(1.5)
        end
    }
}