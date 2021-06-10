-----------------------------------------------------------------------------------------------
--SCRIPT CREADO PARA EL SERVIDOR DE FIVEM DE PLATA O PLOMO COMUNIDAD GAMER.
--SCRIPT CREADO TOTALMENTE POR THEMAYKELLLL1 [ MIGUEL ANGEL LOPEZ REYES ].
--PLATA O PLOMO COMUNIDAD GAMER ACEPTA NO VENDER / REGALAR / PASAR ESTOS SCRIPTS A OTRAS PERSONAS O COMUNIDADES.
-----------------------------------------------------------------------------------------------


-------------------------------------------
------------------VARIABLES----------------
-------------------------------------------

local Amazn = { x = 1194.87, y = -3254.34, z = 6.1}
local truckamz = { x = 1179.18, y = -3253.57, z = 6.03, h= 91.17 }

local propina = 0
local posibilidad = 0

local casas = {
	[1] = {name = "Vinewood Hills",x = -1220.50, y = 666.95 , z = 143.10},
	[2] = {name = "Vinewood Hills",x = -1338.97, y = 606.31 , z = 133.37},
	[3] = {name = "Rockford Hills",x = -1051.85, y = 431.66 , z = 76.06 },
	[4] = {name = "Rockford Hills",x = -904.04 , y = 191.49 , z = 68.44 },
	[5] = {name = "Rockford Hills",x = -21.58  , y = -23.70 , z = 72.24 },
	[6] = {name = "Hawick"        ,x = -904.04 , y = 191.49 , z = 68.44 },
	[7] = {name = "Alta"          ,x = 225.39  , y = -283.63, z = 28.25 },
	[8] = {name = "Pillbox Hills" ,x = 5.62    , y = -707.72, z = 44.97 },
	[9] = {name = "Mission Row"   ,x = 284.50  , y = -938.50 , z = 28.35},
	[10] ={name = "Rancho"        ,x = 411.59  , y = -1487.54, z = 29.14},
	[11] ={name = "Davis"         ,x = 85.19   , y = -1958.18, z = 20.12},
	[12] ={name ="Chamberlain Hills",x = -213.00, y =-1617.35 , z =37.35},
	[13] ={name ="La puerta"      ,x = -1015.65, y =-1515.05 ,z = 5.51}
}

local isInJobAmz = false
local sigcasa = 0
local plateab = "AMZN"
local isToHouse = false
local isToDepot = false
local multiplicador_De_dinero = 0.5 
local paga = 0

local px = 0
local py = 0
local pz = 0

local blips = {
	{title="Amazon Depot", colour=66, id=147, x = 1194.87, y = -3254.34, z = 7.1},
}

-------------------------------------------
--------------------BLIPS------------------
-------------------------------------------

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.9)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)

function Iracasa(casas,sigcasa)
	blip_casa = AddBlipForCoord(casas[sigcasa].x,casas[sigcasa].y, casas[sigcasa].z)
	SetBlipSprite(blip_casa, 1)
	SetNewWaypoint(casas[sigcasa].x,casas[sigcasa].y)
end

-------------------------------------------
------------------CITIZENS-----------------
-------------------------------------------

Citizen.CreateThread(function()
	while true do
		local wait = 2000
		if isInJobAmz == false then
			wait = 0
			DrawMarker(1,Amazn.x,Amazn.y,Amazn.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,255,51, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(Amazn.x, Amazn.y, Amazn.z, GetEntityCoords(GetPlayerPed(-1),true)) < 1.5 then
				drawTxt("PRESS E TO START THE DELIVERY",2, 1, 0.45, 0.03, 0.80,255,255,51,255)
				if IsControlJustPressed(1,38) then
					isInJobAmz = true
					isToHouse = true
					sigcasa = math.random(1, 13)
					-- [INFO] TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, sigcasa)
					px = casas[sigcasa].x
					py = casas[sigcasa].y
					pz = casas[sigcasa].z
					distancia = round(GetDistanceBetweenCoords(Amazn.x, Amazn.y, Amazn.z, px,py,pz))
					paga = distancia * multiplicador_De_dinero
					-- [INFO] TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, distancia)
					spawn_faggio()
					Iracasa(casas,sigcasa)
				end
			end
		end
		if isToHouse == true then
			wait = 0
			destinol = casas[sigcasa].name
			drawTxt("TAKE THE Truck AND HEAD TO "..destinol .." AND DELIVER THE Packages",4, 1, 0.45, 0.92, 0.70,255,255,255,255)
			DrawMarker(1,casas[sigcasa].x,casas[sigcasa].y,casas[sigcasa].z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,255,51, 200, 0, 0, 0, 0)
			if GetDistanceBetweenCoords(px,py,pz, GetEntityCoords(GetPlayerPed(-1),true)) < 3 then
				drawTxt("PRESS E TO DELIVER THE Packages",2, 1, 0.45, 0.03, 0.80,255,255,51,255)
				if IsControlJustPressed(1,38) then
					posibilidad = math.random(1, 100)
					if (posibilidad > 70) and (posibilidad < 90) then
						propina = math.random(100, 200)
						TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"Taking Tips : "..propina.."$")
						TriggerServerEvent("job_amzn:propina", propina)
					end
					isToHouse = false
					isToDepot = true
					RemoveBlip(blip_casa)
					SetNewWaypoint(Amazn.x,Amazn.y)
				end
			end
		end
		if isToDepot == true then
			wait = 0
			drawTxt("HEAD BACK TO THE Amazon Depot TO COLLECT YOUR MONEY",4, 1, 0.45, 0.92, 0.70,255,255,255,255)
			DrawMarker(1,Amazn.x,Amazn.y,Amazn.z, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.6001,255,255,51, 200, 0, 0, 0, 0)
				if GetDistanceBetweenCoords(Amazn.x,Amazn.y,Amazn.z, GetEntityCoords(GetPlayerPed(-1),true)) < 3 then
					drawTxt("PRESS E TO BE CHARGED",2, 1, 0.45, 0.03, 0.80,255,255,51,255)
					if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("mule"))  then
						if IsControlJustPressed(1,38) then
							if IsInVehicle() then
								TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"Thanks for doing the delivery, take your pay: "..paga.."$")
								TriggerServerEvent("job_amzn:propina", paga)
								isToHouse = false
								isToDepot = false
								isInJobAmz = false
								paga = 0
								px = 0
								py = 0
								pz = 0
								local vehicleu = GetVehiclePedIsIn(GetPlayerPed(-1), false)
								SetEntityAsMissionEntity( vehicleu, true, true )
			               		deleteCar( vehicleu )
							else
								TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"We will not pay you if you do not Return Company Truck, I'm sorry.")
							end
						end
					else
						TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0},"We will not pay you if you do not Return Company Truck, I'm sorry.")
					end
				end
		end
		if IsEntityDead(GetPlayerPed(-1)) then
			wait = 0
			 isInJobAmz = false
			 sigcasa = 0
			 isToHouse = false
			 isToDepot = false
			 paga = 0
			 px = 0
			 py = 0
			 pz = 0
		end
		Citizen.Wait(wait)	
	end
end)

-------------------------------------------
----------------FUNCIONES------------------
-------------------------------------------

function spawn_faggio()
	Citizen.Wait(0)

	local myPed = GetPlayerPed(-1)
	local player = PlayerId()
	local vehicle = GetHashKey('mule')

	RequestModel(vehicle)

	while not HasModelLoaded(vehicle) do
		Wait(1)
	end

	local plate = math.random(100, 900)
	local spawned_car = CreateVehicle(vehicle, truckamz.x,truckamz.y,truckamz.z, 431.436, - 996.786, 25.1887, true, false)

	local plate = "CTZN"..math.random(100, 300)
    SetVehicleNumberPlateText(spawned_car, plate)
	SetVehicleOnGroundProperly(spawned_car)
	SetVehicleLivery(spawned_car, 2)
	SetPedIntoVehicle(myPed, spawned_car, - 1)
	SetModelAsNoLongerNeeded(vehicle)
	Citizen.InvokeNative(0xB736A491E64A32CF, Citizen.PointerValueIntInitialized(spawned_car))
end

function round(num, numDecimalPlaces)
	local mult = 5^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function deleteCar( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

function IsInVehicle()
  local ply = GetPlayerPed(-1)
  if IsPedSittingInAnyVehicle(ply) then
    return true
  else
    return false
  end
end

-------------------------------------------
----------FUNCIONES ADICIONALES------------
-------------------------------------------

function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end
