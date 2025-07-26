local cloneref = cloneref or function(...) return ... end
local HttpService = cloneref(game:GetService("HttpService"))

return function(flag: string, value: string?): (string?)
	if type(flag) ~= "string" then
		return task.spawn(error, "string expected, got " .. type(flag))
	end

	local FFlag: string = Bloxstrap.TouchEnabled and flag
		:gsub("DFInt", "")
		:gsub("DFFlag", "")
		:gsub("FFlag", "")
		:gsub("FInt", "")
		:gsub("DFString", "")
		:gsub("FString", "")
		:gsub("FLog", "")
		:gsub("DFLog", "")
		:gsub("DFFLoat", "")
		:gsub("FFloat", "")
		:gsub("DFTime", "")
		:gsub("FTime", "")
		:gsub("DFTest", "")
		:gsub("FTest", "")
		:gsub("DFUInt", "")
		:gsub("FUInt", "")
		:gsub("SFInt", "")
		:gsub("SFFlag", "")
		or flag

	local path = "Bloxstrap/FFlags.json"
	local flags = isfile(path) and HttpService:JSONDecode(readfile(path)) or {}

	local success, result = pcall(getfflag, FFlag)

	if success and result ~= nil then
		return result
	else
		warn("⚠️ getfflag failed for:", FFlag)
		flags[flag] = nil
		writefile(path, HttpService:JSONEncode(flags))
		return nil
	end
end