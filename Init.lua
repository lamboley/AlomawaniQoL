local _, AQL = ...

AQL.Print = function(...)
	DEFAULT_CHAT_FRAME:AddMessage(strjoin('', '|cff00ff00', 'AQL:|r ', ...))
end

AQL['System'] = CreateFrame('Frame')
AQL['Interface'] = CreateFrame('Frame')
