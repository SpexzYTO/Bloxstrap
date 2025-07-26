local cloneref = cloneref or function(...) return ... end
local HttpService = cloneref(game:GetService("HttpService"))

return function(flag: string, value: string): (string, string) -> ()
	local type = type or typeof
	if type(flag) ~= "string" then
		return task.spawn(error, "string expected, got " .. type(flag))
	end

	local FFlag: string = flag
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

	local path = "Bloxstrap/FFlags.json"
	local flags = HttpService:JSONDecode(readfile(path))

	local success, err = pcall(function()
		setfflag(FFlag, tostring(value))
	end)

	if success then
		flags[flag] = tostring(value)
	else
		warn("❌ Failed to set FastFlag:", flag, "| Error:", err)
		flags[flag] = nil -- remove it from the list
	end

	writefile(path, HttpService:JSONEncode(flags))
end