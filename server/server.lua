local animalZones = {}

local function spawnAnimals(source, zone, amount)
    local netIds = {}
    if animalZones[zone] then netIds = animalZones[zone] end
    for _ = 1, amount do
        local zoneRand = Config.Zones[zone].spawnPoints[math.random(1, #Config.Zones[zone].spawnPoints)]
        local pedstuff = CreatePed(30, joaat(zoneRand.possibleAnimals[math.random(1, #zoneRand.possibleAnimals)]),
            zoneRand.coords.x, zoneRand.coords.y, zoneRand.coords.z, zoneRand.coords.w, true, false)
        while not DoesEntityExist(pedstuff) do Wait(25) end
        netIds[#netIds + 1] = NetworkGetNetworkIdFromEntity(pedstuff)
    end
    Wait(300)
    animalZones[zone] = netIds
    TriggerClientEvent('flight-animals:client:spawnAnimals', source, netIds, Config.Zones[zone])
end

-- Events
RegisterServerEvent("oxlib-zones:enter", function(ZoneName)
    if not ZoneName:sub(1, -1) == "animal_zone_" then return end
    if animalZones[tonumber(ZoneName:sub(-1))] == nil then
        spawnAnimals(source, tonumber(ZoneName:sub(-1)), Config.Zones[tonumber(ZoneName:sub(-1))].defAmount)
    else
        TriggerClientEvent('flight-animals:client:checkExistence', source,
            { source = source, zone = tonumber(ZoneName:sub(-1)), animalZones = animalZones })
    end
end)

RegisterNetEvent('flight-animals:server:countThem', function(data)
    animalZones = data.animalZones
    spawnAnimals(data.source, data.zone, Config.Zones[data.zone].defAmount - #animalZones[data.zone])
end)
