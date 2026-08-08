queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/vfx-qudsa/newguiauto/refs/heads/main/.lua'))()")

local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local lp = Players.LocalPlayer

if CoreGui:FindFirstChild("Crazy Diamond") then 
    return 
end

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

local Window = Library:CreateWindow({
    Title = "Crazy Diamond",
    Footer = "script by t.me/IcrazyDiamondI",
    Icon = 10448205324,
    NotifySide = "Right",
    ShowCustomCursor = false,
    Size = UDim2.new(0, 600, 0, 500),
})

Window:SetCornerRadius(20)

local Tabs = {
    Settings = Window:AddTab("UI Settings", "settings"),
    Farm = Window:AddTab("autofarm", "hand-coins"),
}

local MenuGroup = Tabs.Settings:AddLeftGroupbox("Menu", "wrench")

MenuGroup:AddToggle('KeybindList', {
    Text = 'Show Keybind List',
    Default = false,
})

Toggles.KeybindList:OnChanged(function()
    Library.KeybindFrame.Visible = Toggles.KeybindList.Value
end)

MenuGroup:AddButton("Copy Telegram", function()
    setclipboard("t.me/IcrazyDiamondI")
    Library:Notify("Telegram copied to clipboard!", 3)
end)

MenuGroup:AddSlider("UICornerSlider", {
    Text = "Corner Radius",
    Default = 20,
    Min = 0,
    Max = 20,
    Rounding = 0,
    Callback = function(value)
        Window:SetCornerRadius(value)
    end
})

MenuGroup:AddDropdown("DPIDropdown", {
    Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
    Default = "100%",
    Text = "DPI Scale",
    Callback = function(Value)
        Value = Value:gsub("%%", "")
        local DPI = tonumber(Value)
        Library:SetDPIScale(DPI)
    end,
})

MenuGroup:AddDivider()

MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKey", { Default = "RightShift", NoUI = true })
Library.ToggleKeybind = Options.MenuKey

local function Cleanup()
    Library:Unload()
end

MenuGroup:AddButton("Unload", Cleanup)
local FarmGroup = Tabs.Farm:AddLeftGroupbox("Autofarm", "play")

FarmGroup:AddButton("Start Autofarm", function()
    _G.AutofarmEnabled = true
    Library:Notify("Autofarm started!", 2)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vfx-qudsa/newauto/refs/heads/main/.lua"))()
end)

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKey" }) 

ThemeManager:SetFolder("ObsidianSoft")
SaveManager:SetFolder("ObsidianSoft/main")
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
ThemeManager:ApplyTheme("farm.theme")
SaveManager:LoadAutoloadConfig()

if script then
    script.Destroying:Connect(Cleanup)
end
