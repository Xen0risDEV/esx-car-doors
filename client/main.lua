ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)

		local playerCoords = GetEntityCoords(PlayerPedId())
		local vehicle = GetClosestVehicle(playerCoords, Config.ClosestVehicleRadius)

		if DoesEntityExist(vehicle) then
			for i = 1, GetNumberOfVehicleDoors(vehicle) do
				local door = GetEntryPositionOfDoor(vehicle, i)
				local distance = #(playerCoords - door)

				if(distance < Config.Distance and DoesEntityExist(GetPedInVehicleSeat(vehicle, i -1)) == false and GetVehicleDoorLockStatus(vehicle) ~= 2) then
					if IsControlJustPressed(1, 38) then
		    			TaskEnterVehicle(PlayerPedId(), vehicle, 10000, i - 1, 1.0, 1, 0)	
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsPedInAnyVehicle(PlayerPedId(), false) and Config.disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId(), false), 0) == PlayerPedId() then
				if GetIsTaskActive(PlayerPedId(), 165) then
					SetPedIntoVehicle(PlayerPedId(), GetVehiclePedIsIn(PlayerPedId(), false), 0)
				end
			end
		end
	end
end)