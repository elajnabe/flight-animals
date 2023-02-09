Config = Config or {}

Config.Zones = {
    [1] = {
        defAmount = 3,
        zone = {
            coords = {
                vector2(-2201.0236816406, 2327.6989746094),
                vector2(-2258.4938964844, 2306.5080566406),
                vector2(-2247.7514648438, 2263.7687988281),
                vector2(-2182.19140625, 2293.1325683594)
            },
            height = {min = 20, max = 40}
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