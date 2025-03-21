local HTTPService = game:GetService("HttpService")
local function JSONDecode(data)
    return HTTPService:JSONDecode(data)
end

local function GetHTTPJSON(url)
    return JSONDecode(game:HttpGet(url))
end

local repo = "loglizzy/open-hub"
local ui = loadstring(GetHTTPJSON(`{repo}/ui.luau`))()
table.foreach(ui, print)

local apiRepoUrl = `https://api.github.com/repos/{repo}/`
local placeId = game.PlaceId
local apiGameUrl
for gameName, gameInfo in GetHTTPJSON(`{apiRepoUrl}/contents/games.json`) do
    if gameInfo.placeId == placeId then
        apiGameUrl = `{apiRepoUrl}/contents/games/{gameName}`
    end
end

-- Load UI sections
for i, section in GetHTTPJSON(apiGameUrl) do
    local sectionType = section.type
    -- Loads section features
    if sectionType == "dir" then
        local sectionName = section.name
        for i, file in GetHTTPJSON(section.url) do
            if file.type ~= "file" then continue end

            local fileContent = game:HttpGet(file.download_url)
        end
    -- Starts singleton
    elseif sectionType == "file" then
        task.spawn(loadstring(game:HttpGet(section.download_url)))
    end
end