--// Xor Hub V1 Lower-End | Universal Script

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
local VirtualInputManager = game:GetService("VirtualInputManager")

--// Player & Mouse
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

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
			Title = "Impulse Hub | Universal",
			Text = message,
			Duration = 6
		})
	end)
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

--// UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/XorHub/refs/heads/main/uilib.luau"))()
local Window = Library.CreateLib("Impulse Hub", "Ocean")

--// Tabs & Sections
local HomeTab = Window:NewTab("Home 🏠")
local HomeSection = HomeTab:NewSection("Home 🏠")

local UniversalTab = Window:NewTab("Universal 🎯")
local UniversalSection = UniversalTab:NewSection("Universal 🎯")

local PrisonTab = Window:NewTab("Prison Life ⛓️‍💥")
local PrisonSection = PrisonTab:NewSection("Prison Life ⛓️‍💥")

local DesSimTab = Window:NewTab("Destruction Sim 💥")
local DesSimSection = DesSimTab:NewSection("Destruction Sim 💥")

local NatDisasterTab = Window:NewTab("Natural Disasters 🌪️")
local NatDisasterSection = NatDisasterTab:NewSection("Natural Disasters 🌪️")

local SettingsTab = Window:NewTab("Settings ⚙️")
local SettingsSection = SettingsTab:NewSection("Settings ⚙️")

--// Other Varables
local RefreshingGodmode = false
local PrisonLife_ClickKill = false
local PrisonLife_ClickArrest = false

local TestOption
HomeSection:NewLabel("Welcome, "..LocalPlayer.Name.."!")
HomeSection:NewLabel(GetGameName())
HomeSection:NewLabel("Executor: "..GetExecutor())

HomeSection:NewButton("Join discord", "rawr", function()
	Notify("dsc.gg/impulserbx")
end)

HomeSection:NewDropdown("Type of test", "Choose types of exploit tests", {"Normal UNC Test", "Deep UNC Test", "SUNC Test", "Deep Vulnerability Test", "MoreUNC Test"}, function(currentOption)
	TestOption = currentOption
end)

HomeSection:NewButton("Run Executor Test", "Run a exploit test", function()
	 
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
	 
	flySpeed = s
end)

UniversalSection:NewButton("Toggle Fly (E)", "Fly with WASD and E toggle", function()
	 
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

local AimlockEnabled = false
local AimSmoothness = 6
local Aimlock_Target = nil
local TriggerBotEnabled = false
local TriggerDelay = 0

UniversalSection:NewToggle("Mouse Aimbot", "Locks mouse to target near crosshair", function(state)
	AimlockEnabled = state
end)

UniversalSection:NewSlider("Aim Smoothness", "Lower = faster, higher = slower", 30, 1, function(val)
	AimSmoothness = val
end)

UniversalSection:NewToggle("Trigger Bot", "Auto click when aiming at someone", function(state)
	TriggerBotEnabled = state
end)

UniversalSection:NewSlider("Trigger Delay (ms)", "Delay before firing", 500, 0, function(val)
	TriggerDelay = val
end)

UniversalSection:NewButton("ESP", "Allows you to view all users behind objects", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/XorHub/refs/heads/main/Scripts/ESP.luau"))()
end)

UniversalSection:NewButton("Jerk", "Loads a script that u can do sus stuff", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/pasteisback/XorHub/refs/heads/main/Scripts/sus.luau"))()
end)

UniversalSection:NewButton("Clear Chat", "Clears chat for everyone", function()
	 
	if game:GetService("TextChatService").ChatVersion == Enum.ChatVersion.TextChatService then
		game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("hi\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\rCleared Chat.")
	else
		Notify("Chat is not supported. Only use on new rbx chat!")
	end
end)

UniversalSection:NewButton("Infinite Yield", "Executes inf yield", function()
	 
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

if game.PlaceId == 155615604 then
	--// Functions
	local function ReturnGun()
		for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
			if tool:IsA("Tool") and tool:FindFirstChildOfClass("ModuleScript") then
				return tool
			end
		end
		return nil
	end

	local function GetPos()
		return LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
	end

	local function MoveTo(pos)
		pcall(function()
			local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if typeof(pos):lower() == "position" then pos = CFrame.new(pos) end
			LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
			for _ = 1, 3 do hrp.CFrame = pos end
		end)
	end

	local function MoveToJunk(part)
		part.CFrame = CFrame.new(0, 5^5, 0)
	end

	local function GetTeam()
		return LocalPlayer.TeamColor.Name
	end

	local function ValidTeam(team)
		local valid = {"Bright orange", "Bright blue"}
		if team and typeof(team):lower() == "string" then
			if table.find(valid, team) then return true end
			if team == "Really red" then return 1 end
		end
		return nil
	end

	local function MKILL(target, stop, pos)
		if typeof(target) == "string" then target = Players:FindFirstChild(target) end
		if not target or target == LocalPlayer then return end
		if not stop then stop = 1 end

		local tChar, tHum = target.Character, target.Character and target.Character:FindFirstChild("Humanoid")
		if not tChar or not tHum or tHum.Health < 1 or tChar:FindFirstChildOfClass("ForceField") then return end

		local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if not humanoid or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
		humanoid.Sit = false
		pos = pos or GetPos()
		MoveTo(target.Character.Head.Position)
		wait(0.2)

		for _ = 1, 10 do
			task.spawn(function()
				ReplicatedStorage.meleeEvent:FireServer(target)
			end)
		end
		wait(0.1)

		if tHum.Health > 1 and stop < 3 then
			MKILL(target, stop + 1, pos)
		else
			MoveTo(pos)
		end
	end

	local function LastTeam(teamName)
		task.spawn(function()
			local pos, camCFrame = GetPos(), Workspace.CurrentCamera.CFrame
			LocalPlayer.CharacterAdded:Connect(function(char)
				Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Wait()
				for _ = 1, 5 do Workspace.CurrentCamera.CFrame = camCFrame end
				char:WaitForChild("HumanoidRootPart")
				MoveTo(pos)
			end)

			local teamType = ValidTeam(teamName)
			if teamType and teamType ~= 1 then
				Workspace.Remote.TeamEvent:FireServer(teamName)
			elseif teamType == 1 then
				Workspace.Remote.TeamEvent:FireServer("Bright orange")
				local crimSpawn = Workspace["Criminals Spawn"].SpawnLocation
				crimSpawn.CanCollide = false
				crimSpawn.Transparency = 1
				repeat task.wait() crimSpawn.CFrame = GetPos() until LocalPlayer.Team == game.Teams.Criminals
				MoveToJunk(crimSpawn)
			end
		end)
	end

	local function GetGunFromTigerAdmin(itemName, skipReturn)
		local savedPos = GetPos()
		local item = Workspace.Prison_ITEMS.giver:FindFirstChild(itemName)
		if item and item:FindFirstChild("ITEMPICKUP") then
			repeat
				MoveTo(item.Position)
				task.spawn(function()
					Workspace.Remote.ItemHandler:InvokeServer(item)
				end)
				wait()
			until LocalPlayer.Backpack:FindFirstChild(itemName) or LocalPlayer.Character:FindFirstChild(itemName)
		end
		if not skipReturn then
			MoveTo(savedPos)
		end
	end

	local PlayerEvents = {
		loadchar = function()
			if LocalPlayer.Team == game.Teams.Inmates then
				local ohString1 = "Bright orange"
				workspace.Remote.TeamEvent:FireServer(ohString1)
			elseif LocalPlayer.Team == game.Teams.Guards then
				local ohString1 = "Bright blue"
				workspace.Remote.TeamEvent:FireServer(ohString1)
			elseif LocalPlayer.Team == game.Teams.Criminals then
				workspace.Remote.TeamEvent:FireServer("Bright orange")
				wait(0.3)
				local crimpad = workspace["Criminals Spawn"].SpawnLocation
				crimpad.CanCollide = false
				crimpad.Transparency = 1
				repeat task.wait() crimpad.CFrame = GetPos()() until LocalPlayer.Team == game.Teams.Criminals
				MoveToJunk(crimpad)
			end
		end,
	}

	local function ChangeTeam(team)
		if team == game.Teams.Criminals then
			local pos = GetPos()
			local crimSpawn = Workspace["Criminals Spawn"].SpawnLocation
			crimSpawn.CanCollide = false
			crimSpawn.Transparency = 1
			repeat task.wait() crimSpawn.CFrame = pos until LocalPlayer.Team == game.Teams.Criminals
			MoveTo(pos)
			MoveToJunk(crimSpawn)
			return
		end

		local camCFrame = Workspace.CurrentCamera.CFrame
		LocalPlayer.CharacterAdded:Connect(function(char)
			Workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Wait()
			for _ = 1, 5 do Workspace.CurrentCamera.CFrame = camCFrame end
			char:WaitForChild("HumanoidRootPart")
			MoveTo(GetPos())
		end)
		Workspace.Remote.TeamEvent:FireServer(team.TeamColor.Name)
	end

	function refresh(Pos)
		if not Pos then
			Pos = GetPos()
		end
		RefreshingGodmode = true
		local Goto = Pos or GetPos()
		local Connections = {}
		local Cam = workspace.CurrentCamera.CFrame
		Connections[1] = LocalPlayer.CharacterAdded:Connect(function(charnew)
			pcall(function()
				task.spawn(function()
					workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Wait()
					for i =1,5 do
						workspace.CurrentCamera.CFrame = Cam
					end
				end)
				repeat task.wait() until charnew and charnew:FindFirstChild("HumanoidRootPart")
				MoveTo(Goto)
				task.spawn(function()
					wait(.05)
					MoveTo(Goto)
					RefreshingGodmode = false
				end)
				Connections[1]:Disconnect()
			end)
		end)
		PlayerEvents.loadchar()
		print("Refreshed")
		return
	end

	local function KillAll(targetTeam)
		local originalTeam = GetTeam()
		local savedPos = GetPos()
		if not targetTeam then ChangeTeam(game.Teams.Inmates) end
		GetGunFromTigerAdmin("M9")

		repeat task.wait() until ReturnGun()
		local gun = ReturnGun()
		local shootPayload = {}

		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= LocalPlayer and (not targetTeam or plr.Team == targetTeam) then
				for _ = 1, 10 do
					table.insert(shootPayload, {
						RayObject = Ray.new(Vector3.new(), Vector3.new()),
						Distance = 0.1,
						Cframe = CFrame.new(),
						Hit = plr.Character:WaitForChild("Head")
					})
				end
			end
		end
		ReplicatedStorage.ShootEvent:FireServer(shootPayload, gun)
		wait(0.1)
		LastTeam(originalTeam)
		wait(0.4)
		MoveTo(savedPos)
	end

	local function kill(player)
		if typeof(player) == "string" then player = Players:FindFirstChild(player) end
		if not player or player == LocalPlayer then return Notify("Can't kill yourself????") end
		local gun = ReturnGun()

		if gun and LocalPlayer.Team ~= player.Team then
			local shootPayload = {}
			for _ = 1, 15 do
				table.insert(shootPayload, {
					RayObject = Ray.new(Vector3.new(), Vector3.new()),
					Distance = 0.1,
					Cframe = CFrame.new(),
					Hit = player.Character:WaitForChild("Head")
				})
			end
			ReplicatedStorage.ShootEvent:FireServer(shootPayload, gun)
		else
			MKILL(player)
		end

		wait(0.3)
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		Notify(hum and hum.Health < 1 and "Player has been killed" or "Failed to kill player")
	end

	function keycard()
		if LocalPlayer.Character:FindFirstChild("Key card") or LocalPlayer.Backpack:FindFirstChild("Key card") then
			return Notify("You already have a keycard!")
		end
		if game:GetService("Workspace")["Prison_ITEMS"].single:FindFirstChild("Key card") then
			local a = GetPos()
			local Key = workspace.Prison_ITEMS.single["Key card"].ITEMPICKUP
			MoveTo(CFrame.new(workspace.Prison_ITEMS.single["Key card"].ITEMPICKUP.Position))
			wait()
			repeat wait(.1)
				local a =pcall(function()
					local Key = workspace.Prison_ITEMS.single["Key card"].ITEMPICKUP
					game.Workspace.Remote["ItemHandler"]:InvokeServer(Key)
					MoveTo(CFrame.new(workspace.Prison_ITEMS.single["Key card"].ITEMPICKUP.Position+Vector3.new(0,3,0)))
				end)
				if not a then
					break
				end
			until LocalPlayer.Backpack:FindFirstChild("Key card")
			wait()
			MoveTo(a)
			return
		end
		local a,b= GetPos(),LocalPlayer.TeamColor.Name
		local HadOn = RefreshingGodmode
		if HadOn then
			RefreshingGodmode = false
		end
		ChangeTeam(game.Teams.Guards)
		repeat wait(.2)
			pcall(function()
				LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health =0
				wait(.2)
				ChangeTeam(game.Teams.Guards)
			end)
		until game:GetService("Workspace")["Prison_ITEMS"].single:FindFirstChild("Key card")
		if HadOn then
			RefreshingGodmode = true
		end
		LastTeam(b)
		wait(.1)
		MoveTo(CFrame.new(workspace.Prison_ITEMS.single["Key card"].ITEMPICKUP.Position))
		wait()
		repeat wait(.1)
			local a =pcall(function()
				local Key = workspace.Prison_ITEMS.single["Key card"].ITEMPICKUP
				game.Workspace.Remote["ItemHandler"]:InvokeServer(Key)
				MoveTo(CFrame.new(workspace.Prison_ITEMS.single["Key card"].ITEMPICKUP.Position+Vector3.new(0,3,0)))
			end)
			if not a then
				break
			end
		until LocalPlayer.Backpack:FindFirstChild("Key card")
		wait()
		MoveTo(a)

	end

	LocalPlayer:GetMouse().Button1Up:Connect(function()
		local Target = LocalPlayer:GetMouse().Target
		if PrisonLife_ClickArrest or PrisonLife_ClickKill then
			if Target and Target.Parent and Target.Parent:FindFirstChildOfClass("Humanoid") and game:GetService("Players"):FindFirstChild(Target.Parent.Name) or game:GetService("Players"):FindFirstChild(Target.Parent.Parent.Name) then
				local TargetModelPlr = game:GetService("Players"):FindFirstChild(Target.Parent.Name) or game:GetService("Players"):FindFirstChild(Target.Parent.Parent.Name)
				if PrisonLife_ClickArrest then
					if TargetModelPlr.Team ~= game:GetService("Teams").Guards then
						local ohInstance1 = Target
						local savedPos1 = GetPos()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = ohInstance1.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
						workspace.Remote.arrest:InvokeServer(ohInstance1)
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedPos1
					end
				end
				if PrisonLife_ClickKill then
					local savedPos2 = GetPos()
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TargetModelPlr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
					kill(TargetModelPlr)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedPos2
				end
			end
		end
	end)

	--// Kill Aura Toggle
	PrisonSection:NewToggle("Kill Aura", "Automatically attacks players nearby", function(state)
		 
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
		 
		local plr = game.Players.LocalPlayer
		if state then
			plr.Character.ClientInputHandler.Disabled = true
			plr.CharacterAdded:Connect(function()
				plr.Character:WaitForChild("ClientInputHandler").Disabled = true
			end)
		end
	end)
	
	--// Click kill
	PrisonSection:NewToggle("Click Kill", "Click = Kill", function(state)
		 
		PrisonLife_ClickKill = state
	end)

	--// Click arrest
	PrisonSection:NewToggle("Click Arrest", "Click = Arrest", function(state)
		 
		PrisonLife_ClickArrest = state
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
			 
			workspace.Remote.TeamEvent:FireServer(data[2])
		end)
	end

	--// Car Spawn
	PrisonSection:NewButton("Spawn Car", "Spawns a car at your location", function()
		 

		local Players = game:GetService("Players")
		local Workspace = game:GetService("Workspace")
		local RunService = game:GetService("RunService")
		local Remote = Workspace:WaitForChild("Remote")

		local LocalPlayer = Players.LocalPlayer
		local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local HRP = Character:WaitForChild("HumanoidRootPart")
		local OldPos = Character:GetPrimaryPartCFrame()

		-- Move player to the car spawn location
		Character:SetPrimaryPartCFrame(CFrame.new(-910, 95, 2157))
		task.wait(0.3)

		local car
		local carSpawned = false

		-- Wait for car to spawn
		local conn = Workspace.CarContainer.ChildAdded:Connect(function(child)
			car = child
			carSpawned = true
		end)

		-- Continuously fire car spawner
		local buttons = Workspace:WaitForChild("Prison_ITEMS"):WaitForChild("buttons")
		local spawner = buttons:GetChildren()[8]:FindFirstChild("Car Spawner")
		if not spawner then return Notify("Car spawner not found.") end

		while not carSpawned do
			task.wait(0.1)
			Remote.ItemHandler:InvokeServer(spawner)
		end

		conn:Disconnect()

		-- Wait for all car components
		repeat task.wait() until car:FindFirstChild("RWD") and car:FindFirstChild("Body") and car.Body:FindFirstChild("VehicleSeat")

		-- Set car primary part
		car.PrimaryPart = car.RWD

		-- Return to original position
		Character:SetPrimaryPartCFrame(OldPos)

		-- Sit in the car
		local VehicleSeat = car.Body.VehicleSeat
		VehicleSeat:Sit(Humanoid)

		-- Sync car with player position until seated
		repeat
			RunService.RenderStepped:Wait()
			car:SetPrimaryPartCFrame(OldPos)
			HRP.CFrame = VehicleSeat.CFrame
			VehicleSeat:Sit(Humanoid)
		until Humanoid.Sit

		Notify("Car spawned and seated!")
	end)

	--// Arrest All
	PrisonSection:NewButton("Arrest All", "Arrests all criminals", function()
		 
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

	--// Get keycard
	PrisonSection:NewButton("Get keycard", "Kills cop and grabs keycard", function()
		 
		keycard()
	end)

	--// Kill Target
	local eztarget = ""
	PrisonSection:NewTextBox("Target", "Target for the below features", function(txt)
		 
		eztarget = txt
	end)

	PrisonSection:NewButton("Kill Target", "Damages selected target using melee hits", function()
		 
		local target = game.Players:FindFirstChild(eztarget)
		local savedPos = GetPos()
		if not target then return warn("Invalid player target:", eztarget) end

		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
		kill(target)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = savedPos
	end)

	PrisonSection:NewButton("Arrest Target", "Attempts to arrest your selected target", function()
		 
		local target = game.Players:FindFirstChild(eztarget)
		if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			workspace.Remote.arrest:InvokeServer(target.Character.HumanoidRootPart)
		else
			warn("Invalid player target:", eztarget)
		end
	end)

	PrisonSection:NewButton("TP to target", "Punch nearby enemies instantly using key", function()
		 
		local target = game.Players:FindFirstChild(eztarget)
		if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
		else
			warn("Invalid player target:", eztarget)
		end
	end)

	--// Instant Punch
	PrisonSection:NewButton("Instant Punch", "Punch nearby enemies instantly using key", function()
		 
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
		 
		if workspace:FindFirstChild("Prison_Cellblock") then
			workspace.Prison_Cellblock:FindFirstChild("doors"):Destroy()
		end
		for _, v in pairs(workspace:GetChildren()) do
			if v.Name == "Doors" then
				v:Destroy()
			end
		end
	end)

	PrisonSection:NewButton("Kill all", "Kills all users", function()
		 
		KillAll(game.Teams.Inmates)
		KillAll(game.Teams.Guards)
		KillAll(game.Teams.Criminals)
		KillAll("Inmates")
		KillAll("Guards")
		KillAll("Criminals")
	end)

	--// Anti-Touch
	local antiTouchEnabled = false

	PrisonSection:NewToggle("Anti-Touch", "Kills users who touch your character", function(state)
		 
		antiTouchEnabled = state

		if state then
			task.spawn(function()
				while antiTouchEnabled do
					for _, player in ipairs(Players:GetPlayers()) do
						if player ~= LocalPlayer and player.Character and LocalPlayer.Character then
							local enemyHRP = player.Character:FindFirstChild("HumanoidRootPart")
							local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

							if enemyHRP and myHRP then
								local dist = (myHRP.Position - enemyHRP.Position).Magnitude
								if dist < 3.5 then
									for i = 1, 13 do
										task.spawn(function()
											ReplicatedStorage:WaitForChild("meleeEvent"):FireServer(player)
										end)
									end
								end
							end
						end
					end
					task.wait(0.2) -- adjust to control how often it checks
				end
			end)
		end
	end)

	PrisonSection:NewButton("Range Kill-All", "Kills users who are in the map", function()
		 
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and LocalPlayer.Character then
				local enemyHRP = player.Character:FindFirstChild("HumanoidRootPart")
				local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

				if enemyHRP and myHRP then
					local dist = (myHRP.Position - enemyHRP.Position).Magnitude
					if dist < 50 then
						for i = 1, 13 do
							task.spawn(function()
								ReplicatedStorage:WaitForChild("meleeEvent"):FireServer(player)
								local players = game.Players:GetPlayers()
								if #players > 0 then
									local target = players[math.random(1, #players)]
									if target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
										local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
										if hrp then
											hrp.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
											ReplicatedStorage:WaitForChild("meleeEvent"):FireServer(target)
										end
									end
								end
							end)
						end
					end
				end
			end
		end
	end)

	--// BTools
	PrisonSection:NewButton("Btools", "Gives classic building tools", function()
		 
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
			 
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(t[3])
		end)
	end

	--// Loop Kill All Toggle
	PrisonSection:NewToggle("Loop Kill All", "Teleports to and attacks players", function(state)
		 
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
							kill(target)
						end
					end
				end
			end
		end)
	end)

	--// Godmode
	PrisonSection:NewToggle("Godmode", "Prevents death and refreshes on respawn", function(state)
		 
		task.spawn(function()
			while state do
				local char = LocalPlayer.Character
				repeat task.wait() until char and char:FindFirstChildOfClass("Humanoid")
				char:FindFirstChildOfClass("Humanoid").BreakJointsOnDeath = false
				char:FindFirstChildOfClass("Humanoid").Died:Connect(function()
					refresh()
				end)
				task.wait(0.2)
			end
		end)
	end)

	PrisonSection:NewButton("Crash Server", "Crashes the server for everyone", function()
		 

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
else
	PrisonSection:NewLabel("Join Prison Life to load features")
	PrisonSection:NewButton("Join Game", "Joins the required game", function()
		 
		local TeleportService = game:GetService("TeleportService")
		local PlaceId = 155615604

		local success, err = pcall(function()
			TeleportService:Teleport(PlaceId, game.Players.LocalPlayer)
		end)

		if not success then
			warn("Teleport failed:", err)
			Notify("Teleport failed. Check console for details.")
		else
			Notify("Teleporting to Natural Disaster Survival...")
		end
	end)
end

if game.PlaceId == 2248408710 then --destruction simulator
	--// Coin and Level Input
	local moneyamt, lvlamt = 0, 0

	DesSimSection:NewTextBox("Coins", "Enter amount to add", function(txt)
		 
		moneyamt = tonumber(txt) or 0
	end)

	DesSimSection:NewTextBox("Level", "Enter desired level", function(txt)
		 
		lvlamt = tonumber(txt) or 0
	end)

	--// Add Coins
	DesSimSection:NewButton("Add Coins", "Adds selected coin amount", function()
		 
		if moneyamt > 0 then
			game:GetService("ReplicatedStorage").Remotes.generateBoost:FireServer("Coins", 999999, moneyamt)
			Notify("Added " .. moneyamt .. " Coins!")
		else
			Notify("Invalid coin amount!")
		end
	end)

	--// Add Level
	DesSimSection:NewButton("Add Level", "Sets your player level", function()
		 
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
		 
		task.spawn(function()
			while state do
				game:GetService("ReplicatedStorage").Remotes.generateBoost:FireServer("Coins", 999999, 99999999)
				wait(0.1)
			end
		end)
	end)

	--// Spam Sell Bricks Toggle
	DesSimSection:NewToggle("Spam Sell Bricks", "Rapidly sells bricks nonstop", function(state)
		 
		task.spawn(function()
			while state do
				game:GetService("ReplicatedStorage").Remotes.sellBricks:FireServer()
				wait(0.01)
			end
		end)
	end)

	--// Spam Money Button
	DesSimSection:NewButton("Spam Money (Fast)", "Floods 5-10b/sec coins", function()
		 
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
		 
		areatochange = tonumber(txt) or 0
	end)

	DesSimSection:NewButton("Change Area", "Sends player to target area", function()
		 
		game:GetService("ReplicatedStorage").Remotes.areaChanged:FireServer(areatochange)
	end)

	--// Boost Setup
	local boosttypeforplr, boostdurationforplr, boostmultiplierforplr = nil, 180, 2

	DesSimSection:NewDropdown("Boost Type", "Select your boost type", {"XP", "Super Jump", "Coin", "Brick", "Speed"}, function(opt)
		 
		boosttypeforplr = opt
	end)

	DesSimSection:NewTextBox("Boost Duration", "Duration in seconds", function(txt)
		 
		boostdurationforplr = tonumber(txt) or 0
	end)

	DesSimSection:NewTextBox("Boost Multiplier", "Multiplier (e.g. 2x, 3x)", function(txt)
		 
		boostmultiplierforplr = tonumber(txt) or 0
	end)

	DesSimSection:NewButton("Apply Boost", "Grants selected boost power", function()
		 
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
else
	DesSimSection:NewLabel("Join Destruction Simulator to load features")
	DesSimSection:NewButton("Join Game", "Joins the required game", function()
		 
		local TeleportService = game:GetService("TeleportService")
		local PlaceId = 2248408710

		local success, err = pcall(function()
			TeleportService:Teleport(PlaceId, game.Players.LocalPlayer)
		end)

		if not success then
			warn("Teleport failed:", err)
			Notify("Teleport failed. Check console for details.")
		else
			Notify("Teleporting to Natural Disaster Survival...")
		end
	end)
end

-- Exploit-heavy optimized version with full physics and reduced lag
if game.PlaceId == 189707 then
	local ringPartsEnabled = false
	local trackedParts = {}
	local MAX_PARTS = 200

	-- Anchor setup
	local baseFolder = Instance.new("Folder", Workspace)
	baseFolder.Name = "RingAnchorFolder"

	local anchorPart = Instance.new("Part")
	anchorPart.Name = "Anchor"
	anchorPart.Anchored = true
	anchorPart.CanCollide = false
	anchorPart.Transparency = 1
	anchorPart.Size = Vector3.new(1, 1, 1)
	anchorPart.Parent = baseFolder

	local anchorAttachment = Instance.new("Attachment", anchorPart)

	-- Setup physics override
	Network = Network or {
		BaseParts = {},
		Velocity = Vector3.new(14.46, 14.46, 14.46)
	}

	local function RetainPart(part)
		if part:IsA("BasePart") and not part.Anchored and part:IsDescendantOf(Workspace) then
			if not part:IsDescendantOf(LocalPlayer.Character) then
				part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
				part.CanCollide = false
				return true
			end
		end
		return false
	end

	local function TrackPart(part)
		if RetainPart(part) and not table.find(trackedParts, part) then
			table.insert(trackedParts, part)
			table.insert(Network.BaseParts, part)
		end
	end

	local function UntrackPart(part)
		local index = table.find(trackedParts, part)
		if index then table.remove(trackedParts, index) end

		local netIndex = table.find(Network.BaseParts, part)
		if netIndex then table.remove(Network.BaseParts, netIndex) end
	end

	-- Initial scan
	for _, part in ipairs(Workspace:GetDescendants()) do
		if #trackedParts >= MAX_PARTS then break end
		TrackPart(part)
	end

	Workspace.DescendantAdded:Connect(function(part)
		if #trackedParts >= MAX_PARTS then return end
		TrackPart(part)
	end)

	Workspace.DescendantRemoving:Connect(UntrackPart)

	-- Full physics override loop
	RunService.Heartbeat:Connect(function()
		if ringPartsEnabled then
			local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if not root then return end

			local center = root.Position

			-- Move anchor near the player to force ownership
			anchorPart.Position = center

			for i = #trackedParts, 1, -1 do
				local part = trackedParts[i]
				if not part or not part:IsDescendantOf(Workspace) then
					table.remove(trackedParts, i)
					continue
				end

				local pos = part.Position
				local dist = (Vector3.new(pos.X, center.Y, pos.Z) - center).Magnitude
				local angle = math.atan2(pos.Z - center.Z, pos.X - center.X)
				local newAngle = angle + math.rad(config.speed)

				local targetPos = Vector3.new(
					center.X + math.cos(newAngle) * math.min(config.radius, dist),
					center.Y + (config.height * math.abs(math.sin((pos.Y - center.Y) / config.height))),
					center.Z + math.sin(newAngle) * math.min(config.radius, dist)
				)

				local direction = (targetPos - pos)
				part.Velocity = direction.Unit * config.strength
			end
		end
	end)

	-- UI controls
	NatDisasterSection:NewToggle("Ring Parts", "Enable rotating part ring", function(state)
		ringPartsEnabled = state
	end)

	NatDisasterSection:NewSlider("Radius of ring parts", "Distance from center", 500, 0, function(val)
		config.radius = val
	end)

	NatDisasterSection:NewSlider("Height of ring parts", "Vertical swirl height", 500, 0, function(val)
		config.height = val
	end)

	NatDisasterSection:NewSlider("Speed of ring parts", "Rotation speed", 500, 0, function(val)
		config.speed = val
	end)

	NatDisasterSection:NewSlider("Strength of ring parts", "Force toward orbit", 500, 0, function(val)
		config.strength = val
	end)

	NatDisasterSection:NewButton("Get Disaster", "Predicts Disaster", function()
		local char = Workspace:FindFirstChild(LocalPlayer.Name)
		if char and char:FindFirstChild("SurvivalTag") then
			Notify(char.SurvivalTag.Value)
		else
			Notify("Wait until you are on the island")
		end
	end)
else
	NatDisasterSection:NewLabel("Join Natural Disasters to load features")
	NatDisasterSection:NewButton("Join Game", "Joins the required game", function()
		local TeleportService = game:GetService("TeleportService")
		local PlaceId = 189707

		local success, err = pcall(function()
			TeleportService:Teleport(PlaceId, game.Players.LocalPlayer)
		end)

		if not success then
			warn("Teleport failed:", err)
			Notify("Teleport failed. Check console for details.")
			Notify(err)
		else
			Notify("Teleporting to Natural Disaster Survival...")
		end
	end)
end

--// Default to RightShift if config.bind is invalid or missing
local defaultKey = Enum.KeyCode.RightShift
local keybind = Enum.KeyCode[config.bind] or defaultKey

--// Setup keybind in UI
SettingsSection:NewKeybind("Menu Bind", "Toggle the UI menu", keybind, function()
	if Library and typeof(Library.ToggleUI) == "function" then
		Library:ToggleUI()
	end
end)

--// Aimlock and Trigger bot functions
local function getClosestTarget()
	local closest, shortest = nil, math.huge
	local screenCenter = Camera.ViewportSize / 2

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
			local head = plr.Character:FindFirstChild("Head")
			if head then
				local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
				local dist = (Vector2.new(pos.X, pos.Y) - screenCenter).Magnitude
				if onScreen and dist < shortest and dist <= 150 then
					closest = plr
					shortest = dist
				end
			end
		end
	end

	return closest
end

-- // Aim Function (Memory)
local function aimToHead(target)
	if not target or not target.Character then return end
	local head = target.Character:FindFirstChild("Head")
	if not head then return end

	local predicted = head.Position + head.Velocity * 0.05
	Camera.CFrame = CFrame.new(Camera.CFrame.Position, predicted)
end

--// Aimlock and Trigger Bot detection
RunService.RenderStepped:Connect(function()
	-- Aimlock
	if AimlockEnabled and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
		Aimlock_Target = Aimlock_Target or getClosestTarget()
		if Aimlock_Target then
			aimToHead(Aimlock_Target)
		end
	else
		Aimlock_Target = nil
	end

	-- Triggerbot
	if TriggerBotEnabled and Aimlock_Target and Aimlock_Target.Character then
		local head = Aimlock_Target.Character:FindFirstChild("Head")
		if head then
			local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
			local dist = (Vector2.new(pos.X, pos.Y) - (Camera.ViewportSize / 2)).Magnitude
			if onScreen and dist <= 15 then
				VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, game, 0)
				task.wait(0.01)
				VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, game, 0)
			end
		end
	end
end)

if IsMobile then 
	Notify("Some features may be limited on mobile.") 
end

Notify("Impulse Hub injected!")
