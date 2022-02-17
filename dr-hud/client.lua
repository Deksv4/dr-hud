vRP = Proxy.getInterface("vRP")

local IsDefault = "round"
local IsMapSet = false

CreateThread(function() -- Update hud thread
    while true do
        Wait(250)
        UpdateHud()
    end
end)

RegisterNetEvent("dr-hud:ToggleItem", function(type)
    SendNUIMessage({
        type = "toggleitem",
        item = type,
    })
end)

function UpdateHud()
    local ped = PlayerPedId()
    local health = vRP.getHealth()-100
    local armor = GetPedArmour(ped)

    if health == 20 then
        health = 0
    end

    TriggerServerCallback('dr-hud:CheckInformation', function(hunger, thirst)
        SendNUIMessage({
            type = "updatehud",
            health = health,
            hunger = hunger, 
            thirst = thirst,
            armor = armor,
        })
    end)

    if IsMapSet == false then
        IsMapSet = true
        if IsDefault == "square" then
            SetSquareMap()
        elseif IsDefault == "round" then
            SetRoundMap()
        else
            SetRoundMap()
        end
    end
end

function SetSquareMap()
    RequestStreamedTextureDict("squaremap", false)
    if not HasStreamedTextureDictLoaded("squaremap") then
        Wait(150)
    end
    SetMinimapClipType(0)
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
    AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
    SetMinimapComponentPosition("minimap", "L", "B", 0.0 + minimapOffset, -0.047, 0.1638, 0.183)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.0 + minimapOffset, 0.0, 0.128, 0.20)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.01 + minimapOffset, 0.025, 0.262, 0.300)
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetRadarBigmapEnabled(true, false)
    SetMinimapClipType(0)
    Wait(50)
    SetRadarBigmapEnabled(false, false)
end

function SetRoundMap()
    local defaultAspectRatio = 1920/1080
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX/resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
    end

    RequestStreamedTextureDict("circlemap", false)
    if not HasStreamedTextureDictLoaded("circlemap") then
        Wait(150)
    end
    SetMinimapClipType(1)
    AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
    AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "circlemap", "radarmasksm")
    SetMinimapComponentPosition("minimap", "L", "B", -0.0100 + minimapOffset, -0.030, 0.180, 0.258)
    SetMinimapComponentPosition("minimap_mask", "L", "B", 0.200 + minimapOffset, 0.0, 0.065, 0.20)
    SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.00 + minimapOffset, 0.055, 0.252, 0.338)

    
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetMinimapClipType(1)
    SetRadarBigmapEnabled(true, false)
    Wait(50)
    SetRadarBigmapEnabled(false, false)
end


CreateThread(function()
    SetBigmapActive(false, false)
    SetRadarBigmapEnabled(false, false)
    local minimap = RequestScaleformMovie("minimap")

    while true do
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
        Wait(0)
    end
end)