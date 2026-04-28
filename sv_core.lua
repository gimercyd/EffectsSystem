if CLIENT then return end

EFFECTS = {}
EFFECTS.MODULES = {}


function EFFECTS.RegisterModule(effectType, spec)
    EFFECTS.MODULES[effectType] = spec
end

function EFFECTS.Add(ply, effectType, id, value, duration)
    if not IsValid(ply) then return end
    if not EFFECTS.MODULES[effectType] then
        error("Вызов несуществующего эффекта: " .. effectType)
    end
    
    local plyEffects = EFFECTS[ply]
    local typeEffects = plyEffects[effectType] or {}
    local exp = (duration and duration > 0) and CurTime() + duration or 0

    typeEffects[id] = {
        value = value,
        exp = exp
    }

    plyEffects[effectType] = typeEffects
    EFFECTS[ply] = plyEffects

    EFFECTS.recalc(ply, effectType)
end

function EFFECTS.Remove(ply, effectType, id)
    if not IsValid(ply) then return end

    local plyEffects = EFFECTS[ply]
    if not plyEffects then return end
    local typeEffects = plyEffects[effectType]
    if not typeEffects or not typeEffects[id] then return end

    typeEffects[id] = nil
    if next(typeEffects) == nil then
        plyEffects[effectType] = nil
    end

    EFFECTS.recalc(ply, effectType)
end

function EFFECTS.recalc(ply, effectType)
    if not IsValid(ply) then return end
    local module = EFFECTS.MODULES[effectType]
    if not module then return end
    local total = module.defaultValue or 0
    local plyEffects = EFFECTS[ply]
    if plyEffects then
        local typeEffects = plyEffects[effectType]
        if typeEffects then
            for id, eff in ipairs(typeEffects) do
                if eff.exp > 0 and eff.exp <= CurTime() then
                    EFFECTS.Remove(ply, effectType, id)
                else
                    total = total + eff.value
                end
            end
        end
    end
    module.apply(ply, total)
end

hook.Add("PlayerDisconnected", "Clean", function(ply)
    EFFECTS[ply] = nil
end)


timer.Create("Ticks", 1, 0, function()
    for ply, plyData in ipairs(EFFECTS) do
        if not IsValid then EFFECTS[ply] = nil
        else
            for effType, _ in pairs(plyData) do 
                EFFECTS.recalc(ply, effType)
            end
        end
    end
end)