local BankDeposit = game.ReplicatedStorage.Remotes.BankDeposit
return {
    {
        "Checkbox",
        "Generate money using Bank",
        loop = function(f, dt)
            BankDeposit:FireServer(1.5)
        end
    }
}