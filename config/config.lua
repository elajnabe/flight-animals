Config = Config or {}

Config.Debug = true

Config.Zones = {
    [1] = {
        defAmount = 3,
        zone = {
            coords = vector3(-2201.0236816406, 2327.6989746094, 30.0),
            radius = 20,
        },
        spawnPoints = {
            [1] = {
                coords = vector4(-2239.015, 2300.096, 32.326, 113.366),
                possibleAnimals = {"A_C_Boar", "A_C_Cat_01", "A_C_Chickenhawk"},
            }, 
            [2] = {
                coords = vector4(-2239.015, 2300.096, 32.326, 113.366),
                possibleAnimals = {"A_C_Chimp", "A_C_Chop", "A_C_Cormorant"},
            },
        }
    },
}