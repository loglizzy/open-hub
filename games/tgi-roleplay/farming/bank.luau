local BankDeposit = game.ReplicatedStorage.Remotes.BankDeposit
return {
    {
        type = "toogle",
        name = "Bank exploit",
        loop = function(f, dt)
            BankDeposit:FireServer(1.5)
        end
    }
}