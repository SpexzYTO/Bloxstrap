local cloneref = cloneref or function(...) return ... end
local HttpService = cloneref(game:GetService("HttpService"))

return function(flag: string, value: string): ()
	local type = type or typeof
	if type(flag) ~= "string" then
		return task.spawn(error, "string expected, got " .. type(flag))
	end

	local setterMap = {
		["FFlag"] = setfflag,
		["FInt"] = setfint,
		["DFInt"] = setdfint,
		["SFInt"] = setsfint,
		["FUInt"] = setfuint,
		["DFUInt"] = setdfuint,
		["FString"] = setfstring,
		["DFString"] = setdfstring,
		["FLog"] = setflog,
		["DFLog"] = setdflog,
		["FFloat"] = setffloat,
		["DFFloat"] = setdffloat,
		["FTest"] = setftest,
		["DFTest"] = setdftest,
		["FTime"] = setftime,
		["DFTime"] = setdftime,
		["SFFlag"] = setsfflag
	}

	local detectedSetter, cleanName
	for prefix, setter in pairs(setterMap) do
		if flag:sub(1, #prefix) == prefix then
			detectedSetter = setter
			cleanName = flag:sub(#prefix + 1)
			break
		end
	end

	local path = "Bloxstrap/FFlags.json"
	local flags = isfile(path) and HttpService:JSONDecode(readfile(path)) or {}

	if detectedSetter then
		local success, err = pcall(function()
			detectedSetter(cleanName, tostring(value))
		end)

		if success then
			flags[flag] = tostring(value)
		else
			warn("❌ Failed to set FastFlag:", flag, "| Error:", err)
			flags[flag] = nil
		end
else
		warn("❌ Unknown flag type for:", flag)
		flags[flag] = nil
	end

	writefile(path, HttpService:JSONEncode(flags))
end