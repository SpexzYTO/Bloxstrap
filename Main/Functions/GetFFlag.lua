return function(flag: string, value: string?): (string, string?) -> (string?)
	if type(flag) ~= "string" then return task.spawn(error, "string expected, got "..type(flag)) end
	local FFlag: string = Bloxstrap.TouchEnabled and flag:gsub("DFInt", ""):gsub("DFFlag", ""):gsub("FFlag", ""):gsub("FInt", ""):gsub("DFString", ""):gsub("FString", "") :gsub("FLog", ""):gsub("DFLog", ""):gsub("DFFLoat", ""):gsub("FFloat", ""):gsub("DFTime", ""):gsub("FTime", ""):gsub("DFTest", ""):gsub("FTest", ""):gsub("DFUInt", ""):gsub("FUInt", ""):gsub("SFInt", ""):gsub("SFFlag", "") or flag --> Removes the keyword of the FFlag, setfflag doesn't like those so we will need to remove it.
	
	if getfflag(FFlag) ~= nil then
		return getfflag(FFlag)
	else
		return task.spawn(error, "FFlag expected, got "..FFlag)
	end
end
