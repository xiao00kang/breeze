--require
--process msg

local handler = require("script.stress.net")
local config = require("config")
dump = Protoz.dump

--event on connect
summer.registerConnect(function(sID)
							handler:onConnect(sID)
						end)

--event on recv message
summer.registerMessage(function(sID, pID, binData)
							handler:onMessage(sID, pID, binData)
						end)

--event on disconnect
summer.registerDisconnect(function(sID)
								handler:onDisconnect(sID)
							end)

--start summer
summer.start()

--dump(config)
--add connector
for i=1, 3 do
	local id = summer.addConnect({ip=config.connect.stress[1].ip, port=config.connect.stress[1].port, reconnect=2})
	if id == nil then
		summer.logw("id == nil when addConnect")
	end
	summer.logi("new connect id=" .. id)
end



--local jsonData = cjson.decode("{\"Himi\":\"himigame.com\"}")
--Protoz.dump(jsonData)
--start summer event loop
while 1 do
	summer.runOnce()
--	summer.runOnce(true) -- call retuen is immediately.
end


