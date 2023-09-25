local CachedViewPos = nil
local CachedViewAng = nil
net.Receive("sm_risehero", function(length)
	local pl = net.ReadEntity()
	GAMEMODE.RisenHero = pl
	
	if pl and pl:IsValid() then
		GAMEMODE.HeroTime = CurTime()
		
		hook.Add("CalcView", "Hero:CalculateViews", function(pl, origin, angles, fov, znear, zfar)
            if GAMEMODE.HeroTime and CurTime() < GAMEMODE.HeroTime + 5 then
                if not CachedViewPos then
                    CachedViewPos = origin
                    CachedViewAng = angles
                end
                
                if GAMEMODE.RisenHero and GAMEMODE.RisenHero:IsValid() then
                    local t = CurTime()
                    local delta = math.Clamp((t - GAMEMODE.HeroTime) * 2, 0, 1)
                    local pos = GAMEMODE.RisenHero:LocalToWorld(GAMEMODE.RisenHero:OBBCenter())
                    
                    t = t*0.65
                    local destpos = pos + Vector(math.cos(t),math.sin(t),0.7):GetNormalized()*64
                    local destang = (pos-destpos):Angle()
                    
                    local tr = util.TraceHull({start = pos, endpos = destpos, mins = Vector(-4, -4, -4), maxs = Vector(4, 4, 4), filter = player.GetAll(), mask = MASK_SOLID})
                    if tr.Hit then
                        destpos = tr.HitPos
                    end

                    if delta<1 then
                        destpos = LerpVector(delta,CachedViewPos,destpos)
                        destang = LerpAngle(delta,CachedViewAng,destang)
                    end
                    
                    return {origin=destpos, angles=destang}
                end
        
                return
            end

            pl:ScreenFade(SCREENFADE.IN, color_white, 0.5, 0)
            
            GAMEMODE.HeroTime = nil
        
            CachedViewPos = nil
            CachedViewAng = nil
            
            hook.Remove("CalcView", "Hero:CalculateViews")
            hook.Remove("ShouldDrawLocalPlayer", "Hero:DrawPlayer")
        end)

		hook.Add("ShouldDrawLocalPlayer", "Hero:DrawPlayer", function(pl)
            return true
        end)
	end
end)