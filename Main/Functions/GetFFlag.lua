return function(flag: string, value: string?): (string, string?) -> (string?)
	if type(flag) ~= "string" then return task.spawn(error, "string expected, got "..type(flag)) end
	local FFlag: string = Bloxstrap.TouchEnabled and flag:gsub("DFInt", ""):gsub("DFFlag", ""):gsub("FFlag", ""):gsub("FInt", ""):gsub("DFString", ""):gsub("FString", ""):gsub("DFLog", ""):gsub("FLog", ""):gsub("FTime", ""):gsub("DFTime", ""):gsub("FTest", ""):gsub("DFTest", ""):gsub("FLog::DFLog", ""):gsub("FLog::FLog", ""):gsub("DFLog::DFLog", ""):gsub("DFFloat", ""):gsub("FFloat", ""):gsub("FLog::", ""):gsub("DFLog::", "") or flag --> Removes the keyword of the FFlag, setfflag doesn't like those so we will need to remove it.
	
	if getfflag(FFlag) ~= nil then
		return getfflag(FFlag)
	else
		return task.spawn(error, "FFlag expected, got "..FFlag)
	end
end