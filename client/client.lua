-- Functions
function Init()
    -- Initialize each zone
    for k, v in pairs(Config.Zones) do
        lib.zones.sphere({
            coords = v.coords,
            radius = v.radius > 120 and 120 or v.radius < 1 and 1 or v.radius,
            debug = Config.Debug,
            onEnter = function()
                TriggerServerEvent("flight-animals:zone:enter", "animal_zone_"..k)
            end,
        })

        if Config.Debug then
            local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(blip, 141)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.9)
            SetBlipColour(blip, 1)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Animal Zone "..k)
            SetBlipCategory(blip, 11)
            EndTextCommandSetBlipName(blip)
            if v.radius then
                local blipRadius = AddBlipForRadius(v.coords.x, v.coords.y, v.coords.z, v.radius > 120 and 120 or v.radius < 1 and 1 or v.radius)
                SetBlipRotation(blipRadius, 0)
                SetBlipColour(blipRadius, 1)
                SetBlipAlpha(blipRadius, 128)
            end
        end
    end
end

-- Threads
CreateThread(function() Init() end)

-- Events
RegisterNetEvent('flight-animals:client:spawnAnimals', function(netIds, Location)
    for i = 1, #netIds do
        local APed = NetworkGetEntityFromNetworkId(netIds[i])
        TaskWanderStandard(APed, 10.0, 10)
        SetEntityAsMissionEntity(APed, true, true)
        SetPedComponentVariation(APed, 0, 0, 0, 0)
        SetPedRelationshipGroupHash(APed, GetHashKey(Relationships[GetEntityModel(APed)]))
    end
end)

RegisterNetEvent('flight-animals:client:checkExistence', function(data)
    -- Checks how many animals don't exist anymore and removes them from the table
    for k, v in pairs(data.animalZones[data.zone]) do 
        if not DoesEntityExist(NetworkGetEntityFromNetworkId(v)) then data.animalZones[data.zone][k] = nil end end
    TriggerServerEvent("flight-animals:server:countThem", data)
end)

lib.callback.register('flight-animals:client:getGround', function(coords)
    local _, z = GetGroundZFor_3dCoord(coords.x, coords.y, 1000.0, false)
    return z + 2
end)