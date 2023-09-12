--!strict
local _Package = script.Parent
local _Packages = _Package.Parent
-- Services
-- Packages
-- Modules
-- Types
-- Constants
-- Variables
local Topics: {[string]: BindableEvent} = {}
-- References
-- Private Functions
function getTopicEvent(key: string): BindableEvent
	if not Topics[key] then
		Topics[key] = Instance.new("BindableEvent")
	end

	local event = Topics[key]
	assert(event, `bad topic`)

	return event
end
-- Class
local MockMessagingService = {}

function MockMessagingService:PublishAsync(topic: string, data: any): ()
	getTopicEvent(topic):Fire({
		Data = data,
		Sent = DateTime.now().UnixTimestamp,
	})
end

function MockMessagingService:SubscribeAsync(topic: string, callback: (data: {
	Data: any,
	Sent: number
}) -> ()): RBXScriptConnection
	return getTopicEvent(topic).Event:Connect(callback)
end


return MockMessagingService