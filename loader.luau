local function GetCachedRequest(url)
    if isfile(url) then
        return readfile(url)
    end

    local body = game:HttpGet(url)
    writefile(url, body)

    return body
end

local HTTPService = game:GetService("HttpService")
local function JSONDecode(data)
    return HTTPService:JSONDecode(data)
end

local apiRepoUrl = "https://api.github.com/repos/OWNER/open-hub/contents"