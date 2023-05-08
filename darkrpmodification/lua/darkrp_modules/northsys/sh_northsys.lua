-- Trace

function NG_TraceAttack(tbl)
    local tr = util.TraceLine({
        start = tbl.start,
        endpos = tbl.endpos,
        filter = tbl.filter,
        mask = MASK_SHOT_HULL
    })

    if !IsValid(tr.Entity) then
        tr = util.TraceHull({
            start = tbl.start,
            endpos = tbl.endpos,
            filter = tbl.filter,
            mins = tbl.mins or Vector(-10, -10, -8),
            maxs = tbl.maxs or Vector(10, 10, 8),
            mask = MASK_SHOT_HULL
        })
    end

    return tr
end

-- Time To String
function NG_TimeToString(time)
    local tmp = time
    local s = tmp % 60
    tmp = math.floor(tmp / 60)
    local m = tmp % 60
    tmp = math.floor(tmp / 60)
    local h = tmp % 24
    tmp = math.floor(tmp / 24)
    local d = tmp % 7
    local w = math.floor(tmp / 7)

    if w < 0 then
        return "00w 00d 00h 00m 00s"
    end
    return string.format("%02iw %id %02ih %02im %02is", w, d, h, m, s)
end

-- Bewegungsgeräuchse

hook.Add("PlayerFootstep", "North_Footsteps", function(ply, pos)
    if !ply.getJobTable then return end
    local job_tbl = ply:getJobTable()
    if !job_tbl then return end
    if job_tbl.noStepSound then
        return true
    end

    local stepsounds = job_tbl.stepsounds
    if stepsounds then
        ply:EmitSound(stepsounds[math.random(#stepsounds)])
        return true
    end
end)
