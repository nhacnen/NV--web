-- KimP Gaming UI Library
-- Modern UI Library for Roblox

local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- Theme Colors
local Theme = {
    Background = Color3.fromRGB(25, 25, 35),
    Secondary = Color3.fromRGB(35, 35, 45),
    Accent = Color3.fromRGB(85, 170, 255),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(180, 180, 180),
    Border = Color3.fromRGB(45, 45, 55),
    Success = Color3.fromRGB(75, 200, 100),
    Warning = Color3.fromRGB(255, 170, 85),
    Error = Color3.fromRGB(255, 85, 85)
}

-- Utility Functions
local function MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragInput, mousePos, framePos

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

local function Tween(object, properties, duration)
    duration = duration or 0.3
    local tween = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    )
    tween:Play()
    return tween
end

local function CreateRound(parent, radius)
    radius = radius or 8
    local round = Instance.new("UICorner")
    round.CornerRadius = UDim.new(0, radius)
    round.Parent = parent
    return round
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Border
    stroke.Thickness = thickness or 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

-- Window Creation
function Library:CreateWindow(title)
    title = title or "KimP Gaming"
    
    -- Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KimPLibrary"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    if gethui then
        ScreenGui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    else
        ScreenGui.Parent = CoreGui
    end

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 650, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    CreateRound(MainFrame, 12)
    CreateStroke(MainFrame, Theme.Border, 2)

    -- Shadow Effect
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = MainFrame
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Theme.Secondary
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    CreateRound(TitleBar, 12)

    local TitleBarBottom = Instance.new("Frame")
    TitleBarBottom.Size = UDim2.new(1, 0, 0, 12)
    TitleBarBottom.Position = UDim2.new(0, 0, 1, -12)
    TitleBarBottom.BackgroundColor3 = Theme.Secondary
    TitleBarBottom.BorderSizePixel = 0
    TitleBarBottom.Parent = TitleBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Theme.Text
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = Theme.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Theme.Text
    CloseButton.TextSize = 20
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TitleBar
    CreateRound(CloseButton, 6)

    CloseButton.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        wait(0.3)
        ScreenGui:Destroy()
    end)

    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
    MinimizeButton.BackgroundColor3 = Theme.Accent
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Theme.Text
    MinimizeButton.TextSize = 20
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = TitleBar
    CreateRound(MinimizeButton, 6)

    local minimized = false
    local originalSize = MainFrame.Size
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 40)})
            MinimizeButton.Text = "+"
        else
            Tween(MainFrame, {Size = originalSize})
            MinimizeButton.Text = "−"
        end
    end)

    MakeDraggable(MainFrame, TitleBar)

    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 150, 1, -50)
    TabContainer.Position = UDim2.new(0, 10, 0, 45)
    TabContainer.BackgroundColor3 = Theme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame
    CreateRound(TabContainer, 8)

    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    TabList.Parent = TabContainer

    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingBottom = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)
    TabPadding.Parent = TabContainer

    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -180, 1, -50)
    ContentContainer.Position = UDim2.new(0, 170, 0, 45)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame

    -- Window Object
    local WindowObject = {
        Tabs = {},
        CurrentTab = nil
    }

    function WindowObject:addTab(name)
        name = name or "Tab"
        name = name:gsub("#", "")
        
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.BackgroundColor3 = Theme.Background
        TabButton.BorderSizePixel = 0
        TabButton.Text = name
        TabButton.TextColor3 = Theme.TextDark
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.Parent = TabContainer
        CreateRound(TabButton, 6)

        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = name
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Theme.Accent
        TabContent.Visible = false
        TabContent.Parent = ContentContainer
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)

        local TabLayout = Instance.new("UIListLayout")
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 8)
        TabLayout.Parent = TabContent

        TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
        end)

        local TabPadding = Instance.new("UIPadding")
        TabPadding.PaddingTop = UDim.new(0, 5)
        TabPadding.PaddingLeft = UDim.new(0, 5)
        TabPadding.PaddingRight = UDim.new(0, 5)
        TabPadding.Parent = TabContent

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(WindowObject.Tabs) do
                tab.Content.Visible = false
                Tween(tab.Button, {BackgroundColor3 = Theme.Background, TextColor3 = Theme.TextDark})
            end
            
            TabContent.Visible = true
            WindowObject.CurrentTab = TabContent
            Tween(TabButton, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Text})
        end)

        if WindowObject.CurrentTab == nil then
            TabContent.Visible = true
            WindowObject.CurrentTab = TabContent
            TabButton.BackgroundColor3 = Theme.Accent
            TabButton.TextColor3 = Theme.Text
        end

        local TabObject = {
            Button = TabButton,
            Content = TabContent,
            Sections = {}
        }

        function TabObject:addSection()
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, -10, 0, 0)
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Parent = TabContent

            local SectionLayout = Instance.new("UIListLayout")
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Padding = UDim.new(0, 8)
            SectionLayout.Parent = SectionFrame

            SectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionFrame.Size = UDim2.new(1, -10, 0, SectionLayout.AbsoluteContentSize.Y)
            end)

            local SectionObject = {}

            function SectionObject:addMenu(name)
                name = name or "Menu"
                name = name:gsub("#", "")
                
                local MenuFrame = Instance.new("Frame")
                MenuFrame.Size = UDim2.new(1, 0, 0, 0)
                MenuFrame.BackgroundColor3 = Theme.Secondary
                MenuFrame.BorderSizePixel = 0
                MenuFrame.Parent = SectionFrame
                CreateRound(MenuFrame, 8)

                local MenuHeader = Instance.new("TextLabel")
                MenuHeader.Size = UDim2.new(1, -20, 0, 30)
                MenuHeader.Position = UDim2.new(0, 10, 0, 5)
                MenuHeader.BackgroundTransparency = 1
                MenuHeader.Text = name
                MenuHeader.TextColor3 = Theme.Text
                MenuHeader.TextSize = 14
                MenuHeader.Font = Enum.Font.GothamBold
                MenuHeader.TextXAlignment = Enum.TextXAlignment.Left
                MenuHeader.Parent = MenuFrame

                local MenuContent = Instance.new("Frame")
                MenuContent.Size = UDim2.new(1, -20, 1, -40)
                MenuContent.Position = UDim2.new(0, 10, 0, 35)
                MenuContent.BackgroundTransparency = 1
                MenuContent.Parent = MenuFrame

                local MenuLayout = Instance.new("UIListLayout")
                MenuLayout.SortOrder = Enum.SortOrder.LayoutOrder
                MenuLayout.Padding = UDim.new(0, 8)
                MenuLayout.Parent = MenuContent

                MenuLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    MenuFrame.Size = UDim2.new(1, 0, 0, MenuLayout.AbsoluteContentSize.Y + 45)
                end)

                local MenuObject = {}

                function MenuObject:addButton(name, callback)
                    callback = callback or function() end
                    
                    local Button = Instance.new("TextButton")
                    Button.Size = UDim2.new(1, 0, 0, 35)
                    Button.BackgroundColor3 = Theme.Background
                    Button.BorderSizePixel = 0
                    Button.Text = name
                    Button.TextColor3 = Theme.Text
                    Button.TextSize = 13
                    Button.Font = Enum.Font.Gotham
                    Button.Parent = MenuContent
                    CreateRound(Button, 6)

                    Button.MouseEnter:Connect(function()
                        Tween(Button, {BackgroundColor3 = Theme.Accent})
                    end)

                    Button.MouseLeave:Connect(function()
                        Tween(Button, {BackgroundColor3 = Theme.Background})
                    end)

                    Button.MouseButton1Click:Connect(function()
                        Tween(Button, {BackgroundColor3 = Theme.Success}, 0.1)
                        wait(0.1)
                        Tween(Button, {BackgroundColor3 = Theme.Accent}, 0.1)
                        pcall(callback)
                    end)

                    return Button
                end

                function MenuObject:addToggle(name, default, callback)
                    default = default or false
                    callback = callback or function() end
                    
                    local ToggleFrame = Instance.new("Frame")
                    ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
                    ToggleFrame.BackgroundColor3 = Theme.Background
                    ToggleFrame.BorderSizePixel = 0
                    ToggleFrame.Parent = MenuContent
                    CreateRound(ToggleFrame, 6)

                    local ToggleLabel = Instance.new("TextLabel")
                    ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
                    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
                    ToggleLabel.BackgroundTransparency = 1
                    ToggleLabel.Text = name
                    ToggleLabel.TextColor3 = Theme.Text
                    ToggleLabel.TextSize = 13
                    ToggleLabel.Font = Enum.Font.Gotham
                    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ToggleLabel.Parent = ToggleFrame

                    local ToggleButton = Instance.new("TextButton")
                    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                    ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
                    ToggleButton.BackgroundColor3 = default and Theme.Success or Theme.Border
                    ToggleButton.BorderSizePixel = 0
                    ToggleButton.Text = ""
                    ToggleButton.Parent = ToggleFrame
                    CreateRound(ToggleButton, 10)

                    local ToggleCircle = Instance.new("Frame")
                    ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
                    ToggleCircle.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    ToggleCircle.BackgroundColor3 = Theme.Text
                    ToggleCircle.BorderSizePixel = 0
                    ToggleCircle.Parent = ToggleButton
                    CreateRound(ToggleCircle, 8)

                    local toggled = default

                    ToggleButton.MouseButton1Click:Connect(function()
                        toggled = not toggled
                        
                        Tween(ToggleButton, {BackgroundColor3 = toggled and Theme.Success or Theme.Border})
                        Tween(ToggleCircle, {Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)})
                        
                        pcall(callback, toggled)
                    end)

                    return ToggleButton
                end

                function MenuObject:addTextbox(name, default, callback)
                    default = default or ""
                    callback = callback or function() end
                    
                    local TextboxFrame = Instance.new("Frame")
                    TextboxFrame.Size = UDim2.new(1, 0, 0, 60)
                    TextboxFrame.BackgroundColor3 = Theme.Background
                    TextboxFrame.BorderSizePixel = 0
                    TextboxFrame.Parent = MenuContent
                    CreateRound(TextboxFrame, 6)

                    local TextboxLabel = Instance.new("TextLabel")
                    TextboxLabel.Size = UDim2.new(1, -20, 0, 20)
                    TextboxLabel.Position = UDim2.new(0, 10, 0, 5)
                    TextboxLabel.BackgroundTransparency = 1
                    TextboxLabel.Text = name
                    TextboxLabel.TextColor3 = Theme.Text
                    TextboxLabel.TextSize = 13
                    TextboxLabel.Font = Enum.Font.Gotham
                    TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextboxLabel.Parent = TextboxFrame

                    local Textbox = Instance.new("TextBox")
                    Textbox.Size = UDim2.new(1, -20, 0, 25)
                    Textbox.Position = UDim2.new(0, 10, 0, 28)
                    Textbox.BackgroundColor3 = Theme.Secondary
                    Textbox.BorderSizePixel = 0
                    Textbox.Text = tostring(default)
                    Textbox.PlaceholderText = "Enter value..."
                    Textbox.TextColor3 = Theme.Text
                    Textbox.PlaceholderColor3 = Theme.TextDark
                    Textbox.TextSize = 12
                    Textbox.Font = Enum.Font.Gotham
                    Textbox.ClearTextOnFocus = false
                    Textbox.Parent = TextboxFrame
                    CreateRound(Textbox, 4)

                    Textbox.FocusLost:Connect(function(enter)
                        if enter then
                            pcall(callback, Textbox.Text)
                        end
                    end)

                    return Textbox
                end

                function MenuObject:addSlider(name, min, max, default, callback)
                    min = min or 0
                    max = max or 100
                    default = default or min
                    callback = callback or function() end
                    
                    local SliderFrame = Instance.new("Frame")
                    SliderFrame.Size = UDim2.new(1, 0, 0, 60)
                    SliderFrame.BackgroundColor3 = Theme.Background
                    SliderFrame.BorderSizePixel = 0
                    SliderFrame.Parent = MenuContent
                    CreateRound(SliderFrame, 6)

                    local SliderLabel = Instance.new("TextLabel")
                    SliderLabel.Size = UDim2.new(1, -60, 0, 20)
                    SliderLabel.Position = UDim2.new(0, 10, 0, 5)
                    SliderLabel.BackgroundTransparency = 1
                    SliderLabel.Text = name
                    SliderLabel.TextColor3 = Theme.Text
                    SliderLabel.TextSize = 13
                    SliderLabel.Font = Enum.Font.Gotham
                    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                    SliderLabel.Parent = SliderFrame

                    local SliderValue = Instance.new("TextLabel")
                    SliderValue.Size = UDim2.new(0, 50, 0, 20)
                    SliderValue.Position = UDim2.new(1, -55, 0, 5)
                    SliderValue.BackgroundTransparency = 1
                    SliderValue.Text = tostring(default)
                    SliderValue.TextColor3 = Theme.Accent
                    SliderValue.TextSize = 13
                    SliderValue.Font = Enum.Font.GothamBold
                    SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                    SliderValue.Parent = SliderFrame

                    local SliderBar = Instance.new("Frame")
                    SliderBar.Size = UDim2.new(1, -20, 0, 6)
                    SliderBar.Position = UDim2.new(0, 10, 0, 35)
                    SliderBar.BackgroundColor3 = Theme.Secondary
                    SliderBar.BorderSizePixel = 0
                    SliderBar.Parent = SliderFrame
                    CreateRound(SliderBar, 3)

                    local SliderFill = Instance.new("Frame")
                    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                    SliderFill.BackgroundColor3 = Theme.Accent
                    SliderFill.BorderSizePixel = 0
                    SliderFill.Parent = SliderBar
                    CreateRound(SliderFill, 3)

                    local SliderButton = Instance.new("TextButton")
                    SliderButton.Size = UDim2.new(0, 14, 0, 14)
                    SliderButton.Position = UDim2.new(1, -7, 0.5, -7)
                    SliderButton.BackgroundColor3 = Theme.Text
                    SliderButton.BorderSizePixel = 0
                    SliderButton.Text = ""
                    SliderButton.Parent = SliderFill
                    CreateRound(SliderButton, 7)

                    local dragging = false

                    local function updateSlider(input)
                        local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                        local value = math.floor(min + (max - min) * pos)
                        
                        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                        SliderValue.Text = tostring(value)
                        
                        pcall(callback, value)
                    end

                    SliderButton.MouseButton1Down:Connect(function()
                        dragging = true
                    end)

                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)

                    UserInputService.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            updateSlider(input)
                        end
                    end)

                    SliderBar.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            updateSlider(input)
                        end
                    end)

                    return SliderFrame
                end

                function MenuObject:addDropdown(name, options, default, callback)
                    options = options or {}
                    default = default or options[1] or ""
                    callback = callback or function() end
                    
                    local DropdownFrame = Instance.new("Frame")
                    DropdownFrame.Size = UDim2.new(1, 0, 0, 60)
                    DropdownFrame.BackgroundColor3 = Theme.Background
                    DropdownFrame.BorderSizePixel = 0
                    DropdownFrame.Parent = MenuContent
                    CreateRound(DropdownFrame, 6)
                    DropdownFrame.ClipsDescendants = true

                    local DropdownLabel = Instance.new("TextLabel")
                    DropdownLabel.Size = UDim2.new(1, -20, 0, 20)
                    DropdownLabel.Position = UDim2.new(0, 10, 0, 5)
                    DropdownLabel.BackgroundTransparency = 1
                    DropdownLabel.Text = name
                    DropdownLabel.TextColor3 = Theme.Text
                    DropdownLabel.TextSize = 13
                    DropdownLabel.Font = Enum.Font.Gotham
                    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownLabel.Parent = DropdownFrame

                    local DropdownButton = Instance.new("TextButton")
                    DropdownButton.Size = UDim2.new(1, -20, 0, 25)
                    DropdownButton.Position = UDim2.new(0, 10, 0, 28)
                    DropdownButton.BackgroundColor3 = Theme.Secondary
                    DropdownButton.BorderSizePixel = 0
                    DropdownButton.Text = default
                    DropdownButton.TextColor3 = Theme.Text
                    DropdownButton.TextSize = 12
                    DropdownButton.Font = Enum.Font.Gotham
                    DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownButton.Parent = DropdownFrame
                    CreateRound(DropdownButton, 4)

                    local DropdownPadding = Instance.new("UIPadding")
                    DropdownPadding.PaddingLeft = UDim.new(0, 10)
                    DropdownPadding.Parent = DropdownButton

                    local DropdownIcon = Instance.new("TextLabel")
                    DropdownIcon.Size = UDim2.new(0, 20, 1, 0)
                    DropdownIcon.Position = UDim2.new(1, -25, 0, 0)
                    DropdownIcon.BackgroundTransparency = 1
                    DropdownIcon.Text = "▼"
                    DropdownIcon.TextColor3 = Theme.TextDark
                    DropdownIcon.TextSize = 10
                    DropdownIcon.Font = Enum.Font.Gotham
                    DropdownIcon.Parent = DropdownButton

                    local DropdownList = Instance.new("Frame")
                    DropdownList.Size = UDim2.new(1, -20, 0, 0)
                    DropdownList.Position = UDim2.new(0, 10, 0, 58)
                    DropdownList.BackgroundColor3 = Theme.Secondary
                    DropdownList.BorderSizePixel = 0
                    DropdownList.Visible = false
                    DropdownList.Parent = DropdownFrame
                    CreateRound(DropdownList, 4)

                    local DropdownListLayout = Instance.new("UIListLayout")
                    DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    DropdownListLayout.Padding = UDim.new(0, 2)
                    DropdownListLayout.Parent = DropdownList

                    local DropdownListPadding = Instance.new("UIPadding")
                    DropdownListPadding.PaddingTop = UDim.new(0, 5)
                    DropdownListPadding.PaddingBottom = UDim.new(0, 5)
                    DropdownListPadding.Parent = DropdownList

                    local opened = false

                    DropdownButton.MouseButton1Click:Connect(function()
                        opened = not opened
                        
                        if opened then
                            DropdownList.Visible = true
                            local listHeight = math.min(#options * 27 + 10, 150)
                            DropdownList.Size = UDim2.new(1, -20, 0, listHeight)
                            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 60 + listHeight + 5)})
                            Tween(DropdownIcon, {Rotation = 180})
                        else
                            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 60)})
                            Tween(DropdownIcon, {Rotation = 0})
                            wait(0.3)
                            DropdownList.Visible = false
                        end
                    end)

                    for _, option in ipairs(options) do
                        local OptionButton = Instance.new("TextButton")
                        OptionButton.Size = UDim2.new(1, 0, 0, 25)
                        OptionButton.BackgroundColor3 = Theme.Background
                        OptionButton.BorderSizePixel = 0
                        OptionButton.Text = tostring(option)
                        OptionButton.TextColor3 = Theme.Text
                        OptionButton.TextSize = 12
                        OptionButton.Font = Enum.Font.Gotham
                        OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                        OptionButton.Parent = DropdownList
                        CreateRound(OptionButton, 4)

                        local OptionPadding = Instance.new("UIPadding")
                        OptionPadding.PaddingLeft = UDim.new(0, 10)
                        OptionPadding.Parent = OptionButton

                        OptionButton.MouseEnter:Connect(function()
                            Tween(OptionButton, {BackgroundColor3 = Theme.Accent})
                        end)

                        OptionButton.MouseLeave:Connect(function()
                            Tween(OptionButton, {BackgroundColor3 = Theme.Background})
                        end)

                        OptionButton.MouseButton1Click:Connect(function()
                            DropdownButton.Text = tostring(option)
                            opened = false
                            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 60)})
                            Tween(DropdownIcon, {Rotation = 0})
                            wait(0.3)
                            DropdownList.Visible = false
                            pcall(callback, option)
                        end)
                    end

                    return DropdownFrame
                end

                function MenuObject:addTextbox(name, default, callback)
                    default = default or ""
                    callback = callback or function() end
                    
                    local TextboxFrame = Instance.new("Frame")
                    TextboxFrame.Size = UDim2.new(1, 0, 0, 60)
                    TextboxFrame.BackgroundColor3 = Theme.Background
                    TextboxFrame.BorderSizePixel = 0
                    TextboxFrame.Parent = MenuContent
                    CreateRound(TextboxFrame, 6)

                    local TextboxLabel = Instance.new("TextLabel")
                    TextboxLabel.Size = UDim2.new(1, -20, 0, 20)
                    TextboxLabel.Position = UDim2.new(0, 10, 0, 5)
                    TextboxLabel.BackgroundTransparency = 1
                    TextboxLabel.Text = name
                    TextboxLabel.TextColor3 = Theme.Text
                    TextboxLabel.TextSize = 13
                    TextboxLabel.Font = Enum.Font.Gotham
                    TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextboxLabel.Parent = TextboxFrame

                    local TextboxInput = Instance.new("TextBox")
                    TextboxInput.Size = UDim2.new(1, -20, 0, 28)
                    TextboxInput.Position = UDim2.new(0, 10, 0, 27)
                    TextboxInput.BackgroundColor3 = Theme.Secondary
                    TextboxInput.BorderSizePixel = 0
                    TextboxInput.Text = tostring(default)
                    TextboxInput.PlaceholderText = "Enter value..."
                    TextboxInput.TextColor3 = Theme.Text
                    TextboxInput.PlaceholderColor3 = Theme.TextDark
                    TextboxInput.TextSize = 12
                    TextboxInput.Font = Enum.Font.Gotham
                    TextboxInput.TextXAlignment = Enum.TextXAlignment.Left
                    TextboxInput.ClearTextOnFocus = false
                    TextboxInput.Parent = TextboxFrame
                    CreateRound(TextboxInput, 4)

                    local TextboxPadding = Instance.new("UIPadding")
                    TextboxPadding.PaddingLeft = UDim.new(0, 10)
                    TextboxPadding.PaddingRight = UDim.new(0, 10)
                    TextboxPadding.Parent = TextboxInput

                    TextboxInput.FocusLost:Connect(function(enterPressed)
                        local value = TextboxInput.Text
                        -- Try to convert to number if possible
                        local numValue = tonumber(value)
                        if numValue then
                            pcall(callback, numValue)
                        else
                            pcall(callback, value)
                        end
                    end)

                    TextboxInput.MouseEnter:Connect(function()
                        Tween(TextboxInput, {BackgroundColor3 = Theme.Border})
                    end)

                    TextboxInput.MouseLeave:Connect(function()
                        if not TextboxInput:IsFocused() then
                            Tween(TextboxInput, {BackgroundColor3 = Theme.Secondary})
                        end
                    end)

                    return TextboxFrame
                end

                function MenuObject:addChangelog(text)
                    local ChangelogLabel = Instance.new("TextLabel")
                    ChangelogLabel.Size = UDim2.new(1, 0, 0, 25)
                    ChangelogLabel.BackgroundColor3 = Theme.Background
                    ChangelogLabel.BorderSizePixel = 0
                    ChangelogLabel.Text = "• " .. text
                    ChangelogLabel.TextColor3 = Theme.TextDark
                    ChangelogLabel.TextSize = 12
                    ChangelogLabel.Font = Enum.Font.Gotham
                    ChangelogLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ChangelogLabel.TextWrapped = true
                    ChangelogLabel.Parent = MenuContent
                    CreateRound(ChangelogLabel, 4)

                    local ChangelogPadding = Instance.new("UIPadding")
                    ChangelogPadding.PaddingLeft = UDim.new(0, 10)
                    ChangelogPadding.Parent = ChangelogLabel

                    return ChangelogLabel
                end

                function MenuObject:addLabel(text, color)
                    color = color or Theme.Text
                    
                    local Label = Instance.new("TextLabel")
                    Label.Size = UDim2.new(1, 0, 0, 25)
                    Label.BackgroundTransparency = 1
                    Label.Text = text
                    Label.TextColor3 = color
                    Label.TextSize = 13
                    Label.Font = Enum.Font.Gotham
                    Label.TextXAlignment = Enum.TextXAlignment.Left
                    Label.TextWrapped = true
                    Label.Parent = MenuContent

                    return Label
                end

                return MenuObject
            end

            table.insert(self.Sections, SectionObject)
            return SectionObject
        end

        table.insert(WindowObject.Tabs, TabObject)
        return TabObject
    end

    -- Animation when window appears
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 450)}, 0.5)

    return WindowObject
end

return Library                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

local function Tween(object, properties, duration)
    duration = duration or 0.3
    local tween = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    )
    tween:Play()
    return tween
end

local function CreateRound(parent, radius)
    radius = radius or 8
    local round = Instance.new("UICorner")
    round.CornerRadius = UDim.new(0, radius)
    round.Parent = parent
    return round
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Border
    stroke.Thickness = thickness or 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

-- Window Creation
function Library:CreateWindow(title)
    title = title or "KimP Gaming"
    
    -- Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KimPLibrary"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    if gethui then
        ScreenGui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    else
        ScreenGui.Parent = CoreGui
    end

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 650, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    CreateRound(MainFrame, 12)
    CreateStroke(MainFrame, Theme.Border, 2)

    -- Shadow Effect
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = MainFrame
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Theme.Secondary
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    CreateRound(TitleBar, 12)

    local TitleBarBottom = Instance.new("Frame")
    TitleBarBottom.Size = UDim2.new(1, 0, 0, 12)
    TitleBarBottom.Position = UDim2.new(0, 0, 1, -12)
    TitleBarBottom.BackgroundColor3 = Theme.Secondary
    TitleBarBottom.BorderSizePixel = 0
    TitleBarBottom.Parent = TitleBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Theme.Text
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = Theme.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Theme.Text
    CloseButton.TextSize = 20
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TitleBar
    CreateRound(CloseButton, 6)

    CloseButton.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        wait(0.3)
        ScreenGui:Destroy()
    end)

    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
    MinimizeButton.BackgroundColor3 = Theme.Accent
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Theme.Text
    MinimizeButton.TextSize = 20
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = TitleBar
    CreateRound(MinimizeButton, 6)

    local minimized = false
    local originalSize = MainFrame.Size
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 40)})
            MinimizeButton.Text = "+"
        else
            Tween(MainFrame, {Size = originalSize})
            MinimizeButton.Text = "−"
        end
    end)

    MakeDraggable(MainFrame, TitleBar)

    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 150, 1, -50)
    TabContainer.Position = UDim2.new(0, 10, 0, 45)
    TabContainer.BackgroundColor3 = Theme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame
    CreateRound(TabContainer, 8)

    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    TabList.Parent = TabContainer

    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingBottom = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)
    TabPadding.Parent = TabContainer

    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -180, 1, -50)
    ContentContainer.Position = UDim2.new(0, 170, 0, 45)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame

    -- Window Object
    local WindowObject = {
        Tabs = {},
        CurrentTab = nil
    }

    function WindowObject:addTab(name)
        name = name or "Tab"
        name = name:gsub("#", "")
        
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.BackgroundColor3 = Theme.Background
        TabButton.BorderSizePixel = 0
        TabButton.Text = name
        TabButton.TextColor3 = Theme.TextDark
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.Parent = TabContainer
        CreateRound(TabButton, 6)

        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = name
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Theme.Accent
        TabContent.Visible = false
        TabContent.Parent = ContentContainer
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)

        local TabLayout = Instance.new("UIListLayout")
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 8)
        TabLayout.Parent = TabContent

        TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
        end)

        local TabPadding = Instance.new("UIPadding")
        TabPadding.PaddingTop = UDim.new(0, 5)
        TabPadding.PaddingLeft = UDim.new(0, 5)
        TabPadding.PaddingRight = UDim.new(0, 5)
        TabPadding.Parent = TabContent

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(WindowObject.Tabs) do
                tab.Content.Visible = false
                Tween(tab.Button, {BackgroundColor3 = Theme.Background, TextColor3 = Theme.TextDark})
            end
            
            TabContent.Visible = true
            WindowObject.CurrentTab = TabContent
            Tween(TabButton, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Text})
        end)

        if WindowObject.CurrentTab == nil then
            TabContent.Visible = true
            WindowObject.CurrentTab = TabContent
            TabButton.BackgroundColor3 = Theme.Accent
            TabButton.TextColor3 = Theme.Text
        end

        local TabObject = {
            Button = TabButton,
            Content = TabContent,
            Sections = {}
        }

        function TabObject:addSection()
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, -10, 0, 0)
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Parent = TabContent

            local SectionLayout = Instance.new("UIListLayout")
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Padding = UDim.new(0, 8)
            SectionLayout.Parent = SectionFrame

            SectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionFrame.Size = UDim2.new(1, -10, 0, SectionLayout.AbsoluteContentSize.Y)
            end)

            local SectionObject = {}

            function SectionObject:addMenu(name)
                name = name or "Menu"
                name = name:gsub("#", "")
                
                local MenuFrame = Instance.new("Frame")
                MenuFrame.Size = UDim2.new(1, 0, 0, 50)
                MenuFrame.BackgroundColor3 = Theme.Secondary
                MenuFrame.BorderSizePixel = 0
                MenuFrame.Parent = SectionFrame
                MenuFrame.ClipsDescendants = false
                CreateRound(MenuFrame, 8)

                local MenuHeader = Instance.new("TextLabel")
                MenuHeader.Size = UDim2.new(1, -20, 0, 30)
                MenuHeader.Position = UDim2.new(0, 10, 0, 5)
                MenuHeader.BackgroundTransparency = 1
                MenuHeader.Text = name
                MenuHeader.TextColor3 = Theme.Text
                MenuHeader.TextSize = 14
                MenuHeader.Font = Enum.Font.GothamBold
                MenuHeader.TextXAlignment = Enum.TextXAlignment.Left
                MenuHeader.Parent = MenuFrame

                local MenuContent = Instance.new("Frame")
                MenuContent.Size = UDim2.new(1, -20, 0, 0)
                MenuContent.Position = UDim2.new(0, 10, 0, 40)
                MenuContent.BackgroundTransparency = 1
                MenuContent.Parent = MenuFrame

                local MenuLayout = Instance.new("UIListLayout")
                MenuLayout.SortOrder = Enum.SortOrder.LayoutOrder
                MenuLayout.Padding = UDim.new(0, 8)
                MenuLayout.Parent = MenuContent

                MenuLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    MenuContent.Size = UDim2.new(1, -20, 0, MenuLayout.AbsoluteContentSize.Y)
                    MenuFrame.Size = UDim2.new(1, 0, 0, MenuLayout.AbsoluteContentSize.Y + 55)
                end)

                local MenuObject = {}

                function MenuObject:addButton(name, callback)
                    callback = callback or function() end
                    
                    local Button = Instance.new("TextButton")
                    Button.Size = UDim2.new(1, 0, 0, 35)
                    Button.BackgroundColor3 = Theme.Background
                    Button.BorderSizePixel = 0
                    Button.Text = name
                    Button.TextColor3 = Theme.Text
                    Button.TextSize = 13
                    Button.Font = Enum.Font.Gotham
                    Button.Parent = MenuContent
                    CreateRound(Button, 6)

                    Button.MouseEnter:Connect(function()
                        Tween(Button, {BackgroundColor3 = Theme.Accent})
                    end)

                    Button.MouseLeave:Connect(function()
                        Tween(Button, {BackgroundColor3 = Theme.Background})
                    end)

                    Button.MouseButton1Click:Connect(function()
                        Tween(Button, {BackgroundColor3 = Theme.Success}, 0.1)
                        wait(0.1)
                        Tween(Button, {BackgroundColor3 = Theme.Accent}, 0.1)
                        pcall(callback)
                    end)

                    return Button
                end

                function MenuObject:addToggle(name, default, callback)
                    default = default or false
                    callback = callback or function() end
                    
                    local ToggleFrame = Instance.new("Frame")
                    ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
                    ToggleFrame.BackgroundColor3 = Theme.Background
                    ToggleFrame.BorderSizePixel = 0
                    ToggleFrame.Parent = MenuContent
                    CreateRound(ToggleFrame, 6)

                    local ToggleLabel = Instance.new("TextLabel")
                    ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
                    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
                    ToggleLabel.BackgroundTransparency = 1
                    ToggleLabel.Text = name
                    ToggleLabel.TextColor3 = Theme.Text
                    ToggleLabel.TextSize = 13
                    ToggleLabel.Font = Enum.Font.Gotham
                    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ToggleLabel.Parent = ToggleFrame

                    local ToggleButton = Instance.new("TextButton")
                    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                    ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
                    ToggleButton.BackgroundColor3 = default and Theme.Success or Theme.Border
                    ToggleButton.BorderSizePixel = 0
                    ToggleButton.Text = ""
                    ToggleButton.Parent = ToggleFrame
                    CreateRound(ToggleButton, 10)

                    local ToggleCircle = Instance.new("Frame")
                    ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
                    ToggleCircle.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    ToggleCircle.BackgroundColor3 = Theme.Text
                    ToggleCircle.BorderSizePixel = 0
                    ToggleCircle.Parent = ToggleButton
                    CreateRound(ToggleCircle, 8)

                    local toggled = default

                    ToggleButton.MouseButton1Click:Connect(function()
                        toggled = not toggled
                        
                        Tween(ToggleButton, {BackgroundColor3 = toggled and Theme.Success or Theme.Border})
                        Tween(ToggleCircle, {Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)})
                        
                        pcall(callback, toggled)
                    end)

                    return ToggleButton
                end

                function MenuObject:addTextbox(name, default, callback)
                    default = default or ""
                    callback = callback or function() end
                    
                    local TextboxFrame = Instance.new("Frame")
                    TextboxFrame.Size = UDim2.new(1, 0, 0, 60)
                    TextboxFrame.BackgroundColor3 = Theme.Background
                    TextboxFrame.BorderSizePixel = 0
                    TextboxFrame.Parent = MenuContent
                    CreateRound(TextboxFrame, 6)

                    local TextboxLabel = Instance.new("TextLabel")
                    TextboxLabel.Size = UDim2.new(1, -20, 0, 20)
                    TextboxLabel.Position = UDim2.new(0, 10, 0, 5)
                    TextboxLabel.BackgroundTransparency = 1
                    TextboxLabel.Text = name
                    TextboxLabel.TextColor3 = Theme.Text
                    TextboxLabel.TextSize = 13
                    TextboxLabel.Font = Enum.Font.Gotham
                    TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextboxLabel.Parent = TextboxFrame

                    local Textbox = Instance.new("TextBox")
                    Textbox.Size = UDim2.new(1, -20, 0, 25)
                    Textbox.Position = UDim2.new(0, 10, 0, 28)
                    Textbox.BackgroundColor3 = Theme.Secondary
                    Textbox.BorderSizePixel = 0
                    Textbox.Text = tostring(default)
                    Textbox.PlaceholderText = "Enter value..."
                    Textbox.TextColor3 = Theme.Text
                    Textbox.PlaceholderColor3 = Theme.TextDark
                    Textbox.TextSize = 12
                    Textbox.Font = Enum.Font.Gotham
                    Textbox.ClearTextOnFocus = false
                    Textbox.Parent = TextboxFrame
                    CreateRound(Textbox, 4)

                    Textbox.FocusLost:Connect(function(enter)
                        if enter then
                            pcall(callback, Textbox.Text)
                        end
                    end)

                    return Textbox
                end

                function MenuObject:addSlider(name, min, max, default, callback)
                    min = min or 0
                    max = max or 100
                    default = default or min
                    callback = callback or function() end
                    
                    local SliderFrame = Instance.new("Frame")
                    SliderFrame.Size = UDim2.new(1, 0, 0, 60)
                    SliderFrame.BackgroundColor3 = Theme.Background
                    SliderFrame.BorderSizePixel = 0
                    SliderFrame.Parent = MenuContent
                    CreateRound(SliderFrame, 6)

                    local SliderLabel = Instance.new("TextLabel")
                    SliderLabel.Size = UDim2.new(1, -60, 0, 20)
                    SliderLabel.Position = UDim2.new(0, 10, 0, 5)
                    SliderLabel.BackgroundTransparency = 1
                    SliderLabel.Text = name
                    SliderLabel.TextColor3 = Theme.Text
                    SliderLabel.TextSize = 13
                    SliderLabel.Font = Enum.Font.Gotham
                    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                    SliderLabel.Parent = SliderFrame

                    local SliderValue = Instance.new("TextLabel")
                    SliderValue.Size = UDim2.new(0, 50, 0, 20)
                    SliderValue.Position = UDim2.new(1, -55, 0, 5)
                    SliderValue.BackgroundTransparency = 1
                    SliderValue.Text = tostring(default)
                    SliderValue.TextColor3 = Theme.Accent
                    SliderValue.TextSize = 13
                    SliderValue.Font = Enum.Font.GothamBold
                    SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                    SliderValue.Parent = SliderFrame

                    local SliderBar = Instance.new("Frame")
                    SliderBar.Size = UDim2.new(1, -20, 0, 6)
                    SliderBar.Position = UDim2.new(0, 10, 0, 35)
                    SliderBar.BackgroundColor3 = Theme.Secondary
                    SliderBar.BorderSizePixel = 0
                    SliderBar.Parent = SliderFrame
                    CreateRound(SliderBar, 3)

                    local SliderFill = Instance.new("Frame")
                    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                    SliderFill.BackgroundColor3 = Theme.Accent
                    SliderFill.BorderSizePixel = 0
                    SliderFill.Parent = SliderBar
                    CreateRound(SliderFill, 3)

                    local SliderButton = Instance.new("TextButton")
                    SliderButton.Size = UDim2.new(0, 14, 0, 14)
                    SliderButton.Position = UDim2.new(1, -7, 0.5, -7)
                    SliderButton.BackgroundColor3 = Theme.Text
                    SliderButton.BorderSizePixel = 0
                    SliderButton.Text = ""
                    SliderButton.Parent = SliderFill
                    CreateRound(SliderButton, 7)

                    local dragging = false

                    local function updateSlider(input)
                        local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                        local value = math.floor(min + (max - min) * pos)
                        
                        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                        SliderValue.Text = tostring(value)
                        
                        pcall(callback, value)
                    end

                    SliderButton.MouseButton1Down:Connect(function()
                        dragging = true
                    end)

                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)

                    UserInputService.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            updateSlider(input)
                        end
                    end)

                    SliderBar.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            updateSlider(input)
                        end
                    end)

                    return SliderFrame
                end

                function MenuObject:addDropdown(name, options, default, callback)
                    options = options or {}
                    default = default or options[1] or ""
                    callback = callback or function() end
                    
                    local DropdownFrame = Instance.new("Frame")
                    DropdownFrame.Size = UDim2.new(1, 0, 0, 60)
                    DropdownFrame.BackgroundColor3 = Theme.Background
                    DropdownFrame.BorderSizePixel = 0
                    DropdownFrame.Parent = MenuContent
                    CreateRound(DropdownFrame, 6)
                    DropdownFrame.ClipsDescendants = true

                    local DropdownLabel = Instance.new("TextLabel")
                    DropdownLabel.Size = UDim2.new(1, -20, 0, 20)
                    DropdownLabel.Position = UDim2.new(0, 10, 0, 5)
                    DropdownLabel.BackgroundTransparency = 1
                    DropdownLabel.Text = name
                    DropdownLabel.TextColor3 = Theme.Text
                    DropdownLabel.TextSize = 13
                    DropdownLabel.Font = Enum.Font.Gotham
                    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownLabel.Parent = DropdownFrame

                    local DropdownButton = Instance.new("TextButton")
                    DropdownButton.Size = UDim2.new(1, -20, 0, 25)
                    DropdownButton.Position = UDim2.new(0, 10, 0, 28)
                    DropdownButton.BackgroundColor3 = Theme.Secondary
                    DropdownButton.BorderSizePixel = 0
                    DropdownButton.Text = default
                    DropdownButton.TextColor3 = Theme.Text
                    DropdownButton.TextSize = 12
                    DropdownButton.Font = Enum.Font.Gotham
                    DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownButton.Parent = DropdownFrame
                    CreateRound(DropdownButton, 4)

                    local DropdownPadding = Instance.new("UIPadding")
                    DropdownPadding.PaddingLeft = UDim.new(0, 10)
                    DropdownPadding.Parent = DropdownButton

                    local DropdownIcon = Instance.new("TextLabel")
                    DropdownIcon.Size = UDim2.new(0, 20, 1, 0)
                    DropdownIcon.Position = UDim2.new(1, -25, 0, 0)
                    DropdownIcon.BackgroundTransparency = 1
                    DropdownIcon.Text = "▼"
                    DropdownIcon.TextColor3 = Theme.TextDark
                    DropdownIcon.TextSize = 10
                    DropdownIcon.Font = Enum.Font.Gotham
                    DropdownIcon.Parent = DropdownButton

                    local DropdownList = Instance.new("Frame")
                    DropdownList.Size = UDim2.new(1, -20, 0, 0)
                    DropdownList.Position = UDim2.new(0, 10, 0, 58)
                    DropdownList.BackgroundColor3 = Theme.Secondary
                    DropdownList.BorderSizePixel = 0
                    DropdownList.Visible = false
                    DropdownList.Parent = DropdownFrame
                    CreateRound(DropdownList, 4)

                    local DropdownListLayout = Instance.new("UIListLayout")
                    DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    DropdownListLayout.Padding = UDim.new(0, 2)
                    DropdownListLayout.Parent = DropdownList

                    local DropdownListPadding = Instance.new("UIPadding")
                    DropdownListPadding.PaddingTop = UDim.new(0, 5)
                    DropdownListPadding.PaddingBottom = UDim.new(0, 5)
                    DropdownListPadding.Parent = DropdownList

                    local opened = false

                    DropdownButton.MouseButton1Click:Connect(function()
                        opened = not opened
                        
                        if opened then
                            DropdownList.Visible = true
                            local listHeight = math.min(#options * 27 + 10, 150)
                            DropdownList.Size = UDim2.new(1, -20, 0, listHeight)
                            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 60 + listHeight + 5)})
                            Tween(DropdownIcon, {Rotation = 180})
                        else
                            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 60)})
                            Tween(DropdownIcon, {Rotation = 0})
                            wait(0.3)
                            DropdownList.Visible = false
                        end
                    end)

                    for _, option in ipairs(options) do
                        local OptionButton = Instance.new("TextButton")
                        OptionButton.Size = UDim2.new(1, 0, 0, 25)
                        OptionButton.BackgroundColor3 = Theme.Background
                        OptionButton.BorderSizePixel = 0
                        OptionButton.Text = tostring(option)
                        OptionButton.TextColor3 = Theme.Text
                        OptionButton.TextSize = 12
                        OptionButton.Font = Enum.Font.Gotham
                        OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                        OptionButton.Parent = DropdownList
                        CreateRound(OptionButton, 4)

                        local OptionPadding = Instance.new("UIPadding")
                        OptionPadding.PaddingLeft = UDim.new(0, 10)
                        OptionPadding.Parent = OptionButton

                        OptionButton.MouseEnter:Connect(function()
                            Tween(OptionButton, {BackgroundColor3 = Theme.Accent})
                        end)

                        OptionButton.MouseLeave:Connect(function()
                            Tween(OptionButton, {BackgroundColor3 = Theme.Background})
                        end)

                        OptionButton.MouseButton1Click:Connect(function()
                            DropdownButton.Text = tostring(option)
                            opened = false
                            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 60)})
                            Tween(DropdownIcon, {Rotation = 0})
                            wait(0.3)
                            DropdownList.Visible = false
                            pcall(callback, option)
                        end)
                    end

                    return DropdownFrame
                end

                function MenuObject:addChangelog(text)
                    local ChangelogLabel = Instance.new("TextLabel")
                    ChangelogLabel.Size = UDim2.new(1, 0, 0, 25)
                    ChangelogLabel.BackgroundColor3 = Theme.Background
                    ChangelogLabel.BorderSizePixel = 0
                    ChangelogLabel.Text = "• " .. text
                    ChangelogLabel.TextColor3 = Theme.TextDark
                    ChangelogLabel.TextSize = 12
                    ChangelogLabel.Font = Enum.Font.Gotham
                    ChangelogLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ChangelogLabel.TextWrapped = true
                    ChangelogLabel.Parent = MenuContent
                    CreateRound(ChangelogLabel, 4)

                    local ChangelogPadding = Instance.new("UIPadding")
                    ChangelogPadding.PaddingLeft = UDim.new(0, 10)
                    ChangelogPadding.Parent = ChangelogLabel

                    return ChangelogLabel
                end

                function MenuObject:addLabel(text, color)
                    color = color or Theme.Text
                    
                    local Label = Instance.new("TextLabel")
                    Label.Size = UDim2.new(1, 0, 0, 25)
                    Label.BackgroundTransparency = 1
                    Label.Text = text
                    Label.TextColor3 = color
                    Label.TextSize = 13
                    Label.Font = Enum.Font.Gotham
                    Label.TextXAlignment = Enum.TextXAlignment.Left
                    Label.TextWrapped = true
                    Label.Parent = MenuContent

                    return Label
                end

                return MenuObject
            end

            table.insert(self.Sections, SectionObject)
            return SectionObject
        end

        table.insert(WindowObject.Tabs, TabObject)
        return TabObject
    end

    -- Animation when window appears
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 450)}, 0.5)

    return WindowObject
end

return Library                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

local function Tween(object, properties, duration)
    duration = duration or 0.3
    local tween = TweenService:Create(
        object,
        TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        properties
    )
    tween:Play()
    return tween
end

local function CreateRound(parent, radius)
    radius = radius or 8
    local round = Instance.new("UICorner")
    round.CornerRadius = UDim.new(0, radius)
    round.Parent = parent
    return round
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Border
    stroke.Thickness = thickness or 1
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = parent
    return stroke
end

-- Window Creation
function Library:CreateWindow(title)
    title = title or "KimP Gaming"
    
    -- Main ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KimPLibrary"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    
    if gethui then
        ScreenGui.Parent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    else
        ScreenGui.Parent = CoreGui
    end

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 650, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
    MainFrame.BackgroundColor3 = Theme.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    CreateRound(MainFrame, 12)
    CreateStroke(MainFrame, Theme.Border, 2)

    -- Shadow Effect
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = MainFrame
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0, -15, 0, -15)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Theme.Secondary
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    CreateRound(TitleBar, 12)

    local TitleBarBottom = Instance.new("Frame")
    TitleBarBottom.Size = UDim2.new(1, 0, 0, 12)
    TitleBarBottom.Position = UDim2.new(0, 0, 1, -12)
    TitleBarBottom.BackgroundColor3 = Theme.Secondary
    TitleBarBottom.BorderSizePixel = 0
    TitleBarBottom.Parent = TitleBar

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Theme.Text
    TitleLabel.TextSize = 16
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar

    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 5)
    CloseButton.BackgroundColor3 = Theme.Error
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Theme.Text
    CloseButton.TextSize = 20
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = TitleBar
    CreateRound(CloseButton, 6)

    CloseButton.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
        wait(0.3)
        ScreenGui:Destroy()
    end)

    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -70, 0, 5)
    MinimizeButton.BackgroundColor3 = Theme.Accent
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Theme.Text
    MinimizeButton.TextSize = 20
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Parent = TitleBar
    CreateRound(MinimizeButton, 6)

    local minimized = false
    local originalSize = MainFrame.Size
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 40)})
            MinimizeButton.Text = "+"
        else
            Tween(MainFrame, {Size = originalSize})
            MinimizeButton.Text = "−"
        end
    end)

    MakeDraggable(MainFrame, TitleBar)

    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 150, 1, -50)
    TabContainer.Position = UDim2.new(0, 10, 0, 45)
    TabContainer.BackgroundColor3 = Theme.Secondary
    TabContainer.BorderSizePixel = 0
    TabContainer.Parent = MainFrame
    CreateRound(TabContainer, 8)

    local TabList = Instance.new("UIListLayout")
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)
    TabList.Parent = TabContainer

    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingBottom = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)
    TabPadding.Parent = TabContainer

    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -180, 1, -50)
    ContentContainer.Position = UDim2.new(0, 170, 0, 45)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.BorderSizePixel = 0
    ContentContainer.Parent = MainFrame

    -- Window Object
    local WindowObject = {
        Tabs = {},
        CurrentTab = nil
    }

    function WindowObject:addTab(name)
        name = name or "Tab"
        name = name:gsub("#", "")
        
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.BackgroundColor3 = Theme.Background
        TabButton.BorderSizePixel = 0
        TabButton.Text = name
        TabButton.TextColor3 = Theme.TextDark
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.GothamMedium
        TabButton.Parent = TabContainer
        CreateRound(TabButton, 6)

        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = name
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 4
        TabContent.ScrollBarImageColor3 = Theme.Accent
        TabContent.Visible = false
        TabContent.Parent = ContentContainer
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)

        local TabLayout = Instance.new("UIListLayout")
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 8)
        TabLayout.Parent = TabContent

        TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y + 10)
        end)

        local TabPadding = Instance.new("UIPadding")
        TabPadding.PaddingTop = UDim.new(0, 5)
        TabPadding.PaddingLeft = UDim.new(0, 5)
        TabPadding.PaddingRight = UDim.new(0, 5)
        TabPadding.Parent = TabContent

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(WindowObject.Tabs) do
                tab.Content.Visible = false
                Tween(tab.Button, {BackgroundColor3 = Theme.Background, TextColor3 = Theme.TextDark})
            end
            
            TabContent.Visible = true
            WindowObject.CurrentTab = TabContent
            Tween(TabButton, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Text})
        end)

        if WindowObject.CurrentTab == nil then
            TabContent.Visible = true
            WindowObject.CurrentTab = TabContent
            TabButton.BackgroundColor3 = Theme.Accent
            TabButton.TextColor3 = Theme.Text
        end

        local TabObject = {
            Button = TabButton,
            Content = TabContent,
            Sections = {}
        }

        function TabObject:addSection()
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, -10, 0, 0)
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Parent = TabContent

            local SectionLayout = Instance.new("UIListLayout")
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Padding = UDim.new(0, 8)
            SectionLayout.Parent = SectionFrame

            SectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionFrame.Size = UDim2.new(1, -10, 0, SectionLayout.AbsoluteContentSize.Y)
            end)

            local SectionObject = {}

            function SectionObject:addMenu(name)
                name = name or "Menu"
                name = name:gsub("#", "")
                
                local MenuFrame = Instance.new("Frame")
                MenuFrame.Size = UDim2.new(1, 0, 0, 0)
                MenuFrame.BackgroundColor3 = Theme.Secondary
                MenuFrame.BorderSizePixel = 0
                MenuFrame.Parent = SectionFrame
                CreateRound(MenuFrame, 8)

                local MenuHeader = Instance.new("TextLabel")
                MenuHeader.Size = UDim2.new(1, -20, 0, 30)
                MenuHeader.Position = UDim2.new(0, 10, 0, 5)
                MenuHeader.BackgroundTransparency = 1
                MenuHeader.Text = name
                MenuHeader.TextColor3 = Theme.Text
                MenuHeader.TextSize = 14
                MenuHeader.Font = Enum.Font.GothamBold
                MenuHeader.TextXAlignment = Enum.TextXAlignment.Left
                MenuHeader.Parent = MenuFrame

                local MenuContent = Instance.new("Frame")
                MenuContent.Size = UDim2.new(1, -20, 1, -40)
                MenuContent.Position = UDim2.new(0, 10, 0, 35)
                MenuContent.BackgroundTransparency = 1
                MenuContent.Parent = MenuFrame

                local MenuLayout = Instance.new("UIListLayout")
                MenuLayout.SortOrder = Enum.SortOrder.LayoutOrder
                MenuLayout.Padding = UDim.new(0, 8)
                MenuLayout.Parent = MenuContent

                MenuLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    MenuFrame.Size = UDim2.new(1, 0, 0, MenuLayout.AbsoluteContentSize.Y + 45)
                end)

                local MenuObject = {}

                function MenuObject:addButton(name, callback)
                    callback = callback or function() end
                    
                    local Button = Instance.new("TextButton")
                    Button.Size = UDim2.new(1, 0, 0, 35)
                    Button.BackgroundColor3 = Theme.Background
                    Button.BorderSizePixel = 0
                    Button.Text = name
                    Button.TextColor3 = Theme.Text
                    Button.TextSize = 13
                    Button.Font = Enum.Font.Gotham
                    Button.Parent = MenuContent
                    CreateRound(Button, 6)

                    Button.MouseEnter:Connect(function()
                        Tween(Button, {BackgroundColor3 = Theme.Accent})
                    end)

                    Button.MouseLeave:Connect(function()
                        Tween(Button, {BackgroundColor3 = Theme.Background})
                    end)

                    Button.MouseButton1Click:Connect(function()
                        Tween(Button, {BackgroundColor3 = Theme.Success}, 0.1)
                        wait(0.1)
                        Tween(Button, {BackgroundColor3 = Theme.Accent}, 0.1)
                        pcall(callback)
                    end)

                    return Button
                end

                function MenuObject:addToggle(name, default, callback)
                    default = default or false
                    callback = callback or function() end
                    
                    local ToggleFrame = Instance.new("Frame")
                    ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
                    ToggleFrame.BackgroundColor3 = Theme.Background
                    ToggleFrame.BorderSizePixel = 0
                    ToggleFrame.Parent = MenuContent
                    CreateRound(ToggleFrame, 6)

                    local ToggleLabel = Instance.new("TextLabel")
                    ToggleLabel.Size = UDim2.new(1, -50, 1, 0)
                    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
                    ToggleLabel.BackgroundTransparency = 1
                    ToggleLabel.Text = name
                    ToggleLabel.TextColor3 = Theme.Text
                    ToggleLabel.TextSize = 13
                    ToggleLabel.Font = Enum.Font.Gotham
                    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ToggleLabel.Parent = ToggleFrame

                    local ToggleButton = Instance.new("TextButton")
                    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
                    ToggleButton.Position = UDim2.new(1, -45, 0.5, -10)
                    ToggleButton.BackgroundColor3 = default and Theme.Success or Theme.Border
                    ToggleButton.BorderSizePixel = 0
                    ToggleButton.Text = ""
                    ToggleButton.Parent = ToggleFrame
                    CreateRound(ToggleButton, 10)

                    local ToggleCircle = Instance.new("Frame")
                    ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
                    ToggleCircle.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                    ToggleCircle.BackgroundColor3 = Theme.Text
                    ToggleCircle.BorderSizePixel = 0
                    ToggleCircle.Parent = ToggleButton
                    CreateRound(ToggleCircle, 8)

                    local toggled = default

                    ToggleButton.MouseButton1Click:Connect(function()
                        toggled = not toggled
                        
                        Tween(ToggleButton, {BackgroundColor3 = toggled and Theme.Success or Theme.Border})
                        Tween(ToggleCircle, {Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)})
                        
                        pcall(callback, toggled)
                    end)

                    return ToggleButton
                end

                function MenuObject:addTextbox(name, default, callback)
                    default = default or ""
                    callback = callback or function() end
                    
                    local TextboxFrame = Instance.new("Frame")
                    TextboxFrame.Size = UDim2.new(1, 0, 0, 60)
                    TextboxFrame.BackgroundColor3 = Theme.Background
                    TextboxFrame.BorderSizePixel = 0
                    TextboxFrame.Parent = MenuContent
                    CreateRound(TextboxFrame, 6)

                    local TextboxLabel = Instance.new("TextLabel")
                    TextboxLabel.Size = UDim2.new(1, -20, 0, 20)
                    TextboxLabel.Position = UDim2.new(0, 10, 0, 5)
                    TextboxLabel.BackgroundTransparency = 1
                    TextboxLabel.Text = name
                    TextboxLabel.TextColor3 = Theme.Text
                    TextboxLabel.TextSize = 13
                    TextboxLabel.Font = Enum.Font.Gotham
                    TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextboxLabel.Parent = TextboxFrame

                    local Textbox = Instance.new("TextBox")
                    Textbox.Size = UDim2.new(1, -20, 0, 25)
                    Textbox.Position = UDim2.new(0, 10, 0, 28)
                    Textbox.BackgroundColor3 = Theme.Secondary
                    Textbox.BorderSizePixel = 0
                    Textbox.Text = tostring(default)
                    Textbox.PlaceholderText = "Enter value..."
                    Textbox.TextColor3 = Theme.Text
                    Textbox.PlaceholderColor3 = Theme.TextDark
                    Textbox.TextSize = 12
                    Textbox.Font = Enum.Font.Gotham
                    Textbox.ClearTextOnFocus = false
                    Textbox.Parent = TextboxFrame
                    CreateRound(Textbox, 4)

                    Textbox.FocusLost:Connect(function(enter)
                        if enter then
                            pcall(callback, Textbox.Text)
                        end
                    end)

                    return Textbox
                end

                function MenuObject:addSlider(name, min, max, default, callback)
                    min = min or 0
                    max = max or 100
                    default = default or min
                    callback = callback or function() end
                    
                    local SliderFrame = Instance.new("Frame")
                    SliderFrame.Size = UDim2.new(1, 0, 0, 60)
                    SliderFrame.BackgroundColor3 = Theme.Background
                    SliderFrame.BorderSizePixel = 0
                    SliderFrame.Parent = MenuContent
                    CreateRound(SliderFrame, 6)

                    local SliderLabel = Instance.new("TextLabel")
                    SliderLabel.Size = UDim2.new(1, -60, 0, 20)
                    SliderLabel.Position = UDim2.new(0, 10, 0, 5)
                    SliderLabel.BackgroundTransparency = 1
                    SliderLabel.Text = name
                    SliderLabel.TextColor3 = Theme.Text
                    SliderLabel.TextSize = 13
                    SliderLabel.Font = Enum.Font.Gotham
                    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                    SliderLabel.Parent = SliderFrame

                    local SliderValue = Instance.new("TextLabel")
                    SliderValue.Size = UDim2.new(0, 50, 0, 20)
                    SliderValue.Position = UDim2.new(1, -55, 0, 5)
                    SliderValue.BackgroundTransparency = 1
                    SliderValue.Text = tostring(default)
                    SliderValue.TextColor3 = Theme.Accent
                    SliderValue.TextSize = 13
                    SliderValue.Font = Enum.Font.GothamBold
                    SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                    SliderValue.Parent = SliderFrame

                    local SliderBar = Instance.new("Frame")
                    SliderBar.Size = UDim2.new(1, -20, 0, 6)
                    SliderBar.Position = UDim2.new(0, 10, 0, 35)
                    SliderBar.BackgroundColor3 = Theme.Secondary
                    SliderBar.BorderSizePixel = 0
                    SliderBar.Parent = SliderFrame
                    CreateRound(SliderBar, 3)

                    local SliderFill = Instance.new("Frame")
                    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
                    SliderFill.BackgroundColor3 = Theme.Accent
                    SliderFill.BorderSizePixel = 0
                    SliderFill.Parent = SliderBar
                    CreateRound(SliderFill, 3)

                    local SliderButton = Instance.new("TextButton")
                    SliderButton.Size = UDim2.new(0, 14, 0, 14)
                    SliderButton.Position = UDim2.new(1, -7, 0.5, -7)
                    SliderButton.BackgroundColor3 = Theme.Text
                    SliderButton.BorderSizePixel = 0
                    SliderButton.Text = ""
                    SliderButton.Parent = SliderFill
                    CreateRound(SliderButton, 7)

                    local dragging = false

                    local function updateSlider(input)
                        local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                        local value = math.floor(min + (max - min) * pos)
                        
                        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                        SliderValue.Text = tostring(value)
                        
                        pcall(callback, value)
                    end

                    SliderButton.MouseButton1Down:Connect(function()
                        dragging = true
                    end)

                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)

                    UserInputService.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            updateSlider(input)
                        end
                    end)

                    SliderBar.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            updateSlider(input)
                        end
                    end)

                    return SliderFrame
                end

                function MenuObject:addDropdown(name, options, default, callback)
                    options = options or {}
                    default = default or options[1] or ""
                    callback = callback or function() end
                    
                    local DropdownFrame = Instance.new("Frame")
                    DropdownFrame.Size = UDim2.new(1, 0, 0, 60)
                    DropdownFrame.BackgroundColor3 = Theme.Background
                    DropdownFrame.BorderSizePixel = 0
                    DropdownFrame.Parent = MenuContent
                    CreateRound(DropdownFrame, 6)
                    DropdownFrame.ClipsDescendants = true

                    local DropdownLabel = Instance.new("TextLabel")
                    DropdownLabel.Size = UDim2.new(1, -20, 0, 20)
                    DropdownLabel.Position = UDim2.new(0, 10, 0, 5)
                    DropdownLabel.BackgroundTransparency = 1
                    DropdownLabel.Text = name
                    DropdownLabel.TextColor3 = Theme.Text
                    DropdownLabel.TextSize = 13
                    DropdownLabel.Font = Enum.Font.Gotham
                    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownLabel.Parent = DropdownFrame

                    local DropdownButton = Instance.new("TextButton")
                    DropdownButton.Size = UDim2.new(1, -20, 0, 25)
                    DropdownButton.Position = UDim2.new(0, 10, 0, 28)
                    DropdownButton.BackgroundColor3 = Theme.Secondary
                    DropdownButton.BorderSizePixel = 0
                    DropdownButton.Text = default
                    DropdownButton.TextColor3 = Theme.Text
                    DropdownButton.TextSize = 12
                    DropdownButton.Font = Enum.Font.Gotham
                    DropdownButton.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownButton.Parent = DropdownFrame
                    CreateRound(DropdownButton, 4)

                    local DropdownPadding = Instance.new("UIPadding")
                    DropdownPadding.PaddingLeft = UDim.new(0, 10)
                    DropdownPadding.Parent = DropdownButton

                    local DropdownIcon = Instance.new("TextLabel")
                    DropdownIcon.Size = UDim2.new(0, 20, 1, 0)
                    DropdownIcon.Position = UDim2.new(1, -25, 0, 0)
                    DropdownIcon.BackgroundTransparency = 1
                    DropdownIcon.Text = "▼"
                    DropdownIcon.TextColor3 = Theme.TextDark
                    DropdownIcon.TextSize = 10
                    DropdownIcon.Font = Enum.Font.Gotham
                    DropdownIcon.Parent = DropdownButton

                    local DropdownList = Instance.new("Frame")
                    DropdownList.Size = UDim2.new(1, -20, 0, 0)
                    DropdownList.Position = UDim2.new(0, 10, 0, 58)
                    DropdownList.BackgroundColor3 = Theme.Secondary
                    DropdownList.BorderSizePixel = 0
                    DropdownList.Visible = false
                    DropdownList.Parent = DropdownFrame
                    CreateRound(DropdownList, 4)

                    local DropdownListLayout = Instance.new("UIListLayout")
                    DropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    DropdownListLayout.Padding = UDim.new(0, 2)
                    DropdownListLayout.Parent = DropdownList

                    local DropdownListPadding = Instance.new("UIPadding")
                    DropdownListPadding.PaddingTop = UDim.new(0, 5)
                    DropdownListPadding.PaddingBottom = UDim.new(0, 5)
                    DropdownListPadding.Parent = DropdownList

                    local opened = false

                    DropdownButton.MouseButton1Click:Connect(function()
                        opened = not opened
                        
                        if opened then
                            DropdownList.Visible = true
                            local listHeight = math.min(#options * 27 + 10, 150)
                            DropdownList.Size = UDim2.new(1, -20, 0, listHeight)
                            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 60 + listHeight + 5)})
                            Tween(DropdownIcon, {Rotation = 180})
                        else
                            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 60)})
                            Tween(DropdownIcon, {Rotation = 0})
                            wait(0.3)
                            DropdownList.Visible = false
                        end
                    end)

                    for _, option in ipairs(options) do
                        local OptionButton = Instance.new("TextButton")
                        OptionButton.Size = UDim2.new(1, 0, 0, 25)
                        OptionButton.BackgroundColor3 = Theme.Background
                        OptionButton.BorderSizePixel = 0
                        OptionButton.Text = tostring(option)
                        OptionButton.TextColor3 = Theme.Text
                        OptionButton.TextSize = 12
                        OptionButton.Font = Enum.Font.Gotham
                        OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                        OptionButton.Parent = DropdownList
                        CreateRound(OptionButton, 4)

                        local OptionPadding = Instance.new("UIPadding")
                        OptionPadding.PaddingLeft = UDim.new(0, 10)
                        OptionPadding.Parent = OptionButton

                        OptionButton.MouseEnter:Connect(function()
                            Tween(OptionButton, {BackgroundColor3 = Theme.Accent})
                        end)

                        OptionButton.MouseLeave:Connect(function()
                            Tween(OptionButton, {BackgroundColor3 = Theme.Background})
                        end)

                        OptionButton.MouseButton1Click:Connect(function()
                            DropdownButton.Text = tostring(option)
                            opened = false
                            Tween(DropdownFrame, {Size = UDim2.new(1, 0, 0, 60)})
                            Tween(DropdownIcon, {Rotation = 0})
                            wait(0.3)
                            DropdownList.Visible = false
                            pcall(callback, option)
                        end)
                    end

                    return DropdownFrame
                end

                function MenuObject:addChangelog(text)
                    local ChangelogLabel = Instance.new("TextLabel")
                    ChangelogLabel.Size = UDim2.new(1, 0, 0, 25)
                    ChangelogLabel.BackgroundColor3 = Theme.Background
                    ChangelogLabel.BorderSizePixel = 0
                    ChangelogLabel.Text = "• " .. text
                    ChangelogLabel.TextColor3 = Theme.TextDark
                    ChangelogLabel.TextSize = 12
                    ChangelogLabel.Font = Enum.Font.Gotham
                    ChangelogLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ChangelogLabel.TextWrapped = true
                    ChangelogLabel.Parent = MenuContent
                    CreateRound(ChangelogLabel, 4)

                    local ChangelogPadding = Instance.new("UIPadding")
                    ChangelogPadding.PaddingLeft = UDim.new(0, 10)
                    ChangelogPadding.Parent = ChangelogLabel

                    return ChangelogLabel
                end

                function MenuObject:addLabel(text, color)
                    color = color or Theme.Text
                    
                    local Label = Instance.new("TextLabel")
                    Label.Size = UDim2.new(1, 0, 0, 25)
                    Label.BackgroundTransparency = 1
                    Label.Text = text
                    Label.TextColor3 = color
                    Label.TextSize = 13
                    Label.Font = Enum.Font.Gotham
                    Label.TextXAlignment = Enum.TextXAlignment.Left
                    Label.TextWrapped = true
                    Label.Parent = MenuContent

                    return Label
                end

                return MenuObject
            end

            table.insert(self.Sections, SectionObject)
            return SectionObject
        end

        table.insert(WindowObject.Tabs, TabObject)
        return TabObject
    end

    -- Animation when window appears
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 450)}, 0.5)

    return WindowObject
end

return Library
