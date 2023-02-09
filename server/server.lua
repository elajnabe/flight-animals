local animalZones = {}

-- Functions
-- Logic to spawn animals and store the data
function spawnAnimals(source, zone, amount)
    -- Spawn all the animals required
    local netIds = {} if animalZones[zone] then netIds = animalZones[zone] end for i = 1, amount do
        local zoneRand = Config.Zones[zone].spawnPoints[math.random(1, #Config.Zones[zone].spawnPoints)]
        local pedstuff = CreatePed(30, joaat(zoneRand.possibleAnimals[math.random(1, #zoneRand.possibleAnimals)]), 
        zoneRand.coords.x, zoneRand.coords.y, zoneRand.coords.z, true, false)
        while not DoesEntityExist(pedstuff) do Wait(25) end
        netIds[#netIds + 1] = NetworkGetNetworkIdFromEntity(pedstuff)
    end Wait(300)
    -- Store them for future checks
    animalZones[zone] = netIds
    -- Initiate them on client side in order for them to move around
    TriggerClientEvent('flight-animals:client:spawnAnimals', source, netIds, Config.Zones[zone])
end

-- Events
RegisterServerEvent("ps-zones:enter", function(ZoneName, ZoneData)
    -- checks if zone entered is an animal zone
    if not ZoneName:sub(1, -1) == "animal_zone_" then return end
    -- checks if zone is already existent
    print(json.encode(animalZones[tonumber(ZoneName:sub(-1))]))
    if animalZones[tonumber(ZoneName:sub(-1))] == nil then
        spawnAnimals(source, tonumber(ZoneName:sub(-1)), Config.Zones[tonumber(ZoneName:sub(-1))].defAmount)
    else
        TriggerClientEvent('flight-animals:client:checkExistence', source, {source = source, zone = tonumber(ZoneName:sub(-1)), animalZones = animalZones})
    end
end)

RegisterNetEvent('flight-animals:server:countThem', function(data)
    -- spawns the missing amount of animals
    animalZones = data.animalZones
    spawnAnimals(data.source, data.zone, Config.Zones[data.zone].defAmount - #animalZones[data.zone])
end)