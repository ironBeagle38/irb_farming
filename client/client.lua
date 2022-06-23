local myPlants = {}
local myPlants2 = {}
local myPlants3 = {}
local isPlanting = false
local Zones = {}
local zonename = NIL
local inFarmZone = false

CreateThread(function() 
    for k=1, #Config.FarmZone do
		if Config.FarmZone[k].showBlips then
			local blipsInfo = Config.FarmZone[k].blips
			local blip = N_0x554d9d53f696d002(1664425300, blipsInfo.x, blipsInfo.y, blipsInfo.z)
			SetBlipSprite(blip, blipsInfo.sprite, 1)
			SetBlipScale(blip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, blip, _U("zoneName"))
		end
		Zones[k] = PolyZone:Create(Config.FarmZone[k].zones, {
			name = Config.FarmZone[k].name,
			minZ = 	Config.FarmZone[k].minz,
			maxZ = Config.FarmZone[k].maxz,
			debugPoly = false,
		})
		Zones[k]:onPlayerInOut(function(isPointInside)
			if isPointInside then
				inFarmZone = true
				zonename = Zones[k].name
                TriggerEvent('vorp:ShowBasicTopNotification', _U("zoneName"), 4000)
			else
				inFarmZone = false
			end
		end)
    end
end)

-- planting (must be in farming zone)
RegisterNetEvent('irb_farming:planting')
AddEventHandler('irb_farming:planting', function(itemn, hash1, hash2, hash3)
	if inFarmZone == true then
		local myPed = PlayerPedId()
		local itemname = tostring(itemn)
		local plant1 = hash1
		if not HasModelLoaded(plant1) then
			RequestModel(plant1)
		end
		while not HasModelLoaded(plant1) do
			Citizen.Wait(100)
		end
		if isPlanting == false then
			isPlanting = true
			TaskStartScenarioInPlace(myPed, `WORLD_HUMAN_FARMER_RAKE`, 10000, true, false, false, false)
			Wait(10000)
			ClearPedTasks(myPed)
			SetCurrentPedWeapon(myPed, `WEAPON_UNARMED`, true)		
			Wait(1000)
			TaskStartScenarioInPlace(myPed, `WORLD_HUMAN_FARMER_WEEDING`, 20000, true, false, false, false)
			Wait(20000)
			ClearPedTasks(myPed)
			SetCurrentPedWeapon(myPed, `WEAPON_UNARMED`, true)
			local pPos = GetEntityCoords(myPed, true)
			local object = CreateObject(plant1, pPos.x, pPos.y, pPos.z, true, true, false)
			local plantCount = #myPlants+1
			myPlants[plantCount] = {["object"] = object, ['x'] = pPos.x, ['y'] = pPos.y, ['z'] = pPos.z, ['stage'] = 1, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3,}
			PlaceObjectOnGroundProperly(myPlants[plantCount].object)
			SetEntityAsMissionEntity(myPlants[plantCount].object, true)
			SetModelAsNoLongerNeeded(plant1)
            TriggerEvent('vorp:TipBottom', _U("plantingFinished"), 4000)
			isPlanting = false
		else
            TriggerEvent('vorp:TipBottom', _U("plantingFirst"), 4000)
		end
	else
        TriggerServerEvent('irb_farming:giveback', itemn)
	end
end)

RegisterNetEvent('irb_farming:waterplant')
AddEventHandler('irb_farming:waterplant', function(source)
    if isPlanting == false then
        local pos = GetEntityCoords(PlayerPedId(), true)
        local object = nil
        local key = nil
        local hash1, hash2, hash3 = nil, nil, nil
        local planta = GetEntityCoords(object, true)
        local x, y, z = nil, nil, nil
        
        for k, v in ipairs(myPlants) do
            if v.stage == 1 then
                if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 2.0 then
                    object = v.object
                    key = k
                    x, y, z = v.x, v.y, v.z
                    hash1, hash2, hash3 = v.hash, v.hash2, v.hash3
                    break
                end
            end
        end
        
        local plant2 = hash2
        
        if DoesEntityExist(object) then
            isPlanting = true
            dowaterplant()

            RequestModel(plant2)

            while not HasModelLoaded(plant2) do
                Citizen.Wait(1)
            end

            DeleteObject(object)
            table.remove(myPlants, key)
            Wait(800)
            local object = CreateObject(plant2, x, y, z, true, true, false)
            local plantCount = #myPlants2+1
            myPlants2[plantCount] = {["object"] = object, ['x'] = x, ['y'] = y, ['z'] = z, ['stage'] = 2, ['timer'] = Config.TimeToGrow, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3}
            PlaceObjectOnGroundProperly(myPlants2[plantCount].object)
            SetEntityAsMissionEntity(myPlants2[plantCount].object, true)
            SetModelAsNoLongerNeeded(plant2)
            isPlanting = false
        end
    else
        TriggerEvent('vorp:TipBottom', _U("finishFirst"), 4000)
    end
end)

RegisterNetEvent('irb_farming:fin2')
AddEventHandler('irb_farming:fin2', function(object2, x, y, z, key, hash1, hash2, hash3)
    local planta2 = GetEntityCoords(object2, true)
    TriggerEvent('vorp:TipBottom', _U("hasGrown"), 4000)
    
    local plant3 = hash3
    
    RequestModel(plant3)

    while not HasModelLoaded(plant3) do
        Citizen.Wait(1)
    end
    
    DeleteObject(object2)
    Wait(800)
    local object3 = CreateObject(plant3, x, y, z, true, true, false)
    PlaceObjectOnGroundProperly(object3)
    local plantCount = #myPlants3+1
    myPlants3[plantCount] = {["object"] = object3, ['x'] = x, ['y'] = y, ['z'] = z, ['stage'] = 3, ['prompt'] = false, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3,}
    PlaceObjectOnGroundProperly(myPlants3[plantCount].object)
    SetEntityAsMissionEntity(myPlants3[plantCount].object, true)
    SetModelAsNoLongerNeeded(plant3)
end)

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local pos = GetEntityCoords(PlayerPedId(), true)
		if myPlants2 ~= nil then
			for k, v in ipairs(myPlants2) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 15.0 then
					if v.stage == 2 then
						v.timer = v.timer-1
						if v.timer == 0 then
							v.stage = 3
							local key = k
							TriggerEvent('irb_farming:fin2', v.object, v.x, v.y, v.z, key, v.hash, v.hash2, v.hash3)
						end
					end    
				end
			end
		end
		if myPlants3 ~= nil then
			for k, v in ipairs(myPlants3) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 15.0 then
					if v.stage == 3 and GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) <= 2.0 then
						if not v.prompt then
							v.prompt = true
						end
					end   
					if v.stage == 3 and GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) > 2.1 then
						if v.prompt then
							v.prompt = false
						end
					end
				end
			end
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
        local pos = GetEntityCoords(PlayerPedId(), true)
		if myPlants ~= nil  then
			for k, v in ipairs(myPlants) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 1.0 then
					if v.stage == 1 then
                        DrawText3D(v.x, v.y, v.z, _U("watering"))
					end
				end
			end
        end
        if myPlants2 ~= nil then
            for k, v in ipairs(myPlants2) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 1.0 then
					if v.stage == 2 then
                        DrawText3D(v.x, v.y, v.z, _U("harvestIn") .. v.timer)
					end
				end
			end
        end
        if myPlants3 ~= nil then
            for k, v in ipairs(myPlants3) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 1.0 then
					if v.stage == 3 then
                        DrawText3D(v.x, v.y, v.z, _U("toHarvest") .. Config.Harvest.keyLabel)
					end
					if v.prompt then
                        if isPlanting == false then
                            if Citizen.InvokeNative(0x91AEF906BCA88877, 0, Config.Harvest.key) then
                                local key = k
                                if isPlanting == false then
                                    isPlanting = true
                                    local myPed = PlayerPedId()
                                    if IsPedMale(myPed) then
                                        TaskStartScenarioInPlace(myPed, `WORLD_HUMAN_FARMER_WEEDING`, 10000, true, false, false, false)
                                    else
                                        RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
                                        while (not HasAnimDictLoaded("amb_work@world_human_farmer_weeding@male_a@idle_a")) do
                                            Citizen.Wait(100)
                                        end
                                        TaskPlayAnim(myPed, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_a", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
                                    end
                                    Wait(10000)
                                    isPlanting = false
                                    ClearPedTasks(myPed)
                                    SetCurrentPedWeapon(myPed, `WEAPON_UNARMED`, true)
                                    DeleteObject(myPlants3[key].object)
                                    table.remove(myPlants3, key)
                                else
                                    TriggerEvent('vorp:TipBottom', _U("finishFirst"), 4000)
                                end
                                TriggerServerEvent("irb_farming:giveitem", v.hash3)
                            end
                        end
					end
				end
			end
        end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in ipairs(myPlants) do
			DeleteObject(v.object)
			table.remove(myPlants, k)
		end
        for k, v in ipairs(myPlants2) do
			DeleteObject(v.object)
			table.remove(myPlants2, k)
		end
        for k, v in ipairs(myPlants3) do
			DeleteObject(v.object)
			table.remove(myPlants3, k)
		end
	end
end)
