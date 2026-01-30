local _, AlomawaniQoL = ...

--Lua API
local tinsert = table.insert
local pairs = pairs
local time = time

-- WoW API
local PlaySoundFile = PlaySoundFile
local CreateFrame = CreateFrame

local Voice = CreateFrame('Frame')

local lastSoundTime = 0

-- TODO: I can probably just do an array with all the sounds.
--
local ilgynothdeathsounds = {
    [1360543] = true, -- "You have failed those who needed you"
    [1360544] = true, -- "Your light sputters out"
    [1360545] = true, -- "Welcome death. Do not fight it"
}

local yshaarjdeathsounds = {
    [901523] = true, -- "Wish each thread unravel, a step closer to my realm"
    [901525] = true, -- "Another blemish on your soul"
    [901527] = true, -- "You will rest in Ny'alotha"
}

local xalatathdeathsounds = {
    [1391162] = true, -- Delicious
    [1391163] = true, -- Every little death helps
    [1391164] = true, -- Enjoy that?
    [1391165] = true, -- Boring
    [1391167] = true, -- *Long laugh*
    [1391194] = true, -- *Short laugh*
}

local yoggsarondeathsounds = {
    [564844] = true, -- "Your will is no longer your own"
}

function Voice:OnEvent(_, ...)
    if not AlomawaniQoLData.Configs["AddVoiceLineWhenDead"] then
        return
    end

    local currentTime = time()
    if (currentTime - lastSoundTime) > 10  then
		local possibleSounds = {}

		for key, value in pairs(ilgynothdeathsounds) do
			if value then
				tinsert(possibleSounds, key)
			end
		end

		for key, value in pairs(yshaarjdeathsounds) do
			if value then
				tinsert(possibleSounds, key)
			end
		end

		for key, value in pairs(xalatathdeathsounds) do
			if value then
				tinsert(possibleSounds, key)
			end
		end

		for key, value in pairs(yoggsarondeathsounds) do
			if value then
				tinsert(possibleSounds, key)
			end
		end

		local soundFile = possibleSounds[math.random(1, #possibleSounds)]

		local willPlay = PlaySoundFile(soundFile , 'Master', true, false)
		if willPlay then
			lastSoundTime = currentTime
		end
	end
end

function Voice:Enable()
	self:RegisterEvent('PLAYER_DEAD')
	self:SetScript('OnEvent', self.OnEvent)
end

AlomawaniQoL.Gameplay.Voice = Voice
