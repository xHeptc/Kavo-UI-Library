for i,v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
	v:Disable()
end
local tools = {}

for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
	if v:IsA("Tool") then
		table.insert(tools, v.Name)
	end
end
local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local window = ui.CreateLib("Blox Fruits", getgenv().ThemeOption)

local customColors = {
    SchemeColor = Color3.fromRGB(0,255,255),
    Background = Color3.fromRGB(0, 0, 0),
    Header = Color3.fromRGB(0, 0, 0),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(20, 20, 20)
}

local plr = game:GetService("Players").LocalPlayer
------------------------------
getgenv().AutoFarm = false
getgenv().CurrentQuest = "Bandit [Lv. 5]"
getgenv().FruitEsp = false
getgenv().ChestEsp = false

getgenv().SkillZ = false
getgenv().SkillC = false
getgenv().SkillX = false
getgenv().SKillF = false

getgenv().CurrentWeapon = "Combat"
getgenv().AutoWeapon = false

getgenv().FarmStopped = false
getgenv().IsQuestStarted = false

getgenv().Noclip = false
-------------------------------
local mainTab = window:NewTab("Main")
local plrTab = window:NewTab("Player")
local mainSection = mainTab:NewSection("Auto Farm")
local plrSection = plrTab:NewSection("Player")
local fruitSection = mainTab:NewSection("Fruits")
local chestSection = mainTab:NewSection("Chests")
local creditsTab = window:NewTab("Credits")

local creditSection = creditsTab:NewSection("Credits")
local xheptccredit = creditsTab:NewSection("xHeptc - UI Library / Main Scripter")
local sanincredit = creditsTab:NewSection("sannin - Helper <3")

plrSection:NewToggle("Noclip", "Enables Noclip", function(state)
    getgenv().Noclip = state
end)

local toolDropdown = mainSection:NewDropdown("Weapon", "Choose your tool to use!", tools, function(weapon)
	getgenv().CurrentWeapon = weapon
end)

game.Players.LocalPlayer.Backpack.DescendantAdded:Connect(function(tool)
	local toolName = tool.Name
	if tool:IsA("Tool") then
		table.insert(tools, toolName)
		toolDropdown:Refresh(tools)
	end
end)
game.Players.LocalPlayer.Backpack.DescendantRemoving:Connect(function(tool)
	local toolName = tool.Name
	if tool:IsA("Tool") then
		for i,v in pairs(tools) do
			if v == toolName then
				table.remove(tools, i)
			end
		end	
	end
	toolDropdown:Refresh(tools)
end)

local skillsSection = mainTab:NewSection("Skills")

mainSection:NewToggle("Auto Farm", "Auto Farms Enemies", function(state)
    getgenv().AutoFarm = state
end)

local quests = {
	"Bandit [Lv. 5]",
	"Monkey [Lv. 14]", 
	"Gorilla [Lv. 20]",
	"Pirate [Lv. 35]", 
	"Brute [Lv. 45]", 
	"Desert Bandit [Lv. 60]", 
	"Desert Officer [Lv. 70]", 
	"Snow Bandit [Lv. 90]", 
	"Snowman [Lv. 100]",
	"Chief Petty Officer [Lv. 120]" ,
	"Sky Bandit [Lv. 150]", 
	"Toga Warrior [Lv. 225]", 
	"Gladiator [Lv. 275]", 
	"Military Soldier [Lv. 300]", 
	"Military Spy [Lv. 330]", 
	"God's Guard [Lv. 450]",
	"Shanda [Lv. 475]", 
	"Galley Pirate [Lv. 625]"
}

mainSection:NewDropdown("Mob", "Choose Your Mob To Farm", quests, function(chosenQuest)
    getgenv().CurrentQuest = chosenQuest
end)

function enemy()
    if game.Workspace.Enemies:FindFirstChild(getgenv().CurrentQuest) then
        local mobs = game.Workspace.Enemies:GetChildren()
        for i = 1, #mobs do local v = mobs[i]
            if v.Name == getgenv().CurrentQuest and v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                return v
            end
        end
    end
    return game.ReplicatedStorage:FindFirstChild(getgenv().CurrentQuest)
end

skillsSection:NewToggle("Auto Skill: C", "Uses Skill C", function(state)
    getgenv().SkillC = state
end)

skillsSection:NewToggle("Auto Skill: Z", "Uses Skill Z", function(state)
    getgenv().SkillZ = state
end)

skillsSection:NewToggle("Auto Skill: X", "Uses Skill X", function(state)
    getgenv().SkillX = state
end)

skillsSection:NewToggle("Auto Skill: F", "Uses Skill F", function(state)
    getgenv().SkillF = state
end)

game:GetService("RunService").Stepped:Connect(function()
    if getgenv().AutoFarm then
        local useTool = game.Players.LocalPlayer.Backpack[getgenv().CurrentWeapon]
        plr.Character.Humanoid:EquipTool(useTool)
    end
    if getgenv().AutoFarm or getgenv().Noclip then
        pcall(function()
            plr.Character.Humanoid:ChangeState(11)
        end)
    end
    if getgenv().SkillX then
        pcall(function()
            keypress(0x58)
            wait(1)
            keyrelease(0x58)
        end)
    end
    if getgenv().SkillC then
        pcall(function()
            keypress(0x43)
            wait(1)
            keyrelease(0x43)
        end)
    end
    if getgenv().SkillF then
        pcall(function()
            keypress(0x46)
            wait(1)
            keyrelease(0x46)
        end)
    end
    if getgenv().SkillZ then
        pcall(function()
            keypress(0x5A)
            wait(1)
            keyrelease(0x5A)
        end)
    end
end)
coroutine.wrap(function()
    while wait() do
        if getgenv().AutoFarm and not getgenv().FarmStopped then
            local v = enemy()
            local vuser = game:GetService("VirtualUser")
            vuser:CaptureController()
            vuser:ClickButton1(Vector2.new())
            pcall(function()
                plr.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame - v.HumanoidRootPart.CFrame.lookVector * 2
            end)
        end
    end
end)()

