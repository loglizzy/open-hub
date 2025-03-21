local playersName = {}
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

return {
    {
        "Dropdown",
        "Select players to kill",
        {
            options = playersName
        }
    },
    {
        "Button",
        "Craft selected weapon",
        function(f)
            for i, name in playersName do
                
            end
        end
    }
}