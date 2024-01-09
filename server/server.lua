local animalZones = {}

local function getRandomCoordsInRadius(center, radius)
    local angle = math.rad(math.random(0, 360))
    local distance = math.random() * radius

    local x = center.x + distance * math.cos(angle)
    local y = center.y + distance * math.sin(angle)
    local z = center.z

    return vector3(x, y, z)
end

local function spawnAnimals(source, zone, amount)
    local netIds = {}
    if animalZones[zone] then netIds = animalZones[zone] end
    local zoneData = Config.Zones[zone]
    for _ = 1, amount do
        local zoneRand = getRandomCoordsInRadius(zoneData.coords, zoneData.radius)
        local groundZ = lib.callback.await('flight-animals:client:getGround', source, zoneRand)
        local animal = zoneData.possibleAnimals[math.random(1, #zoneData.possibleAnimals)]
        local pedstuff = CreatePed(30, joaat(animal), zoneRand.x, zoneRand.y, groundZ, math.random(0, 360), true, false)
        while not DoesEntityExist(pedstuff) do Wait(25) end
        netIds[#netIds + 1] = NetworkGetNetworkIdFromEntity(pedstuff)
    end
    Wait(100 * amount)
    animalZones[zone] = netIds
    TriggerClientEvent('flight-animals:client:spawnAnimals', source, netIds, Config.Zones[zone])
end

-- Events
RegisterServerEvent("flight-animals:zone:enter", function(ZoneName)
    local zoneNumber = tonumber(string.match(ZoneName, "animal_zone_(%d+)"))
    if not zoneNumber then return end
    if not animalZones[zoneNumber] then
        spawnAnimals(source, zoneNumber, Config.Zones[zoneNumber].defAmount)
    else
        TriggerClientEvent('flight-animals:client:checkExistence', source,
            { source = source, zone = zoneNumber, animalZones = animalZones })
    end
end)

RegisterNetEvent('flight-animals:server:countThem', function(data)
    animalZones = data.animalZones
    spawnAnimals(data.source, data.zone, Config.Zones[data.zone].defAmount - #animalZones[data.zone])
end)
