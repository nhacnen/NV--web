-- KimP Gaming UI Library - Fixed Version
-- Thay thế: https://raw.githubusercontent.com/VanThanhIOS/OniiChanVanThanhIOS/refs/heads/main/main.txt

local TweenService = game:GetService("TweenService")

local Library = {}

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KimPGamingUI"
    ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 600, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame
    
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = Color3.fromRGB(0, 170, 255)
    UIStroke.Thickness = 2
    UIStroke.Parent = MainFrame
    
    -- Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Header.Parent = MainFrame
    
    local HeaderCorner = Instance.new("UICorner")
    HeaderCorner.CornerRadius = UDim.new(0, 8)
    HeaderCorner.Parent = Header
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0.7, 0, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = title or "KimP Gaming"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 20
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Parent = Header
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseButton
    
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    -- Tab Container
    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(0, 150, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    TabContainer.Parent = MainFrame
    
    local TabContainerCorner = Instance.new("UICorner")
    TabContainerCorner.CornerRadius = UDim.new(0, 8)
    TabContainerCorner.Parent = TabContainer
    
    -- Content Container
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Name = "ContentContainer"
    ContentContainer.Size = UDim2.new(1, -150, 1, -40)
    ContentContainer.Position = UDim2.new(0, 150, 0, 40)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ClipsDescendants = true
    ContentContainer.Parent = MainFrame
    
    local ContentScrolling = Instance.new("ScrollingFrame")
    ContentScrolling.Name = "ContentScrolling"
    ContentScrolling.Size = UDim2.new(1, 0, 1, 0)
    ContentScrolling.BackgroundTransparency = 1
    ContentScrolling.BorderSizePixel = 0
    ContentScrolling.ScrollBarThickness = 5
    ContentScrolling.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
    ContentScrolling.Parent = ContentContainer
    
    local ContentLayout = Instance.new("UIListLayout")
    ContentLayout.Parent = ContentScrolling
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 10)
    
    local window = {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        TabContainer = TabContainer,
        ContentContainer = ContentScrolling,
        Tabs = {},
        CurrentTab = nil
    }
    
    -- Hiệu ứng hover
    local function AddHoverEffect(button, normalColor, hoverColor)
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = hoverColor
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = normalColor
            }):Play()
        end)
    end
    
    AddHoverEffect(CloseButton, Color3.fromRGB(255, 60, 60), Color3.fromRGB(255, 90, 90))
    
    -- Thêm tab
    function window:addTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "Tab"
        TabButton.Size = UDim2.new(1, -10, 0, 40)
        TabButton.Position = UDim2.new(0, 5, 0, (#self.Tabs * 45) + 5)
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.Gotham
        TabButton.TextWrapped = true
        TabButton.Parent = self.TabContainer
        
        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 6)
        TabButtonCorner.Parent = TabButton
        
        local TabButtonStroke = Instance.new("UIStroke")
        TabButtonStroke.Color = Color3.fromRGB(60, 60, 70)
        TabButtonStroke.Thickness = 1
        TabButtonStroke.Parent = TabButton
        
        local TabContent = Instance.new("Frame")
        TabContent.Name = name .. "Content"
        TabContent.Size = UDim2.new(1, 0, 0, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = false
        TabContent.Parent = self.ContentContainer
        
        local TabLayout = Instance.new("UIListLayout")
        TabLayout.Parent = TabContent
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 10)
        
        local TabPadding = Instance.new("UIPadding")
        TabPadding.Parent = TabContent
        TabPadding.PaddingLeft = UDim.new(0, 5)
        TabPadding.PaddingRight = UDim.new(0, 5)
        TabPadding.PaddingTop = UDim.new(0, 5)
        TabPadding.PaddingBottom = UDim.new(0, 5)
        
        local tab = {
            Name = name,
            Button = TabButton,
            Content = TabContent,
            Sections = {}
        }
        
        table.insert(self.Tabs, tab)
        
        AddHoverEffect(TabButton, Color3.fromRGB(50, 50, 60), Color3.fromRGB(0, 170, 255))
        
        TabButton.MouseButton1Click:Connect(function()
            self:SwitchTab(tab)
        end)
        
        if #self.Tabs == 1 then
            self:SwitchTab(tab)
        end
        
        -- Thêm section
        function tab:addSection(name)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Name = name .. "Section"
            SectionFrame.Size = UDim2.new(1, 0, 0, 0)
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.LayoutOrder = #self.Sections + 1
            SectionFrame.Parent = self.Content
            SectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "Title"
            SectionTitle.Size = UDim2.new(1, 0, 0, 30)
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Text = name
            SectionTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
            SectionTitle.TextSize = 16
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            SectionTitle.Parent = SectionFrame
            
            local SectionContent = Instance.new("Frame")
            SectionContent.Name = "Content"
            SectionContent.Size = UDim2.new(1, 0, 0, 0)
            SectionContent.Position = UDim2.new(0, 0, 0, 35)
            SectionContent.BackgroundTransparency = 1
            SectionContent.Parent = SectionFrame
            SectionContent.AutomaticSize = Enum.AutomaticSize.Y
            
            local SectionLayout = Instance.new("UIListLayout")
            SectionLayout.Parent = SectionContent
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Padding = UDim.new(0, 10)
            
            local section = {
                Name = name,
                Frame = SectionFrame,
                Content = SectionContent,
                Menus = {}
            }
            
            table.insert(self.Sections, section)
            
            -- Thêm menu
            function section:addMenu(name)
                local MenuFrame = Instance.new("Frame")
                MenuFrame.Name = name .. "Menu"
                MenuFrame.Size = UDim2.new(1, 0, 0, 0)
                MenuFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                MenuFrame.LayoutOrder = #self.Menus + 1
                MenuFrame.Parent = self.Content
                MenuFrame.AutomaticSize = Enum.AutomaticSize.Y
                
                local MenuCorner = Instance.new("UICorner")
                MenuCorner.CornerRadius = UDim.new(0, 8)
                MenuCorner.Parent = MenuFrame
                
                local MenuStroke = Instance.new("UIStroke")
                MenuStroke.Color = Color3.fromRGB(60, 60, 70)
                MenuStroke.Thickness = 1
                MenuStroke.Parent = MenuFrame
                
                local MenuPadding = Instance.new("UIPadding")
                MenuPadding.Parent = MenuFrame
                MenuPadding.PaddingLeft = UDim.new(0, 10)
                MenuPadding.PaddingRight = UDim.new(0, 10)
                MenuPadding.PaddingTop = UDim.new(0, 10)
                MenuPadding.PaddingBottom = UDim.new(0, 10)
                
                local MenuTitle = Instance.new("TextLabel")
                MenuTitle.Name = "Title"
                MenuTitle.Size = UDim2.new(1, 0, 0, 25)
                MenuTitle.BackgroundTransparency = 1
                MenuTitle.Text = name
                MenuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                MenuTitle.TextSize = 16
                MenuTitle.Font = Enum.Font.GothamBold
                MenuTitle.TextXAlignment = Enum.TextXAlignment.Left
                MenuTitle.Parent = MenuFrame
                
                local MenuContent = Instance.new("Frame")
                MenuContent.Name = "Content"
                MenuContent.Size = UDim2.new(1, 0, 0, 0)
                MenuContent.Position = UDim2.new(0, 0, 0, 30)
                MenuContent.BackgroundTransparency = 1
                MenuContent.Parent = MenuFrame
                MenuContent.AutomaticSize = Enum.AutomaticSize.Y
                
                local MenuLayout = Instance.new("UIListLayout")
                MenuLayout.Parent = MenuContent
                MenuLayout.SortOrder = Enum.SortOrder.LayoutOrder
                MenuLayout.Padding = UDim.new(0, 10)
                
                local menu = {
                    Name = name,
                    Frame = MenuFrame,
                    Content = MenuContent,
                    Elements = {}
                }
                
                table.insert(self.Menus, menu)
                
                -- Thêm button
                function menu:addButton(text, callback)
                    local Button = Instance.new("TextButton")
                    Button.Name = text .. "Button"
                    Button.Size = UDim2.new(1, 0, 0, 35)
                    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                    Button.Text = text
                    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Button.TextSize = 14
                    Button.Font = Enum.Font.Gotham
                    Button.LayoutOrder = #self.Elements + 1
                    Button.Parent = self.Content
                    
                    local ButtonCorner = Instance.new("UICorner")
                    ButtonCorner.CornerRadius = UDim.new(0, 6)
                    ButtonCorner.Parent = Button
                    
                    local ButtonStroke = Instance.new("UIStroke")
                    ButtonStroke.Color = Color3.fromRGB(0, 170, 255)
                    ButtonStroke.Thickness = 1
                    ButtonStroke.Parent = Button
                    
                    AddHoverEffect(Button, Color3.fromRGB(50, 50, 60), Color3.fromRGB(0, 170, 255))
                    
                    Button.MouseButton1Click:Connect(function()
                        if callback then
                            callback()
                        end
                    end)
                    
                    table.insert(self.Elements, Button)
                    return Button
                end
                
                -- Thêm toggle
                function menu:addToggle(text, defaultValue, callback)
                    local ToggleFrame = Instance.new("Frame")
                    ToggleFrame.Name = text .. "Toggle"
                    ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
                    ToggleFrame.BackgroundTransparency = 1
                    ToggleFrame.LayoutOrder = #self.Elements + 1
                    ToggleFrame.Parent = self.Content
                    
                    local ToggleButton = Instance.new("TextButton")
                    ToggleButton.Name = "Toggle"
                    ToggleButton.Size = UDim2.new(0, 60, 0, 30)
                    ToggleButton.Position = UDim2.new(1, -65, 0.5, -15)
                    ToggleButton.BackgroundColor3 = defaultValue and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(50, 50, 60)
                    ToggleButton.Text = defaultValue and "ON" or "OFF"
                    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleButton.TextSize = 12
                    ToggleButton.Font = Enum.Font.GothamBold
                    ToggleButton.Parent = ToggleFrame
                    
                    local ToggleCorner = Instance.new("UICorner")
                    ToggleCorner.CornerRadius = UDim.new(0, 15)
                    ToggleCorner.Parent = ToggleButton
                    
                    local ToggleStroke = Instance.new("UIStroke")
                    ToggleStroke.Color = Color3.fromRGB(0, 170, 255)
                    ToggleStroke.Thickness = 1
                    ToggleStroke.Parent = ToggleButton
                    
                    local ToggleLabel = Instance.new("TextLabel")
                    ToggleLabel.Name = "Label"
                    ToggleLabel.Size = UDim2.new(1, -70, 1, 0)
                    ToggleLabel.BackgroundTransparency = 1
                    ToggleLabel.Text = text
                    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleLabel.TextSize = 14
                    ToggleLabel.Font = Enum.Font.Gotham
                    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    ToggleLabel.Parent = ToggleFrame
                    
                    local state = defaultValue or false
                    
                    ToggleButton.MouseButton1Click:Connect(function()
                        state = not state
                        ToggleButton.Text = state and "ON" or "OFF"
                        TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                            BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(50, 50, 60)
                        }):Play()
                        
                        if callback then
                            callback(state)
                        end
                    end)
                    
                    table.insert(self.Elements, ToggleFrame)
                    return ToggleFrame
                end
                
                -- Thêm textbox
                function menu:addTextbox(text, defaultValue, callback)
                    local TextboxFrame = Instance.new("Frame")
                    TextboxFrame.Name = text .. "Textbox"
                    TextboxFrame.Size = UDim2.new(1, 0, 0, 60)
                    TextboxFrame.BackgroundTransparency = 1
                    TextboxFrame.LayoutOrder = #self.Elements + 1
                    TextboxFrame.Parent = self.Content
                    
                    local TextboxLabel = Instance.new("TextLabel")
                    TextboxLabel.Name = "Label"
                    TextboxLabel.Size = UDim2.new(1, 0, 0, 20)
                    TextboxLabel.BackgroundTransparency = 1
                    TextboxLabel.Text = text
                    TextboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextboxLabel.TextSize = 14
                    TextboxLabel.Font = Enum.Font.Gotham
                    TextboxLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextboxLabel.Parent = TextboxFrame
                    
                    local Textbox = Instance.new("TextBox")
                    Textbox.Name = "Input"
                    Textbox.Size = UDim2.new(1, 0, 0, 35)
                    Textbox.Position = UDim2.new(0, 0, 0, 25)
                    Textbox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                    Textbox.Text = tostring(defaultValue or "")
                    Textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Textbox.TextSize = 14
                    Textbox.Font = Enum.Font.Gotham
                    Textbox.PlaceholderText = "Enter value..."
                    Textbox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
                    Textbox.ClearTextOnFocus = false
                    Textbox.Parent = TextboxFrame
                    
                    local TextboxCorner = Instance.new("UICorner")
                    TextboxCorner.CornerRadius = UDim.new(0, 6)
                    TextboxCorner.Parent = Textbox
                    
                    local TextboxStroke = Instance.new("UIStroke")
                    TextboxStroke.Color = Color3.fromRGB(0, 170, 255)
                    TextboxStroke.Thickness = 1
                    TextboxStroke.Parent = Textbox
                    
                    local TextboxPadding = Instance.new("UIPadding")
                    TextboxPadding.Parent = Textbox
                    TextboxPadding.PaddingLeft = UDim.new(0, 10)
                    TextboxPadding.PaddingRight = UDim.new(0, 10)
                    
                    Textbox.FocusLost:Connect(function(enterPressed)
                        if callback then
                            callback(Textbox.Text)
                        end
                    end)
                    
                    table.insert(self.Elements, TextboxFrame)
                    return Textbox
                end
                
                -- Thêm dropdown
                function menu:addDropdown(text, defaultValue, options, callback)
                    local DropdownFrame = Instance.new("Frame")
                    DropdownFrame.Name = text .. "Dropdown"
                    DropdownFrame.Size = UDim2.new(1, 0, 0, 60)
                    DropdownFrame.BackgroundTransparency = 1
                    DropdownFrame.LayoutOrder = #self.Elements + 1
                    DropdownFrame.Parent = self.Content
                    
                    local DropdownLabel = Instance.new("TextLabel")
                    DropdownLabel.Name = "Label"
                    DropdownLabel.Size = UDim2.new(1, 0, 0, 20)
                    DropdownLabel.BackgroundTransparency = 1
                    DropdownLabel.Text = text
                    DropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownLabel.TextSize = 14
                    DropdownLabel.Font = Enum.Font.Gotham
                    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownLabel.Parent = DropdownFrame
                    
                    local DropdownButton = Instance.new("TextButton")
                    DropdownButton.Name = "DropdownButton"
                    DropdownButton.Size = UDim2.new(1, 0, 0, 35)
                    DropdownButton.Position = UDim2.new(0, 0, 0, 25)
                    DropdownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                    DropdownButton.Text = defaultValue or "Select..."
                    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownButton.TextSize = 14
                    DropdownButton.Font = Enum.Font.Gotham
                    DropdownButton.Parent = DropdownFrame
                    
                    local DropdownCorner = Instance.new("UICorner")
                    DropdownCorner.CornerRadius = UDim.new(0, 6)
                    DropdownCorner.Parent = DropdownButton
                    
                    local DropdownStroke = Instance.new("UIStroke")
                    DropdownStroke.Color = Color3.fromRGB(0, 170, 255)
                    DropdownStroke.Thickness = 1
                    DropdownStroke.Parent = DropdownButton
                    
                    local DropdownList = Instance.new("Frame")
                    DropdownList.Name = "DropdownList"
                    DropdownList.Size = UDim2.new(1, 0, 0, 0)
                    DropdownList.Position = UDim2.new(0, 0, 0, 65)
                    DropdownList.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                    DropdownList.Visible = false
                    DropdownList.ClipsDescendants = true
                    DropdownList.Parent = DropdownFrame
                    
                    local ListCorner = Instance.new("UICorner")
                    ListCorner.CornerRadius = UDim.new(0, 6)
                    ListCorner.Parent = DropdownList
                    
                    local ListStroke = Instance.new("UIStroke")
                    ListStroke.Color = Color3.fromRGB(0, 170, 255)
                    ListStroke.Thickness = 1
                    ListStroke.Parent = DropdownList
                    
                    local selected = defaultValue
                    local isOpen = false
                    
                    local function UpdateList()
                        for _, child in ipairs(DropdownList:GetChildren()) do
                            if child:IsA("TextButton") then
                                child:Destroy()
                            end
                        end
                        
                        for i, option in ipairs(options) do
                            local OptionButton = Instance.new("TextButton")
                            OptionButton.Name = option .. "Option"
                            OptionButton.Size = UDim2.new(1, 0, 0, 30)
                            OptionButton.Position = UDim2.new(0, 0, 0, (i-1) * 35)
                            OptionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                            OptionButton.Text = option
                            OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                            OptionButton.TextSize = 14
                            OptionButton.Font = Enum.Font.Gotham
                            OptionButton.Parent = DropdownList
                            
                            local OptionCorner = Instance.new("UICorner")
                            OptionCorner.CornerRadius = UDim.new(0, 4)
                            OptionCorner.Parent = OptionButton
                            
                            AddHoverEffect(OptionButton, Color3.fromRGB(50, 50, 60), Color3.fromRGB(0, 170, 255))
                            
                            OptionButton.MouseButton1Click:Connect(function()
                                selected = option
                                DropdownButton.Text = selected
                                isOpen = false
                                DropdownList.Visible = false
                                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                                
                                if callback then
                                    callback(selected)
                                end
                            end)
                        end
                        
                        DropdownList.Size = UDim2.new(1, 0, 0, #options * 35)
                    end
                    
                    DropdownButton.MouseButton1Click:Connect(function()
                        isOpen = not isOpen
                        DropdownList.Visible = isOpen
                        UpdateList()
                    end)
                    
                    AddHoverEffect(DropdownButton, Color3.fromRGB(50, 50, 60), Color3.fromRGB(40, 40, 50))
                    
                    table.insert(self.Elements, DropdownFrame)
                    return DropdownFrame
                end
                
                -- Thêm label
                function menu:addLabel(text)
                    local Label = Instance.new("TextLabel")
                    Label.Name = text .. "Label"
                    Label.Size = UDim2.new(1, 0, 0, 25)
                    Label.BackgroundTransparency = 1
                    Label.Text = text
                    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Label.TextSize = 14
                    Label.Font = Enum.Font.Gotham
                    Label.TextXAlignment = Enum.TextXAlignment.Left
                    Label.LayoutOrder = #self.Elements + 1
                    Label.Parent = self.Content
                    
                    local labelObj = {
                        Label = Label,
                        Refresh = function(newText)
                            Label.Text = newText
                        end
                    }
                    
                    table.insert(self.Elements, Label)
                    return labelObj
                end
                
                -- Thêm changelog
                function menu:addChangelog(text)
                    local ChangelogFrame = Instance.new("Frame")
                    ChangelogFrame.Name = "Changelog"
                    ChangelogFrame.Size = UDim2.new(1, 0, 0, 0)
                    ChangelogFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
                    ChangelogFrame.BackgroundTransparency = 0.5
                    ChangelogFrame.LayoutOrder = #self.Elements + 1
                    ChangelogFrame.Parent = self.Content
                    ChangelogFrame.AutomaticSize = Enum.AutomaticSize.Y
                    
                    local ChangelogCorner = Instance.new("UICorner")
                    ChangelogCorner.CornerRadius = UDim.new(0, 8)
                    ChangelogCorner.Parent = ChangelogFrame
                    
                    local ChangelogStroke = Instance.new("UIStroke")
                    ChangelogStroke.Color = Color3.fromRGB(0, 170, 255)
                    ChangelogStroke.Thickness = 1
                    ChangelogStroke.Parent = ChangelogFrame
                    
                    local ChangelogPadding = Instance.new("UIPadding")
                    ChangelogPadding.Parent = ChangelogFrame
                    ChangelogPadding.PaddingLeft = UDim.new(0, 10)
                    ChangelogPadding.PaddingRight = UDim.new(0, 10)
                    ChangelogPadding.PaddingTop = UDim.new(0, 10)
                    ChangelogPadding.PaddingBottom = UDim.new(0, 10)
                    
                    local ChangelogText = Instance.new("TextLabel")
                    ChangelogText.Name = "Text"
                    ChangelogText.Size = UDim2.new(1, 0, 0, 0)
                    ChangelogText.BackgroundTransparency = 1
                    ChangelogText.Text = text
                    ChangelogText.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ChangelogText.TextSize = 12
                    ChangelogText.Font = Enum.Font.Gotham
                    ChangelogText.TextWrapped = true
                    ChangelogText.TextXAlignment = Enum.TextXAlignment.Left
                    ChangelogText.TextYAlignment = Enum.TextYAlignment.Top
                    ChangelogText.AutomaticSize = Enum.AutomaticSize.Y
                    ChangelogText.Parent = ChangelogFrame
                    
                    table.insert(self.Elements, ChangelogFrame)
                    return ChangelogFrame
                end
                
                return menu
            end
            
            return section
        end
        
        return tab
    end
    
    -- Chuyển tab
    function window:SwitchTab(tab)
        if self.CurrentTab then
            self.CurrentTab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
            self.CurrentTab.Content.Visible = false
        end
        
        self.CurrentTab = tab
        tab.Button.TextColor3 = Color3.fromRGB(0, 170, 255)
        tab.Content.Visible = true
        
        -- Cập nhật kích thước scrolling frame
        wait(0.1)
        local totalHeight = 0
        for _, child in ipairs(tab.Content:GetChildren()) do
            if child:IsA("Frame") then
                totalHeight = totalHeight + child.AbsoluteSize.Y + 10
            end
        end
        self.ContentContainer.CanvasSize = UDim2.new(0, 0, 0, totalHeight)
    end
    
    return window
end

return Library    header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    header.Parent = mainFrame
    
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 8)
    headerCorner.Parent = header
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "KimP Gaming"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = header
    
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0.5, -15)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 14
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = header
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 6)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Tab container
    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Size = UDim2.new(0, 150, 1, -40)
    tabContainer.Position = UDim2.new(0, 0, 0, 40)
    tabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    tabContainer.Parent = mainFrame
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = tabContainer
    
    -- Content container
    local contentContainer = Instance.new("Frame")
    contentContainer.Name = "ContentContainer"
    contentContainer.Size = UDim2.new(1, -150, 1, -40)
    contentContainer.Position = UDim2.new(0, 150, 0, 40)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = mainFrame
    
    local window = {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        TabContainer = tabContainer,
        ContentContainer = contentContainer,
        Tabs = {},
        CurrentTab = nil
    }
    
    setmetatable(window, Library)
    
    -- Hiệu ứng hover cho nút
    local function addHoverEffect(button, normalColor, hoverColor)
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = hoverColor
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = normalColor
            }):Play()
        end)
    end
    
    addHoverEffect(closeButton, Color3.fromRGB(255, 60, 60), Color3.fromRGB(255, 90, 90))
    
    -- Tạo tab mới
    function window:addTab(name)
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name .. "Tab"
        tabButton.Size = UDim2.new(1, -10, 0, 40)
        tabButton.Position = UDim2.new(0, 5, 0, (#self.Tabs * 45) + 5)
        tabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        tabButton.Text = name
        tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        tabButton.TextSize = 14
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextWrapped = true
        tabButton.Parent = self.TabContainer
        
        local tabButtonCorner = Instance.new("UICorner")
        tabButtonCorner.CornerRadius = UDim.new(0, 6)
        tabButtonCorner.Parent = tabButton
        
        local tabButtonStroke = Instance.new("UIStroke")
        tabButtonStroke.Color = Color3.fromRGB(60, 60, 70)
        tabButtonStroke.Thickness = 1
        tabButtonStroke.Parent = tabButton
        
        local tabContent = Instance.new("Frame")
        tabContent.Name = name .. "Content"
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false
        tabContent.Parent = self.ContentContainer
        
        local tab = {
            Name = name,
            Button = tabButton,
            Content = tabContent,
            Sections = {}
        }
        
        table.insert(self.Tabs, tab)
        
        addHoverEffect(tabButton, Color3.fromRGB(45, 45, 55), Color3.fromRGB(0, 170, 255))
        
        tabButton.MouseButton1Click:Connect(function()
            self:SwitchTab(tab)
        end)
        
        if #self.Tabs == 1 then
            self:SwitchTab(tab)
        end
        
        -- Thêm section
        function tab:addSection(name)
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Name = name .. "Section"
            sectionFrame.Size = UDim2.new(1, 0, 0, 0)
            sectionFrame.BackgroundTransparency = 1
            sectionFrame.Parent = self.Content
            sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            
            local sectionTitle = Instance.new("TextLabel")
            sectionTitle.Name = "Title"
            sectionTitle.Size = UDim2.new(1, 0, 0, 25)
            sectionTitle.BackgroundTransparency = 1
            sectionTitle.Text = name
            sectionTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
            sectionTitle.TextSize = 16
            sectionTitle.Font = Enum.Font.GothamBold
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            sectionTitle.Parent = sectionFrame
            
            local sectionContent = Instance.new("Frame")
            sectionContent.Name = "Content"
            sectionContent.Size = UDim2.new(1, 0, 0, 0)
            sectionContent.Position = UDim2.new(0, 0, 0, 25)
            sectionContent.BackgroundTransparency = 1
            sectionContent.Parent = sectionFrame
            sectionContent.AutomaticSize = Enum.AutomaticSize.Y
            
            local sectionLayout = Instance.new("UIListLayout")
            sectionLayout.Parent = sectionContent
            sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            sectionLayout.Padding = UDim.new(0, 5)
            
            local section = {
                Name = name,
                Frame = sectionFrame,
                Content = sectionContent,
                Menus = {}
            }
            
            table.insert(self.Sections, section)
            
            -- Thêm menu
            function section:addMenu(name)
                local menuFrame = Instance.new("Frame")
                menuFrame.Name = name .. "Menu"
                menuFrame.Size = UDim2.new(1, 0, 0, 0)
                menuFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                menuFrame.Parent = self.Content
                menuFrame.AutomaticSize = Enum.AutomaticSize.Y
                
                local menuCorner = Instance.new("UICorner")
                menuCorner.CornerRadius = UDim.new(0, 8)
                menuCorner.Parent = menuFrame
                
                local menuStroke = Instance.new("UIStroke")
                menuStroke.Color = Color3.fromRGB(50, 50, 60)
                menuStroke.Thickness = 1
                menuStroke.Parent = menuFrame
                
                local menuPadding = Instance.new("UIPadding")
                menuPadding.PaddingLeft = UDim.new(0, 10)
                menuPadding.PaddingRight = UDim.new(0, 10)
                menuPadding.PaddingTop = UDim.new(0, 10)
                menuPadding.PaddingBottom = UDim.new(0, 10)
                menuPadding.Parent = menuFrame
                
                local menuTitle = Instance.new("TextLabel")
                menuTitle.Name = "Title"
                menuTitle.Size = UDim2.new(1, 0, 0, 25)
                menuTitle.BackgroundTransparency = 1
                menuTitle.Text = name
                menuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
                menuTitle.TextSize = 16
                menuTitle.Font = Enum.Font.GothamBold
                menuTitle.TextXAlignment = Enum.TextXAlignment.Left
                menuTitle.Parent = menuFrame
                
                local menuContent = Instance.new("Frame")
                menuContent.Name = "Content"
                menuContent.Size = UDim2.new(1, 0, 0, 0)
                menuContent.Position = UDim2.new(0, 0, 0, 30)
                menuContent.BackgroundTransparency = 1
                menuContent.Parent = menuFrame
                menuContent.AutomaticSize = Enum.AutomaticSize.Y
                
                local menuLayout = Instance.new("UIListLayout")
                menuLayout.Parent = menuContent
                menuLayout.SortOrder = Enum.SortOrder.LayoutOrder
                menuLayout.Padding = UDim.new(0, 5)
                
                local menu = {
                    Name = name,
                    Frame = menuFrame,
                    Content = menuContent,
                    ElementCount = 0
                }
                
                table.insert(self.Menus, menu)
                
                -- Thêm button
                function menu:addButton(text, callback)
                    local button = Instance.new("TextButton")
                    button.Name = text .. "Button"
                    button.Size = UDim2.new(1, 0, 0, 35)
                    button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                    button.Text = text
                    button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    button.TextSize = 14
                    button.Font = Enum.Font.Gotham
                    button.LayoutOrder = self.ElementCount
                    button.Parent = self.Content
                    
                    local buttonCorner = Instance.new("UICorner")
                    buttonCorner.CornerRadius = UDim.new(0, 6)
                    buttonCorner.Parent = button
                    
                    local buttonStroke = Instance.new("UIStroke")
                    buttonStroke.Color = Color3.fromRGB(0, 170, 255)
                    buttonStroke.Thickness = 1
                    buttonStroke.Parent = button
                    
                    addHoverEffect(button, Color3.fromRGB(45, 45, 55), Color3.fromRGB(0, 170, 255))
                    
                    button.MouseButton1Click:Connect(function()
                        if callback then
                            callback()
                        end
                    end)
                    
                    self.ElementCount = self.ElementCount + 1
                    
                    return button
                end
                
                -- Thêm toggle
                function menu:addToggle(text, defaultValue, callback)
                    local toggleFrame = Instance.new("Frame")
                    toggleFrame.Name = text .. "Toggle"
                    toggleFrame.Size = UDim2.new(1, 0, 0, 35)
                    toggleFrame.BackgroundTransparency = 1
                    toggleFrame.LayoutOrder = self.ElementCount
                    toggleFrame.Parent = self.Content
                    
                    local toggleButton = Instance.new("TextButton")
                    toggleButton.Name = "Toggle"
                    toggleButton.Size = UDim2.new(0, 60, 0, 30)
                    toggleButton.Position = UDim2.new(1, -65, 0.5, -15)
                    toggleButton.BackgroundColor3 = defaultValue and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 45, 55)
                    toggleButton.Text = defaultValue and "ON" or "OFF"
                    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggleButton.TextSize = 12
                    toggleButton.Font = Enum.Font.GothamBold
                    toggleButton.Parent = toggleFrame
                    
                    local toggleCorner = Instance.new("UICorner")
                    toggleCorner.CornerRadius = UDim.new(0, 6)
                    toggleCorner.Parent = toggleButton
                    
                    local toggleStroke = Instance.new("UIStroke")
                    toggleStroke.Color = Color3.fromRGB(0, 170, 255)
                    toggleStroke.Thickness = 1
                    toggleStroke.Parent = toggleButton
                    
                    local toggleLabel = Instance.new("TextLabel")
                    toggleLabel.Name = "Label"
                    toggleLabel.Size = UDim2.new(1, -70, 1, 0)
                    toggleLabel.BackgroundTransparency = 1
                    toggleLabel.Text = text
                    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggleLabel.TextSize = 14
                    toggleLabel.Font = Enum.Font.Gotham
                    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    toggleLabel.Parent = toggleFrame
                    
                    local state = defaultValue or false
                    
                    toggleButton.MouseButton1Click:Connect(function()
                        state = not state
                        toggleButton.Text = state and "ON" or "OFF"
                        TweenService:Create(toggleButton, TweenInfo.new(0.2), {
                            BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 45, 55)
                        }):Play()
                        
                        if callback then
                            callback(state)
                        end
                    end)
                    
                    self.ElementCount = self.ElementCount + 1
                    
                    return {
                        ToggleFrame = toggleFrame,
                        Value = state,
                        Set = function(newValue)
                            state = newValue
                            toggleButton.Text = state and "ON" or "OFF"
                            toggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(45, 45, 55)
                        end
                    }
                end
                
                -- Thêm textbox
                function menu:addTextbox(text, defaultValue, callback)
                    local textboxFrame = Instance.new("Frame")
                    textboxFrame.Name = text .. "Textbox"
                    textboxFrame.Size = UDim2.new(1, 0, 0, 60)
                    textboxFrame.BackgroundTransparency = 1
                    textboxFrame.LayoutOrder = self.ElementCount
                    textboxFrame.Parent = self.Content
                    
                    local textboxLabel = Instance.new("TextLabel")
                    textboxLabel.Name = "Label"
                    textboxLabel.Size = UDim2.new(1, 0, 0, 20)
                    textboxLabel.BackgroundTransparency = 1
                    textboxLabel.Text = text
                    textboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textboxLabel.TextSize = 14
                    textboxLabel.Font = Enum.Font.Gotham
                    textboxLabel.TextXAlignment = Enum.TextXAlignment.Left
                    textboxLabel.Parent = textboxFrame
                    
                    local textbox = Instance.new("TextBox")
                    textbox.Name = "Input"
                    textbox.Size = UDim2.new(1, 0, 0, 35)
                    textbox.Position = UDim2.new(0, 0, 0, 25)
                    textbox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                    textbox.Text = tostring(defaultValue or "")
                    textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textbox.TextSize = 14
                    textbox.Font = Enum.Font.Gotham
                    textbox.PlaceholderText = "Enter value..."
                    textbox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
                    textbox.ClearTextOnFocus = false
                    textbox.Parent = textboxFrame
                    
                    local textboxCorner = Instance.new("UICorner")
                    textboxCorner.CornerRadius = UDim.new(0, 6)
                    textboxCorner.Parent = textbox
                    
                    local textboxStroke = Instance.new("UIStroke")
                    textboxStroke.Color = Color3.fromRGB(0, 170, 255)
                    textboxStroke.Thickness = 1
                    textboxStroke.Parent = textbox
                    
                    local textboxPadding = Instance.new("UIPadding")
                    textboxPadding.PaddingLeft = UDim.new(0, 10)
                    textboxPadding.PaddingRight = UDim.new(0, 10)
                    textboxPadding.Parent = textbox
                    
                    textbox.FocusLost:Connect(function(enterPressed)
                        if callback then
                            callback(textbox.Text)
                        end
                    end)
                    
                    self.ElementCount = self.ElementCount + 1
                    
                    return textbox
                end
                
                -- Thêm dropdown
                function menu:addDropdown(text, defaultValue, options, callback)
                    local dropdownFrame = Instance.new("Frame")
                    dropdownFrame.Name = text .. "Dropdown"
                    dropdownFrame.Size = UDim2.new(1, 0, 0, 60)
                    dropdownFrame.BackgroundTransparency = 1
                    dropdownFrame.LayoutOrder = self.ElementCount
                    dropdownFrame.Parent = self.Content
                    
                    local dropdownLabel = Instance.new("TextLabel")
                    dropdownLabel.Name = "Label"
                    dropdownLabel.Size = UDim2.new(1, 0, 0, 20)
                    dropdownLabel.BackgroundTransparency = 1
                    dropdownLabel.Text = text
                    dropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropdownLabel.TextSize = 14
                    dropdownLabel.Font = Enum.Font.Gotham
                    dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                    dropdownLabel.Parent = dropdownFrame
                    
                    local dropdownButton = Instance.new("TextButton")
                    dropdownButton.Name = "DropdownButton"
                    dropdownButton.Size = UDim2.new(1, 0, 0, 35)
                    dropdownButton.Position = UDim2.new(0, 0, 0, 25)
                    dropdownButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                    dropdownButton.Text = defaultValue or "Select..."
                    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropdownButton.TextSize = 14
                    dropdownButton.Font = Enum.Font.Gotham
                    dropdownButton.Parent = dropdownFrame
                    
                    local dropdownCorner = Instance.new("UICorner")
                    dropdownCorner.CornerRadius = UDim.new(0, 6)
                    dropdownCorner.Parent = dropdownButton
                    
                    local dropdownStroke = Instance.new("UIStroke")
                    dropdownStroke.Color = Color3.fromRGB(0, 170, 255)
                    dropdownStroke.Thickness = 1
                    dropdownStroke.Parent = dropdownButton
                    
                    local dropdownList = Instance.new("Frame")
                    dropdownList.Name = "DropdownList"
                    dropdownList.Size = UDim2.new(1, 0, 0, 0)
                    dropdownList.Position = UDim2.new(0, 0, 0, 65)
                    dropdownList.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                    dropdownList.Visible = false
                    dropdownList.ClipsDescendants = true
                    dropdownList.Parent = dropdownFrame
                    
                    local listCorner = Instance.new("UICorner")
                    listCorner.CornerRadius = UDim.new(0, 6)
                    listCorner.Parent = dropdownList
                    
                    local listStroke = Instance.new("UIStroke")
                    listStroke.Color = Color3.fromRGB(0, 170, 255)
                    listStroke.Thickness = 1
                    listStroke.Parent = dropdownList
                    
                    local selected = defaultValue
                    local isOpen = false
                    
                    local function updateList()
                        for _, child in ipairs(dropdownList:GetChildren()) do
                            if child:IsA("TextButton") then
                                child:Destroy()
                            end
                        end
                        
                        for i, option in ipairs(options) do
                            local optionButton = Instance.new("TextButton")
                            optionButton.Name = option .. "Option"
                            optionButton.Size = UDim2.new(1, 0, 0, 30)
                            optionButton.Position = UDim2.new(0, 0, 0, (i-1) * 35)
                            optionButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                            optionButton.Text = option
                            optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                            optionButton.TextSize = 14
                            optionButton.Font = Enum.Font.Gotham
                            optionButton.Parent = dropdownList
                            
                            local optionCorner = Instance.new("UICorner")
                            optionCorner.CornerRadius = UDim.new(0, 4)
                            optionCorner.Parent = optionButton
                            
                            addHoverEffect(optionButton, Color3.fromRGB(45, 45, 55), Color3.fromRGB(0, 170, 255))
                            
                            optionButton.MouseButton1Click:Connect(function()
                                selected = option
                                dropdownButton.Text = selected
                                isOpen = false
                                dropdownList.Visible = false
                                dropdownList.Size = UDim2.new(1, 0, 0, 0)
                                
                                if callback then
                                    callback(selected)
                                end
                            end)
                        end
                        
                        dropdownList.Size = UDim2.new(1, 0, 0, #options * 35)
                    end
                    
                    dropdownButton.MouseButton1Click:Connect(function()
                        isOpen = not isOpen
                        dropdownList.Visible = isOpen
                        updateList()
                    end)
                    
                    addHoverEffect(dropdownButton, Color3.fromRGB(45, 45, 55), Color3.fromRGB(35, 35, 45))
                    
                    self.ElementCount = self.ElementCount + 1
                    
                    return {
                        DropdownFrame = dropdownFrame,
                        Value = selected,
                        Refresh = function(newOptions)
                            options = newOptions
                            updateList()
                        end
                    }
                end
                
                -- Thêm label
                function menu:addLabel(text)
                    local label = Instance.new("TextLabel")
                    label.Name = text .. "Label"
                    label.Size = UDim2.new(1, 0, 0, 25)
                    label.BackgroundTransparency = 1
                    label.Text = text
                    label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    label.TextSize = 14
                    label.Font = Enum.Font.Gotham
                    label.TextXAlignment = Enum.TextXAlignment.Left
                    label.LayoutOrder = self.ElementCount
                    label.Parent = self.Content
                    
                    self.ElementCount = self.ElementCount + 1
                    
                    return label
                end
                
                -- Thêm changelog
                function menu:addChangelog(text)
                    local changelogFrame = Instance.new("Frame")
                    changelogFrame.Name = "Changelog"
                    changelogFrame.Size = UDim2.new(1, 0, 0, 0)
                    changelogFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
                    changelogFrame.BackgroundTransparency = 0.5
                    changelogFrame.LayoutOrder = self.ElementCount
                    changelogFrame.Parent = self.Content
                    changelogFrame.AutomaticSize = Enum.AutomaticSize.Y
                    
                    local changelogCorner = Instance.new("UICorner")
                    changelogCorner.CornerRadius = UDim.new(0, 8)
                    changelogCorner.Parent = changelogFrame
                    
                    local changelogStroke = Instance.new("UIStroke")
                    changelogStroke.Color = Color3.fromRGB(0, 170, 255)
                    changelogStroke.Thickness = 1
                    changelogStroke.Parent = changelogFrame
                    
                    local changelogPadding = Instance.new("UIPadding")
                    changelogPadding.PaddingLeft = UDim.new(0, 10)
                    changelogPadding.PaddingRight = UDim.new(0, 10)
                    changelogPadding.PaddingTop = UDim.new(0, 10)
                    changelogPadding.PaddingBottom = UDim.new(0, 10)
                    changelogPadding.Parent = changelogFrame
                    
                    local changelogText = Instance.new("TextLabel")
                    changelogText.Name = "Text"
                    changelogText.Size = UDim2.new(1, 0, 0, 0)
                    changelogText.BackgroundTransparency = 1
                    changelogText.Text = text
                    changelogText.TextColor3 = Color3.fromRGB(255, 255, 255)
                    changelogText.TextSize = 12
                    changelogText.Font = Enum.Font.Gotham
                    changelogText.TextWrapped = true
                    changelogText.TextXAlignment = Enum.TextXAlignment.Left
                    changelogText.TextYAlignment = Enum.TextYAlignment.Top
                    changelogText.AutomaticSize = Enum.AutomaticSize.Y
                    changelogText.Parent = changelogFrame
                    
                    self.ElementCount = self.ElementCount + 1
                    
                    return changelogFrame
                end
                
                return menu
            end
            
            return section
        end
        
        return tab
    end
    
    -- Chuyển tab
    function window:SwitchTab(tab)
        if self.CurrentTab then
            self.CurrentTab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
            self.CurrentTab.Content.Visible = false
        end
        
        self.CurrentTab = tab
        tab.Button.TextColor3 = Color3.fromRGB(0, 170, 255)
        tab.Content.Visible = true
    end
    
    return window
end

return Library
