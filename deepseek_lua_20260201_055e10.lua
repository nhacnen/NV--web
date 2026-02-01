-- KimP Gaming Library - Simplified Version
-- Replace: https://raw.githubusercontent.com/VanThanhIOS/OniiChanVanThanhIOS/refs/heads/main/main.txt

local KimP_Library = {}

-- Main Functions
function KimP_Library:CreateWindow(title)
    local Window = {}
    Window.Title = title
    Window.Tabs = {}
    
    function Window:addTab(name)
        local Tab = {}
        Tab.Name = name
        Tab.Sections = {}
        
        function Tab:addSection(name)
            local Section = {}
            Section.Name = name
            Section.Elements = {}
            
            function Section:addMenu(name)
                local Menu = {}
                Menu.Name = name
                Menu.Buttons = {}
                Menu.Toggles = {}
                Menu.Textboxes = {}
                Menu.Dropdowns = {}
                Menu.Labels = {}
                Menu.Changelogs = {}
                
                -- Button
                function Menu:addButton(text, callback)
                    print("[Button] " .. text)
                    table.insert(self.Buttons, {
                        Text = text,
                        Callback = callback
                    })
                    if callback then
                        callback()
                    end
                end
                
                -- Toggle
                function Menu:addToggle(text, default, callback)
                    print("[Toggle] " .. text .. " (Default: " .. tostring(default) .. ")")
                    local toggleState = default or false
                    
                    table.insert(self.Toggles, {
                        Text = text,
                        State = toggleState,
                        Callback = callback
                    })
                    
                    -- Return an object with refresh function if needed
                    return {
                        Refresh = function(value)
                            if callback then
                                callback(value)
                            end
                        end
                    }
                end
                
                -- Textbox
                function Menu:addTextbox(text, default, callback)
                    print("[Textbox] " .. text .. " (Default: " .. tostring(default) .. ")")
                    
                    table.insert(self.Textboxes, {
                        Text = text,
                        Value = default,
                        Callback = callback
                    })
                    
                    if callback and default then
                        callback(default)
                    end
                end
                
                -- Dropdown
                function Menu:addDropdown(text, default, options, callback)
                    print("[Dropdown] " .. text .. " (Default: " .. tostring(default) .. ")")
                    
                    table.insert(self.Dropdowns, {
                        Text = text,
                        Value = default,
                        Options = options,
                        Callback = callback
                    })
                    
                    if callback and default then
                        callback(default)
                    end
                    
                    -- Return dropdown object with refresh function
                    local dropdownObj = {}
                    
                    function dropdownObj:Refresh(newOptions)
                        if newOptions then
                            self.Options = newOptions
                        end
                    end
                    
                    function dropdownObj:Clear()
                        self.Options = {}
                    end
                    
                    return dropdownObj
                end
                
                -- Label
                function Menu:addLabel(text)
                    print("[Label] " .. text)
                    
                    local labelObj = {}
                    labelObj.Text = text
                    
                    table.insert(self.Labels, labelObj)
                    
                    function labelObj:Refresh(newText)
                        self.Text = newText
                        print("[Label Updated] " .. newText)
                    end
                    
                    return labelObj
                end
                
                -- Changelog
                function Menu:addChangelog(text)
                    print("[Changelog] " .. text)
                    table.insert(self.Changelogs, text)
                end
                
                table.insert(Section.Elements, Menu)
                return Menu
            end
            
            table.insert(Tab.Sections, Section)
            return Section
        end
        
        table.insert(Window.Tabs, Tab)
        return Tab
    end
    
    return Window
end

-- Create global Library object
local Library = {}
setmetatable(Library, KimP_Library)

-- Loadstring replacement
local function loadstringReplacement(url)
    if url:find("VanThanhIOS") then
        print("Loading KimP Gaming Library...")
        return function() return Library end
    else
        -- Try to load from actual URL if needed
        return loadstring(game:HttpGet(url))
    end
end

-- Override loadstring if needed
if not getgenv().originalLoadstring then
    getgenv().originalLoadstring = loadstring
    loadstring = loadstringReplacement
end

return Library