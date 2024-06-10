--!strict

-- this script is originally from https://github.com/buildthomas/MockDataStoreService to unify the mock conditions
--[[

	DataStoreService.lua
	This module decides whether to use actual datastores or mock datastores depending on the environment.

	This module is licensed under APLv2, refer to the LICENSE file or:
	https://github.com/buildthomas/MockDataStoreService/blob/master/LICENSE
]]

function getService(): MessagingService

	local shouldUseMock = false
	if game.GameId == 0 then -- Local place file
		shouldUseMock = true
	elseif game:GetService("RunService"):IsStudio() then -- Published file in Studio
		local status, _message = pcall(function()
			game:GetService("MessagingService"):PublishAsync("__TEST", "__TEST_" .. os.time())
		end)
		if not status then -- HACK
			-- Can connect to datastores, but no API access
			shouldUseMock = true
		end
	end
	
	-- Return the mock or actual service depending on environment:
	if shouldUseMock then
		warn("INFO: Using MockMessagingService instead of MessagingService")
		return require(script:WaitForChild("MockMessagingService")) :: MessagingService
	else
		return game:GetService("MessagingService") :: MessagingService
	end
end

return getService()
