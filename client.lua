local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}

RegisterNetEvent('flashBadge:client:animation')
AddEventHandler('flashBadge:client:animation', function(JobInfo)
    PlayerJob = JobInfo
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local badgeProp = CreateObject(GetHashKey 'prop_fib_badge', coords.x, coords.y, coords.z + 0.2, true, true, true)
        local boneIndex = GetPedBoneIndex(ped, 28422)
        
        AttachEntityToEntity(badgeProp, ped, boneIndex, 0.065, 0.029, -0.035, 80.0, -1.90, 75.0, true, true, false, true, 1, true)
        RequestAnimDict('paper_1_rcm_alt1-9')
        TaskPlayAnim(ped, 'paper_1_rcm_alt1-9', 'player_one_dual-9', 8.0, -8, 10.0, 49, 0, 0, 0, 0)
        Citizen.Wait(4000)
        ClearPedSecondaryTask(ped)
        DeleteObject(badgeProp)
    end)
end)

RegisterCommand('badge', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        local src = source
        job = PlayerData.job.name
        if PlayerData.job.name == "police" then --and onDuty
            TriggerEvent('flashBadge:client:animation')
        else
            QBCore.Functions.Notify('Bạn không phải cảnh sát', 'error', 2500)
		end 
    end)
end, false)

RegisterKeyMapping('badge', 'Huy hieu canh sat', 'keyboard', 'N')