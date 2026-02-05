local Configs_HUB = {
  Cor_Hub = Color3.fromRGB(15, 15, 15),
  Cor_Options = Color3.fromRGB(15, 15, 15),
  Cor_Stroke = Color3.fromRGB(60, 60, 60),
  Cor_Text = Color3.fromRGB(240, 240, 240),
  Cor_DarkText = Color3.fromRGB(140, 140, 140),
  Corner_Radius = UDim.new(0, 4),
  Text_Font = Enum.Font.FredokaOne
}

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function Create(instance, parent, props)
  local new = Instance.new(instance, parent)
  if props then
    for prop, value in pairs(props) do
      new[prop] = value
    end
  end
  return new
end

local function SetProps(instance, props)
  if instance and props then
    for prop, value in pairs(props) do
      instance[prop] = value
    end
  end
  return instance
end

local function Corner(parent, props)
  local new = Create("UICorner", parent)
  new.CornerRadius = Configs_HUB.Corner_Radius
  if props then
    SetProps(new, props)
  end
  return new
end

local function Stroke(parent, props)
  local new = Create("UIStroke", parent)
  new.Color = Configs_HUB.Cor_Stroke
  new.ApplyStrokeMode = "Border"
  if props then
    SetProps(new, props)
  end
  return new
end

local function CreateTween(instance, prop, value, time, tweenWait)
  local tween = TweenService:Create(instance,
  TweenInfo.new(time, Enum.EasingStyle.Linear),
  {[prop] = value})
  tween:Play()
  if tweenWait then
    tween.Completed:Wait()
  end
end

local function TextSetColor(instance)
  instance.MouseEnter:Connect(function()
    CreateTween(instance, "TextColor3", Color3.fromRGB(28, 120, 212), 0.4, true)
  end)
  instance.MouseLeave:Connect(function()
    CreateTween(instance, "TextColor3", Configs_HUB.Cor_Text, 0.4, false)
  end)
end

local ScreenGui = Create("ScreenGui", CoreGui, {
  Name = "KimP Gaming UI Library",
  ResetOnSpawn = false,
  ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

ScreenFind = CoreGui:FindFirstChild(ScreenGui.Name)
if ScreenFind and ScreenFind ~= ScreenGui then
  ScreenFind:Destroy()
end

function DestroyScript()
  ScreenGui:Destroy()
end

-- Notification System
local Menu_Notifi = Create("Frame", ScreenGui, {
  Size = UDim2.new(0, 300, 1, 0),
  Position = UDim2.new(1, 0, 0, 0),
  AnchorPoint = Vector2.new(1, 0),
  BackgroundTransparency = 1
})

local Padding = Create("UIPadding", Menu_Notifi, {
  PaddingLeft = UDim.new(0, 25),
  PaddingTop = UDim.new(0, 25),
  PaddingBottom = UDim.new(0, 50)
})

local ListLayout = Create("UIListLayout", Menu_Notifi, {
  Padding = UDim.new(0, 15),
  VerticalAlignment = "Bottom"
})

function MakeNotifi(Configs)
  local Title = Configs.Title or "KimP Gaming"
  local text = Configs.Text or "Notification"
  local timewait = Configs.Time or 5
  
  local Frame1 = Create("Frame", Menu_Notifi, {
    Size = UDim2.new(2, 0, 0, 0),
    BackgroundTransparency = 1,
    AutomaticSize = "Y",
    Name = "Title"
  })
  
  local Frame2 = Create("Frame", Frame1, {
    Size = UDim2.new(0, Menu_Notifi.Size.X.Offset - 50, 0, 0),
    BackgroundColor3 = Configs_HUB.Cor_Hub,
    Position = UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0),
    AutomaticSize = "Y"
  })Corner(Frame2)
  
  local TextLabel = Create("TextLabel", Frame2, {
    Size = UDim2.new(1, 0, 0, 25),
    Font = Configs_HUB.Text_Font,
    BackgroundTransparency = 1,
    Text = Title,
    TextSize = 20,
    Position = UDim2.new(0, 20, 0, 5),
    TextXAlignment = "Left",
    TextColor3 = Configs_HUB.Cor_Text
  })
  
  local TextButton = Create("TextButton", Frame2, {
    Text = "X",
    Font = Configs_HUB.Text_Font,
    TextSize = 20,
    BackgroundTransparency = 1,
    TextColor3 = Color3.fromRGB(200, 200, 200),
    Position = UDim2.new(1, -5, 0, 5),
    AnchorPoint = Vector2.new(1, 0),
    Size = UDim2.new(0, 25, 0, 25)
  })
  
  local TextLabel2 = Create("TextLabel", Frame2, {
    Size = UDim2.new(1, -30, 0, 0),
    Position = UDim2.new(0, 20, 0, TextButton.Size.Y.Offset + 10),
    TextSize = 15,
    TextColor3 = Configs_HUB.Cor_DarkText,
    TextXAlignment = "Left",
    TextYAlignment = "Top",
    AutomaticSize = "Y",
    Text = text,
    Font = Configs_HUB.Text_Font,
    BackgroundTransparency = 1,
    TextWrapped = true
  })
  
  local FrameSize = Create("Frame", Frame2, {
    Size = UDim2.new(1, 0, 0, 2),
    BackgroundColor3 = Configs_HUB.Cor_Stroke,
    Position = UDim2.new(0, 2, 0, 30),
    BorderSizePixel = 0
  })Corner(FrameSize)Create("Frame", Frame2, {
    Size = UDim2.new(0, 0, 0, 5),
    Position = UDim2.new(0, 0, 1, 5),
    BackgroundTransparency = 1
  })
  
  task.spawn(function()
    CreateTween(FrameSize, "Size", UDim2.new(0, 0, 0, 2), timewait, true)
  end)
  
  TextButton.MouseButton1Click:Connect(function()
    CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.1, true)
    CreateTween(Frame2, "Position", UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0), 0.5, true)
    Frame1:Destroy()
  end)
  
  task.spawn(function()
    CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.5, true)
    CreateTween(Frame2, "Position", UDim2.new(), 0.1, true)
    task.wait(timewait)
    if Frame2 then
      CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.1, true)
      CreateTween(Frame2, "Position", UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0), 0.5, true)
      Frame1:Destroy()
    end
  end)
end

-- Main Library Functions
local Library = {}

function Library:CreateWindow(WindowTitle)
  local Menu = {}
  local FirstTab = nil
  
  -- Main Window Frame
  local MainFrame = Create("Frame", ScreenGui, {
    Size = UDim2.new(0, 650, 0, 500),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Configs_HUB.Cor_Hub,
    Active = true,
    Draggable = true,
    Visible = true
  })Corner(MainFrame)Stroke(MainFrame)
  
  -- Title Bar
  local TitleBar = Create("Frame", MainFrame, {
    Size = UDim2.new(1, 0, 0, 40),
    BackgroundColor3 = Color3.fromRGB(20, 20, 20)
  })Corner(TitleBar)
  
  local TitleLabel = Create("TextLabel", TitleBar, {
    Size = UDim2.new(1, -100, 1, 0),
    Position = UDim2.new(0, 15, 0, 0),
    Text = WindowTitle,
    Font = Configs_HUB.Text_Font,
    TextSize = 20,
    TextColor3 = Configs_HUB.Cor_Text,
    TextXAlignment = "Left",
    BackgroundTransparency = 1
  })
  
  -- Close Button
  local CloseButton = Create("TextButton", TitleBar, {
    Size = UDim2.new(0, 35, 0, 35),
    Position = UDim2.new(1, -40, 0.5, 0),
    AnchorPoint = Vector2.new(0, 0.5),
    Text = "X",
    Font = Configs_HUB.Text_Font,
    TextSize = 18,
    TextColor3 = Color3.fromRGB(255, 100, 100),
    BackgroundColor3 = Configs_HUB.Cor_Options
  })Corner(CloseButton)
  
  CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
  end)
  
  -- Tab Container
  local TabContainer = Create("ScrollingFrame", MainFrame, {
    Size = UDim2.new(0, 140, 1, -50),
    Position = UDim2.new(0, 5, 0, 45),
    BackgroundColor3 = Configs_HUB.Cor_Options,
    ScrollBarThickness = 4,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    BorderSizePixel = 0
  })Corner(TabContainer)Stroke(TabContainer)
  
  local TabLayout = Create("UIListLayout", TabContainer, {
    Padding = UDim.new(0, 4),
    SortOrder = Enum.SortOrder.LayoutOrder
  })
  
  Create("UIPadding", TabContainer, {
    PaddingTop = UDim.new(0, 5),
    PaddingLeft = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 5)
  })
  
  -- Content Container
  local ContentContainer = Create("Frame", MainFrame, {
    Size = UDim2.new(1, -155, 1, -50),
    Position = UDim2.new(0, 150, 0, 45),
    BackgroundColor3 = Configs_HUB.Cor_Hub,
    BackgroundTransparency = 1
  })
  
  function Menu:addTab(TabName)
    local Tab = {}
    
    -- Clean TabName
    local CleanName = TabName:gsub("#", "")
    
    -- Tab Button
    local TabButton = Create("TextButton", TabContainer, {
      Size = UDim2.new(1, 0, 0, 32),
      Text = CleanName,
      Font = Configs_HUB.Text_Font,
      TextSize = 13,
      TextColor3 = Configs_HUB.Cor_DarkText,
      BackgroundColor3 = Configs_HUB.Cor_Hub
    })Corner(TabButton)
    
    -- Tab Content
    local TabContent = Create("ScrollingFrame", ContentContainer, {
      Size = UDim2.new(1, 0, 1, 0),
      BackgroundTransparency = 1,
      ScrollBarThickness = 5,
      ScrollBarImageColor3 = Configs_HUB.Cor_Stroke,
      Visible = false,
      CanvasSize = UDim2.new(0, 0, 0, 0),
      AutomaticCanvasSize = Enum.AutomaticSize.Y,
      BorderSizePixel = 0
    })
    
    -- Container for all sections in this tab
    local SectionsContainer = Create("Frame", TabContent, {
      Size = UDim2.new(1, 0, 0, 0),
      BackgroundTransparency = 1,
      AutomaticSize = Enum.AutomaticSize.Y
    })
    
    local SectionsLayout = Create("UIListLayout", SectionsContainer, {
      Padding = UDim.new(0, 8),
      SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    Create("UIPadding", TabContent, {
      PaddingTop = UDim.new(0, 6),
      PaddingLeft = UDim.new(0, 6),
      PaddingRight = UDim.new(0, 6),
      PaddingBottom = UDim.new(0, 6)
    })
    
    TabButton.MouseButton1Click:Connect(function()
      -- Hide all tabs
      for _, child in pairs(ContentContainer:GetChildren()) do
        if child:IsA("ScrollingFrame") then
          child.Visible = false
        end
      end
      
      -- Reset all tab buttons
      for _, button in pairs(TabContainer:GetChildren()) do
        if button:IsA("TextButton") then
          button.BackgroundColor3 = Configs_HUB.Cor_Hub
          button.TextColor3 = Configs_HUB.Cor_DarkText
        end
      end
      
      -- Activate current tab
      TabContent.Visible = true
      TabButton.BackgroundColor3 = Configs_HUB.Cor_Options
      TabButton.TextColor3 = Configs_HUB.Cor_Text
    end)
    
    -- Store first tab reference
    if not FirstTab then
      FirstTab = TabButton
    end
    
    local SectionCount = 0
    
    function Tab:addSection()
      local Section = {}
      SectionCount = SectionCount + 1
      
      -- Section Frame (Full width)
      local SectionFrame = Create("Frame", SectionsContainer, {
        Size = UDim2.new(1, 0, 0, 0),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = SectionCount
      })
      
      local SectionLayout = Create("UIListLayout", SectionFrame, {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
      })
      
      function Section:addMenu(MenuName)
        local MenuSection = {}
        
        -- Menu Container
        local MenuContainer = Create("Frame", SectionFrame, {
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundTransparency = 1,
          AutomaticSize = Enum.AutomaticSize.Y
        })
        
        local MenuContainerLayout = Create("UIListLayout", MenuContainer, {
          Padding = UDim.new(0, 4),
          SortOrder = Enum.SortOrder.LayoutOrder
        })
        
        -- Menu Header
        local MenuHeader = Create("Frame", MenuContainer, {
          Size = UDim2.new(1, 0, 0, 30),
          BackgroundColor3 = Configs_HUB.Cor_Options,
          LayoutOrder = 1
        })Corner(MenuHeader)Stroke(MenuHeader)
        
        local MenuTitle = Create("TextLabel", MenuHeader, {
          Size = UDim2.new(1, -20, 1, 0),
          Position = UDim2.new(0, 10, 0, 0),
          Text = MenuName:gsub("#", ""),
          Font = Configs_HUB.Text_Font,
          TextSize = 14,
          TextColor3 = Configs_HUB.Cor_Text,
          TextXAlignment = "Left",
          BackgroundTransparency = 1
        })
        
        -- Menu Content
        local MenuContent = Create("Frame", MenuContainer, {
          Size = UDim2.new(1, 0, 0, 0),
          BackgroundTransparency = 1,
          AutomaticSize = Enum.AutomaticSize.Y,
          LayoutOrder = 2
        })
        
        local MenuLayout = Create("UIListLayout", MenuContent, {
          Padding = UDim.new(0, 4),
          SortOrder = Enum.SortOrder.LayoutOrder
        })
        
        -- Add Textbox
        function MenuSection:addTextbox(TextboxName, DefaultValue, Callback)
          local TextboxFrame = Create("Frame", MenuContent, {
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = Configs_HUB.Cor_Options
          })Corner(TextboxFrame)Stroke(TextboxFrame)
          
          local TextboxLabel = Create("TextLabel", TextboxFrame, {
            Size = UDim2.new(0.5, -10, 1, 0),
            Position = UDim2.new(0, 8, 0, 0),
            Text = TextboxName,
            Font = Configs_HUB.Text_Font,
            TextSize = 12,
            TextColor3 = Configs_HUB.Cor_Text,
            TextXAlignment = "Left",
            BackgroundTransparency = 1
          })
          
          local TextboxInput = Create("TextBox", TextboxFrame, {
            Size = UDim2.new(0.35, 0, 0, 24),
            Position = UDim2.new(0.6, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Text = tostring(DefaultValue),
            Font = Configs_HUB.Text_Font,
            TextSize = 11,
            TextColor3 = Configs_HUB.Cor_Text,
            BackgroundColor3 = Configs_HUB.Cor_Hub,
            PlaceholderText = "Enter...",
            ClearTextOnFocus = false
          })Corner(TextboxInput)Stroke(TextboxInput)
          
          Create("UIPadding", TextboxInput, {
            PaddingLeft = UDim.new(0, 5),
            PaddingRight = UDim.new(0, 5)
          })
          
          TextboxInput.FocusLost:Connect(function()
            local value = tonumber(TextboxInput.Text) or TextboxInput.Text
            Callback(value)
          end)
        end
        
        -- Add Toggle
        function MenuSection:addToggle(ToggleName, DefaultValue, Callback)
          local ToggleFrame = Create("Frame", MenuContent, {
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = Configs_HUB.Cor_Options
          })Corner(ToggleFrame)Stroke(ToggleFrame)
          
          local ToggleLabel = Create("TextLabel", ToggleFrame, {
            Size = UDim2.new(0.7, -10, 1, 0),
            Position = UDim2.new(0, 8, 0, 0),
            Text = ToggleName,
            Font = Configs_HUB.Text_Font,
            TextSize = 12,
            TextColor3 = Configs_HUB.Cor_Text,
            TextXAlignment = "Left",
            BackgroundTransparency = 1
          })
          
          local ToggleButton = Create("TextButton", ToggleFrame, {
            Size = UDim2.new(0, 40, 0, 20),
            Position = UDim2.new(1, -48, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Text = "",
            BackgroundColor3 = DefaultValue and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0)
          })Corner(ToggleButton)
          
          local ToggleIndicator = Create("Frame", ToggleButton, {
            Size = UDim2.new(0, 16, 0, 16),
            Position = DefaultValue and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
          })Corner(ToggleIndicator)
          
          local IsToggled = DefaultValue
          
          ToggleButton.MouseButton1Click:Connect(function()
            IsToggled = not IsToggled
            
            CreateTween(ToggleButton, "BackgroundColor3", 
              IsToggled and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0), 
              0.2, false)
            
            CreateTween(ToggleIndicator, "Position", 
              IsToggled and UDim2.new(1, -18, 0.5, 0) or UDim2.new(0, 2, 0.5, 0),
              0.2, false)
            
            Callback(IsToggled)
          end)
        end
        
        -- Add Button
        function MenuSection:addButton(ButtonName, Callback)
          local ButtonFrame = Create("TextButton", MenuContent, {
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = Configs_HUB.Cor_Options,
            Text = ButtonName,
            Font = Configs_HUB.Text_Font,
            TextSize = 13,
            TextColor3 = Configs_HUB.Cor_Text
          })Corner(ButtonFrame)Stroke(ButtonFrame)
          
          ButtonFrame.MouseButton1Click:Connect(function()
            Callback()
          end)
          
          TextSetColor(ButtonFrame)
        end
        
        -- Add Dropdown
        function MenuSection:addDropdown(DropdownName, Options, DefaultValue, Callback)
          local DropdownFrame = Create("Frame", MenuContent, {
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = Configs_HUB.Cor_Options,
            ClipsDescendants = false,
            ZIndex = 5
          })Corner(DropdownFrame)Stroke(DropdownFrame)
          
          local DropdownLabel = Create("TextLabel", DropdownFrame, {
            Size = UDim2.new(0.4, -10, 1, 0),
            Position = UDim2.new(0, 8, 0, 0),
            Text = DropdownName,
            Font = Configs_HUB.Text_Font,
            TextSize = 12,
            TextColor3 = Configs_HUB.Cor_Text,
            TextXAlignment = "Left",
            BackgroundTransparency = 1
          })
          
          local DropdownButton = Create("TextButton", DropdownFrame, {
            Size = UDim2.new(0.55, 0, 0, 24),
            Position = UDim2.new(0.43, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            Text = DefaultValue or "Select...",
            Font = Configs_HUB.Text_Font,
            TextSize = 11,
            TextColor3 = Configs_HUB.Cor_Text,
            BackgroundColor3 = Configs_HUB.Cor_Hub,
            ZIndex = 6
          })Corner(DropdownButton)Stroke(DropdownButton)
          
          local DropdownList = Create("ScrollingFrame", DropdownFrame, {
            Size = UDim2.new(0.55, 0, 0, 0),
            Position = UDim2.new(0.43, 0, 1, 2),
            BackgroundColor3 = Configs_HUB.Cor_Hub,
            ScrollBarThickness = 3,
            Visible = false,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ZIndex = 10,
            BorderSizePixel = 0
          })Corner(DropdownList)Stroke(DropdownList)
          
          local DropdownListLayout = Create("UIListLayout", DropdownList, {
            Padding = UDim.new(0, 1)
          })
          
          local IsOpen = false
          
          for _, option in pairs(Options) do
            local OptionButton = Create("TextButton", DropdownList, {
              Size = UDim2.new(1, 0, 0, 22),
              Text = option,
              Font = Configs_HUB.Text_Font,
              TextSize = 10,
              TextColor3 = Configs_HUB.Cor_DarkText,
              BackgroundColor3 = Configs_HUB.Cor_Options,
              BackgroundTransparency = 0.5,
              ZIndex = 11
            })
            
            if option == DefaultValue then
              OptionButton.BackgroundTransparency = 0
              OptionButton.TextColor3 = Configs_HUB.Cor_Text
            end
            
            OptionButton.MouseButton1Click:Connect(function()
              DropdownButton.Text = option
              Callback(option)
              
              for _, btn in pairs(DropdownList:GetChildren()) do
                if btn:IsA("TextButton") then
                  btn.BackgroundTransparency = 0.5
                  btn.TextColor3 = Configs_HUB.Cor_DarkText
                end
              end
              
              OptionButton.BackgroundTransparency = 0
              OptionButton.TextColor3 = Configs_HUB.Cor_Text
              
              IsOpen = false
              CreateTween(DropdownList, "Size", UDim2.new(0.55, 0, 0, 0), 0.15, false)
              task.wait(0.15)
              DropdownList.Visible = false
            end)
          end
          
          DropdownButton.MouseButton1Click:Connect(function()
            IsOpen = not IsOpen
            DropdownList.Visible = true
            
            local targetSize = IsOpen and UDim2.new(0.55, 0, 0, math.min(#Options * 23, 120)) or UDim2.new(0.55, 0, 0, 0)
            CreateTween(DropdownList, "Size", targetSize, 0.15, false)
            
            if not IsOpen then
              task.wait(0.15)
              DropdownList.Visible = false
            end
          end)
        end
        
        -- Add Slider
        function MenuSection:addSlider(SliderName, MinValue, MaxValue, DefaultValue, Callback)
          local SliderFrame = Create("Frame", MenuContent, {
            Size = UDim2.new(1, 0, 0, 45),
            BackgroundColor3 = Configs_HUB.Cor_Options
          })Corner(SliderFrame)Stroke(SliderFrame)
          
          local SliderLabel = Create("TextLabel", SliderFrame, {
            Size = UDim2.new(0.6, -10, 0, 18),
            Position = UDim2.new(0, 8, 0, 4),
            Text = SliderName,
            Font = Configs_HUB.Text_Font,
            TextSize = 12,
            TextColor3 = Configs_HUB.Cor_Text,
            TextXAlignment = "Left",
            BackgroundTransparency = 1
          })
          
          local SliderValue = Create("TextLabel", SliderFrame, {
            Size = UDim2.new(0.3, 0, 0, 18),
            Position = UDim2.new(0.7, 0, 0, 4),
            Text = tostring(DefaultValue),
            Font = Configs_HUB.Text_Font,
            TextSize = 11,
            TextColor3 = Configs_HUB.Cor_DarkText,
            BackgroundTransparency = 1
          })
          
          local SliderBar = Create("Frame", SliderFrame, {
            Size = UDim2.new(1, -16, 0, 5),
            Position = UDim2.new(0, 8, 1, -12),
            BackgroundColor3 = Configs_HUB.Cor_Hub
          })Corner(SliderBar)
          
          local SliderFill = Create("Frame", SliderBar, {
            Size = UDim2.new((DefaultValue - MinValue) / (MaxValue - MinValue), 0, 1, 0),
            BackgroundColor3 = Color3.fromRGB(28, 120, 212)
          })Corner(SliderFill)
          
          local Dragging = false
          
          local function UpdateSlider(input)
            local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
            local value = math.floor(MinValue + (MaxValue - MinValue) * pos)
            
            SliderFill.Size = UDim2.new(pos, 0, 1, 0)
            SliderValue.Text = tostring(value)
            Callback(value)
          end
          
          SliderBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
              Dragging = true
              UpdateSlider(input)
            end
          end)
          
          SliderBar.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
              Dragging = false
            end
          end)
          
          UserInputService.InputChanged:Connect(function(input)
            if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
              UpdateSlider(input)
            end
          end)
        end
        
        -- Add Changelog (for Home tab info)
        function MenuSection:addChangelog(Text)
          local ChangelogFrame = Create("TextLabel", MenuContent, {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = Configs_HUB.Cor_Options,
            Text = "• " .. Text,
            Font = Configs_HUB.Text_Font,
            TextSize = 11,
            TextColor3 = Configs_HUB.Cor_DarkText,
            TextXAlignment = "Left",
            TextYAlignment = "Top",
            TextWrapped = true
          })Corner(ChangelogFrame)Stroke(ChangelogFrame)
          
          Create("UIPadding", ChangelogFrame, {
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 6),
            PaddingBottom = UDim.new(0, 6)
          })
        end
        
        return MenuSection
      end
      
      return Section
    end
    
    return Tab
  end
  
  -- Auto-activate first tab after all tabs are created
  task.spawn(function()
    task.wait(0.1)
    if FirstTab then
      FirstTab.MouseButton1Click:Fire()
    end
  end)
  
  return Menu
end

return Library
