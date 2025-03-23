local function GetStringLetters(str)
    return string.gsub(str, "[^%a]", "")
end

local HTTPService = game:GetService("HttpService")
local cacheDir = "cache"
makefolder(cacheDir)

cacheDir = `{cacheDir}/open-hub`

local function GetCachedHTTP(url)
    local file = `{cacheDir}/{GetStringLetters(url)}`
    local body
    if isfile(file) then 
        body = readfile(file)
    else
        body = game:HttpGet(url)
        writefile(file, body)
    end

    return body
end

local function GetHTTPJSON(url)
    local body = GetCachedHTTP(url)

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
local apiRepoUrl = `https://api.github.com/repos/{repo}`
local lastGamesSHA
local lastGamesSHADir = `{cacheDir}/lastGamesSHA`
if isfile(lastGamesSHADir) then
    lastGamesSHA = readfile(lastGamesSHADir) 
end

for i, v in GetHTTPJSON(`{apiRepoUrl}/contents`) do
    if v.name == "games" then
        if v.sha ~= lastGamesSHA then
            delfolder(cacheDir)

            lastGamesSHA = v.sha
            writefile(lastGamesSHADir, lastGamesSHA)

            break
        end
    end
end

makefolder(cacheDir)

local repoDownloadUrl = `https://raw.githubusercontent.com/{repo}/main`
local Finity = loadstring(game:HttpGet(`{repoDownloadUrl}/ui.luau`))()

local placeId = game.PlaceId
local apiGameUrl
for gameName, gameInfo in GetHTTPJSON(`{repoDownloadUrl}/games.json`) do
    print(gameInfo.placeId)
    if gameInfo.placeId == placeId then
        apiGameUrl = `{apiRepoUrl}/contents/games/{gameName}`
        break
    end
end

local StarterGui = game:GetService("StarterGui")
local bindable = Instance.new("BindableFunction")
function bindable.OnInvoke()
    setclipboard(`https://github.com/{repo}`)
end

StarterGui:SetCore("SendNotification", {
	Title = "Open-hub";
	Text = "That's an open source project hosted on github";
	Callback = bindable;
    Button1 = "Copy repository url";
    Duration = 10;
})

if not apiGameUrl then
    StarterGui:SetCore("SendNotification", {
    	Title = "Game not supported";
    	Text = "No one made features to that game yet";
        Duration = 10;
    })

    return
end

local window = Finity.new(true)
window.ChangeToggleKey(Enum.KeyCode.Semicolon)

-- Load UI categories
local flags = {}
for i, categoryFile in GetHTTPJSON(apiGameUrl) do
    local categoryFileType = categoryFile.type

    if categoryFileType == "dir" then
        local categoryName = GetFirstCaseUpperString(categoryFile.name)
        
        local categoryFlags = {}
        flags[categoryName] = categoryFlags

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
            for _, v in feature do
                for i = 3, 4 do
                    local fn = v[i]
                    if type(fn) == "function" then
                        v[i] = function(...)
                            fn(flags, ...)
                        end

                        break
                    end
                end

                section:Cheat(table.unpack(v))
            end
        end
    -- Starts singleton
    elseif categoryFileType == "file" then
        task.spawn(loadstring(GetCachedHTTP(categoryFile.download_url)))
    end
end