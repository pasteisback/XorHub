local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local isR6 = character:FindFirstChild("Torso") ~= nil

if isR6 then
	loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
else
	loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end
