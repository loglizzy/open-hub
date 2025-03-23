local playersName = {
    "All"
}
local playerNameMap = {}
game.Players.PlayerAdded:Connect(function(player)
    table.insert(playersName, player.Name)
    playerNameMap[player] = #playersName
end)

game.Players.PlayerRemoving:Connect(function(player)
    local idx = playerNameMap[player]
    local len = #playersName
    for i = idx, len - 1 do
        playersName[i] = playersName[i + 1]
    end

    playersName[len] = nil
end)

local selectedPlayer

local function KillPlayer(player: Player)
    
end

return {
    {
        "Dropdown",
        "Select players to kill",
        function(f, option)
            selectedPlayer = option
        end,
        {
            options = playersName
        }
    },
    {
        "Button",
        "Kill selected player(s)",
        function(f)
            if selectedPlayer == "All" then
                for i, v in game.Players:GetPlayers() do
                    KillPlayer(v)
                end
                
                return
            end

            KillPlayer(game.Players:FindFirstChild(selectedPlayer))
        end
    }
}