local CoinsUtils = {}



function CoinsUtils.addCoins(player, value)
	local leaderstats = player:WaitForChild('leaderstats')
	local coins = leaderstats:WaitForChild('Coins')
	
	coins.Value += value
	
end

function CoinsUtils.removeCoins(player, value)
	local leaderstats = player:WaitForChild('leaderstats')
	local coins = leaderstats:WaitForChild('Coins')
	
	coins.Value -= value
end


return CoinsUtils
