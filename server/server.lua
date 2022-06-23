local VORPcore = {}
local VORPinv

TriggerEvent("getCore", function(core)
    VORPcore = core
end)

VORPinv = exports.vorp_inventory:vorp_inventoryApi()

for k, item in ipairs(Config.Items) do
    VORPinv.RegisterUsableItem(item.seedName, function(data)
        VORPinv.subItem(data.source, item.seedName, 1)
        TriggerClientEvent('irb_farming:planting', data.source, item.seedName, item.plant1, item.plant2, item.plant3)
    end)
end

VORPinv.RegisterUsableItem("wateringcan", function(data)
    TriggerClientEvent('irb_farming:waterplant', data.source)
end)

RegisterServerEvent('irb_farming:giveback')
AddEventHandler('irb_farming:giveback', function(item)
	local _source = source
	TriggerClientEvent('vorp:TipBottom', _source, _U("farmingZone"), 4000)
	Wait(1000)
	VORPinv.addItem(_source, item, 1)
end) 

RegisterServerEvent('irb_farming:giveitem')
AddEventHandler('irb_farming:giveitem', function(plant)
    local _source = source
	local count = math.random(Config.Harvest.min, Config.Harvest.max)
    
    for k, item in ipairs(Config.Items) do
        if plant == item.plant3 then
            TriggerClientEvent("vorp:TipRight", _source, _U("haveCollected") .. '[X'..count..'] ' .. _U(item.name), 3000)
            VORPinv.addItem(_source, item.name, count)
        end
    end
end)
