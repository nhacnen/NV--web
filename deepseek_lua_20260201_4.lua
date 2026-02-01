-- Simple UI Library for Roblox - Tương thích với code KimP Gaming
-- Thay thế: https://raw.githubusercontent.com/VanThanhIOS/OniiChanVanThanhIOS/refs/heads/main/main.txt

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Library = {}
Library.__index = Library

function Library:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KimPGamingUI"
    screenGui.Parent = game.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(0, 170, 255)
    stroke.Thickness = 2
    stroke.Parent = mainFrame
    
    -- Header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
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