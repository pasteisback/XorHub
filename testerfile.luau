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
local hassethiddenproperty = true

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
if not sethiddenproperty then
	Notify("Your executor does not support sethiddenproperty. Some features will not work.")
	hassethiddenproperty = false
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

local NatDisasterTab = Window:NewTab("Natural Disasters 🌪️")
local NatDisasterSection = NatDisasterTab:NewSection("Natural Disasters 🌪️")

local SettingsTab = Window:NewTab("Settings ⚙️")
local SettingsSection = SettingsTab:NewSection("Settings ⚙️")

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

--// Coin and Level Input
local moneyamt, lvlamt = 0, 0

DesSimSection:NewTextBox("Coins", "Enter amount to add", function(txt)
	SaveConfig()
	moneyamt = tonumber(txt) or 0
end)

DesSimSection:NewTextBox("Level", "Enter desired level", function(txt)
	SaveConfig()
	lvlamt = tonumber(txt) or 0
end)

--// Add Coins
DesSimSection:NewButton("Add Coins", "Adds selected coin amount", function()
	SaveConfig()
	if moneyamt > 0 then
		game:GetService("ReplicatedStorage").Remotes.generateBoost:FireServer("Coins", 999999, moneyamt)
		Notify("Added " .. moneyamt .. " Coins!")
	else
		Notify("Invalid coin amount!")
	end
end)

--// Add Level
DesSimSection:NewButton("Add Level", "Sets your player level", function()
	SaveConfig()
	local Event = game:GetService("ReplicatedStorage").Remotes.generateBoost
	local currentLvl = game.Players.LocalPlayer.leaderstats.Level.Value
	local targetLvl = lvlamt
	local diff = math.abs(targetLvl - currentLvl)
	local direction = targetLvl > currentLvl and 1 or -1
	for _ = 1, math.ceil(diff / 15) do
		local fireAmt = math.min(diff, 15) * direction
		Event:FireServer("Levels", 480, fireAmt)
		diff -= math.abs(fireAmt)
		wait()
	end
	Notify("Set Level to " .. lvlamt .. "!")
end)

--// Sell Bricks
DesSimSection:NewButton("Sell Bricks", "Sells all your bricks", function()
	SaveConfig()
	game:GetService("ReplicatedStorage").Remotes.sellBricks:FireServer()
	Notify("Sold bricks.")
end)

--// Infinite Backpack Display
local function displayInfBackpack()
	local plrGui = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.StatsFrame.Stats.Bricks.amnt
	local backpackAmt = workspace[LocalPlayer.Name].Backpack.HUD.backpackUI.amnt
	local newAmt = plrGui:Clone()
	local newAmt2 = backpackAmt:Clone()
	newAmt.Text, newAmt2.Text = "inf", "inf"
	newAmt.Name, newAmt2.Name = "amount", "amount"
	newAmt.Parent, newAmt2.Parent = plrGui.Parent, backpackAmt.Parent
	plrGui:Destroy()
	backpackAmt:Destroy()
end

DesSimSection:NewButton("Get inf backpack", "Visually gives infinite backpack", function()
	SaveConfig()
	task.spawn(function()
		while true do
			game:GetService("ReplicatedStorage").Remotes.sellBricks:FireServer()
			displayInfBackpack()
			wait(0.1)
		end
	end)
end)

--// Spam Money Toggle
DesSimSection:NewToggle("Spam Money", "Spams coins into inventory", function(state)
	SaveConfig()
	task.spawn(function()
		while state do
			game:GetService("ReplicatedStorage").Remotes.generateBoost:FireServer("Coins", 999999, 99999999)
			wait(0.1)
		end
	end)
end)

--// Spam Sell Bricks Toggle
DesSimSection:NewToggle("Spam Sell Bricks", "Rapidly sells bricks nonstop", function(state)
	SaveConfig()
	task.spawn(function()
		while state do
			game:GetService("ReplicatedStorage").Remotes.sellBricks:FireServer()
			wait(0.01)
		end
	end)
end)

--// Spam Money Button
DesSimSection:NewButton("Spam Money (Fast)", "Floods 5-10b/sec coins", function()
	SaveConfig()
	task.spawn(function()
		while true do
			game:GetService("ReplicatedStorage").Remotes.generateBoost:FireServer("Coins", 999999, 99999999)
			wait(0.1)
		end
	end)
end)

--// Area Change
local areatochange = 0
DesSimSection:NewTextBox("Area", "Enter target area number", function(txt)
	SaveConfig()
	areatochange = tonumber(txt) or 0
end)

DesSimSection:NewButton("Change Area", "Sends player to target area", function()
	SaveConfig()
	game:GetService("ReplicatedStorage").Remotes.areaChanged:FireServer(areatochange)
end)

--// Boost Setup
local boosttypeforplr, boostdurationforplr, boostmultiplierforplr = nil, 180, 2

DesSimSection:NewDropdown("Boost Type", "Select your boost type", {"XP", "Super Jump", "Coin", "Brick", "Speed"}, function(opt)
	SaveConfig()
	boosttypeforplr = opt
end)

DesSimSection:NewTextBox("Boost Duration", "Duration in seconds", function(txt)
	SaveConfig()
	boostdurationforplr = tonumber(txt) or 0
end)

DesSimSection:NewTextBox("Boost Multiplier", "Multiplier (e.g. 2x, 3x)", function(txt)
	SaveConfig()
	boostmultiplierforplr = tonumber(txt) or 0
end)

DesSimSection:NewButton("Apply Boost", "Grants selected boost power", function()
	SaveConfig()
	local boostevent = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("generateBoost")
	if not boostevent then return warn("Boost event not found!") end
	if not boosttypeforplr then return warn("No boost type selected!") end

	local boostMap = {
		["Speed"] = "ExtraSpeed",
		["XP"] = "XPBoost",
		["Super Jump"] = "SuperJump",
		["Brick"] = "BrickBoost",
		["Coin"] = "CoinBoost"
	}

	local boostKey = boostMap[boosttypeforplr]
	if boostKey then
		boostevent:FireServer(boostKey, boostdurationforplr, boostmultiplierforplr)
	else
		warn("Invalid boost type!")
	end
end)

--// Silent Aim
RivalsSection:NewButton("Silent Aim", "Enables automatic aimbot silently", function()
	SaveConfig()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/XorHub/refs/heads/main/Scripts/rivalsslientaim.luau"))()
end)

--// Device Selection
local selectedDevice = nil
local deviceMap = {
	["Mobile"] = "Touch",
	["PC"] = "MouseKeyboard",
	["Console"] = "Gamepad"
}

RivalsSection:NewDropdown("Input Device", "Select control device type", {"Mobile", "PC", "Console"}, function(option)
	SaveConfig()
	selectedDevice = deviceMap[option]
end)

RivalsSection:NewButton("Apply Device", "Apply chosen device control type", function()
	SaveConfig()
	local remotePath = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
		:WaitForChild("Replication"):WaitForChild("Fighter"):WaitForChild("SetControls")

	if selectedDevice then
		remotePath:FireServer(selectedDevice)
	else
		warn("No device selected!")
	end
end)

local ringPartsEnabled = false
local trackedParts = {}

--// Attachments
local baseFolder = Instance.new("Folder", Workspace)
local anchorPart = Instance.new("Part")
anchorPart.Name = "Anchor"
anchorPart.Anchored = true
anchorPart.CanCollide = false
anchorPart.Transparency = 1
anchorPart.Parent = baseFolder

local anchorAttachment = Instance.new("Attachment", anchorPart)

--// Network Setup
if not getgenv().Network then
	getgenv().Network = {
		BaseParts = {},
		Velocity = Vector3.new(14.46, 14.46, 14.46)
	}

	function Network.RetainPart(part)
		if typeof(part) == "Instance" and part:IsA("BasePart") and part:IsDescendantOf(Workspace) then
			table.insert(Network.BaseParts, part)
			part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
			part.CanCollide = false
		end
	end

	RunService.Heartbeat:Connect(function()
		sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
		for _, part in ipairs(Network.BaseParts) do
			if part:IsDescendantOf(Workspace) then
				part.Velocity = Network.Velocity
			end
		end
	end)
end

--// Force Part
local function ForcePart(part)
	if part:IsA("Part") and not part.Anchored and not part:FindFirstAncestorWhichIsA("Model"):FindFirstChild("Humanoid") and part.Name ~= "Handle" then
		for _, child in ipairs(part:GetChildren()) do
			if child:IsA("BodyMover") or child:IsA("Torque") or child:IsA("AlignPosition") then
				child:Destroy()
			end
		end
		part.CanCollide = false

		local attachment = Instance.new("Attachment", part)
		local torque = Instance.new("Torque", part)
		torque.Torque = Vector3.new(100000, 100000, 100000)
		torque.Attachment0 = attachment

		local alignPos = Instance.new("AlignPosition", part)
		alignPos.Attachment0 = attachment
		alignPos.Attachment1 = anchorAttachment
		alignPos.MaxForce = math.huge
		alignPos.MaxVelocity = math.huge
		alignPos.Responsiveness = 200
	end
end

--// Retain Part
local function RetainPart(part)
	if part:IsA("BasePart") and not part.Anchored and part:IsDescendantOf(Workspace) then
		if part:IsDescendantOf(LocalPlayer.Character) then return false end
		part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
		part.CanCollide = false
		return true
	end
	return false
end

--// Track Parts
local function addPart(part)
	if RetainPart(part) and not table.find(trackedParts, part) then
		table.insert(trackedParts, part)
	end
end

local function removePart(part)
	local index = table.find(trackedParts, part)
	if index then
		table.remove(trackedParts, index)
	end
end

--// Populate trackedParts
for _, part in ipairs(Workspace:GetDescendants()) do
	addPart(part)
end
Workspace.DescendantAdded:Connect(addPart)
Workspace.DescendantRemoving:Connect(removePart)

--// Ring Effect Loop
RunService.Heartbeat:Connect(function()
	if not ringPartsEnabled then return end

	local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local center = root.Position

	for _, part in ipairs(trackedParts) do
		if part:IsA("BasePart") and part.Parent and not part.Anchored then
			local pos = part.Position
			local dist = (Vector3.new(pos.X, center.Y, pos.Z) - center).Magnitude
			local angle = math.atan2(pos.Z - center.Z, pos.X - center.X)
			local newAngle = angle + math.rad(config.speed)

			local targetPos = Vector3.new(
				center.X + math.cos(newAngle) * math.min(config.radius, dist),
				center.Y + (config.height * math.abs(math.sin((pos.Y - center.Y) / config.height))),
				center.Z + math.sin(newAngle) * math.min(config.radius, dist)
			)

			local velocity = (targetPos - part.Position).Unit * config.strength
			part.Velocity = velocity
		end
	end
end)

--// UI Buttons
NatDisasterSection:NewButton("Get Disaster", "Predicts Disaster", function()
	SaveConfig()
	local char = Workspace:FindFirstChild(LocalPlayer.Name)
	if char and char:FindFirstChild("SurvivalTag") then
		Notify(char.SurvivalTag.Value)
	else
		Notify("Wait until you are on the island")
	end
end)

NatDisasterSection:NewToggle("Ring Parts", "Enable rotating part ring", function(state)
	ringPartsEnabled = state
	SaveConfig()
end)

NatDisasterSection:NewSlider("Radius of ring parts", "Distance from center", 500, 0, function(val)
	config.radius = val
	SaveConfig()
end)

NatDisasterSection:NewSlider("Height of ring parts", "Vertical swirl height", 500, 0, function(val)
	config.height = val
	SaveConfig()
end)

NatDisasterSection:NewSlider("Speed of ring parts", "Rotation speed", 500, 0, function(val)
	config.speed = val
	SaveConfig()
end)

NatDisasterSection:NewSlider("Strength of ring parts", "Force toward orbit", 500, 0, function(val)
	config.strength = val
	SaveConfig()
end)

--// Default to RightShift if config.bind is invalid or missing
local defaultKey = Enum.KeyCode.RightShift
local keybind = Enum.KeyCode[config.bind] or defaultKey

--// Setup keybind in UI
SettingsSection:NewKeybind("Menu Bind", "Toggle the UI menu", keybind, function()
	if Library and typeof(Library.ToggleUI) == "function" then
		Library:ToggleUI()
	end
	SaveConfig()
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
