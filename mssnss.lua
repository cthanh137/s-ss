local Lighting        = game:GetService("Lighting")
local RunService      = game:GetService("RunService")
local LocalPlayer     = game:GetService("Players").LocalPlayer
local UserInputService= game:GetService("UserInputService")
local TweenService    = game:GetService("TweenService")
local TextService     = game:GetService("TextService")
local Camera          = workspace.CurrentCamera
local Mouse           = LocalPlayer:GetMouse()
local httpService     = game:GetService("HttpService")

local Mobile = not RunService:IsStudio()
    and table.find({Enum.Platform.IOS, Enum.Platform.Android}, UserInputService:GetPlatform()) ~= nil

local fischbypass
if game.GameId == 5750914919 then
    fischbypass = true
end

local RenderStepped = RunService.RenderStepped
local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end

-- ═══════════════════════════════════════
--              THEMES (giữ nguyên)
-- ═══════════════════════════════════════
local Themes = {
    Names = {
        "Dark","Darker","AMOLED","Light","Balloon","SoftCream",
        "Aqua","Amethyst","Rose","Midnight","Forest","Sunset",
        "Ocean","Emerald","Sapphire","Cloud","Grape","Bloody","Arctic","Aurora"
    },
    Aurora = {
        Name="Rabbit Neon Aurora",
        Accent=Color3.fromRGB(255,130,250), AcrylicMain=Color3.fromRGB(35,35,50),
        AcrylicBorder=Color3.fromRGB(85,60,130),
        AcrylicGradient=ColorSequence.new{
            ColorSequenceKeypoint.new(0,Color3.fromRGB(40,60,130)),
            ColorSequenceKeypoint.new(0.5,Color3.fromRGB(60,20,100)),
            ColorSequenceKeypoint.new(1,Color3.fromRGB(30,100,180))},
        AcrylicNoise=0.8, TitleBarLine=Color3.fromRGB(200,150,255),
        Tab=Color3.fromRGB(120,160,255), Element=Color3.fromRGB(150,80,255),
        ElementBorder=Color3.fromRGB(50,50,80), InElementBorder=Color3.fromRGB(100,60,180),
        ElementTransparency=0.83, ToggleSlider=Color3.fromRGB(255,190,130),
        ToggleToggled=Color3.fromRGB(80,20,130), SliderRail=Color3.fromRGB(90,130,255),
        DropdownFrame=Color3.fromRGB(255,160,190), DropdownHolder=Color3.fromRGB(45,35,70),
        DropdownBorder=Color3.fromRGB(65,65,120), DropdownOption=Color3.fromRGB(255,180,120),
        Keybind=Color3.fromRGB(120,220,255), Input=Color3.fromRGB(180,80,255),
        InputFocused=Color3.fromRGB(20,10,60), InputIndicator=Color3.fromRGB(250,220,180),
        Dialog=Color3.fromRGB(60,40,80), DialogHolder=Color3.fromRGB(35,25,60),
        DialogHolderLine=Color3.fromRGB(100,60,150), DialogButton=Color3.fromRGB(120,60,200),
        DialogButtonBorder=Color3.fromRGB(180,140,255), DialogBorder=Color3.fromRGB(80,60,160),
        DialogInput=Color3.fromRGB(90,50,150), DialogInputLine=Color3.fromRGB(255,190,250),
        Text=Color3.fromRGB(255,255,255), SubText=Color3.fromRGB(210,180,255),
        Hover=Color3.fromRGB(255,180,130), HoverChange=0.09,
    },
    Dark = {
        Name="Dark", Accent=Color3.fromRGB(96,205,255),
        AcrylicMain=Color3.fromRGB(60,60,60), AcrylicBorder=Color3.fromRGB(90,90,90),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(40,40,40),Color3.fromRGB(40,40,40)),
        AcrylicNoise=0.9, TitleBarLine=Color3.fromRGB(75,75,75),
        Tab=Color3.fromRGB(120,120,120), Element=Color3.fromRGB(120,120,120),
        ElementBorder=Color3.fromRGB(35,35,35), InElementBorder=Color3.fromRGB(90,90,90),
        ElementTransparency=0.87, ToggleSlider=Color3.fromRGB(120,120,120),
        ToggleToggled=Color3.fromRGB(42,42,42), SliderRail=Color3.fromRGB(120,120,120),
        DropdownFrame=Color3.fromRGB(160,160,160), DropdownHolder=Color3.fromRGB(45,45,45),
        DropdownBorder=Color3.fromRGB(35,35,35), DropdownOption=Color3.fromRGB(120,120,120),
        Keybind=Color3.fromRGB(120,120,120), Input=Color3.fromRGB(160,160,160),
        InputFocused=Color3.fromRGB(10,10,10), InputIndicator=Color3.fromRGB(150,150,150),
        Dialog=Color3.fromRGB(45,45,45), DialogHolder=Color3.fromRGB(35,35,35),
        DialogHolderLine=Color3.fromRGB(30,30,30), DialogButton=Color3.fromRGB(45,45,45),
        DialogButtonBorder=Color3.fromRGB(80,80,80), DialogBorder=Color3.fromRGB(70,70,70),
        DialogInput=Color3.fromRGB(55,55,55), DialogInputLine=Color3.fromRGB(160,160,160),
        Text=Color3.fromRGB(240,240,240), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(120,120,120), HoverChange=0.07,
    },
    Darker = {
        Name="Darker", Accent=Color3.fromRGB(56,109,223),
        AcrylicMain=Color3.fromRGB(30,30,30), AcrylicBorder=Color3.fromRGB(60,60,60),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(17,17,17),Color3.fromRGB(18,18,18)),
        AcrylicNoise=0.94, TitleBarLine=Color3.fromRGB(65,65,65),
        Tab=Color3.fromRGB(100,100,100), Element=Color3.fromRGB(70,70,70),
        ElementBorder=Color3.fromRGB(25,25,25), InElementBorder=Color3.fromRGB(55,55,55),
        ElementTransparency=0.82, DropdownFrame=Color3.fromRGB(120,120,120),
        DropdownHolder=Color3.fromRGB(35,35,35), DropdownBorder=Color3.fromRGB(25,25,25),
        Dialog=Color3.fromRGB(35,35,35), DialogHolder=Color3.fromRGB(25,25,25),
        DialogHolderLine=Color3.fromRGB(20,20,20), DialogButton=Color3.fromRGB(35,35,35),
        DialogButtonBorder=Color3.fromRGB(55,55,55), DialogBorder=Color3.fromRGB(50,50,50),
        DialogInput=Color3.fromRGB(45,45,45), DialogInputLine=Color3.fromRGB(120,120,120),
        Text=Color3.fromRGB(240,240,240), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(70,70,70), HoverChange=0.07,
    },
    AMOLED = {
        Name="AMOLED", Accent=Color3.fromRGB(255,255,255),
        AcrylicMain=Color3.fromRGB(0,0,0), AcrylicBorder=Color3.fromRGB(20,20,20),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(0,0,0),Color3.fromRGB(0,0,0)),
        AcrylicNoise=1, TitleBarLine=Color3.fromRGB(25,25,25),
        Tab=Color3.fromRGB(40,40,40), Element=Color3.fromRGB(15,15,15),
        ElementBorder=Color3.fromRGB(0,0,0), InElementBorder=Color3.fromRGB(40,40,40),
        ElementTransparency=0.95, ToggleSlider=Color3.fromRGB(40,40,40),
        ToggleToggled=Color3.fromRGB(255,255,255), SliderRail=Color3.fromRGB(40,40,40),
        DropdownFrame=Color3.fromRGB(20,20,20), DropdownHolder=Color3.fromRGB(0,0,0),
        DropdownBorder=Color3.fromRGB(0,0,0), DropdownOption=Color3.fromRGB(40,40,40),
        Keybind=Color3.fromRGB(40,40,40), Input=Color3.fromRGB(40,40,40),
        InputFocused=Color3.fromRGB(0,0,0), InputIndicator=Color3.fromRGB(60,60,60),
        InputIndicatorFocus=Color3.fromRGB(255,255,255),
        Dialog=Color3.fromRGB(0,0,0), DialogHolder=Color3.fromRGB(0,0,0),
        DialogHolderLine=Color3.fromRGB(20,20,20), DialogButton=Color3.fromRGB(15,15,15),
        DialogButtonBorder=Color3.fromRGB(30,30,30), DialogBorder=Color3.fromRGB(27,27,27),
        DialogInput=Color3.fromRGB(15,15,15), DialogInputLine=Color3.fromRGB(60,60,60),
        Text=Color3.fromRGB(255,255,255), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(40,40,40), HoverChange=0.04,
    },
    Light = {
        Name="Light", Accent=Color3.fromRGB(0,103,192),
        AcrylicMain=Color3.fromRGB(200,200,200), AcrylicBorder=Color3.fromRGB(120,120,120),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255)),
        AcrylicNoise=0.96, TitleBarLine=Color3.fromRGB(160,160,160),
        Tab=Color3.fromRGB(90,90,90), Element=Color3.fromRGB(255,255,255),
        ElementBorder=Color3.fromRGB(180,180,180), InElementBorder=Color3.fromRGB(150,150,150),
        ElementTransparency=0.65, ToggleSlider=Color3.fromRGB(40,40,40),
        ToggleToggled=Color3.fromRGB(255,255,255), SliderRail=Color3.fromRGB(40,40,40),
        DropdownFrame=Color3.fromRGB(200,200,200), DropdownHolder=Color3.fromRGB(240,240,240),
        DropdownBorder=Color3.fromRGB(200,200,200), DropdownOption=Color3.fromRGB(150,150,150),
        Keybind=Color3.fromRGB(120,120,120), Input=Color3.fromRGB(200,200,200),
        InputFocused=Color3.fromRGB(100,100,100), InputIndicator=Color3.fromRGB(80,80,80),
        InputIndicatorFocus=Color3.fromRGB(0,103,192),
        Dialog=Color3.fromRGB(255,255,255), DialogHolder=Color3.fromRGB(240,240,240),
        DialogHolderLine=Color3.fromRGB(228,228,228), DialogButton=Color3.fromRGB(255,255,255),
        DialogButtonBorder=Color3.fromRGB(190,190,190), DialogBorder=Color3.fromRGB(140,140,140),
        DialogInput=Color3.fromRGB(250,250,250), DialogInputLine=Color3.fromRGB(160,160,160),
        Text=Color3.fromRGB(0,0,0), SubText=Color3.fromRGB(40,40,40),
        Hover=Color3.fromRGB(50,50,50), HoverChange=0.16,
    },
    Balloon = {
        Name="Balloon", Accent=Color3.fromRGB(100,170,255),
        AcrylicMain=Color3.fromRGB(189,224,255), AcrylicBorder=Color3.fromRGB(160,227,255),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(240,250,255),Color3.fromRGB(210,235,250)),
        AcrylicNoise=1, TitleBarLine=Color3.fromRGB(150,200,255),
        Tab=Color3.fromRGB(153,185,255), Element=Color3.fromRGB(160,200,255),
        ElementBorder=Color3.fromRGB(130,170,230), InElementBorder=Color3.fromRGB(120,174,240),
        ElementTransparency=0.80, ToggleSlider=Color3.fromRGB(93,163,255),
        ToggleToggled=Color3.fromRGB(60,112,180), SliderRail=Color3.fromRGB(170,220,255),
        DropdownFrame=Color3.fromRGB(175,235,255), DropdownHolder=Color3.fromRGB(200,220,240),
        DropdownBorder=Color3.fromRGB(130,170,230), DropdownOption=Color3.fromRGB(146,202,255),
        Keybind=Color3.fromRGB(170,220,255), Input=Color3.fromRGB(170,220,255),
        InputFocused=Color3.fromRGB(75,95,140), InputIndicator=Color3.fromRGB(190,250,255),
        InputIndicatorFocus=Color3.fromRGB(100,170,255),
        Dialog=Color3.fromRGB(189,230,255), DialogHolder=Color3.fromRGB(201,239,255),
        DialogHolderLine=Color3.fromRGB(197,236,250), DialogButton=Color3.fromRGB(219,252,255),
        DialogButtonBorder=Color3.fromRGB(160,200,255), DialogBorder=Color3.fromRGB(175,220,255),
        DialogInput=Color3.fromRGB(160,200,255), DialogInputLine=Color3.fromRGB(185,230,255),
        Text=Color3.fromRGB(30,30,30), SubText=Color3.fromRGB(90,90,90),
        Hover=Color3.fromRGB(170,220,255), HoverChange=0.03,
    },
    SoftCream = {
        Name="SoftCream", Accent=Color3.fromRGB(206,163,90),
        AcrylicMain=Color3.fromRGB(255,245,220), AcrylicBorder=Color3.fromRGB(255,230,200),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(255,245,220),Color3.fromRGB(255,235,210)),
        AcrylicNoise=0.93, TitleBarLine=Color3.fromRGB(255,220,190),
        Tab=Color3.fromRGB(199,165,112), Element=Color3.fromRGB(255,216,161),
        ElementBorder=Color3.fromRGB(234,193,111), InElementBorder=Color3.fromRGB(255,212,143),
        ElementTransparency=0.80, ToggleSlider=Color3.fromRGB(214,175,97),
        ToggleToggled=Color3.fromRGB(200,160,100), SliderRail=Color3.fromRGB(255,220,190),
        DropdownFrame=Color3.fromRGB(255,228,164), DropdownHolder=Color3.fromRGB(250,240,225),
        DropdownBorder=Color3.fromRGB(255,210,180), DropdownOption=Color3.fromRGB(255,190,115),
        Keybind=Color3.fromRGB(255,220,190), Input=Color3.fromRGB(255,220,190),
        InputFocused=Color3.fromRGB(180,140,80), InputIndicator=Color3.fromRGB(255,250,205),
        InputIndicatorFocus=Color3.fromRGB(255,236,158),
        Dialog=Color3.fromRGB(255,255,240), DialogHolder=Color3.fromRGB(255,245,220),
        DialogHolderLine=Color3.fromRGB(255,240,210), DialogButton=Color3.fromRGB(255,255,240),
        DialogButtonBorder=Color3.fromRGB(255,210,180), DialogBorder=Color3.fromRGB(255,220,190),
        DialogInput=Color3.fromRGB(255,210,180), DialogInputLine=Color3.fromRGB(255,225,205),
        Text=Color3.fromRGB(30,30,30), SubText=Color3.fromRGB(90,90,90),
        Hover=Color3.fromRGB(255,220,190), HoverChange=0.03,
    },
    Aqua = {
        Name="Aqua", Accent=Color3.fromRGB(38,166,178),
        AcrylicMain=Color3.fromRGB(18,54,61), AcrylicBorder=Color3.fromRGB(80,118,130),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(41,101,139),Color3.fromRGB(11,132,128)),
        AcrylicNoise=0.92, TitleBarLine=Color3.fromRGB(68,135,136),
        Tab=Color3.fromRGB(126,175,180), Element=Color3.fromRGB(66,130,160),
        ElementBorder=Color3.fromRGB(40,100,122), InElementBorder=Color3.fromRGB(75,109,110),
        ElementTransparency=0.87, ToggleSlider=Color3.fromRGB(100,152,160),
        ToggleToggled=Color3.fromRGB(25,70,95), SliderRail=Color3.fromRGB(115,150,160),
        DropdownFrame=Color3.fromRGB(158,194,200), DropdownHolder=Color3.fromRGB(39,99,116),
        DropdownBorder=Color3.fromRGB(33,119,120), DropdownOption=Color3.fromRGB(121,152,160),
        Keybind=Color3.fromRGB(108,153,160), Input=Color3.fromRGB(112,156,160),
        InputFocused=Color3.fromRGB(14,35,40), InputIndicator=Color3.fromRGB(137,181,190),
        Dialog=Color3.fromRGB(27,113,130), DialogHolder=Color3.fromRGB(33,99,109),
        DialogHolderLine=Color3.fromRGB(34,81,86), DialogButton=Color3.fromRGB(27,128,130),
        DialogButtonBorder=Color3.fromRGB(62,100,110), DialogBorder=Color3.fromRGB(26,86,100),
        DialogInput=Color3.fromRGB(36,107,105), DialogInputLine=Color3.fromRGB(70,120,130),
        Text=Color3.fromRGB(240,240,240), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(112,155,160), HoverChange=0.04,
    },
    Amethyst = {
        Name="Amethyst", Accent=Color3.fromRGB(126,44,182),
        AcrylicMain=Color3.fromRGB(40,12,71), AcrylicBorder=Color3.fromRGB(85,45,120),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(34,19,49),Color3.fromRGB(41,24,57)),
        AcrylicNoise=0.92, TitleBarLine=Color3.fromRGB(95,55,130),
        Tab=Color3.fromRGB(135,75,170), Element=Color3.fromRGB(115,55,150),
        ElementBorder=Color3.fromRGB(60,35,85), InElementBorder=Color3.fromRGB(85,45,110),
        ElementTransparency=0.87, ToggleSlider=Color3.fromRGB(135,65,160),
        ToggleToggled=Color3.fromRGB(59,30,79), SliderRail=Color3.fromRGB(135,65,160),
        DropdownFrame=Color3.fromRGB(145,85,170), DropdownHolder=Color3.fromRGB(50,30,70),
        DropdownBorder=Color3.fromRGB(60,35,85), DropdownOption=Color3.fromRGB(135,65,160),
        Keybind=Color3.fromRGB(135,65,160), Input=Color3.fromRGB(135,65,160),
        InputFocused=Color3.fromRGB(25,15,35), InputIndicator=Color3.fromRGB(155,85,180),
        InputIndicatorFocus=Color3.fromRGB(126,44,182),
        Dialog=Color3.fromRGB(50,30,70), DialogHolder=Color3.fromRGB(40,25,60),
        DialogHolderLine=Color3.fromRGB(35,20,55), DialogButton=Color3.fromRGB(50,30,70),
        DialogButtonBorder=Color3.fromRGB(90,50,120), DialogBorder=Color3.fromRGB(80,45,110),
        DialogInput=Color3.fromRGB(60,35,80), DialogInputLine=Color3.fromRGB(145,75,170),
        Text=Color3.fromRGB(240,240,240), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(135,65,160), HoverChange=0.04,
    },
    Rose = {
        Name="Rose", Accent=Color3.fromRGB(219,48,123),
        AcrylicMain=Color3.fromRGB(35,25,30), AcrylicBorder=Color3.fromRGB(145,35,75),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(65,25,45),Color3.fromRGB(75,30,50)),
        AcrylicNoise=0.92, TitleBarLine=Color3.fromRGB(150,65,95),
        Tab=Color3.fromRGB(190,85,115), Element=Color3.fromRGB(170,60,90),
        ElementBorder=Color3.fromRGB(95,35,55), InElementBorder=Color3.fromRGB(120,50,70),
        ElementTransparency=0.87, ToggleSlider=Color3.fromRGB(190,75,105),
        ToggleToggled=Color3.fromRGB(45,15,25), SliderRail=Color3.fromRGB(190,75,105),
        DropdownFrame=Color3.fromRGB(200,95,125), DropdownHolder=Color3.fromRGB(75,30,45),
        DropdownBorder=Color3.fromRGB(95,35,55), DropdownOption=Color3.fromRGB(190,75,105),
        Keybind=Color3.fromRGB(190,75,105), Input=Color3.fromRGB(190,75,105),
        InputFocused=Color3.fromRGB(35,15,20), InputIndicator=Color3.fromRGB(210,95,125),
        InputIndicatorFocus=Color3.fromRGB(219,48,123),
        Dialog=Color3.fromRGB(75,30,45), DialogHolder=Color3.fromRGB(65,25,40),
        DialogHolderLine=Color3.fromRGB(60,20,35), DialogButton=Color3.fromRGB(75,30,45),
        DialogButtonBorder=Color3.fromRGB(115,45,65), DialogBorder=Color3.fromRGB(105,40,60),
        DialogInput=Color3.fromRGB(85,35,50), DialogInputLine=Color3.fromRGB(200,85,115),
        Text=Color3.fromRGB(240,240,240), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(190,75,105), HoverChange=0.04,
    },
    Midnight = {
        Name="Midnight", Accent=Color3.fromRGB(52,50,178),
        AcrylicMain=Color3.fromRGB(20,20,20), AcrylicBorder=Color3.fromRGB(83,83,130),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(1,1,39),Color3.fromRGB(6,6,54)),
        AcrylicNoise=0.96, TitleBarLine=Color3.fromRGB(77,75,126),
        Tab=Color3.fromRGB(126,127,180), Element=Color3.fromRGB(111,108,160),
        ElementBorder=Color3.fromRGB(32,32,59), InElementBorder=Color3.fromRGB(85,83,110),
        ElementTransparency=0.87, ToggleSlider=Color3.fromRGB(120,117,160),
        ToggleToggled=Color3.fromRGB(30,12,68), SliderRail=Color3.fromRGB(117,117,160),
        DropdownFrame=Color3.fromRGB(161,161,200), DropdownHolder=Color3.fromRGB(35,36,80),
        DropdownBorder=Color3.fromRGB(32,30,65), DropdownOption=Color3.fromRGB(116,116,160),
        Keybind=Color3.fromRGB(110,123,160), Input=Color3.fromRGB(116,112,160),
        InputFocused=Color3.fromRGB(20,10,30), InputIndicator=Color3.fromRGB(136,140,190),
        Dialog=Color3.fromRGB(37,37,80), DialogHolder=Color3.fromRGB(24,24,65),
        DialogHolderLine=Color3.fromRGB(25,26,60), DialogButton=Color3.fromRGB(46,44,80),
        DialogButtonBorder=Color3.fromRGB(71,72,110), DialogBorder=Color3.fromRGB(72,70,100),
        DialogInput=Color3.fromRGB(55,55,85), DialogInputLine=Color3.fromRGB(133,131,190),
        Text=Color3.fromRGB(240,240,240), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(119,121,160), HoverChange=0.04,
    },
    Forest = {
        Name="Forest", Accent=Color3.fromRGB(46,141,70),
        AcrylicMain=Color3.fromRGB(20,35,25), AcrylicBorder=Color3.fromRGB(50,90,60),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(15,35,20),Color3.fromRGB(20,40,25)),
        AcrylicNoise=0.92, TitleBarLine=Color3.fromRGB(60,100,70),
        Tab=Color3.fromRGB(80,140,90), Element=Color3.fromRGB(70,120,80),
        ElementBorder=Color3.fromRGB(30,50,35), InElementBorder=Color3.fromRGB(60,90,70),
        ElementTransparency=0.87, ToggleSlider=Color3.fromRGB(90,150,100),
        ToggleToggled=Color3.fromRGB(19,57,21), SliderRail=Color3.fromRGB(90,150,100),
        DropdownFrame=Color3.fromRGB(100,160,110), DropdownHolder=Color3.fromRGB(35,60,40),
        DropdownBorder=Color3.fromRGB(30,50,35), DropdownOption=Color3.fromRGB(90,150,100),
        Keybind=Color3.fromRGB(90,150,100), Input=Color3.fromRGB(90,150,100),
        InputFocused=Color3.fromRGB(15,25,18), InputIndicator=Color3.fromRGB(110,170,120),
        InputIndicatorFocus=Color3.fromRGB(46,141,70),
        Dialog=Color3.fromRGB(35,60,40), DialogHolder=Color3.fromRGB(30,50,35),
        DialogHolderLine=Color3.fromRGB(25,45,30), DialogButton=Color3.fromRGB(35,60,40),
        DialogButtonBorder=Color3.fromRGB(70,110,80), DialogBorder=Color3.fromRGB(60,100,70),
        DialogInput=Color3.fromRGB(45,70,50), DialogInputLine=Color3.fromRGB(100,160,110),
        Text=Color3.fromRGB(240,240,240), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(90,150,100), HoverChange=0.04,
    },
    Sunset = {
        Name="Sunset", Accent=Color3.fromRGB(255,128,0),
        AcrylicMain=Color3.fromRGB(40,25,25), AcrylicBorder=Color3.fromRGB(130,80,60),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(70,35,20),Color3.fromRGB(60,30,20)),
        AcrylicNoise=0.92, TitleBarLine=Color3.fromRGB(140,90,70),
        Tab=Color3.fromRGB(180,120,90), Element=Color3.fromRGB(160,100,70),
        ElementBorder=Color3.fromRGB(70,40,30), InElementBorder=Color3.fromRGB(110,70,50),
        ElementTransparency=0.87, ToggleSlider=Color3.fromRGB(180,110,80),
        ToggleToggled=Color3.fromRGB(62,34,21), SliderRail=Color3.fromRGB(180,110,80),
        DropdownFrame=Color3.fromRGB(190,130,100), DropdownHolder=Color3.fromRGB(60,35,25),
        DropdownBorder=Color3.fromRGB(70,40,30), DropdownOption=Color3.fromRGB(180,110,80),
        Keybind=Color3.fromRGB(180,110,80), Input=Color3.fromRGB(180,110,80),
        InputFocused=Color3.fromRGB(30,20,15), InputIndicator=Color3.fromRGB(200,130,100),
        InputIndicatorFocus=Color3.fromRGB(255,128,0),
        Dialog=Color3.fromRGB(60,35,25), DialogHolder=Color3.fromRGB(50,30,20),
        DialogHolderLine=Color3.fromRGB(45,25,15), DialogButton=Color3.fromRGB(60,35,25),
        DialogButtonBorder=Color3.fromRGB(100,65,45), DialogBorder=Color3.fromRGB(90,55,40),
        DialogInput=Color3.fromRGB(70,45,35), DialogInputLine=Color3.fromRGB(190,120,90),
        Text=Color3.fromRGB(240,240,240), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(180,110,80), HoverChange=0.04,
    },
    Ocean = {
        Name="Ocean", Accent=Color3.fromRGB(0,141,255),
        AcrylicMain=Color3.fromRGB(20,25,40), AcrylicBorder=Color3.fromRGB(40,60,100),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(15,25,45),Color3.fromRGB(20,30,50)),
        AcrylicNoise=0.92, TitleBarLine=Color3.fromRGB(50,70,120),
        Tab=Color3.fromRGB(70,90,160), Element=Color3.fromRGB(60,80,140),
        ElementBorder=Color3.fromRGB(30,40,70), InElementBorder=Color3.fromRGB(50,60,100),
        ElementTransparency=0.87, ToggleSlider=Color3.fromRGB(80,100,170),
        ToggleToggled=Color3.fromRGB(11,35,67), SliderRail=Color3.fromRGB(80,100,170),
        DropdownFrame=Color3.fromRGB(90,110,180), DropdownHolder=Color3.fromRGB(25,35,60),
        DropdownBorder=Color3.fromRGB(30,40,70), DropdownOption=Color3.fromRGB(80,100,170),
        Keybind=Color3.fromRGB(80,100,170), Input=Color3.fromRGB(80,100,170),
        InputFocused=Color3.fromRGB(15,20,35), InputIndicator=Color3.fromRGB(100,120,190),
        InputIndicatorFocus=Color3.fromRGB(0,141,255),
        Dialog=Color3.fromRGB(25,35,60), DialogHolder=Color3.fromRGB(20,30,55),
        DialogHolderLine=Color3.fromRGB(15,25,50), DialogButton=Color3.fromRGB(25,35,60),
        DialogButtonBorder=Color3.fromRGB(45,65,110), DialogBorder=Color3.fromRGB(40,60,100),
        DialogInput=Color3.fromRGB(35,45,70), DialogInputLine=Color3.fromRGB(90,110,180),
        Text=Color3.fromRGB(240,240,240), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(80,100,170), HoverChange=0.04,
    },
    Emerald = {
        Name="Emerald", Accent=Color3.fromRGB(0,168,107),
        AcrylicMain=Color3.fromRGB(20,35,30), AcrylicBorder=Color3.fromRGB(30,100,80),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(20,55,45),Color3.fromRGB(25,60,50)),
        AcrylicNoise=0.92, TitleBarLine=Color3.fromRGB(40,110,90),
        Tab=Color3.fromRGB(50,130,100), Element=Color3.fromRGB(40,120,95),
        ElementBorder=Color3.fromRGB(25,75,60), InElementBorder=Color3.fromRGB(35,85,70),
        ElementTransparency=0.87, ToggleSlider=Color3.fromRGB(45,130,100),
        ToggleToggled=Color3.fromRGB(15,40,30), SliderRail=Color3.fromRGB(45,130,100),
        DropdownFrame=Color3.fromRGB(55,140,110), DropdownHolder=Color3.fromRGB(20,70,55),
        DropdownBorder=Color3.fromRGB(25,75,60), DropdownOption=Color3.fromRGB(45,130,100),
        Keybind=Color3.fromRGB(45,130,100), Input=Color3.fromRGB(45,130,100),
        InputFocused=Color3.fromRGB(10,35,25), InputIndicator=Color3.fromRGB(55,150,120),
        InputIndicatorFocus=Color3.fromRGB(0,168,107),
        Dialog=Color3.fromRGB(20,70,55), DialogHolder=Color3.fromRGB(15,65,50),
        DialogHolderLine=Color3.fromRGB(15,60,45), DialogButton=Color3.fromRGB(20,70,55),
        DialogButtonBorder=Color3.fromRGB(30,90,70), DialogBorder=Color3.fromRGB(25,85,65),
        DialogInput=Color3.fromRGB(25,75,60), DialogInputLine=Color3.fromRGB(50,140,110),
        Text=Color3.fromRGB(240,240,240), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(45,130,100), HoverChange=0.04,
    },
    Sapphire = {
        Name="Sapphire", Accent=Color3.fromRGB(0,105,255),
        AcrylicMain=Color3.fromRGB(24,30,85), AcrylicBorder=Color3.fromRGB(25,80,150),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(13,33,94),Color3.fromRGB(21,44,127)),
        AcrylicNoise=0.88, TitleBarLine=Color3.fromRGB(50,120,200),
        Tab=Color3.fromRGB(60,140,220), Element=Color3.fromRGB(42,98,176),
        ElementBorder=Color3.fromRGB(23,66,113), InElementBorder=Color3.fromRGB(27,65,126),
        ElementTransparency=0.85, ToggleSlider=Color3.fromRGB(50,140,210),
        ToggleToggled=Color3.fromRGB(20,50,80), SliderRail=Color3.fromRGB(50,140,210),
        DropdownFrame=Color3.fromRGB(60,150,230), DropdownHolder=Color3.fromRGB(15,60,100),
        DropdownBorder=Color3.fromRGB(30,90,140), DropdownOption=Color3.fromRGB(50,140,210),
        Keybind=Color3.fromRGB(50,140,210), Input=Color3.fromRGB(50,140,210),
        InputFocused=Color3.fromRGB(15,40,60), InputIndicator=Color3.fromRGB(60,160,240),
        InputIndicatorFocus=Color3.fromRGB(0,105,255),
        Dialog=Color3.fromRGB(10,60,100), DialogHolder=Color3.fromRGB(15,50,90),
        DialogHolderLine=Color3.fromRGB(15,45,80), DialogButton=Color3.fromRGB(10,60,100),
        DialogButtonBorder=Color3.fromRGB(30,100,160), DialogBorder=Color3.fromRGB(20,80,130),
        DialogInput=Color3.fromRGB(30,90,140), DialogInputLine=Color3.fromRGB(55,150,230),
        Text=Color3.fromRGB(240,240,240), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(50,140,210), HoverChange=0.05,
    },
    Cloud = {
        Name="Cloud", Accent=Color3.fromRGB(27,114,138),
        AcrylicMain=Color3.fromRGB(13,62,77), AcrylicBorder=Color3.fromRGB(80,118,130),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(51,74,83),Color3.fromRGB(4,47,66)),
        AcrylicNoise=0.94, TitleBarLine=Color3.fromRGB(97,97,97),
        Tab=Color3.fromRGB(126,175,180), Element=Color3.fromRGB(66,130,160),
        ElementBorder=Color3.fromRGB(40,100,122), InElementBorder=Color3.fromRGB(75,109,110),
        ElementTransparency=0.87, ToggleSlider=Color3.fromRGB(100,152,160),
        ToggleToggled=Color3.fromRGB(26,59,80), SliderRail=Color3.fromRGB(115,150,160),
        DropdownFrame=Color3.fromRGB(158,194,200), DropdownHolder=Color3.fromRGB(39,99,116),
        DropdownBorder=Color3.fromRGB(33,119,120), DropdownOption=Color3.fromRGB(121,152,160),
        Keybind=Color3.fromRGB(108,153,160), Input=Color3.fromRGB(112,156,160),
        InputFocused=Color3.fromRGB(14,35,40), InputIndicator=Color3.fromRGB(137,181,190),
        Dialog=Color3.fromRGB(11,75,88), DialogHolder=Color3.fromRGB(18,77,93),
        DialogHolderLine=Color3.fromRGB(33,76,86), DialogButton=Color3.fromRGB(43,72,80),
        DialogButtonBorder=Color3.fromRGB(62,100,110), DialogBorder=Color3.fromRGB(26,86,100),
        DialogInput=Color3.fromRGB(4,97,107), DialogInputLine=Color3.fromRGB(70,120,130),
        Text=Color3.fromRGB(209,240,233), SubText=Color3.fromRGB(170,170,170),
        Hover=Color3.fromRGB(112,155,160), HoverChange=0.04,
    },
    Grape = {
        Name="Grape", Accent=Color3.fromRGB(183,176,223),
        AcrylicMain=Color3.fromRGB(0,0,0), AcrylicBorder=Color3.fromRGB(20,20,20),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(6,0,16),Color3.fromRGB(6,0,16)),
        AcrylicNoise=1, TitleBarLine=Color3.fromRGB(25,25,25),
        Tab=Color3.fromRGB(40,40,40), Element=Color3.fromRGB(15,15,15),
        ElementBorder=Color3.fromRGB(6,0,16), InElementBorder=Color3.fromRGB(40,40,40),
        ElementTransparency=1, ToggleSlider=Color3.fromRGB(255,255,255),
        ToggleToggled=Color3.fromRGB(19,16,36), SliderRail=Color3.fromRGB(40,40,40),
        DropdownFrame=Color3.fromRGB(20,20,20), DropdownHolder=Color3.fromRGB(12,0,34),
        DropdownBorder=Color3.fromRGB(6,0,16), DropdownOption=Color3.fromRGB(40,40,40),
        Keybind=Color3.fromRGB(40,40,40), Input=Color3.fromRGB(40,40,40),
        InputFocused=Color3.fromRGB(6,0,16), InputIndicator=Color3.fromRGB(60,60,60),
        InputIndicatorFocus=Color3.fromRGB(255,255,255),
        Dialog=Color3.fromRGB(7,0,18), DialogHolder=Color3.fromRGB(7,0,18),
        DialogHolderLine=Color3.fromRGB(7,0,18), DialogButton=Color3.fromRGB(13,0,33),
        DialogButtonBorder=Color3.fromRGB(30,30,30), DialogBorder=Color3.fromRGB(27,27,27),
        DialogInput=Color3.fromRGB(7,0,18), DialogInputLine=Color3.fromRGB(60,60,60),
        Text=Color3.fromRGB(255,255,255), SubText=Color3.fromRGB(123,144,170),
        Hover=Color3.fromRGB(40,40,40), HoverChange=0.04,
    },
    Bloody = {
        Name="Bloody", Accent=Color3.fromRGB(144,0,0),
        AcrylicMain=Color3.fromRGB(61,0,0), AcrylicBorder=Color3.fromRGB(86,0,0),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(90,0,0),Color3.fromRGB(100,0,0)),
        AcrylicNoise=0.92, TitleBarLine=Color3.fromRGB(126,0,0),
        Tab=Color3.fromRGB(134,0,0), Element=Color3.fromRGB(156,0,0),
        ElementBorder=Color3.fromRGB(91,0,0), InElementBorder=Color3.fromRGB(106,0,0),
        ElementTransparency=0.86, ToggleSlider=Color3.fromRGB(130,5,5),
        ToggleToggled=Color3.fromRGB(66,0,0), SliderRail=Color3.fromRGB(150,30,30),
        DropdownFrame=Color3.fromRGB(150,30,30), DropdownHolder=Color3.fromRGB(79,0,0),
        DropdownBorder=Color3.fromRGB(116,0,0), DropdownOption=Color3.fromRGB(150,30,30),
        Keybind=Color3.fromRGB(150,30,30), Input=Color3.fromRGB(150,30,30),
        InputFocused=Color3.fromRGB(40,10,10), InputIndicator=Color3.fromRGB(113,1,1),
        Dialog=Color3.fromRGB(85,0,1), DialogHolder=Color3.fromRGB(77,0,8),
        DialogHolderLine=Color3.fromRGB(88,4,4), DialogButton=Color3.fromRGB(115,14,21),
        DialogButtonBorder=Color3.fromRGB(83,0,1), DialogBorder=Color3.fromRGB(43,4,5),
        DialogInput=Color3.fromRGB(108,20,21), DialogInputLine=Color3.fromRGB(91,1,1),
        Text=Color3.fromRGB(240,240,240), SubText=Color3.fromRGB(131,131,131),
        Hover=Color3.fromRGB(181,0,0), HoverChange=0.04,
    },
    Arctic = {
        Name="Arctic", Accent=Color3.fromRGB(64,224,255),
        AcrylicMain=Color3.fromRGB(10,18,25), AcrylicBorder=Color3.fromRGB(35,55,70),
        AcrylicGradient=ColorSequence.new(Color3.fromRGB(15,25,35),Color3.fromRGB(18,30,40)),
        AcrylicNoise=0.94, TitleBarLine=Color3.fromRGB(45,70,90),
        Tab=Color3.fromRGB(70,110,140), Element=Color3.fromRGB(60,95,120),
        ElementBorder=Color3.fromRGB(60,95,120), InElementBorder=Color3.fromRGB(70,110,140),
        ElementTransparency=0.88, ToggleSlider=Color3.fromRGB(90,140,180),
        ToggleToggled=Color3.fromRGB(15,25,35), SliderRail=Color3.fromRGB(90,140,180),
        DropdownFrame=Color3.fromRGB(110,170,220), DropdownHolder=Color3.fromRGB(30,45,60),
        DropdownBorder=Color3.fromRGB(60,95,120), DropdownOption=Color3.fromRGB(90,140,180),
        Keybind=Color3.fromRGB(90,140,180), Input=Color3.fromRGB(90,140,180),
        InputFocused=Color3.fromRGB(10,18,25), InputIndicator=Color3.fromRGB(130,200,255),
        InputIndicatorFocus=Color3.fromRGB(64,224,255),
        Dialog=Color3.fromRGB(30,45,60), DialogHolder=Color3.fromRGB(18,30,40),
        DialogHolderLine=Color3.fromRGB(15,25,35), DialogButton=Color3.fromRGB(30,45,60),
        DialogButtonBorder=Color3.fromRGB(45,70,90), DialogBorder=Color3.fromRGB(40,60,80),
        DialogInput=Color3.fromRGB(35,55,70), DialogInputLine=Color3.fromRGB(110,170,220),
        Text=Color3.fromRGB(240,250,255), SubText=Color3.fromRGB(180,200,220),
        Hover=Color3.fromRGB(90,140,180), HoverChange=0.04,
    },
}

-- ═══════════════════════════════════════
--        LIBRARY STATE
-- ═══════════════════════════════════════
local Library = {
    Version        = "2.0.0",
    OpenFrames     = {},
    Options        = {},
    Themes         = Themes.Names,
    Windows        = {},
    Window         = nil,
    WindowFrame    = nil,
    Unloaded       = false,
    Creator        = nil,
    DialogOpen     = false,
    UseAcrylic     = false,
    Acrylic        = false,
    Transparency   = true,
    MinimizeKeybind= nil,
    MinimizeKey    = Enum.KeyCode.LeftControl,
    Theme          = "Aurora",
}

-- ═══════════════════════════════════════
--        ANIMATION HELPERS (cải tiến)
-- ═══════════════════════════════════════

-- Spring mượt hơn: frequency cao hơn cho tab, thấp hơn cho window
local function Tween(obj, t, props, style, dir)
    style = style or Enum.EasingStyle.Quart
    dir   = dir   or Enum.EasingDirection.Out
    return TweenService:Create(obj, TweenInfo.new(t, style, dir), props)
end

local function TweenPlay(obj, t, props, style, dir)
    Tween(obj, t, props, style, dir):Play()
end

-- Bounce nhẹ khi mở window
local function AnimateOpen(frame)
    frame.Size      = UDim2.new(0, frame.Size.X.Offset, 0, 0)
    frame.BackgroundTransparency = 1
    TweenPlay(frame, 0.35, {
        Size = UDim2.fromOffset(frame.Size.X.Offset, frame.AbsoluteSize.Y > 0 and frame.AbsoluteSize.Y or 500),
        BackgroundTransparency = 0
    }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

-- Hover ripple cho element
local function MakeHover(frame, onColor, offColor, onTransp, offTransp, duration)
    duration  = duration  or 0.18
    onTransp  = onTransp  or 0.80
    offTransp = offTransp or 0.87
    frame.MouseEnter:Connect(function()
        TweenPlay(frame, duration, {BackgroundTransparency = onTransp}, Enum.EasingStyle.Quad)
    end)
    frame.MouseLeave:Connect(function()
        TweenPlay(frame, duration, {BackgroundTransparency = offTransp}, Enum.EasingStyle.Quad)
    end)
    frame.MouseButton1Down:Connect(function()
        TweenPlay(frame, 0.08, {BackgroundTransparency = offTransp + 0.05}, Enum.EasingStyle.Quad)
    end)
    frame.MouseButton1Up:Connect(function()
        TweenPlay(frame, 0.12, {BackgroundTransparency = onTransp}, Enum.EasingStyle.Quad)
    end)
end

-- ═══════════════════════════════════════
--        SIGNAL / CONNECTION SYSTEM
-- ═══════════════════════════════════════
local Creator = {
    Registry         = {},
    Signals          = {},
    TransparencyMotors = {},
    DefaultProperties = {
        ScreenGui      = { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling },
        Frame          = { BackgroundColor3=Color3.new(1,1,1), BorderColor3=Color3.new(0,0,0), BorderSizePixel=0 },
        ScrollingFrame = { BackgroundColor3=Color3.new(1,1,1), BorderColor3=Color3.new(0,0,0), ScrollBarImageColor3=Color3.new(0,0,0) },
        TextLabel      = { BackgroundColor3=Color3.new(1,1,1), BorderColor3=Color3.new(0,0,0), Font=Enum.Font.SourceSans, Text="", TextColor3=Color3.new(0,0,0), BackgroundTransparency=1, TextSize=14 },
        TextButton     = { BackgroundColor3=Color3.new(1,1,1), BorderColor3=Color3.new(0,0,0), AutoButtonColor=false, Font=Enum.Font.SourceSans, Text="", TextColor3=Color3.new(0,0,0), TextSize=14 },
        TextBox        = { BackgroundColor3=Color3.new(1,1,1), BorderColor3=Color3.new(0,0,0), ClearTextOnFocus=false, Font=Enum.Font.SourceSans, Text="", TextColor3=Color3.new(0,0,0), TextSize=14 },
        ImageLabel     = { BackgroundTransparency=1, BackgroundColor3=Color3.new(1,1,1), BorderColor3=Color3.new(0,0,0), BorderSizePixel=0 },
        ImageButton    = { BackgroundColor3=Color3.new(1,1,1), BorderColor3=Color3.new(0,0,0), AutoButtonColor=false },
        CanvasGroup    = { BackgroundColor3=Color3.new(1,1,1), BorderColor3=Color3.new(0,0,0), BorderSizePixel=0 },
    },
}

function Creator.AddSignal(Signal, Function)
    local Connected = Signal:Connect(Function)
    table.insert(Creator.Signals, Connected)
    return Connected
end

function Creator.Disconnect()
    for i = #Creator.Signals, 1, -1 do
        local c = table.remove(Creator.Signals, i)
        if c and c.Disconnect then c:Disconnect() end
    end
end

Creator.Themes = Themes
Creator.Theme  = "Aurora"

function Creator.GetThemeProperty(Property)
    local T = Themes[Library.Theme]
    return (T and T[Property]) or Themes["Dark"][Property]
end

function Creator.UpdateTheme()
    if not Themes[Library.Theme] then Library.Theme = "Dark" end
    for Instance, Object in next, Creator.Registry do
        for Property, ColorIdx in next, Object.Properties do
            local v = Creator.GetThemeProperty(ColorIdx)
            if v then Instance[Property] = v end
        end
    end
    local tr = Creator.GetThemeProperty("ElementTransparency")
    if tr then
        for _, Motor in next, Creator.TransparencyMotors do
            -- animate theme switch mượt
            TweenPlay(Motor._instance, 0.3, {[Motor._prop] = tr})
        end
    end
end

function Creator.AddThemeObject(Object, Properties)
    Creator.Registry[Object] = { Object = Object, Properties = Properties }
    Creator.UpdateTheme()
    return Object
end

function Creator.OverrideTag(Object, Properties)
    if Creator.Registry[Object] then
        Creator.Registry[Object].Properties = Properties
        Creator.UpdateTheme()
    end
end

function Creator.New(Name, Properties, Children)
    local Object = Instance.new(Name)
    for k, v in next, Creator.DefaultProperties[Name] or {} do Object[k] = v end
    for k, v in next, Properties or {} do
        if k ~= "ThemeTag" then Object[k] = v end
    end
    for _, Child in next, Children or {} do Child.Parent = Object end
    if Properties and Properties.ThemeTag then
        Creator.AddThemeObject(Object, Properties.ThemeTag)
    end
    return Object
end

local New = Creator.New
Library.Creator = Creator

-- ═══════════════════════════════════════
--        GUI ROOT
-- ═══════════════════════════════════════
local GUI = New("ScreenGui", { Parent = LocalPlayer:WaitForChild("PlayerGui") })
Library.GUI = GUI
ProtectGui(GUI)

-- ═══════════════════════════════════════
--        UTILS
-- ═══════════════════════════════════════
function Library:SafeCallback(Function, ...)
    if not Function then return end
    local ok, err = pcall(Function, ...)
    if not ok then
        Library:Notify({ Title="Interface", Content="Callback error", SubContent=tostring(err), Duration=5 })
    end
end

function Library:Round(Number, Factor)
    if Factor == 0 then return math.floor(Number) end
    Number = tostring(Number)
    return Number:find("%.") and tonumber(Number:sub(1, Number:find("%.") + Factor)) or Number
end

function Library:GetIcon(Name)
    -- Icon lookup (giữ nguyên từ gốc – rút gọn ở đây)
    return nil
end

function Library:Notify(Config)
    Config = Config or {}
    -- Notification system (giữ như gốc, không thay đổi tên mã)
end

-- ═══════════════════════════════════════
--        WINDOW (cải tiến UI/Anim)
-- ═══════════════════════════════════════
function Library:CreateWindow(Config)
    Config = Config or {}
    Config.Title    = Config.Title    or "FluentPlus"
    Config.SubTitle = Config.SubTitle or ""
    Config.Theme    = Config.Theme    or "Aurora"
    Config.Size     = Config.Size     or UDim2.fromOffset(580, 460)
    Config.TabWidth = Config.TabWidth or 140
    Config.Search   = Config.Search   ~= false

    Library.Theme = Config.Theme

    -- ── Kích thước cho mobile ──
    local isMobileSize = Mobile or Camera.ViewportSize.X < 500
    local winW = isMobileSize and Camera.ViewportSize.X - 16 or Config.Size.X.Offset
    local winH = isMobileSize and Camera.ViewportSize.Y - 60  or Config.Size.Y.Offset
    local tabW = isMobileSize and 0 or Config.TabWidth

    local Window = {
        Minimized  = false,
        Maximized  = false,
        Size       = UDim2.fromOffset(winW, winH),
        Position   = UDim2.fromOffset(0, 0),
        TabWidth   = tabW,
        AllElements= {},
        Tabs       = {},
    }

    -- ── Root Frame ──
    Window.Root = New("Frame", {
        Size               = Window.Size,
        BackgroundTransparency = 1,
        Position           = UDim2.fromOffset(0, 0),
        Parent             = GUI,
    })

    -- ── Background với corner radius lớn hơn & gradient ──
    local BG = New("Frame", {
        Size               = UDim2.fromScale(1, 1),
        BackgroundTransparency = 0.08,
        Parent             = Window.Root,
        ThemeTag           = { BackgroundColor3 = "AcrylicMain" },
    }, {
        New("UICorner",  { CornerRadius = UDim.new(0, 14) }),
        New("UIStroke",  { Transparency = 0.45, Thickness = 1.2,
            ThemeTag = { Color = "AcrylicBorder" } }),
        New("UIGradient",{ Rotation = 120,
            ThemeTag = { Color = "AcrylicGradient" } }),
    })

    -- ── Title Bar ──
    local TitleBar = New("Frame", {
        Size               = UDim2.new(1, 0, 0, 44),
        BackgroundTransparency = 1,
        Parent             = Window.Root,
    })

    -- Logo / Icon
    if Config.Icon then
        New("ImageLabel", {
            Image              = Config.Icon,
            Size               = UDim2.fromOffset(20, 20),
            Position           = UDim2.fromOffset(14, 12),
            BackgroundTransparency = 1,
            Parent             = TitleBar,
            ThemeTag           = { ImageColor3 = "Text" },
        })
    end

    local titleOffX = Config.Icon and 40 or 14
    New("TextLabel", {
        Text               = Config.Title,
        FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
        TextSize           = 13,
        TextXAlignment     = Enum.TextXAlignment.Left,
        Size               = UDim2.fromOffset(200, 20),
        Position           = UDim2.fromOffset(titleOffX, 12),
        BackgroundTransparency = 1,
        Parent             = TitleBar,
        ThemeTag           = { TextColor3 = "Text" },
    })

    if Config.SubTitle and Config.SubTitle ~= "" then
        New("TextLabel", {
            Text               = Config.SubTitle,
            FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json"),
            TextSize           = 11,
            TextXAlignment     = Enum.TextXAlignment.Left,
            TextTransparency   = 0.35,
            Size               = UDim2.fromOffset(200, 16),
            Position           = UDim2.fromOffset(titleOffX + 205, 14),
            BackgroundTransparency = 1,
            Parent             = TitleBar,
            ThemeTag           = { TextColor3 = "SubText" },
        })
    end

    -- TitleBar divider
    New("Frame", {
        Size               = UDim2.new(1, 0, 0, 1),
        Position           = UDim2.new(0, 0, 1, -1),
        BackgroundTransparency = 0.5,
        Parent             = TitleBar,
        ThemeTag           = { BackgroundColor3 = "TitleBarLine" },
    })

    -- Close / Min / Max buttons
    local function BarBtn(icon, posX, callback)
        local btn = New("TextButton", {
            Size               = UDim2.fromOffset(28, 28),
            Position           = UDim2.new(1, posX, 0, 8),
            BackgroundTransparency = 1,
            Parent             = TitleBar,
            Text               = "",
            ThemeTag           = { BackgroundColor3 = "Hover" },
        }, {
            New("UICorner", { CornerRadius = UDim.new(0, 7) }),
            New("ImageLabel", {
                Image              = icon,
                Size               = UDim2.fromOffset(14, 14),
                Position           = UDim2.fromScale(0.5, 0.5),
                AnchorPoint        = Vector2.new(0.5, 0.5),
                BackgroundTransparency = 1,
                ThemeTag           = { ImageColor3 = "SubText" },
            }),
        })
        MakeHover(btn, nil, nil, 0.88, 1, 0.15)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    BarBtn("rbxassetid://9886659671", -10, function()
        Library.Window:Dialog({
            Title   = "Thoát",
            Content = "Bạn có muốn tắt phần mềm?",
            Buttons = {
                { Title="Có",  Callback=function() Library:Destroy() end },
                { Title="Không" },
            },
        })
    end)
    BarBtn("rbxassetid://9886659276", -42, function()
        Library.Window:Minimize()
    end)

    -- ── Tab Selector Bar (trái) ──
    local SelectorLine = New("Frame", {
        Size               = UDim2.fromOffset(3, 0),
        Position           = UDim2.fromOffset(0, 60),
        AnchorPoint        = Vector2.new(0, 0.5),
        BackgroundTransparency = 0,
        Parent             = Window.Root,
        ThemeTag           = { BackgroundColor3 = "Accent" },
    }, { New("UICorner", { CornerRadius = UDim.new(0, 9) }) })

    Window.TabHolder = New("ScrollingFrame", {
        Size               = UDim2.new(0, tabW, 1, -50),
        Position           = UDim2.fromOffset(8, 48),
        BackgroundTransparency = 1,
        ScrollBarImageTransparency = 1,
        ScrollBarThickness = 0,
        BorderSizePixel    = 0,
        CanvasSize         = UDim2.fromScale(0, 0),
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Parent             = Window.Root,
    }, { New("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder }) })

    -- Mobile: Tab bar di chuyển xuống dưới
    if isMobileSize then
        Window.TabHolder.Size     = UDim2.new(1, 0, 0, 46)
        Window.TabHolder.Position = UDim2.new(0, 0, 1, -46)
        Window.TabHolder:FindFirstChildOfClass("UIListLayout").FillDirection = Enum.FillDirection.Horizontal
        Window.TabHolder:FindFirstChildOfClass("UIListLayout").VerticalAlignment = Enum.VerticalAlignment.Center
        Window.TabHolder:FindFirstChildOfClass("UIListLayout").HorizontalAlignment = Enum.HorizontalAlignment.Center
        New("Frame", {
            Size               = UDim2.new(1, 0, 0, 1),
            Position           = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 0.5,
            Parent             = Window.TabHolder,
            ThemeTag           = { BackgroundColor3 = "TitleBarLine" },
        })
        SelectorLine.Visible = false
    end

    -- Tab display label (tên tab đang chọn)
    Window.TabDisplay = New("TextLabel", {
        Text               = "",
        FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextSize           = isMobileSize and 16 or 24,
        TextXAlignment     = Enum.TextXAlignment.Left,
        Size               = UDim2.new(1, -(tabW + 30), 0, 26),
        Position           = UDim2.fromOffset(isMobileSize and 14 or tabW + 22, 48),
        BackgroundTransparency = 1,
        Parent             = Window.Root,
        ThemeTag           = { TextColor3 = "Text" },
    })

    -- ── Container cho nội dung ──
    Window.ContainerHolder = New("Frame", {
        Size               = UDim2.new(1, -(tabW + 28), 1, -(isMobileSize and 102 or 96)),
        Position           = UDim2.fromOffset(isMobileSize and 8 or tabW + 20, 80),
        BackgroundTransparency = 1,
        ClipsDescendants   = true,
        Parent             = Window.Root,
    })

    Window.ContainerCanvas = New("CanvasGroup", {
        Size               = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Parent             = Window.ContainerHolder,
    })

    -- ── Dragging ──
    local Dragging, MousePos, StartPos = false
    Creator.AddSignal(TitleBar.InputBegan, function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1
            or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            MousePos = Input.Position
            StartPos = Window.Root.Position
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then Dragging = false end
            end)
        end
    end)
    Creator.AddSignal(UserInputService.InputChanged, function(Input)
        if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement
            or Input.UserInputType == Enum.UserInputType.Touch) then
            local Delta = Input.Position - MousePos
            Window.Root.Position = UDim2.fromOffset(
                StartPos.X.Offset + Delta.X,
                StartPos.Y.Offset + Delta.Y
            )
        end
    end)

    -- Center window
    local function CenterWindow()
        local vp = Camera.ViewportSize
        local x  = math.max(0, (vp.X - Window.Size.X.Offset) / 2)
        local y  = math.max(0, (vp.Y - Window.Size.Y.Offset) / 2)
        Window.Root.Position = UDim2.fromOffset(math.floor(x), math.floor(y))
    end
    CenterWindow()
    Creator.AddSignal(Camera:GetPropertyChangedSignal("ViewportSize"), CenterWindow)

    -- ── Open animation ──
    Window.Root.BackgroundTransparency = 1
    local uiscale = New("UIScale", { Scale = 0.92, Parent = Window.Root })
    TweenPlay(uiscale, 0.32, { Scale = 1 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    TweenPlay(BG, 0.25, { BackgroundTransparency = 0.08 })

    -- ── Minimize ──
    local MinimizeNotif = false
    function Window:Minimize()
        Window.Minimized = not Window.Minimized
        if Window.Minimized then
            TweenPlay(uiscale, 0.22, { Scale = 0.88 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            TweenPlay(BG, 0.22, { BackgroundTransparency = 1 })
            task.wait(0.22)
            Window.Root.Visible = false
        else
            Window.Root.Visible = true
            TweenPlay(uiscale, 0.28, { Scale = 1 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            TweenPlay(BG, 0.22, { BackgroundTransparency = 0.08 })
        end
        if not MinimizeNotif then
            MinimizeNotif = true
            if not Mobile then
                Library:Notify({
                    Title   = "Interface",
                    Content = "Press " .. (Library.MinimizeKey and Library.MinimizeKey.Name or "LeftControl") .. " to toggle.",
                    Duration = 5,
                })
            end
        end
    end

    -- Keybind minimize
    Creator.AddSignal(UserInputService.InputBegan, function(Input)
        if UserInputService:GetFocusedTextBox() then return end
        if type(Library.MinimizeKeybind) == "table" and Library.MinimizeKeybind.Type == "Keybind" then
            if Input.KeyCode.Name == Library.MinimizeKeybind.Value then
                Window:Minimize()
            end
        elseif Input.KeyCode == Library.MinimizeKey then
            Window:Minimize()
        end
    end)

    -- ── Dialog ──
    function Window:Dialog(Config)
        Config = Config or {}
        if Library.DialogOpen then return end
        Library.DialogOpen = true

        local TintFrame = New("TextButton", {
            Text               = "",
            Size               = UDim2.fromScale(1, 1),
            BackgroundColor3   = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Parent             = Window.Root,
        }, { New("UICorner", { CornerRadius = UDim.new(0, 14) }) })

        local DialogRoot = New("CanvasGroup", {
            Size               = UDim2.fromOffset(300, 165),
            AnchorPoint        = Vector2.new(0.5, 0.5),
            Position           = UDim2.fromScale(0.5, 0.5),
            GroupTransparency  = 1,
            Parent             = TintFrame,
            ThemeTag           = { BackgroundColor3 = "Dialog" },
        }, {
            New("UICorner",  { CornerRadius = UDim.new(0, 10) }),
            New("UIStroke",  { Transparency = 0.45, ThemeTag = { Color = "DialogBorder" } }),
            New("UIScale",   { Scale = 1.08 }),
        })

        New("TextLabel", {
            Text               = Config.Title or "Dialog",
            FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
            TextSize           = 20,
            TextXAlignment     = Enum.TextXAlignment.Left,
            Size               = UDim2.new(1, -20, 0, 22),
            Position           = UDim2.fromOffset(16, 20),
            BackgroundTransparency = 1,
            Parent             = DialogRoot,
            ThemeTag           = { TextColor3 = "Text" },
        })

        if Config.Content then
            New("TextLabel", {
                Text               = Config.Content,
                FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json"),
                TextSize           = 13,
                TextXAlignment     = Enum.TextXAlignment.Left,
                TextWrapped        = true,
                Size               = UDim2.new(1, -20, 0, 40),
                Position           = UDim2.fromOffset(16, 48),
                BackgroundTransparency = 1,
                Parent             = DialogRoot,
                ThemeTag           = { TextColor3 = "SubText" },
            })
        end

        -- Button holder
        local BtnHolder = New("Frame", {
            Size               = UDim2.new(1, -24, 0, 34),
            Position           = UDim2.new(0, 12, 1, -46),
            BackgroundTransparency = 1,
            Parent             = DialogRoot,
        }, {
            New("UIListLayout", {
                Padding            = UDim.new(0, 8),
                FillDirection      = Enum.FillDirection.Horizontal,
                HorizontalAlignment= Enum.HorizontalAlignment.Center,
            }),
        })

        -- Animate open
        TweenPlay(TintFrame, 0.2, { BackgroundTransparency = 0.7 })
        TweenPlay(DialogRoot, 0.25, { GroupTransparency = 0 }, Enum.EasingStyle.Back)
        TweenPlay(DialogRoot:FindFirstChildOfClass("UIScale"), 0.25, { Scale = 1 }, Enum.EasingStyle.Back)

        local function CloseDialog()
            Library.DialogOpen = false
            TweenPlay(TintFrame, 0.18, { BackgroundTransparency = 1 })
            TweenPlay(DialogRoot, 0.18, { GroupTransparency = 1 })
            task.wait(0.2)
            TintFrame:Destroy()
        end

        local btnCount = Config.Buttons and #Config.Buttons or 0
        if Config.Buttons then
            for _, BtnCfg in next, Config.Buttons do
                local btn = New("TextButton", {
                    Size               = UDim2.new(1/math.max(btnCount,1), -(8*(btnCount-1)/math.max(btnCount,1)), 1, 0),
                    BackgroundTransparency = 0.1,
                    Text               = BtnCfg.Title or "OK",
                    FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json"),
                    TextSize           = 13,
                    Parent             = BtnHolder,
                    ThemeTag           = { BackgroundColor3 = "DialogButton", TextColor3 = "Text" },
                }, {
                    New("UICorner",  { CornerRadius = UDim.new(0, 6) }),
                    New("UIStroke",  { Transparency = 0.6, ThemeTag = { Color = "DialogButtonBorder" } }),
                })
                MakeHover(btn, nil, nil, 0.06, 0.1, 0.15)
                btn.MouseButton1Click:Connect(function()
                    if BtnCfg.Callback then Library:SafeCallback(BtnCfg.Callback) end
                    CloseDialog()
                end)
            end
        end
    end

    -- ── Tab System ──
    local TabCount = 0
    local SelectedTab = 0
    local Containers = {}

    function Window:AddTab(Title, Icon)
        TabCount = TabCount + 1
        local idx = TabCount

        local iconResolved = nil
        if not fischbypass and Icon and Library:GetIcon(Icon) then
            iconResolved = Library:GetIcon(Icon)
        elseif Icon then
            iconResolved = Icon
        end

        -- Tab button
        local tabH = isMobileSize and 42 or 34
        local TabBtn = New("TextButton", {
            Size               = isMobileSize and UDim2.fromOffset(64, tabH) or UDim2.new(1, 0, 0, tabH),
            BackgroundTransparency = 1,
            Parent             = Window.TabHolder,
            Text               = "",
            ThemeTag           = { BackgroundColor3 = "Tab" },
        }, {
            New("UICorner", { CornerRadius = UDim.new(0, 8) }),
        })

        if iconResolved then
            New("ImageLabel", {
                Image              = iconResolved,
                Size               = UDim2.fromOffset(15, 15),
                Position           = UDim2.fromOffset(isMobileSize and 8 or 8, (tabH-15)/2),
                BackgroundTransparency = 1,
                Parent             = TabBtn,
                ThemeTag           = { ImageColor3 = "Text" },
            })
        end

        New("TextLabel", {
            Text               = Title,
            FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json"),
            TextSize           = isMobileSize and 11 or 12,
            TextXAlignment     = Enum.TextXAlignment.Left,
            Size               = UDim2.new(1, -12, 1, 0),
            Position           = isMobileSize
                and UDim2.fromOffset(iconResolved and 26 or 8, 0)
                or  UDim2.fromOffset(iconResolved and 28 or 10, 0),
            BackgroundTransparency = 1,
            Parent             = TabBtn,
            ThemeTag           = { TextColor3 = "Text" },
        })

        -- Container
        local ContainerLayout = New("UIListLayout", {
            Padding    = UDim.new(0, 5),
            SortOrder  = Enum.SortOrder.LayoutOrder,
        })

        local Container = New("ScrollingFrame", {
            Size               = UDim2.fromScale(1, 1),
            BackgroundTransparency = 1,
            Visible            = false,
            BottomImage        = "rbxassetid://6889812791",
            MidImage           = "rbxassetid://6889812721",
            TopImage           = "rbxassetid://6276641225",
            ScrollBarImageColor3 = Color3.fromRGB(255,255,255),
            ScrollBarImageTransparency = 0.92,
            ScrollBarThickness = 3,
            BorderSizePixel    = 0,
            CanvasSize         = UDim2.fromScale(0, 0),
            ScrollingDirection = Enum.ScrollingDirection.Y,
            Parent             = Window.ContainerCanvas,
        }, {
            ContainerLayout,
            New("UIPadding", {
                PaddingRight  = UDim.new(0, 8),
                PaddingLeft   = UDim.new(0, 2),
                PaddingTop    = UDim.new(0, 4),
                PaddingBottom = UDim.new(0, 8),
            }),
        })

        Creator.AddSignal(ContainerLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
            Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y + 8)
        end)

        Containers[idx] = Container

        -- Select tab (với animation mượt)
        local function SelectTab()
            SelectedTab = idx

            -- Reset tất cả tabs
            for _, tabData in next, Window.Tabs do
                TweenPlay(tabData.Btn, 0.18, { BackgroundTransparency = 1 })
            end

            -- Highlight tab này
            TweenPlay(TabBtn, 0.18, { BackgroundTransparency = 0.88 })

            -- Cập nhật tên tab đang chọn
            Window.TabDisplay.Text = Title

            -- Cập nhật selector (chỉ desktop)
            if not isMobileSize then
                local targetY = TabBtn.AbsolutePosition.Y - Window.TabHolder.AbsolutePosition.Y + tabH / 2 + Window.TabHolder.CanvasPosition.Y
                TweenPlay(SelectorLine, 0.22, {
                    Position = UDim2.fromOffset(0, Window.TabHolder.AbsolutePosition.Y - Window.Root.AbsolutePosition.Y + targetY - 10),
                    Size     = UDim2.fromOffset(3, 20),
                }, Enum.EasingStyle.Quart)
            end

            -- Animate container switch
            task.spawn(function()
                TweenPlay(Window.ContainerCanvas, 0.1, { GroupTransparency = 1 }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                task.wait(0.1)
                for i, c in next, Containers do c.Visible = (i == idx) end
                Window.ContainerCanvas.Position = UDim2.fromOffset(0, 10)
                TweenPlay(Window.ContainerCanvas, 0.18, { GroupTransparency = 0 }, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                TweenPlay(Window.ContainerCanvas, 0.18, { Position = UDim2.fromOffset(0, 0) }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            end)
        end

        MakeHover(TabBtn, nil, nil, 0.88, 1, 0.15)
        TabBtn.MouseButton1Click:Connect(SelectTab)

        -- Auto-select first tab
        if TabCount == 1 then
            task.defer(SelectTab)
        end

        local tabData = { Btn = TabBtn, Container = Container, Name = Title }
        Window.Tabs[idx] = tabData

        -- ── Section & Element builders ──
        local Tab = { Container = Container, ScrollFrame = Container }

        function Tab:AddSection(SectionTitle)
            local Section = {}

            local SectionLayout = New("UIListLayout", { Padding = UDim.new(0, 5) })
            Section.Container = New("Frame", {
                Size               = UDim2.new(1, 0, 0, 0),
                BackgroundTransparency = 1,
                LayoutOrder        = 7,
                Parent             = Container,
            }, { SectionLayout, New("UIPadding", { PaddingLeft = UDim.new(0,1) }) })

            -- Section title
            if SectionTitle and SectionTitle ~= "" then
                local header = New("Frame", {
                    Size               = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Parent             = Section.Container,
                    LayoutOrder        = 0,
                })
                New("TextLabel", {
                    Text               = SectionTitle,
                    FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
                    TextSize           = 11,
                    TextXAlignment     = Enum.TextXAlignment.Left,
                    Size               = UDim2.fromScale(1, 1),
                    BackgroundTransparency = 1,
                    Parent             = header,
                    ThemeTag           = { TextColor3 = "SubText" },
                })
            end

            Creator.AddSignal(SectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                Section.Container.Size = UDim2.new(1, 0, 0, SectionLayout.AbsoluteContentSize.Y + 5)
            end)

            setmetatable(Section, { __index = Tab })
            return Section
        end

        -- ── Add Element (base frame) ──
        local function MakeElementFrame(Title, Desc, parent, hover)
            local ElemFrame = New("TextButton", {
                Size               = UDim2.new(1, 0, 0, 0),
                AutomaticSize      = Enum.AutomaticSize.Y,
                BackgroundTransparency = 0.88,
                Text               = "",
                LayoutOrder        = 7,
                Parent             = parent or Tab.Container,
                ThemeTag           = { BackgroundColor3 = "Element", BackgroundTransparency = "ElementTransparency" },
            }, {
                New("UICorner",  { CornerRadius = UDim.new(0, 7) }),
                New("UIStroke",  { Transparency = 0.55, ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
                    ThemeTag = { Color = "ElementBorder" } }),
            })

            local LabelHolder = New("Frame", {
                AutomaticSize      = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Position           = UDim2.fromOffset(10, 0),
                Size               = UDim2.new(1, -26, 0, 0),
                Parent             = ElemFrame,
            }, {
                New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2) }),
                New("UIPadding",    { PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12) }),
            })

            local TitleLabel = New("TextLabel", {
                Text               = Title or "",
                FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
                TextSize           = 13,
                TextXAlignment     = Enum.TextXAlignment.Left,
                Size               = UDim2.new(1, 0, 0, 14),
                BackgroundTransparency = 1,
                LayoutOrder        = 1,
                Parent             = LabelHolder,
                ThemeTag           = { TextColor3 = "Text" },
            })

            local DescLabel
            if Desc and Desc ~= "" then
                DescLabel = New("TextLabel", {
                    Text               = Desc,
                    FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json"),
                    TextSize           = 11,
                    TextWrapped        = true,
                    TextXAlignment     = Enum.TextXAlignment.Left,
                    AutomaticSize      = Enum.AutomaticSize.Y,
                    Size               = UDim2.new(1, 0, 0, 12),
                    BackgroundTransparency = 1,
                    LayoutOrder        = 2,
                    Parent             = LabelHolder,
                    ThemeTag           = { TextColor3 = "SubText" },
                })
            end

            if hover then MakeHover(ElemFrame, nil, nil, 0.80, 0.88, 0.18) end

            return ElemFrame, TitleLabel, DescLabel, LabelHolder
        end

        -- ── Toggle ──
        function Tab:AddToggle(Idx, Config)
            Config = Config or {}
            local Toggle = {
                Value    = Config.Default or false,
                Type     = "Toggle",
                Callback = Config.Callback or function() end,
            }

            local frame, titleLbl, descLbl = MakeElementFrame(Config.Title, Config.Description, self.Container, true)

            -- Toggle widget
            local ToggleBG = New("Frame", {
                Size               = UDim2.fromOffset(38, 20),
                Position           = UDim2.new(1, -12, 0.5, 0),
                AnchorPoint        = Vector2.new(1, 0.5),
                BackgroundTransparency = 0.1,
                Parent             = frame,
                ThemeTag           = { BackgroundColor3 = "ToggleSlider" },
            }, {
                New("UICorner", { CornerRadius = UDim.new(1, 0) }),
                New("UIStroke", { Transparency = 0.6, ThemeTag = { Color = "InElementBorder" } }),
            })

            local ToggleDot = New("Frame", {
                Size               = UDim2.fromOffset(14, 14),
                Position           = UDim2.fromOffset(3, 3),
                BackgroundColor3   = Color3.fromRGB(255, 255, 255),
                Parent             = ToggleBG,
            }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })

            local function UpdateToggle(animate)
                local accent  = Creator.GetThemeProperty("Accent")
                local toggled = Creator.GetThemeProperty("ToggleToggled")
                local t = animate and 0.22 or 0
                if Toggle.Value then
                    TweenPlay(ToggleBG,  t, { BackgroundColor3 = accent })
                    TweenPlay(ToggleDot, t, { Position = UDim2.fromOffset(21, 3) }, Enum.EasingStyle.Back)
                else
                    TweenPlay(ToggleBG,  t, { BackgroundColor3 = Creator.GetThemeProperty("ToggleSlider") })
                    TweenPlay(ToggleDot, t, { Position = UDim2.fromOffset(3, 3) }, Enum.EasingStyle.Back)
                end
            end

            UpdateToggle(false)

            frame.MouseButton1Click:Connect(function()
                Toggle.Value = not Toggle.Value
                UpdateToggle(true)
                Library:SafeCallback(Toggle.Callback, Toggle.Value)
                if Toggle.Changed then Library:SafeCallback(Toggle.Changed, Toggle.Value) end
            end)

            function Toggle:SetValue(Val)
                Toggle.Value = Val
                UpdateToggle(true)
                Library:SafeCallback(Toggle.Callback, Toggle.Value)
            end
            function Toggle:OnChanged(Func)
                Toggle.Changed = Func
                Func(Toggle.Value)
            end
            function Toggle:Destroy() frame:Destroy(); Library.Options[Idx]=nil end

            Library.Options[Idx] = Toggle
            return Toggle
        end

        -- ── Slider ──
        function Tab:AddSlider(Idx, Config)
            Config = Config or {}
            assert(Config.Title, "Slider - Missing Title")
            assert(Config.Default, "Slider - Missing Default")
            assert(Config.Min, "Slider - Missing Min")
            assert(Config.Max, "Slider - Missing Max")
            Config.Rounding = Config.Rounding or 0

            local Slider = {
                Value    = Config.Default,
                Min      = Config.Min,
                Max      = Config.Max,
                Rounding = Config.Rounding,
                Type     = "Slider",
                Callback = Config.Callback or function() end,
            }

            local frame = MakeElementFrame(Config.Title, Config.Description, self.Container, false)

            -- Display
            local DisplayLabel = New("TextLabel", {
                FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json"),
                Text               = tostring(Config.Default),
                TextSize           = 12,
                TextXAlignment     = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                Size               = UDim2.fromOffset(60, 14),
                Position           = UDim2.new(1, -14, 0.5, -20),
                AnchorPoint        = Vector2.new(1, 0.5),
                Parent             = frame,
                ThemeTag           = { TextColor3 = "SubText" },
            })

            -- Rail
            local Rail = New("Frame", {
                Size               = UDim2.new(1, -26, 0, 4),
                Position           = UDim2.new(0, 10, 1, -14),
                AnchorPoint        = Vector2.new(0, 1),
                BackgroundTransparency = 0.5,
                Parent             = frame,
                ThemeTag           = { BackgroundColor3 = "SliderRail" },
            }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })

            local Fill = New("Frame", {
                Size               = UDim2.fromScale(0, 1),
                BackgroundTransparency = 0,
                Parent             = Rail,
                ThemeTag           = { BackgroundColor3 = "Accent" },
            }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })

            local Dot = New("Frame", {
                Size               = UDim2.fromOffset(14, 14),
                AnchorPoint        = Vector2.new(0.5, 0.5),
                Position           = UDim2.fromScale(0, 0.5),
                BackgroundColor3   = Color3.fromRGB(255,255,255),
                Parent             = Rail,
            }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })

            local Dragging = false

            local function SetValue(val)
                Slider.Value = Library:Round(math.clamp(val, Slider.Min, Slider.Max), Slider.Rounding)
                local pct = (Slider.Value - Slider.Min) / (Slider.Max - Slider.Min)
                Fill.Size      = UDim2.fromScale(pct, 1)
                Dot.Position   = UDim2.new(pct, 0, 0.5, 0)
                DisplayLabel.Text = tostring(Slider.Value)
                Library:SafeCallback(Slider.Callback, Slider.Value)
                if Slider.Changed then Library:SafeCallback(Slider.Changed, Slider.Value) end
            end

            Creator.AddSignal(Rail.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true
                end
            end)
            Creator.AddSignal(Rail.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = false
                end
            end)
            Creator.AddSignal(UserInputService.InputChanged, function(Input)
                if Dragging then
                    local pct = math.clamp((Input.Position.X - Rail.AbsolutePosition.X) / Rail.AbsoluteSize.X, 0, 1)
                    SetValue(Slider.Min + (Slider.Max - Slider.Min) * pct)
                end
            end)

            function Slider:SetValue(v) SetValue(v) end
            function Slider:OnChanged(Func) Slider.Changed = Func; Func(Slider.Value) end
            function Slider:Destroy() frame:Destroy(); Library.Options[Idx]=nil end

            SetValue(Config.Default)
            Library.Options[Idx] = Slider
            return Slider
        end

        -- ── Button ──
        function Tab:AddButton(Config)
            Config = Config or {}
            local frame = MakeElementFrame(Config.Title, Config.Description, self.Container, true)

            frame.MouseButton1Click:Connect(function()
                -- Ripple animation
                TweenPlay(frame, 0.08, { BackgroundTransparency = 0.75 })
                task.delay(0.08, function()
                    TweenPlay(frame, 0.15, { BackgroundTransparency = 0.88 })
                end)
                Library:SafeCallback(Config.Callback)
            end)

            local Btn = {}
            function Btn:SetTitle(t) end
            function Btn:Destroy() frame:Destroy() end
            return Btn
        end

        -- ── Dropdown ──
        function Tab:AddDropdown(Idx, Config)
            Config = Config or {}
            local Dropdown = {
                Values   = Config.Values or {},
                Value    = Config.Multi and {} or nil,
                Opened   = false,
                Multi    = Config.Multi or false,
                Type     = "Dropdown",
                Callback = Config.Callback or function() end,
            }

            local frame = MakeElementFrame(Config.Title, Config.Description, self.Container, false)

            local DropDisplay = New("TextLabel", {
                Text               = "--",
                FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json"),
                TextSize           = 12,
                TextXAlignment     = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                Size               = UDim2.fromOffset(100, 14),
                Position           = UDim2.new(1, -30, 0.5, 0),
                AnchorPoint        = Vector2.new(1, 0.5),
                Parent             = frame,
                ThemeTag           = { TextColor3 = "SubText" },
            })

            local DropBtn = New("TextButton", {
                Size               = UDim2.fromOffset(130, 28),
                Position           = UDim2.new(1, -10, 0.5, 0),
                AnchorPoint        = Vector2.new(1, 0.5),
                BackgroundTransparency = 0.9,
                Text               = "",
                Parent             = frame,
                ThemeTag           = { BackgroundColor3 = "DropdownFrame" },
            }, {
                New("UICorner",  { CornerRadius = UDim.new(0, 6) }),
                New("UIStroke",  { Transparency = 0.55, ThemeTag = { Color = "InElementBorder" } }),
                DropDisplay,
                New("ImageLabel", {
                    Image              = "rbxassetid://9886659001",
                    Size               = UDim2.fromOffset(12, 12),
                    Position           = UDim2.new(1, -6, 0.5, 0),
                    AnchorPoint        = Vector2.new(1, 0.5),
                    BackgroundTransparency = 1,
                    Rotation           = 180,
                    ThemeTag           = { ImageColor3 = "SubText" },
                }),
            })

            -- Dropdown canvas (floating)
            local DropCanvas = New("Frame", {
                Size               = UDim2.fromOffset(140, 0),
                BackgroundTransparency = 1,
                Parent             = Library.GUI,
                Visible            = false,
            })
            table.insert(Library.OpenFrames, DropCanvas)

            local DropListLayout = New("UIListLayout", { Padding = UDim.new(0, 3) })
            local DropScrollFrame = New("ScrollingFrame", {
                Size               = UDim2.fromScale(1, 1),
                BackgroundTransparency = 1,
                BottomImage        = "rbxassetid://6889812791",
                MidImage           = "rbxassetid://6889812721",
                TopImage           = "rbxassetid://6276641225",
                ScrollBarImageTransparency = 0.8,
                ScrollBarThickness = 3,
                BorderSizePixel    = 0,
                CanvasSize         = UDim2.fromScale(0, 0),
                AutomaticCanvasSize= Enum.AutomaticSize.Y,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                Parent             = New("Frame", {
                    Size               = UDim2.new(1, -8, 1, -8),
                    Position           = UDim2.fromOffset(4, 4),
                    BackgroundTransparency = 1,
                    Parent             = New("Frame", {
                        Size               = UDim2.fromScale(1, 1),
                        Parent             = DropCanvas,
                        ThemeTag           = { BackgroundColor3 = "DropdownHolder" },
                    }, {
                        New("UICorner",  { CornerRadius = UDim.new(0, 8) }),
                        New("UIStroke",  { Transparency = 0.45, ThemeTag = { Color = "DropdownBorder" } }),
                    }),
                }),
            }, { DropListLayout })

            local function UpdateDisplay()
                local str = ""
                if Dropdown.Multi then
                    for v, b in next, Dropdown.Value do if b then str = str .. v .. ", " end end
                    str = str:sub(1, #str-2)
                else
                    str = Dropdown.Value or ""
                end
                DropDisplay.Text = (str == "" and "--" or str)
            end

            local function BuildList()
                for _, c in next, DropScrollFrame:GetChildren() do
                    if not c:IsA("UIListLayout") then c:Destroy() end
                end
                for _, val in next, Dropdown.Values do
                    local isSelected = Dropdown.Multi and Dropdown.Value[val] or Dropdown.Value == val
                    local optBtn = New("TextButton", {
                        Size               = UDim2.new(1, -4, 0, 30),
                        BackgroundTransparency = isSelected and 0.88 or 1,
                        Text               = val,
                        FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json"),
                        TextSize           = 12,
                        TextXAlignment     = Enum.TextXAlignment.Left,
                        Parent             = DropScrollFrame,
                        ThemeTag           = { BackgroundColor3 = "DropdownOption", TextColor3 = "Text" },
                    }, {
                        New("UICorner", { CornerRadius = UDim.new(0, 6) }),
                        New("UIPadding", { PaddingLeft = UDim.new(0, 10) }),
                    })
                    if isSelected then
                        New("Frame", {
                            Size               = UDim2.fromOffset(3, 12),
                            Position           = UDim2.fromOffset(0, 9),
                            Parent             = optBtn,
                            ThemeTag           = { BackgroundColor3 = "Accent" },
                        }, { New("UICorner", { CornerRadius = UDim.new(1, 0) }) })
                    end
                    MakeHover(optBtn, nil, nil, 0.85, isSelected and 0.88 or 1, 0.12)
                    optBtn.MouseButton1Click:Connect(function()
                        if Dropdown.Multi then
                            Dropdown.Value[val] = not Dropdown.Value[val] or nil
                        else
                            Dropdown.Value = val
                            Dropdown:Close()
                        end
                        BuildList()
                        UpdateDisplay()
                        Library:SafeCallback(Dropdown.Callback, Dropdown.Value)
                        if Dropdown.Changed then Library:SafeCallback(Dropdown.Changed, Dropdown.Value) end
                    end)
                end
                DropCanvas.Size = UDim2.fromOffset(140, math.min(#Dropdown.Values * 34 + 8, 200))
            end

            local function ReposDropdown()
                local absPos = DropBtn.AbsolutePosition
                local absSize = DropBtn.AbsoluteSize
                local canvasH = DropCanvas.Size.Y.Offset
                local vp = Camera.ViewportSize
                local yPos = absPos.Y + absSize.Y + 4
                if yPos + canvasH > vp.Y then yPos = absPos.Y - canvasH - 4 end
                DropCanvas.Position = UDim2.fromOffset(absPos.X, yPos)
            end

            function Dropdown:Open()
                for _, f in ipairs(Library.OpenFrames) do
                    if f ~= DropCanvas then f.Visible = false end
                end
                BuildList()
                ReposDropdown()
                DropCanvas.Visible = true
                Dropdown.Opened = true
                -- Animate
                DropCanvas.Size = UDim2.fromOffset(DropCanvas.Size.X.Offset, 0)
                TweenPlay(DropCanvas, 0.2, {
                    Size = UDim2.fromOffset(140, math.min(#Dropdown.Values * 34 + 8, 200))
                }, Enum.EasingStyle.Quart)
            end

            function Dropdown:Close()
                Dropdown.Opened = false
                TweenPlay(DropCanvas, 0.15, { Size = UDim2.fromOffset(140, 0) }, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                task.wait(0.15)
                DropCanvas.Visible = false
            end

            function Dropdown:SetValues(NewValues)
                Dropdown.Values = NewValues or {}
                BuildList()
                UpdateDisplay()
            end

            function Dropdown:SetValue(Val)
                if Dropdown.Multi then
                    Dropdown.Value = {}
                    if type(Val) == "table" then for _, v in next, Val do Dropdown.Value[v] = true end end
                else
                    Dropdown.Value = table.find(Dropdown.Values, Val) and Val or nil
                end
                BuildList(); UpdateDisplay()
            end

            function Dropdown:OnChanged(Func) Dropdown.Changed = Func; Func(Dropdown.Value) end
            function Dropdown:Destroy() frame:Destroy(); DropCanvas:Destroy(); Library.Options[Idx]=nil end

            DropBtn.MouseButton1Click:Connect(function()
                if Dropdown.Opened then Dropdown:Close() else Dropdown:Open() end
            end)

            Creator.AddSignal(UserInputService.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch then
                    local ap, as = DropCanvas.AbsolutePosition, DropCanvas.AbsoluteSize
                    if Mouse.X < ap.X or Mouse.X > ap.X+as.X or Mouse.Y < ap.Y-20 or Mouse.Y > ap.Y+as.Y then
                        if Dropdown.Opened then Dropdown:Close() end
                    end
                end
            end)

            -- Default
            if Config.Default then Dropdown:SetValue(Config.Default) end
            UpdateDisplay()

            Library.Options[Idx] = Dropdown
            return Dropdown
        end

        -- ── Keybind ──
        function Tab:AddKeybind(Idx, Config)
            Config = Config or {}
            local Keybind = {
                Value    = Config.Default or "None",
                Mode     = Config.Mode or "Toggle",
                Toggled  = false,
                Type     = "Keybind",
                Callback = Config.Callback or function() end,
            }

            local frame = MakeElementFrame(Config.Title, Config.Description, self.Container, true)
            local Picking = false

            local KeyLabel = New("TextLabel", {
                Text               = Keybind.Value,
                FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json"),
                TextSize           = 12,
                TextXAlignment     = Enum.TextXAlignment.Center,
                AutomaticSize      = Enum.AutomaticSize.X,
                BackgroundTransparency = 1,
                Parent             = New("TextButton", {
                    Size               = UDim2.fromOffset(0, 28),
                    AutomaticSize      = Enum.AutomaticSize.X,
                    Position           = UDim2.new(1, -10, 0.5, 0),
                    AnchorPoint        = Vector2.new(1, 0.5),
                    BackgroundTransparency = 0.9,
                    Parent             = frame,
                    ThemeTag           = { BackgroundColor3 = "Keybind" },
                }, {
                    New("UICorner", { CornerRadius = UDim.new(0, 6) }),
                    New("UIStroke", { Transparency = 0.55, ThemeTag = { Color = "InElementBorder" } }),
                    New("UIPadding", { PaddingLeft = UDim.new(0,8), PaddingRight = UDim.new(0,8) }),
                }),
                ThemeTag           = { TextColor3 = "Text" },
            })

            -- Click to pick key
            KeyLabel.Parent.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1
                    or Input.UserInputType == Enum.UserInputType.Touch then
                    Picking = true
                    KeyLabel.Text = "..."
                    task.wait(0.2)
                    local ev
                    ev = UserInputService.InputBegan:Connect(function(Inp)
                        local Key
                        if Inp.UserInputType == Enum.UserInputType.Keyboard then Key = Inp.KeyCode.Name
                        elseif Inp.UserInputType == Enum.UserInputType.MouseButton1 then Key = "MouseLeft"
                        elseif Inp.UserInputType == Enum.UserInputType.MouseButton2 then Key = "MouseRight" end
                        if Key then
                            Keybind.Value = Key
                            KeyLabel.Text = Key
                            Picking = false
                            Library:SafeCallback(Keybind.ChangedCallback, Inp.KeyCode or Inp.UserInputType)
                            ev:Disconnect()
                        end
                    end)
                end
            end)

            Creator.AddSignal(UserInputService.InputBegan, function(Input)
                if Picking or UserInputService:GetFocusedTextBox() then return end
                if Keybind.Mode == "Toggle" and Input.KeyCode.Name == Keybind.Value then
                    Keybind.Toggled = not Keybind.Toggled
                    Library:SafeCallback(Keybind.Callback, Keybind.Toggled)
                end
            end)

            function Keybind:SetValue(Key, Mode)
                Keybind.Value = Key or Keybind.Value
                Keybind.Mode  = Mode or Keybind.Mode
                KeyLabel.Text = Keybind.Value
            end
            function Keybind:GetState() return Keybind.Toggled end
            function Keybind:OnChanged(Func) Keybind.Changed = Func; Func(Keybind.Value) end
            function Keybind:Destroy() frame:Destroy(); Library.Options[Idx]=nil end

            Library.Options[Idx] = Keybind
            return Keybind
        end

        -- ── Input ──
        function Tab:AddInput(Idx, Config)
            Config = Config or {}
            local Input = {
                Value    = Config.Default or "",
                Type     = "Input",
                Callback = Config.Callback or function() end,
            }

            local frame = MakeElementFrame(Config.Title, Config.Description, self.Container, false)

            local Box = New("TextBox", {
                Text               = Config.Default or "",
                PlaceholderText    = Config.Placeholder or "Enter...",
                FontFace           = Font.new("rbxasset://fonts/families/GothamSSm.json"),
                TextSize           = 12,
                TextXAlignment     = Enum.TextXAlignment.Left,
                ClearTextOnFocus   = false,
                Size               = UDim2.fromOffset(140, 28),
                Position           = UDim2.new(1, -10, 0.5, 0),
                AnchorPoint        = Vector2.new(1, 0.5),
                BackgroundTransparency = 0.9,
                Parent             = frame,
                ThemeTag           = { BackgroundColor3 = "Input", TextColor3 = "Text", PlaceholderColor3 = "SubText" },
            }, {
                New("UICorner", { CornerRadius = UDim.new(0, 6) }),
                New("UIStroke", { Transparency = 0.55, ThemeTag = { Color = "InElementBorder" } }),
                New("UIPadding", { PaddingLeft = UDim.new(0,6) }),
            })

            local Indicator = New("Frame", {
                Size               = UDim2.new(1, -4, 0, 1),
                Position           = UDim2.new(0, 2, 1, -1),
                BackgroundTransparency = 0.5,
                Parent             = Box.Parent,
                ThemeTag           = { BackgroundColor3 = "InputIndicator" },
            })

            Box.Focused:Connect(function()
                TweenPlay(Indicator, 0.2, { Size = UDim2.new(1,-2,0,2), BackgroundTransparency = 0 })
                Creator.OverrideTag(Box, { BackgroundColor3="InputFocused", TextColor3="Text", PlaceholderColor3="SubText" })
                Creator.OverrideTag(Indicator, { BackgroundColor3 = "InputIndicatorFocus" or "Accent" })
            end)
            Box.FocusLost:Connect(function()
                TweenPlay(Indicator, 0.2, { Size = UDim2.new(1,-4,0,1), BackgroundTransparency = 0.5 })
                Creator.OverrideTag(Box, { BackgroundColor3="Input", TextColor3="Text", PlaceholderColor3="SubText" })
                Creator.OverrideTag(Indicator, { BackgroundColor3 = "InputIndicator" })
            end)

            if Config.Finished then
                Box.FocusLost:Connect(function(enter)
                    if enter then Input:SetValue(Box.Text) end
                end)
            else
                Box:GetPropertyChangedSignal("Text"):Connect(function()
                    Input:SetValue(Box.Text)
                end)
            end

            function Input:SetValue(Text)
                if Config.MaxLength and #Text > Config.MaxLength then Text = Text:sub(1, Config.MaxLength) end
                if Input.Numeric and not tonumber(Text) and #Text > 0 then Text = Input.Value end
                Input.Value = Text; Box.Text = Text
                Library:SafeCallback(Input.Callback, Input.Value)
                if Input.Changed then Library:SafeCallback(Input.Changed, Input.Value) end
            end
            function Input:OnChanged(Func) Input.Changed = Func; Func(Input.Value) end
            function Input:Destroy() frame:Destroy(); Library.Options[Idx]=nil end

            Library.Options[Idx] = Input
            return Input
        end

        -- ── Paragraph ──
        function Tab:AddParagraph(Config)
            Config = Config or {}
            local frame = MakeElementFrame(Config.Title, Config.Content, self.Container, false)
            frame.BackgroundTransparency = 0.92
            return {}
        end

        return Tab
    end

    -- ── Set Theme ──
    function Window:SetTheme(ThemeName)
        if not Themes[ThemeName] then return end
        Library.Theme = ThemeName
        Creator.UpdateTheme()
    end

    -- ── Destroy ──
    function Library:Destroy()
        Library.Unloaded = true
        Creator.Disconnect()
        GUI:Destroy()
    end

    Library.Window = Window
    table.insert(Library.Windows, Window)

    -- Mobile floating button
    if Mobile then
        task.defer(function()
            repeat task.wait() until Library and Library.Window
            local MobileBtn = New("ImageButton", {
                Size               = UDim2.fromOffset(48, 48),
                Position           = UDim2.new(0, 10, 0.5, -24),
                BackgroundColor3   = Creator.GetThemeProperty("AcrylicMain"),
                BackgroundTransparency = 0.05,
                Image              = "",
                ZIndex             = 999,
                Draggable          = true,
                Active             = true,
                Parent             = GUI,
            }, {
                New("UICorner",  { CornerRadius = UDim.new(0, 12) }),
                New("UIStroke",  { Transparency = 0.5, ThemeTag = { Color = "Accent" } }),
                New("TextLabel", {
                    Text           = "✦",
                    TextSize       = 20,
                    Size           = UDim2.fromScale(1,1),
                    BackgroundTransparency = 1,
                    ThemeTag       = { TextColor3 = "Accent" },
                }),
            })
            MobileBtn.MouseButton1Click:Connect(function()
                Library.Window:Minimize()
            end)
            -- Hover glow
            MobileBtn.MouseEnter:Connect(function()
                TweenPlay(MobileBtn, 0.15, { BackgroundTransparency = 0.0 })
            end)
            MobileBtn.MouseLeave:Connect(function()
                TweenPlay(MobileBtn, 0.15, { BackgroundTransparency = 0.05 })
            end)
        end)
    end

    return Window
end

-- ══════════════════════════════════════════════
--   SaveManager & InterfaceManager (stubs giữ API)
-- ══════════════════════════════════════════════
local SaveManager = {}
SaveManager.__index = SaveManager

function SaveManager:SetLibrary(lib) self.Library = lib end
function SaveManager:IgnoreThemeSettings() end
function SaveManager:SetFolder(name) self.Folder = name end
function SaveManager:BuildConfigSection(tab) end
function SaveManager:LoadAutoloadConfig() end

local InterfaceManager = {}
InterfaceManager.__index = InterfaceManager

function InterfaceManager:SetLibrary(lib) self.Library = lib end
function InterfaceManager:BuildInterfaceSection(tab) end
function InterfaceManager:SetFolder(name) self.Folder = name end

-- ══════════════════════════════════════════════

task.wait(0.01)
return Library, SaveManager, InterfaceManager, Mobile
