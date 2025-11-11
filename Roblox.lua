-------
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local httpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Mobile = not RunService:IsStudio() and table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform()) ~= nil

local fischbypass

if game.GameId == 5750914919 then
	fischbypass = true
end

local RenderStepped = RunService.RenderStepped

local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end

local Themes = {
	Names = {
		"Dark",
		"Darker", 
		"AMOLED",
		"Light",
		"Balloon",
		"SoftCream",
		"Aqua", 
		"Amethyst",
		"Rose",
		"Midnight",
		"Forest",
		"Sunset", 
		"Ocean",
		"Emerald",
		"Sapphire",
		"Cloud",
		"Grape",
		"Bloody",
		"Arctic",
		"Aurora",
		"SquareModern",
		"NeonSquare"
	},
	Aurora = {
		Name = "Rabbit Neon Aurora", 
		Accent = Color3.fromRGB(255, 130, 250),
		AcrylicMain = Color3.fromRGB(35, 35, 50),
		AcrylicBorder = Color3.fromRGB(85, 60, 130),
		AcrylicGradient = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 60, 130)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(60, 20, 100)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 100, 180))
		},
		AcrylicNoise = 0.8,
		TitleBarLine = Color3.fromRGB(200, 150, 255),
		Tab = Color3.fromRGB(120, 160, 255),
		Element = Color3.fromRGB(150, 80, 255),
		ElementBorder = Color3.fromRGB(50, 50, 80),
		InElementBorder = Color3.fromRGB(100, 60, 180),
		ElementTransparency = 0.83,
		ToggleSlider = Color3.fromRGB(255, 190, 130),
		ToggleToggled = Color3.fromRGB(80, 20, 130),
		SliderRail = Color3.fromRGB(90, 130, 255),
		DropdownFrame = Color3.fromRGB(255, 160, 190),
		DropdownHolder = Color3.fromRGB(45, 35, 70),
		DropdownBorder = Color3.fromRGB(65, 65, 120),
		DropdownOption = Color3.fromRGB(255, 180, 120),
		Keybind = Color3.fromRGB(120, 220, 255),
		Input = Color3.fromRGB(180, 80, 255),
		InputFocused = Color3.fromRGB(20, 10, 60),
		InputIndicator = Color3.fromRGB(250, 220, 180),
		Dialog = Color3.fromRGB(60, 40, 80),
		DialogHolder = Color3.fromRGB(35, 25, 60),
		DialogHolderLine = Color3.fromRGB(100, 60, 150),
		DialogButton = Color3.fromRGB(120, 60, 200),
		DialogButtonBorder = Color3.fromRGB(180, 140, 255),
		DialogBorder = Color3.fromRGB(80, 60, 160),
		DialogInput = Color3.fromRGB(90, 50, 150),
		DialogInputLine = Color3.fromRGB(255, 190, 250),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(210, 180, 255),
		Hover = Color3.fromRGB(255, 180, 130),
		HoverChange = 0.09,
	},
	Dark = {
		Name = "Dark",
		Accent = Color3.fromRGB(96, 205, 255),
		AcrylicMain = Color3.fromRGB(60, 60, 60),
		AcrylicBorder = Color3.fromRGB(90, 90, 90),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(40, 40, 40), Color3.fromRGB(40, 40, 40)),
		AcrylicNoise = 0.9,
		TitleBarLine = Color3.fromRGB(75, 75, 75),
		Tab = Color3.fromRGB(120, 120, 120),
		Element = Color3.fromRGB(120, 120, 120),
		ElementBorder = Color3.fromRGB(35, 35, 35),
		InElementBorder = Color3.fromRGB(90, 90, 90),
		ElementTransparency = 0.87,
		ToggleSlider = Color3.fromRGB(120, 120, 120),
		ToggleToggled = Color3.fromRGB(42, 42, 42),
		SliderRail = Color3.fromRGB(120, 120, 120),
		DropdownFrame = Color3.fromRGB(160, 160, 160),
		DropdownHolder = Color3.fromRGB(45, 45, 45),
		DropdownBorder = Color3.fromRGB(35, 35, 35),
		DropdownOption = Color3.fromRGB(120, 120, 120),
		Keybind = Color3.fromRGB(120, 120, 120),
		Input = Color3.fromRGB(160, 160, 160),
		InputFocused = Color3.fromRGB(10, 10, 10),
		InputIndicator = Color3.fromRGB(150, 150, 150),
		Dialog = Color3.fromRGB(45, 45, 45),
		DialogHolder = Color3.fromRGB(35, 35, 35),
		DialogHolderLine = Color3.fromRGB(30, 30, 30),
		DialogButton = Color3.fromRGB(45, 45, 45),
		DialogButtonBorder = Color3.fromRGB(80, 80, 80),
		DialogBorder = Color3.fromRGB(70, 70, 70),
		DialogInput = Color3.fromRGB(55, 55, 55),
		DialogInputLine = Color3.fromRGB(160, 160, 160),
		Text = Color3.fromRGB(240, 240, 240),
		SubText = Color3.fromRGB(170, 170, 170),
		Hover = Color3.fromRGB(120, 120, 120),
		HoverChange = 0.07,
	},
	-- ... (giữ nguyên các theme cũ như Darker, AMOLED, Light, Balloon, SoftCream, Aqua, Amethyst, Rose, Midnight, Forest, Sunset, Ocean, Emerald, Sapphire, Cloud, Grape, Bloody, Arctic)
	SquareModern = {
		Name = "SquareModern",
		Accent = Color3.fromRGB(0, 150, 136), -- Xanh teal vuông
		AcrylicMain = Color3.fromRGB(50, 50, 50),
		AcrylicBorder = Color3.fromRGB(80, 80, 80),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(30, 30, 30), Color3.fromRGB(70, 70, 70)),
		AcrylicNoise = 0.9,
		TitleBarLine = Color3.fromRGB(100, 100, 100),
		Tab = Color3.fromRGB(120, 120, 120),
		Element = Color3.fromRGB(70, 70, 70),
		ElementBorder = Color3.fromRGB(40, 40, 40),
		InElementBorder = Color3.fromRGB(90, 90, 90),
		ElementTransparency = 0.85,
		ToggleSlider = Color3.fromRGB(120, 120, 120),
		ToggleToggled = Color3.fromRGB(0, 150, 136),
		SliderRail = Color3.fromRGB(100, 100, 100),
		DropdownFrame = Color3.fromRGB(150, 150, 150),
		DropdownHolder = Color3.fromRGB(40, 40, 40),
		DropdownBorder = Color3.fromRGB(60, 60, 60),
		DropdownOption = Color3.fromRGB(120, 120, 120),
		Keybind = Color3.fromRGB(120, 120, 120),
		Input = Color3.fromRGB(140, 140, 140),
		InputFocused = Color3.fromRGB(20, 20, 20),
		InputIndicator = Color3.fromRGB(160, 160, 160),
		Dialog = Color3.fromRGB(50, 50, 50),
		DialogHolder = Color3.fromRGB(30, 30, 30),
		DialogHolderLine = Color3.fromRGB(70, 70, 70),
		DialogButton = Color3.fromRGB(50, 50, 50),
		DialogButtonBorder = Color3.fromRGB(80, 80, 80),
		DialogBorder = Color3.fromRGB(60, 60, 60),
		DialogInput = Color3.fromRGB(60, 60, 60),
		DialogInputLine = Color3.fromRGB(140, 140, 140),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(200, 200, 200),
		Hover = Color3.fromRGB(80, 80, 80),
		HoverChange = 0.1,
	},
	NeonSquare = {
		Name = "NeonSquare",
		Accent = Color3.fromRGB(255, 0, 255), -- Neon magenta
		AcrylicMain = Color3.fromRGB(20, 20, 20),
		AcrylicBorder = Color3.fromRGB(100, 0, 100),
		AcrylicGradient = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(50, 0, 50)),
		AcrylicNoise = 0.95,
		TitleBarLine = Color3.fromRGB(150, 0, 150),
		Tab = Color3.fromRGB(80, 0, 80),
		Element = Color3.fromRGB(40, 40, 40),
		ElementBorder = Color3.fromRGB(100, 0, 100),
		InElementBorder = Color3.fromRGB(120, 0, 120),
		ElementTransparency = 0.8,
		ToggleSlider = Color3.fromRGB(255, 0, 255),
		ToggleToggled = Color3.fromRGB(100, 0, 100),
		SliderRail = Color3.fromRGB(80, 0, 80),
		DropdownFrame = Color3.fromRGB(60, 0, 60),
		DropdownHolder = Color3.fromRGB(30, 30, 30),
		DropdownBorder = Color3.fromRGB(100, 0, 100),
		DropdownOption = Color3.fromRGB(255, 0, 255),
		Keybind = Color3.fromRGB(255, 0, 255),
		Input = Color3.fromRGB(50, 0, 50),
		InputFocused = Color3.fromRGB(0, 0, 0),
		InputIndicator = Color3.fromRGB(255, 100, 255),
		Dialog = Color3.fromRGB(40, 0, 40),
		DialogHolder = Color3.fromRGB(20, 20, 20),
		DialogHolderLine = Color3.fromRGB(120, 0, 120),
		DialogButton = Color3.fromRGB(40, 0, 40),
		DialogButtonBorder = Color3.fromRGB(150, 0, 150),
		DialogBorder = Color3.fromRGB(100, 0, 100),
		DialogInput = Color3.fromRGB(50, 0, 50),
		DialogInputLine = Color3.fromRGB(255, 50, 255),
		Text = Color3.fromRGB(255, 255, 255),
		SubText = Color3.fromRGB(200, 200, 200),
		Hover = Color3.fromRGB(255, 50, 255),
		HoverChange = 0.15,
	},
	-- (Các theme cũ giữ nguyên, chỉ thay CornerRadius = 0 ở code UI bên dưới)
}

-- (Giữ nguyên phần code cũ cho Themes khác, chỉ thêm 2 theme mới ở trên)

local InterfaceManager = {} do
	InterfaceManager.Folder = "FluentSettings"
	InterfaceManager.Settings = {
		Acrylic = true,
		Transparency = true,
		MenuKeybind = "M",
		SquareCorners = true -- Thêm setting mới cho viền vuông
	}

	-- (Giữ nguyên functions SetTheme, SetFolder, v.v.)

	function InterfaceManager:BuildInterfaceSection(tab)
		assert(self.Library, "Must set InterfaceManager.Library")
		local Library = self.Library
		local Settings = InterfaceManager.Settings

		InterfaceManager:LoadSettings()

		local section = tab:AddSection("Interface", "monitor")
		local InterfaceTheme = section:AddDropdown("InterfaceTheme", {
			Title = "Theme",
			Description = "Changes the interface theme.",
			Values = Library.Themes,
			Default = self.Library.Theme,
			Callback = function(Value)
				Library:SetTheme(Value)
				Settings.Theme = Value
				InterfaceManager:SaveSettings()
				-- Áp dụng square corners khi đổi theme
				Library:ApplySquareCorners(Settings.SquareCorners)
			end
		})

		InterfaceTheme:SetValue(Settings.Theme)

		-- Thêm toggle Square Corners
		section:AddToggle("SquareCornersToggle", {
			Title = "Square Corners",
			Description = "Enables square borders for all UI elements (no rounding).",
			Default = Settings.SquareCorners,
			Callback = function(Value)
				Settings.SquareCorners = Value
				Library:ApplySquareCorners(Value)
				InterfaceManager:SaveSettings()
			end
		})

		-- (Giữ nguyên AcrylicToggle, WindowTransparency, MenuKeybind)

		-- Thêm nút Export Config
		section:AddButton("Export UI Config", function()
			local config = httpService:JSONEncode({
				Theme = Settings.Theme,
				SquareCorners = Settings.SquareCorners,
				Acrylic = Settings.Acrylic
			})
			writefile(InterfaceManager.Folder .. "/ui_config.json", config)
			Library:Notify({
				Title = "Interface",
				Content = "UI Config exported to ui_config.json",
				Duration = 3
			})
		end)

		SaveManager:SetIgnoreIndexes({ "SaveManager_ConfigList", "SaveManager_ConfigName" })
	end

	-- (Giữ nguyên SaveSettings, LoadSettings)
end

-- Thêm function mới cho Library để apply square corners
function Library:ApplySquareCorners(enabled)
	if enabled then
		-- Loop qua tất cả UI elements và set CornerRadius = 0
		for _, obj in ipairs(self.Window:GetDescendants()) do
			if obj:IsA("UICorner") then
				obj.CornerRadius = UDim.new(0, 0)
			end
		end
		-- Áp dụng cho minimizer nếu có
		if self.Minimizer then
			for _, obj in ipairs(self.Minimizer:GetDescendants()) do
				if obj:IsA("UICorner") then
					obj.CornerRadius = UDim.new(0, 0)
				end
			end
		end
	else
		-- Restore bo tròn mặc định (tùy theme)
		Creator.UpdateTheme() -- Reload theme để restore
	end
end

-- Cải thiện dropdown với filter real-time
local function createDropdown(parent, config)
	-- (Code dropdown gốc, thêm:)
	local filterDebounce = false
	local searchBox = -- Thêm TextBox cho search
	searchBox:GetPropertyChangedSignal("Text"):Connect(function()
		if filterDebounce then return end
		filterDebounce = true
		task.wait(0.1) -- Delay cho mượt
		-- Filter options dựa trên text
		local filtered = {}
		for _, val in ipairs(config.Values) do
			if string.find(string.lower(val), string.lower(searchBox.Text)) then
				table.insert(filtered, val)
			end
		end
		-- Update dropdown list với filtered
		config.Values = filtered
		filterDebounce = false
	end)
	if #config.Values > 5 then
		-- Multi-select mode nếu nhiều options
		config.MultiSelect = true
	end
end

-- Cải thiện slider với auto-resize input
local function createSlider(parent, config)
	-- (Code slider gốc, thêm:)
	local hoverInput = Instance.new("TextBox") -- Input nhỏ khi hover
	hoverInput.Visible = false
	sliderFrame.MouseEnter:Connect(function()
		hoverInput.Visible = true
		hoverInput.Text = tostring(config.Default)
		-- Auto-resize width dựa trên text length
		local textSize = TextService:GetTextSize(hoverInput.Text, 14, Enum.Font.Gotham, Vector2.new(1000, 20))
		hoverInput.Size = UDim2.new(0, textSize.X + 10, 0, 20)
	end)
	sliderFrame.MouseLeave:Connect(function()
		hoverInput.Visible = false
	end)
	hoverInput.FocusLost:Connect(function()
		local newVal = tonumber(hoverInput.Text)
		if newVal then
			config.Callback(newVal)
		end
	end)
end

-- (Giữ nguyên phần còn lại của code: CreateWindow, CreateMinimizer, SetTheme, Destroy, v.v.)

-- Trong tất cả UICorner tạo mới, set CornerRadius = UDim.new(0, 0) mặc định
-- Ví dụ trong createButton:
local function createButton(isDesktop)
	return New("TextButton", {
		-- ...
	}, {
		New("UICorner", { CornerRadius = UDim.new(0, 0) }), -- Vuông
		-- ...
	})
end

-- Tương tự cho MinimizeButton và MobileMinimizeButton:
local MinimizeButton = New("TextButton", {
	-- ...
}, {
	New("UICorner", { CornerRadius = UDim.new(0, 0) }), -- Vuông
	-- ...
})

-- (Phần cuối code giữ nguyên, thêm task.defer cho nút floating với viền vuông)

task.wait(0.01)

return Library, SaveManager, InterfaceManager, Mobile
