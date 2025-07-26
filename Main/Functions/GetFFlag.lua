local cloneref = cloneref or function(...) return ... end
local HttpService = cloneref(game:GetService("HttpService"))

return function(flag: string, value: string?): (string?)
	if type(flag) ~= "string" then
		return task.spawn(error, "string expected, got " .. type(flag))
	end

	local path = "Bloxstrap/FFlags.json"
	local flags = isfile(path) and HttpService:JSONDecode(readfile(path)) or {}

	local getterMap = {
		["FFlag"] = getfflag,
		["FInt"] = getfint,
		["DFInt"] = getdfint,
		["SFInt"] = getsfint,
		["FUInt"] = getfuint,
		["DFUInt"] = getdfuint,
		["FString"] = getfstring,
		["DFString"] = getdfstring,
		["FLog"] = getflog,
		["DFLog"] = getdflog,
		["FFloat"] = getffloat,
		["DFFloat"] = getdffloat,
		["FTest"] = getftest,
		["DFTest"] = getdftest,
		["FTime"] = getftime,
		["DFTime"] = getdftime,
		["SFFlag"] = getsfflag
	}

	-- Detect flag prefix and remove it for actual flag name
	local detectedGetter, cleanName
	for prefix, getter in pairs(getterMap) do
		if flag:sub(1, #prefix) == prefix then
			detectedGetter = getter
			cleanName = flag:sub(#prefix + 1)
			break
		end
	end

	if not detectedGetter then
		warn("❌ Unknown flag type: " .. flag)
		flags[flag] = nil
		writefile(path, HttpService:JSONEncode(flags))
		return nil
	end

	local success, result = pcall(function()
		return detectedGetter(cleanName)
	end)

	if success and result ~= nil then
		return result
	else
		warn("⚠️ Getter failed for:", flag)
		flags[flag] = nil
		writefile(path, HttpService:JSONEncode(flags))
		return nil
	end
end