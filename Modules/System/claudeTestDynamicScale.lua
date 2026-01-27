-- Perfect UI Scale Calculator for World of Warcraft (Dynamic)
local addonName, addon = ...

-- Calculate scale based purely on resolution
local function GetPerfectScale()
    local screenWidth, screenHeight = GetPhysicalScreenSize()
    
    -- Method 1: Based on vertical pixels
    -- Uses 768 as base (old standard resolution height)
    -- This ensures UI elements maintain similar pixel density
    local scale = 768 / screenHeight
    
    -- Clamp scale between 0.4 and 1.15 (WoW's limits)
    scale = math.max(0.4, math.min(1.15, scale))
    
    -- Round to 2 decimal places
    scale = math.floor(scale * 100 + 0.5) / 100
    
    return scale
end

-- Alternative method: Based on total pixel area
local function GetPerfectScaleByArea()
    local screenWidth, screenHeight = GetPhysicalScreenSize()
    
    -- Uses 1024x768 as base area
    local baseArea = 1024 * 768
    local currentArea = screenWidth * screenHeight
    
    -- Scale is square root of area ratio
    local scale = math.sqrt(baseArea / currentArea)
    
    -- Clamp and round
    scale = math.max(0.4, math.min(1.15, scale))
    scale = math.floor(scale * 100 + 0.5) / 100
    
    return scale
end

-- Alternative method: Aspect ratio aware
local function GetPerfectScaleAspectAware()
    local screenWidth, screenHeight = GetPhysicalScreenSize()
    
    -- Calculate aspect ratio
    local aspectRatio = screenWidth / screenHeight
    
    -- Base calculation on height
    local scale = 768 / screenHeight
    
    -- Adjust slightly for ultra-wide (> 16:9) or narrow screens
    if aspectRatio > 1.78 then -- Ultra-wide (21:9, etc.)
        scale = scale * 1.05 -- Slightly larger UI
    elseif aspectRatio < 1.6 then -- 4:3 or similar
        scale = scale * 0.95 -- Slightly smaller UI
    end
    
    -- Clamp and round
    scale = math.max(0.4, math.min(1.15, scale))
    scale = math.floor(scale * 100 + 0.5) / 100
    
    return scale
end

-- Apply the calculated scale
local function ApplyPerfectScale(method)
    local scale
    
    if method == "area" then
        scale = GetPerfectScaleByArea()
    elseif method == "aspect" then
        scale = GetPerfectScaleAspectAware()
    else
        scale = GetPerfectScale()
    end
    
    local currentScale = UIParent:GetEffectiveScale()
    if math.abs(currentScale - scale) > 0.01 then
        SetCVar("useUiScale", "1")
        SetCVar("uiscale", scale)
        
        local methodName = method == "area" and "Area" or method == "aspect" and "Aspect" or "Height"
        print(string.format("|cff00ff00Perfect Scale Applied (%s):|r %.2f (Resolution: %dx%d)", 
            methodName, scale, GetPhysicalScreenSize()))
    end
end

-- Get scale info for all methods
local function GetScaleInfo()
    local screenWidth, screenHeight = GetPhysicalScreenSize()
    local currentScale = tonumber(GetCVar("uiscale")) or 1.0
    local aspectRatio = screenWidth / screenHeight
    
    return {
        heightBased = GetPerfectScale(),
        areaBased = GetPerfectScaleByArea(),
        aspectBased = GetPerfectScaleAspectAware(),
        current = currentScale,
        width = screenWidth,
        height = screenHeight,
        aspectRatio = aspectRatio,
        isEnabled = GetCVar("useUiScale") == "1"
    }
end

-- Slash command
SLASH_PERFECTSCALE1 = "/perfectscale"
SLASH_PERFECTSCALE2 = "/pscale"
SlashCmdList["PERFECTSCALE"] = function(msg)
    if msg == "info" then
        local info = GetScaleInfo()
        print("|cff00ff00Perfect Scale Info:|r")
        print(string.format("Resolution: %dx%d (%.2f:1)", info.width, info.height, info.aspectRatio))
        print(string.format("Current Scale: %.2f", info.current))
        print(string.format("Height-based: %.2f", info.heightBased))
        print(string.format("Area-based: %.2f", info.areaBased))
        print(string.format("Aspect-aware: %.2f", info.aspectBased))
        print(string.format("UI Scale Enabled: %s", info.isEnabled and "Yes" or "No"))
    elseif msg == "area" then
        ApplyPerfectScale("area")
    elseif msg == "aspect" then
        ApplyPerfectScale("aspect")
    else
        ApplyPerfectScale()
    end
end

-- Auto-apply on login (optional)
-- local frame = CreateFrame("Frame")
-- frame:RegisterEvent("PLAYER_LOGIN")
-- frame:SetScript("OnEvent", ApplyPerfectScale)
