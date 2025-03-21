local function GetStringLetters(str)
    return string.gsub(str, "[^%a]", "")
end

local HTTPService = game:GetService("HttpService")
local cacheDir = "cache"
makefolder(cacheDir)

cacheDir = `{cacheDir}/open-hub`
makefolder(cacheDir)

local function GetHTTPJSON(url)
    local file = `{cacheDir}/{GetStringLetters(url)}`
    local body
    if isfile(file) then 
        body = readfile(file)
    else
        body = game:HttpGet(url)
        writefile(file, body)
    end

    return HTTPService:JSONDecode(body)
end

local function GetBaseName(fileName)
    local at = fileName:find("%.")
    at = if at then at - 1 else #fileName
    return fileName:sub(1, at)
end

local function GetFirstCaseUpperString(str)
    return str:sub(1, 1):upper() .. str:sub(2, #str)
end

local repo = "loglizzy/open-hub"
local repoDownloadUrl = `https://raw.githubusercontent.com/{repo}/main`
local Finity = loadstring(game:HttpGet(`{repoDownloadUrl}/ui.luau`))()

local apiRepoUrl = `https://api.github.com/repos/{repo}`
local placeId = game.PlaceId
local apiGameUrl = `{apiRepoUrl}/contents/games/tgi-roleplay`
-- for gameName, gameInfo in GetHTTPJSON(`{repoDownloadUrl}/games.json`) do
--     if gameInfo.placeId == placeId then
--         apiGameUrl = `{apiRepoUrl}/contents/games/{gameName}`
--         break
--     end
-- end

local window = Finity.new(true)
window.ChangeToggleKey(Enum.KeyCode.Semicolon)

-- Load UI categories
for i, categoryFile in GetHTTPJSON(apiGameUrl) do
    local categoryFileType = categoryFile.type
    print(categoryFile)
    if categoryFileType == "dir" then
        local categoryName = GetFirstCaseUpperString(categoryFile.name)
        local category = window:Category(categoryName)
        for i, sectionFile in GetHTTPJSON(categoryFile.url) do
            if sectionFile.type ~= "file" then continue end

            local sectionName = GetFirstCaseUpperString(GetBaseName(sectionFile.name))
            local func = loadstring(game:HttpGet(sectionFile.download_url))
            if not func then
                warn(`Section {sectionName} has an syntax error and couldnt be compiled`)
                continue
            end

            local ok, feature = pcall(func)
            if not ok then
                warn(`Section {sectionName} error when being loaded: {ok}`)
                continue
            end

            -- Creating section
            local section = category:Sector(sectionName)
            
            -- Loads section features
            for i, v in feature do
                local a, b, c = print(table.unpack(v))
                print(a)
            end
        end
    -- Starts singleton
    elseif categoryFileType == "file" then
        task.spawn(loadstring(game:HttpGet(categoryFile.download_url)))
    end
end