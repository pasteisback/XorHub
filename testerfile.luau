--// Xor Hub V1 | Universal Script

--// Services
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TextChatService = game:GetService("TextChatService")
local Workspace = game:GetService("Workspace")

--// Player & Mouse
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Mouse = LocalPlayer:GetMouse()

--// Function Checkers
local hasgetconnections = true
local hasidentifyexecutor = true
local hasfilefunctions = true
local hasqueueTeleport = true
local hassetclipboard = true
local hashttp_request = true

--// Mobile check (from Infinite Yield)
local IsMobile = table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform()) ~= nil

--// Teleport queue function
local queueTeleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

--// Configuration
local config = {
	radius = 50,
	height = 100,
	speed = 10,
	strength = 1000,
	bind = "RightShift",
}

--// Get Users Executor
local function GetExecutor()
	local executor = getexecutorname() or identifyexecutor()
	if not executor then
		return "nil"
	end
	return executor
end

local function DetectBaseExploit()
	local exploit = GetExecutor()
	if exploit == "Impulse" or exploit == "Light" or exploit == "AbuseX" then
		hasqueueTeleport = false
	else
		--// Else Check For Queue Teleport On Checks Below
	end
end

--// Save settings to file
local function SaveConfig()
	local data = HttpService:JSONEncode(config)
	writefile("XorHubCFG.txt", data)
end

--// Load settings from file
local function LoadConfig()
	if isfile("XorHubCFG.txt") then
		local data = readfile("XorHubCFG.txt")
		config = HttpService:JSONDecode(data)
	end
end

--// Unicode Chat Bypass System
local function SendBypassedMessage(originalText)
	local bypassText = originalText ~= "" and originalText or "Xor Hub."

	-- Upper and lower Unicode mapping tables
	local upperMap = {
		A="Ạ", B="Ḅ", C="C", D="Ḍ", E="Ẹ", F="F", G="Ģ", H="Ḥ", I="Ị", J="J",
		K="Ḳ", L="Ḷ", M="Ṃ", N="Ṇ", O="Ọ", P="Р", Q="Q", R="Ṛ", S="Ṣ", T="Ṭ",
		U="Ụ", V="Ṿ", W="Ẉ", X="Ẋ", Y="Ỵ", Z="Ẓ"
	}
	local lowerMap = {
		a="ạ", b="ḅ", c="c", d="ḍ", e="ẹ", f="f", g="ɡ", h="ḥ", i="ị", j="ј",
		k="ḳ", l="ḷ", m="ṃ", n="ṇ", o="ọ", p="р", q="q", r="ṛ", s="ṣ", t="ṭ",
		u="ụ", v="ṿ", w="ẉ", x="ẋ", y="ỵ", z="ẓ", ["|"] = "\r"
	}

	-- Convert to fancy Unicode
	local converted = ""
	for char in bypassText:gmatch(".") do
		local mapped = upperMap[char] or lowerMap[char] or char
		converted = converted .. mapped .. "͎"
	end

	-- Send message
	if TextChatService.ChatInputBarConfiguration.TargetTextChannel then
		TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(converted)
	else
		ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(converted, "All")
	end
end

--// Send notification using Roblox core UI
local function Notify(message)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Xor Hub | Universal",
			Text = message,
			Duration = 6
		})
	end)
end

--// Compatibility Checks
if not identifyexecutor then
	Notify("Your executor does not support identifyexecutor. Some features will not work.")
	hasidentifyexecutor = false
end
if not (readfile and writefile and isfile) then
	Notify("Your executor does not support file system functions. Some features will not work.")
	hasfilefunctions = false
end
if not queueTeleport then
	Notify("Your executor does not support queue_on_teleport. Some features will not work.")
	hasqueueTeleport = false
end
if not setclipboard then
	Notify("Your executor does not support setclipboard. Some features will not work.")
	hassetclipboard = false
end
if not http_request then
	Notify("Your executor does not support http_request. Some features will not work.")
	hashttp_request = false
end
if not getconnections then
	Notify("Your executor does not support getconnections. Some features will not work.")
	hasgetconnections = false
end

--// Return Game Name
local function GetGameName()
	local success, result = pcall(function()
		return MarketplaceService:GetProductInfo(game.PlaceId).Name
	end)

	if success then
		return result
	else
		return "Game not found."
	end
end

--// Load Config
LoadConfig()

--// UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/XorHub/refs/heads/main/uilib.luau"))()
local Window = Library.CreateLib("Xor Hub", "Ocean")

--// Tabs & Sections
local HomeTab = Window:NewTab("Home 🏠")
local HomeSection = HomeTab:NewSection("Home 🏠")

local UniversalTab = Window:NewTab("Universal 🎯")
local UniversalSection = UniversalTab:NewSection("Universal 🎯")

local PrisonTab = Window:NewTab("Prison Life ⛓️‍💥")
local PrisonSection = PrisonTab:NewSection("Prison Life ⛓️‍💥")

local DesSimTab = Window:NewTab("Destruction Sim 💥")
local DesSimSection = DesSimTab:NewSection("Destruction Sim 💥")

local RivalsTab = Window:NewTab("Rivals ⚔️")
local RivalsSection = RivalsTab:NewSection("Rivals ⚔️")

local TestOption
HomeSection:NewLabel("Welcome, "..LocalPlayer.Name.."!")
HomeSection:NewLabel(GetGameName())
HomeSection:NewLabel("Executor: "..GetExecutor())

HomeSection:NewButton("Join discord", "rawr", function()
	SaveConfig()
	if hassetclipboard and hashttp_request then
		setclipboard("dsc.gg/impulserbx")
		http_request({
			Url = 'http://127.0.0.1:6463/rpc?v=1',
			Method = 'POST',
			Headers = {
				['Content-Type'] = 'application/json',
				Origin = 'https://discord.com'
			},
			Body = HttpService:JSONEncode({
				cmd = 'INVITE_BROWSER',
				nonce = HttpService:GenerateGUID(false),
				args = {code = 'z8fxkenC4P'}
			})
		})
		Notify("Copied to clipboard. Paste in browser!")
	else
		Notify("dsc.gg/impulserbx")
	end
end)

HomeSection:NewDropdown("Type of test", "Choose types of exploit tests", {"Normal UNC Test", "Deep UNC Test", "SUNC Test", "Deep Vulnerability Test", "MoreUNC Test"}, function(currentOption)
	TestOption = currentOption
end)

HomeSection:NewButton("Run Executor Test", "Run a exploit test", function()
	SaveConfig()
	if TestOption == "Normal UNC Test" then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/MoonScripts/refs/heads/main/unctestuniversal.lua"))() -- tests 83 functions
	elseif TestOption == "Deep UNC Test" then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/MoonScripts/refs/heads/main/DeepUNCTest.lua"))() -- tests 248 functions
	elseif TestOption == "SUNC Test" then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/MoonScripts/refs/heads/main/suncuniversal.lua"))() -- tests 105ish functions
	elseif TestOption == "Deep Vulnerability Test" then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/MoonScripts/refs/heads/main/DeepVulnerabilityTest.lua"))()
	elseif TestOption == "MoreUNC Test" then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/MoonScripts/refs/heads/main/FixedMoreUNC"))()
	else
		Notify("Pick a type of test to run.")
	end
end)

HomeSection:NewButton("Rejoin Current Server", "Rejoin your current server", function()
	local PlaceId = game.PlaceId
	local JobId = game.JobId
	SaveConfig()
	if #Players:GetPlayers() <= 1 then
		Players.LocalPlayer:Kick("\nRejoining...")
		wait()
		TeleportService:Teleport(PlaceId, Players.LocalPlayer)
	else
		TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
	end
end)

UniversalSection:NewSlider("WalkSpeed", "Adjusts your humanoid speed", 145, 0, function(s)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

UniversalSection:NewSlider("JumpPower", "Adjusts your humanoid jump power", 545, 0, function(s)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

local flySpeed = 5

UniversalSection:NewSlider("Fly Speed", "Adjust fly speed", 150, 1, function(s)
	SaveConfig()
	flySpeed = s
end)

PrisonSection:NewButton("Toggle Fly (E)", "Fly with WASD and E toggle", function()
	SaveConfig()
	task.spawn(function()
		repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

		local plr = game.Players.LocalPlayer
		local char = plr.Character
		local torso = char:FindFirstChild("HumanoidRootPart")
		local mouse = plr:GetMouse()
		local flying = false
		local ctrl = {f = 0, b = 0, l = 0, r = 0}
		local lastctrl = {f = 0, b = 0, l = 0, r = 0}
		local speed = 0

		function Fly()
			local bg = Instance.new("BodyGyro", torso)
			bg.P = 9e4
			bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			bg.cframe = torso.CFrame

			local bv = Instance.new("BodyVelocity", torso)
			bv.velocity = Vector3.new(0, 0.1, 0)
			bv.maxForce = Vector3.new(9e9, 9e9, 9e9)

			repeat task.wait()
				plr.Character.Humanoid.PlatformStand = true
				if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
					speed += 0.5 + (speed / flySpeed)
					if speed > flySpeed then speed = flySpeed end
				elseif speed ~= 0 then
					speed -= 1
					if speed < 0 then speed = 0 end
				end

				if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
					bv.velocity = ((workspace.CurrentCamera.CFrame.LookVector * (ctrl.f + ctrl.b)) + ((workspace.CurrentCamera.CFrame * CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * 0.2, 0)).Position - workspace.CurrentCamera.CFrame.Position)) * speed
					lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
				elseif speed ~= 0 then
					bv.velocity = ((workspace.CurrentCamera.CFrame.LookVector * (lastctrl.f + lastctrl.b)) + ((workspace.CurrentCamera.CFrame * CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * 0.2, 0)).Position - workspace.CurrentCamera.CFrame.Position)) * speed
				else
					bv.velocity = Vector3.new(0, 0.1, 0)
				end

				bg.CFrame = workspace.CurrentCamera.CFrame * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed / flySpeed), 0, 0)
			until not flying

			ctrl, lastctrl = {f = 0, b = 0, l = 0, r = 0}, {f = 0, b = 0, l = 0, r = 0}
			speed = 0
			bg:Destroy()
			bv:Destroy()
			plr.Character.Humanoid.PlatformStand = false
		end

		mouse.KeyDown:Connect(function(key)
			if key:lower() == "e" then
				flying = not flying
				if flying then Fly() end
			elseif key:lower() == "w" then ctrl.f = 1
			elseif key:lower() == "s" then ctrl.b = -1
			elseif key:lower() == "a" then ctrl.l = -1
			elseif key:lower() == "d" then ctrl.r = 1 end
		end)

		mouse.KeyUp:Connect(function(key)
			if key:lower() == "w" then ctrl.f = 0
			elseif key:lower() == "s" then ctrl.b = 0
			elseif key:lower() == "a" then ctrl.l = 0
			elseif key:lower() == "d" then ctrl.r = 0 end
		end)
	end)
end)

UniversalSection:NewButton("ESP", "Allows you to view all users behind objects", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/XorHub/refs/heads/main/Scripts/ESP.luau"))()
end)

UniversalSection:NewButton("Jerk", "Loads a script that u can do sus stuff", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/XorHub/refs/heads/main/Scripts/sus.luau"))()
end)

UniversalSection:NewButton("Clear Chat", "Clears chat for everyone", function()
	SaveConfig()
	if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
		game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("hi\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\rCleared Chat.")
	else
		Notify("Chat is not supported. Only use on new rbx chat!")
	end
end)

UniversalSection:NewButton("Infinite Yield", "Executes inf yield", function()
	SaveConfig()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/XorHub/refs/heads/main/Scripts/infiniteyield.luau"))()
	Notify("Executed Infinite Yield")
end)

local MessageToBypass = ""
UniversalSection:NewTextBox("Message to bypass", "Chat bypass", function(txt)
	MessageToBypass = txt
end)

UniversalSection:NewButton("Send Bypassed Message", "Works on both chat versions", function()
	SendBypassedMessage(MessageToBypass)
end)

--// Kill Aura Toggle
PrisonSection:NewToggle("Kill Aura", "Automatically attacks players nearby", function(state)
	SaveConfig()
	local Events = {
		TeamEvent = workspace.Remote.TeamEvent,
		ShootEvent = game:GetService("ReplicatedStorage").ShootEvent,
	}

	local mainRemotes = game.ReplicatedStorage
	local meleeRemote = mainRemotes["meleeEvent"]
	local killAuraEnabled = state

	task.spawn(function()
		while killAuraEnabled do
			task.wait()
			for _, target in pairs(game.Players:GetPlayers()) do
				if target ~= game.Players.LocalPlayer then
					meleeRemote:FireServer(target)
				end
			end
		end
	end)
end)

--// Taser Bypass Toggle
PrisonSection:NewToggle("Taser Bypass", "Disables getting stunned by tasers", function(state)
	SaveConfig()
	local plr = game.Players.LocalPlayer
	if state then
		plr.Character.ClientInputHandler.Disabled = true
		plr.CharacterAdded:Connect(function()
			plr.Character:WaitForChild("ClientInputHandler").Disabled = true
		end)
	end
end)

--// Arrest Bypass Toggle
PrisonSection:NewToggle("Arrest Bypass", "Disables getting arrested by players", function(state)
	SaveConfig()
	if state then
		if hasgetconnections then
			for _, conn in ipairs(getconnections(workspace.Remote.arrestPlayer.OnClientEvent)) do
				conn:Disable()
			end
		else
			Notify("Your executor does not support getconnections. This feature will not work.")
		end
	end
end)

--// Team Switch Buttons
local teamButtons = {
	{"Team Guard", "Bright blue"},
	{"Team Neutral", "Medium stone grey"},
	{"Team Inmates", "Bright orange"},
	{"Team Criminals", "Bright red"},
}
for _, data in ipairs(teamButtons) do
	PrisonSection:NewButton(data[1], "Switches to a team", function()
		SaveConfig()
		workspace.Remote.TeamEvent:FireServer(data[2])
	end)
end

--// Arrest All
PrisonSection:NewButton("Arrest All", "Arrests all criminals", function()
	SaveConfig()
	local plr = game.Players.LocalPlayer
	local cpos = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.HumanoidRootPart.CFrame
	local Criminals = game.Teams:FindFirstChild("Criminals")
	if not Criminals then return warn("Criminals team not found!") end

	for _, crim in pairs(Criminals:GetPlayers()) do
		if crim ~= plr and crim.Character and crim.Character:FindFirstChild("HumanoidRootPart") then
			for _ = 1, 10 do
				task.wait()
				workspace.Remote.arrest:InvokeServer(crim.Character.HumanoidRootPart)
				plr.Character.HumanoidRootPart.CFrame = crim.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
			end
		end
	end
	if cpos then
		plr.Character.HumanoidRootPart.CFrame = cpos
	end
	Notify("Arrested everyone.")
end)

--// Kill Target
local eztarget = ""
PrisonSection:NewTextBox("Target", "Target for the below features", function(txt)
	SaveConfig()
	eztarget = txt
end)

PrisonSection:NewButton("Kill Target", "Damages selected target using melee hits", function()
	SaveConfig()
	local target = game.Players:FindFirstChild(eztarget)
	if not target then return warn("Invalid player target:", eztarget) end

	local meleeRemote = game.ReplicatedStorage["meleeEvent"]
	local startTime = os.clock()
	while os.clock() - startTime < 3 do
		meleeRemote:FireServer(target)
		wait(0.1)
	end
end)

PrisonSection:NewButton("Arrest Target", "Attempts to arrest your selected target", function()
	SaveConfig()
	local target = game.Players:FindFirstChild(eztarget)
	if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
		workspace.Remote.arrest:InvokeServer(target.Character.HumanoidRootPart)
	else
		warn("Invalid player target:", eztarget)
	end
end)

PrisonSection:NewButton("TP to target", "Punch nearby enemies instantly using key", function()
	SaveConfig()
	local target = game.Players:FindFirstChild(eztarget)
	if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
	else
		warn("Invalid player target:", eztarget)
	end
end)

--// Instant Punch
PrisonSection:NewButton("Instant Punch", "Punch nearby enemies instantly using key", function()
	SaveConfig()
	local plr = game.Players.LocalPlayer
	local meleeRemote = game.ReplicatedStorage["meleeEvent"]
	local mouse = plr:GetMouse()
	local cooldown = false

	local function punch()
		cooldown = true
		local part = Instance.new("Part", plr.Character)
		part.Transparency = 1
		part.Size = Vector3.new(5, 2, 3)
		part.CanCollide = false
		local weld = Instance.new("Weld", part)
		weld.Part0 = plr.Character.Torso
		weld.Part1 = part
		weld.C1 = CFrame.new(0, 0, 2)

		part.Touched:Connect(function(hit)
			local victim = game.Players:FindFirstChild(hit.Parent.Name)
			if victim and victim ~= plr then
				part:Destroy()
				for _ = 1, 100 do
					meleeRemote:FireServer(victim)
				end
			end
		end)

		task.wait(1)
		cooldown = false
		part:Destroy()
	end

	mouse.KeyDown:Connect(function(key)
		if not cooldown and key:lower() == "f" then
			punch()
		end
	end)
end)

--// Mod Equipped Gun
PrisonSection:NewButton("Mod equipped gun", "Overpowers currently equipped gun’s stats", function()
	SaveConfig()
	local plr = game.Players.LocalPlayer
	local tool = plr.Character:FindFirstChildOfClass("Tool")
	if not tool or not tool:FindFirstChild("GunStates") then return Notify("Needs to be a gun!") end

	local stats = require(tool.GunStates)
	stats.Damage = 9e9
	stats.FireRate = 0.001
	stats.Range = math.huge
	stats.MaxAmmo = math.huge
	stats.StoredAmmo = math.huge
	stats.AmmoPerClip = math.huge
	stats.CurrentAmmo = math.huge

	if tool.Name ~= "Remington 870" then
		stats.Bullets = 1
		stats.AutoFire = true
	end

	Notify("Modded " .. tool.Name)
end)

--// Get Guns
PrisonSection:NewButton("Get guns", "Teleports and equips powerful prison weapons", function()
	SaveConfig()
	local plr = game.Players.LocalPlayer
	local savedCFrame = plr.Character:GetPrimaryPartCFrame()

	local function teleportToPickup(name)
		local item = workspace.Prison_ITEMS.giver[name]
		plr.Character:SetPrimaryPartCFrame(item.ITEMPICKUP.CFrame)
		task.wait()
		workspace.Remote.ItemHandler:InvokeServer(item.ITEMPICKUP)
	end

	teleportToPickup("Remington 870")
	teleportToPickup("M9")
	teleportToPickup("AK-47")

	plr.Character:SetPrimaryPartCFrame(savedCFrame)
end)

--// No Doors
PrisonSection:NewButton("No doors", "Deletes all doors to unlock areas", function()
	SaveConfig()
	if workspace:FindFirstChild("Prison_Cellblock") then
		workspace.Prison_Cellblock:FindFirstChild("doors"):Destroy()
	end
	for _, v in pairs(workspace:GetChildren()) do
		if v.Name == "Doors" then
			v:Destroy()
		end
	end
end)

--// BTools
PrisonSection:NewButton("Btools", "Gives classic building tools", function()
	SaveConfig()
	local types = {"Clone", "GameTool", "Hammer", "Script", "Grab"}
	for _, type in ipairs(types) do
		local tool = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
		tool.BinType = type
	end
	Notify("You have received btools.")
end)

--// Teleports
local teleports = {
	{"TP inside of prison", "Teleport to inside of prison building", Vector3.new(879,99,2377)},
	{"TP to criminal base", "Teleport directly to criminal team base", Vector3.new(-943, 96, 2055)},
	{"TP to guard area", "Teleport to the armed guard location", Vector3.new(802,99,2270)}
}
for _, t in ipairs(teleports) do
	PrisonSection:NewButton(t[1], t[2], function()
		SaveConfig()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(t[3])
	end)
end

--// Loop Kill All Toggle
PrisonSection:NewToggle("Loop Kill All", "Teleports to and attacks players", function(state)
	SaveConfig()
	Notify("Not killing? Kill Aura is required to be on.")
	task.spawn(function()
		while state do
			task.wait(1)
			local players = game.Players:GetPlayers()
			if #players > 0 then
				local target = players[math.random(1, #players)]
				if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
					local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						hrp.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
					end
				end
			end
		end
	end)
end)

--// Godmode
PrisonSection:NewToggle("Godmode", "Prevents death and refreshes on respawn", function(state)
	SaveConfig()
	local player = game.Players.LocalPlayer
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")

	if state then
		humanoid.BreakJointsOnDeath = false

		humanoid.Died:Connect(function()
			if not state then return end
			local pos = player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.CFrame
			player:LoadCharacter()
			task.defer(function()
				if pos and player.Character:FindFirstChild("HumanoidRootPart") then
					player.Character:WaitForChild("HumanoidRootPart").CFrame = pos
				end
			end)
		end)
	else
		humanoid.BreakJointsOnDeath = true
	end
end)

PrisonSection:NewButton("Crash Server", "Crashes the server for everyone", function()
	SaveConfig()

	local player = game.Players.LocalPlayer
	local gunName = "Remington 870"
	local itemPickup = workspace.Prison_ITEMS.giver[gunName].ITEMPICKUP
	local remote = workspace.Remote.ItemHandler

	-- Request the weapon
	remote:InvokeServer(itemPickup)

	-- Move gun to character if it's in backpack
	for _, tool in ipairs(player.Backpack:GetChildren()) do
		if tool.Name == gunName then
			tool.Parent = player.Character
		end
	end

	-- Get tool instance and unequip
	local gunTool = player.Character:FindFirstChild(gunName)
	if not gunTool then
		return warn("Gun not equipped.")
	end

	local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid:UnequipTools()
	end

	-- Fire overloaded bullets repeatedly
	local function fireExploit()
		local bulletData = {{
			Hit = workspace.Terrain, -- Dummy target
			Distance = 100,
			Cframe = CFrame.new(0, 1, 1),
			RayObject = Ray.new(Vector3.new(0.1, 0.2, 0.3), Vector3.new(0.3, 0.4, 0.5))
		}}

		game.ReplicatedStorage.ShootEvent:FireServer(bulletData, gunTool)
	end

	-- Rapid-fire loop using Stepped for max performance
	RunService.Stepped:Connect(function()
		for _ = 1, 5 do -- Adjustable spam count
			fireExploit()
		end
	end)
end)




local TeleportCheck = false
Players.LocalPlayer.OnTeleport:Connect(function(State)
	if (not TeleportCheck) and queueTeleport and hasqueueTeleport == true then
		TeleportCheck = true
		queueTeleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/XorHub/refs/heads/main/xorhub.luau"))()')
	end
end)

if IsMobile then 
	Notify("Some features may be limited on mobile.") 
end

Notify("Xor Hub injected!")
