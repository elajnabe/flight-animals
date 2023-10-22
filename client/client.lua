-- Functions
function Init()
    -- Initialize each zone
    for k, v in pairs(Config.Zones) do
        lib.zones.sphere({
            coords = v.zone.coords,
            radius = v.zone.radius > 30 and 30 or v.zone.radius < 1 and 1 or v.zone.radius,
            debug = Config.Debug,
            onEnter = function()
                TriggerServerEvent("oxlib-zones:enter", "animal_zone_"..k)
            end,
        })
    end
end

-- Threads
CreateThread(function() Init() end)

-- Events
RegisterNetEvent('flight-animals:client:spawnAnimals', function(netIds, Location)
    for i = 1, #netIds do
        local APed = NetworkGetEntityFromNetworkId(netIds[i])
        TaskWanderStandard(APed, 10, 10)
        SetCanAttackFriendly(APed, false, true)
        SetEntityAsMissionEntity(APed, true, true)
        SetPedComponentVariation(APed, 0, 0, 0, 0)
    end
end)

RegisterNetEvent('flight-animals:client:checkExistence', function(data)
    -- Checks how many animals don't exist anymore and removes them from the table
    for k, v in pairs(data.animalZones[data.zone]) do 
        if not DoesEntityExist(NetworkGetEntityFromNetworkId(v)) then data.animalZones[data.zone][k] = nil end end
    TriggerServerEvent("flight-animals:server:countThem", data)
end)