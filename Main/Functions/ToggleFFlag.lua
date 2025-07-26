local cloneref = cloneref or function(...) return ... end
local HttpService = cloneref(game.GetService(game, "HttpService"))

-- keep the original behavior & gsub chain
local function strip(flag: string)
    return flag
        :gsub("DFInt", "")
        :gsub("DFFlag", "")
        :gsub("FFlag", "")
        :gsub("FInt", "")
        :gsub("DFString", "")
        :gsub("FString", "")
        :gsub("FLog", "")
        :gsub("DFLog", "")
        :gsub("DFFLoat", "") -- kept as-is (original typo)
        :gsub("FFloat", "")
        :gsub("DFTime", "")
        :gsub("FTime", "")
        :gsub("DFTest", "")
        :gsub("FTest", "")
        :gsub("DFUInt", "")
        :gsub("FUInt", "")
        :gsub("SFInt", "")
        :gsub("SFFlag", "")
end

return function(flag: string, value: string)
    local type = type or typeof
    if type(flag) ~= "string" then
        return task.spawn(error, "string expected, got " .. type(flag))
    end

    local FFlag: string = Bloxstrap.TouchEnabled and strip(flag) or flag

    -- Safe existence check to prevent crashes
    local ok, current = pcall(function()
        return getfflag(FFlag)
    end)

    if not ok or current == nil then
        local err = isfile(errorlog) and readfile(errorlog) or "Error while loading FFlags: "
        writefile(errorlog, err .. "\nFFlag not found or inaccessible: " .. FFlag .. " (from " .. flag .. ")")
        warn("[Bloxstrap] FFlag not found or inaccessible:", FFlag, "(from", flag .. ")")
        return -- don’t crash, just stop here
    end

    -- If it exists, save & set it
    local fflagfile = HttpService:JSONDecode(readfile("Bloxstrap/FFlags.json"))
    fflagfile[flag] = tostring(value)
    writefile("Bloxstrap/FFlags.json", HttpService:JSONEncode(fflagfile))
    return setfflag(FFlag, tostring(value))
end