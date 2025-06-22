local players = game:GetService("Players")
local camera = game:GetService("Workspace").CurrentCamera
local runService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")
local localPlayer = players.LocalPlayer

local espData = {}

local function isplrvisible(targetPart)
	local origin = camera.CFrame.Position
	local direction = (targetPart.Position - origin).unit * 500

	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	raycastParams.FilterDescendantsInstances = {localPlayer.Character, targetPart.Parent}

	local result = workspace:Raycast(origin, direction, raycastParams)

	return result == nil or (result.Instance and result.Instance:IsDescendantOf(targetPart.Parent))
end

local function make(player)
	if player == localPlayer then return end

	local box = Drawing.new("Square")
	box.Thickness = 2
	box.Filled = false
	box.Visible = false
	box.Rounding = 20

	local nameTag = Drawing.new("Text")
	nameTag.Size = 18
	nameTag.Center = true
	nameTag.Outline = true
	nameTag.Visible = false

	local healthBar = Drawing.new("Line")
	healthBar.Thickness = 3
	healthBar.Visible = false

	local weaponTag = Drawing.new("Text")
	weaponTag.Size = 14
	weaponTag.Center = true
	weaponTag.Outline = true
	weaponTag.Visible = false

	local botTag = Drawing.new("Text")
	botTag.Size = 14
	botTag.Center = true
	botTag.Outline = true
	botTag.Visible = false

	espData[player] = { Box = box, Name = nameTag, Health = healthBar, Weapon = weaponTag, Bot = botTag }
end

local function delete(player)
	if espData[player] then
		espData[player].Box:Remove()
		espData[player].Name:Remove()
		espData[player].Health:Remove()
		espData[player].Weapon:Remove()
		espData[player].Bot:Remove()
		espData[player] = nil
	end
end

local function botcheck(player)
	if not player.Character or not player.Character:FindFirstChildOfClass("Humanoid") then
		return true
	end
	return false
end

local function upd()
	for _, player in pairs(players:GetPlayers()) do
		if player == localPlayer or not player.Character then continue end

		local char = player.Character
		local hrp = char:FindFirstChild("HumanoidRootPart")
		local humanoid = char:FindFirstChildOfClass("Humanoid")

		if not hrp or not humanoid then
			if espData[player] then
				espData[player].Box.Visible = false
				espData[player].Name.Visible = false
				espData[player].Health.Visible = false
				espData[player].Weapon.Visible = false
				espData[player].Bot.Visible = false
			end
			continue
		end

		local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)

		if espData[player] then
			local esp = espData[player]
			local name
			local toolbeingheld
			if player.DisplayName == player.Name then
				name = player.Name
			else
				name = player.DisplayName.." (@"..player.Name..")"
			end
			local awesometool = player:FindFirstChildOfClass("Tool")
			if awesometool then
				toolbeingheld = awesometool.Name
			else
				toolbeingheld = "No Weapon"
			end
			if onScreen then
				local isVisible = isplrvisible(hrp)

				esp.Box.Color = isVisible and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
				esp.Box.Size = Vector2.new(50, 100)
				esp.Box.Position = Vector2.new(screenPos.X - 25, screenPos.Y - 50)
				esp.Box.Visible = true

				esp.Name.Text = name
				esp.Name.Position = Vector2.new(screenPos.X, screenPos.Y - 60)
				esp.Name.Color = Color3.fromRGB(255, 255, 255)
				esp.Name.Visible = true

				local hpRatio = humanoid.Health / humanoid.MaxHealth
				esp.Health.Color = Color3.fromRGB(0, 255, 0)
				esp.Health.From = Vector2.new(screenPos.X - 30, screenPos.Y - 50 + (100 * (1 - hpRatio)))
				esp.Health.To = Vector2.new(screenPos.X - 30, screenPos.Y + 50)
				esp.Health.Visible = true

				esp.Weapon.Text = toolbeingheld
				esp.Weapon.Position = Vector2.new(screenPos.X, screenPos.Y - 80)
				esp.Weapon.Color = Color3.fromRGB(255, 255, 255)
				esp.Weapon.Visible = true

				local botStatus = botcheck(player) and "BOT" or "NOT BOT"
				esp.Bot.Text = botStatus
				esp.Bot.Position = Vector2.new(screenPos.X, screenPos.Y - 100)
				esp.Bot.Color = Color3.fromRGB(255, 255, 255)
				esp.Bot.Visible = true
			else
				esp.Box.Visible = false
				esp.Name.Visible = false
				esp.Health.Visible = false
				esp.Weapon.Visible = false
				esp.Bot.Visible = false
			end
		end
	end
end

for _, player in pairs(players:GetPlayers()) do
	make(player)
end

players.PlayerAdded:Connect(make)
players.PlayerRemoving:Connect(delete)
runService.RenderStepped:Connect(upd)
