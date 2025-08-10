-- Variables
    local scale = 0.5
    local uis = Services.UserInputService
    local players = Services.Players
    local ws = Services.Workspace
    local rs = Services.ReplicatedStorage
    local http_service = Services.HttpService
    local gui_service = Services.GuiService
    local lighting = Services.Lighting
    local run = Services.RunService
    local stats = Services.Stats
    local coregui = Services.CoreGui
    local debris = Services.Debris
    local tween_service = Services.TweenService
    local sound_service = Services.SoundService
    local run_service = Services.RunService

    local vec2 = Vector2.new
    local vec3 = Vector3.new
    local dim2 = UDim2.new
    local dim = UDim.new 
    local rect = Rect.new
    local cfr = CFrame.new
    local empty_cfr = cfr()
    local point_object_space = empty_cfr.PointToObjectSpace
    local angle = CFrame.Angles
    local dim_offset = UDim2.fromOffset

    local color = Color3.new
    local rgb = Color3.fromRGB
    local hex = Color3.fromHex
    local hsv = Color3.fromHSV
    local rgbseq = ColorSequence.new
    local rgbkey = ColorSequenceKeypoint.new
    local numseq = NumberSequence.new
    local numkey = NumberSequenceKeypoint.new

    local camera = ws.CurrentCamera
    local lp = players.LocalPlayer 
    local mouse = lp:GetMouse() 
    local gui_offset = gui_service:GetGuiInset().Y

    local max = math.max 
    local floor = math.floor 
    local min = math.min 
    local abs = math.abs 
    local noise = math.noise
    local rad = math.rad 
    local random = math.random 
    local pow = math.pow 
    local sin = math.sin 
    local pi = math.pi 
    local tan = math.tan 
    local atan2 = math.atan2 
    local clamp = math.clamp 

    local insert = table.insert 
    local find = table.find 
    local remove = table.remove
    local concat = table.concat
-- 

-- Library ini

    local themes = {
        preset = {
            accent = rgb(0, 162, 255),
        }, 

        utility = {
            accent = {
                BackgroundColor3 = {}, 	
                TextColor3 = {}, 
                ImageColor3 = {}, 
                ScrollBarImageColor3 = {} 
            },
        }
    }

    local keys = {
        [Enum.KeyCode.LeftShift] = "LS",
        [Enum.KeyCode.RightShift] = "RS",
        [Enum.KeyCode.LeftControl] = "LC",
        [Enum.KeyCode.RightControl] = "RC",
        [Enum.KeyCode.Insert] = "INS",
        [Enum.KeyCode.Backspace] = "BS",
        [Enum.KeyCode.Return] = "Ent",
        [Enum.KeyCode.LeftAlt] = "LA",
        [Enum.KeyCode.RightAlt] = "RA",
        [Enum.KeyCode.CapsLock] = "CAPS",
        [Enum.KeyCode.One] = "1",
        [Enum.KeyCode.Two] = "2",
        [Enum.KeyCode.Three] = "3",
        [Enum.KeyCode.Four] = "4",
        [Enum.KeyCode.Five] = "5",
        [Enum.KeyCode.Six] = "6",
        [Enum.KeyCode.Seven] = "7",
        [Enum.KeyCode.Eight] = "8",
        [Enum.KeyCode.Nine] = "9",
        [Enum.KeyCode.Zero] = "0",
        [Enum.KeyCode.KeypadOne] = "Num1",
        [Enum.KeyCode.KeypadTwo] = "Num2",
        [Enum.KeyCode.KeypadThree] = "Num3",
        [Enum.KeyCode.KeypadFour] = "Num4",
        [Enum.KeyCode.KeypadFive] = "Num5",
        [Enum.KeyCode.KeypadSix] = "Num6",
        [Enum.KeyCode.KeypadSeven] = "Num7",
        [Enum.KeyCode.KeypadEight] = "Num8",
        [Enum.KeyCode.KeypadNine] = "Num9",
        [Enum.KeyCode.KeypadZero] = "Num0",
        [Enum.KeyCode.Minus] = "-",
        [Enum.KeyCode.Equals] = "=",
        [Enum.KeyCode.Tilde] = "~",
        [Enum.KeyCode.LeftBracket] = "[",
        [Enum.KeyCode.RightBracket] = "]",
        [Enum.KeyCode.RightParenthesis] = ")",
        [Enum.KeyCode.LeftParenthesis] = "(",
        [Enum.KeyCode.Semicolon] = ",",
        [Enum.KeyCode.Quote] = "'",
        [Enum.KeyCode.BackSlash] = "\\",
        [Enum.KeyCode.Comma] = ",",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Slash] = "/",
        [Enum.KeyCode.Asterisk] = "*",
        [Enum.KeyCode.Plus] = "+",
        [Enum.KeyCode.Period] = ".",
        [Enum.KeyCode.Backquote] = "`",
        [Enum.UserInputType.MouseButton1] = "MB1",
        [Enum.UserInputType.MouseButton2] = "MB2",
        [Enum.UserInputType.MouseButton3] = "MB3",
        [Enum.KeyCode.Escape] = "ESC",
        [Enum.KeyCode.Space] = "SPC",
    }
        
    library.__index = library

    for _, path in next, library.folders do 
        makefolder(library.directory .. path)
    end

    local flags = library.flags 
    local config_flags = library.config_flags
    local notifications = library.notifications 

    local fonts = {}; do
        function Register_Font(Name, Weight, Style, Asset)
            if not isfile(Asset.Id) then
                writefile(Asset.Id, Asset.Font)
            end

            if isfile(Name .. ".font") then
                delfile(Name .. ".font")
            end

            local Data = {
                name = Name,
                faces = {
                    {
                        name = "Normal",
                        weight = Weight,
                        style = Style,
                        assetId = getcustomasset(Asset.Id),
                    },
                },
            }

            writefile(Name .. ".font", http_service:JSONEncode(Data))

            return getcustomasset(Name .. ".font");
        end
        
        local Medium = Register_Font("Meawdawdawddium", 200, "Normal", {
            Id = "Mediumawdwad.ttf",
            Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/Inter_28pt-Medium.ttf"),
        })

        local SemiBold = Register_Font("SeawdawdawdawdmiBold", 200, "Normal", {
            Id = "SemiBoldawdawdwad.ttf",
            Font = game:HttpGet("https://github.com/i77lhm/storage/raw/refs/heads/main/fonts/Inter_28pt-SemiBold.ttf"),
        })

        fonts = {
            small = Font.new(Medium, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
            font = Font.new(SemiBold, Enum.FontWeight.Regular, Enum.FontStyle.Normal);
        }
    end
--

-- Library functions 
    -- Misc functions
        function library:tween(obj, properties, easing_style, time) 
            local tween = tween_service:Create(obj, TweenInfo.new(time or 0.25, easing_style or Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0), properties):Play()
                
            return tween
        end

        function library:resizify(frame) 
            local Frame = Instance.new("TextButton")
            Frame.Position = dim2(1, -10, 1, -10)
            Frame.BorderColor3 = rgb(0, 0, 0)
            Frame.Size = dim2(0, 10, 0, 10)
            Frame.BorderSizePixel = 0
            Frame.BackgroundColor3 = rgb(255, 255, 255)
            Frame.Parent = frame
            Frame.BackgroundTransparency = 1 
            Frame.Text = ""

            local resizing = false 
            local start_size 
            local start 
            local og_size = frame.Size  

            Frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    resizing = true
                    start = input.Position
                    start_size = frame.Size
                end
            end)

            Frame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    resizing = false
                end
            end)

            library:connection(uis.InputChanged, function(input, game_event) 
                if resizing and input.UserInputType == Enum.UserInputType.Touch then
                    local viewport_x = camera.ViewportSize.X
                    local viewport_y = camera.ViewportSize.Y

                    local current_size = dim2(
                        start_size.X.Scale,
                        math.clamp(
                            start_size.X.Offset + (input.Position.X - start.X),
                            og_size.X.Offset,
                            viewport_x
                        ),
                        start_size.Y.Scale,
                        math.clamp(
                            start_size.Y.Offset + (input.Position.Y - start.Y),
                            og_size.Y.Offset,
                            viewport_y
                        )
                    )

                    library:tween(frame, {Size = current_size}, Enum.EasingStyle.Linear, 0.05)
                end
            end)
        end 

        function fag(tbl)
            local Size = 0
            
            for _ in tbl do
                Size = Size + 1
            end
        
            return Size
        end
        
        function library:next_flag()
            local index = fag(library.flags) + 1;
            local str = string.format("flagnumber%s", index)
            
            return str;
        end 

        function library:mouse_in_frame(uiobject)
            local y_cond = uiobject.AbsolutePosition.Y <= mouse.Y and mouse.Y <= uiobject.AbsolutePosition.Y + uiobject.AbsoluteSize.Y
            local x_cond = uiobject.AbsolutePosition.X <= mouse.X and mouse.X <= uiobject.AbsolutePosition.X + uiobject.AbsoluteSize.X

            return (y_cond and x_cond)
        end

        function library:draggify(frame)
            local dragging = false 
            local start_size = frame.Position
            local start 

            frame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    start = input.Position
                    start_size = frame.Position
                end
            end)

            frame.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            library:connection(uis.InputChanged, function(input, game_event) 
                if dragging and input.UserInputType == Enum.UserInputType.Touch then
                    local viewport_x = camera.ViewportSize.X
                    local viewport_y = camera.ViewportSize.Y

                    local current_position = dim2(
                        0,
                        start_size.X.Offset + (input.Position.X - start.X),
                        0,
                        start_size.Y.Offset + (input.Position.Y - start.Y)
                    )

                    library:tween(frame, {Position = current_position}, Enum.EasingStyle.Linear, 0.05)
                    library:close_element()
                end
            end)
        end 

        function library:convert(str)
            local values = {}

            for value in string.gmatch(str, "[^,]+") do
                insert(values, tonumber(value))
            end
            
            if #values == 4 then              
                return unpack(values)
            else 
                return
            end
        end
        
        function library:convert_enum(enum)
            local enum_parts = {}
        
            for part in string.gmatch(enum, "[%w_]+") do
                insert(enum_parts, part)
            end
        
            local enum_table = Enum
            for i = 2, #enum_parts do
                local enum_item = enum_table[enum_parts[i]]
        
                enum_table = enum_item
            end
        
            return enum_table
        end

        local config_holder;
        function library:update_config_list() 
            if not config_holder then 
                return 
            end
            
            local list = {}
            
            for idx, file in listfiles(library.directory .. "/configs") do
                local name = file:gsub(library.directory .. "/configs\\", ""):gsub(".cfg", ""):gsub(library.directory .. "\\configs\\", "")
                list[#list + 1] = name
            end

            config_holder.refresh_options(list)
        end 

        function library:get_config()
            local Config = {}
            
            for _, v in next, flags do
                if type(v) == "table" and v.key then
                    Config[_] = {active = v.active, mode = v.mode, key = tostring(v.key)}
                elseif type(v) == "table" and v["Transparency"] and v["Color"] then
                    Config[_] = {Transparency = v["Transparency"], Color = v["Color"]:ToHex()}
                else
                    Config[_] = v
                end
            end 
            
            return http_service:JSONEncode(Config)
        end

        function library:load_config(config_json) 
            local config = http_service:JSONDecode(config_json)
            
            for _, v in config do 
                local function_set = library.config_flags[_]
                
                if _ == "config_name_list" then 
                    continue 
                end

                if function_set then 
                    if type(v) == "table" and v["Transparency"] and v["Color"] then
                        function_set(hex(v["Color"]), v["Transparency"])
                    elseif type(v) == "table" and v["active"] then 
                        function_set(v)
                    else
                        function_set(v)
                    end
                end 
            end 
        end 
        
        function library:round(number, float) 
            local multiplier = 1 / (float or 1)

            return floor(number * multiplier + 0.5) / multiplier
        end 

        function library:apply_theme(instance, theme, property) 
            insert(themes.utility[theme][property], instance)
        end

        function library:update_theme(theme, color)
            for _, property in themes.utility[theme] do 

                for m, object in property do 
                    if object[_] == themes.preset[theme] then 
                        object[_] = color 
                    end 
                end 
            end 

            themes.preset[theme] = color 
        end 

        function library:connection(signal, callback)
            local connection = signal:Connect(callback)
            
            insert(library.connections, connection)

            return connection 
        end

        function library:close_element(new_path) 
            local open_element = library.current_open

            if open_element and new_path ~= open_element then
                open_element.set_visible(false)
                open_element.open = false;
            end 

            if new_path ~= open_element then 
                library.current_open = new_path or nil;
            end
        end 

        function library:create(instance, options)
            local ins = Instance.new(instance) 
            
            for prop, value in options do 
                ins[prop] = value
            end
            
            return ins 
        end

        function library:unload_menu() 
            if library[ "items" ] then 
                library[ "items" ]:Destroy()
            end

            if library[ "other" ] then 
                library[ "other" ]:Destroy()
            end 
            
            for index, connection in library.connections do 
                connection:Disconnect() 
                connection = nil 
            end
            
            library = nil 
        end 
    --
    
    -- Library element functions
        function library:window(properties)
            local cfg = { 
                suffix = properties.suffix or properties.Suffix or "tech";
                name = properties.name or properties.Name or "nebula";
                game_name = properties.gameInfo or properties.game_info or properties.GameInfo or "Milenium for Counter-Strike: Global Offensive";
                size = properties.size or properties.Size or dim2(0, 700, 0, 565);
                selected_tab;
                items = {};

                tween;
            }
            
            library[ "items" ] = library:create( "ScreenGui" , {
                Parent = coregui;
                Name = "\0";
                Enabled = true;
                ZIndexBehavior = Enum.ZIndexBehavior.Global;
                IgnoreGuiInset = true;
            });

            library[ "other" ] = library:create( "ScreenGui" , {
                Parent = coregui;
                Name = "\0";
                Enabled = false;
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
                IgnoreGuiInset = true;
            }); 

            local items = cfg.items; do
                items[ "main" ] = library:create( "Frame" , {
                    Parent = library[ "items" ];
                    Size = cfg.size;
                    Name = "\0";
                    Position = dim2(0.5, -cfg.size.X.Offset / 2, 0.5, -cfg.size.Y.Offset / 2);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(14, 14, 16)
                }); items[ "main" ].Position = dim2(0, items[ "main" ].AbsolutePosition.X, 0, items[ "main" ].AbsolutePosition.Y)

                library:create( "UIScale" , {
                    Parent = items[ "main" ];
                    Scale = scale;
                });

                library:create( "UICorner" , {
                    Parent = items[ "main" ];
                    CornerRadius = dim(0, 10)
                });
                
                library:create( "UIStroke" , {
                    Color = rgb(23, 23, 29);
                    Parent = items[ "main" ];
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                });
                
                items[ "side_frame" ] = library:create( "Frame" , {
                    Parent = items[ "main" ];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 196, 1, -25);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(14, 14, 16)
                });
                
                library:create( "Frame" , {
                    AnchorPoint = vec2(1, 0);
                    Parent = items[ "side_frame" ];
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 1, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(21, 21, 23)
                });
                
                items[ "button_holder" ] = library:create( "Frame" , {
                    Parent = items[ "side_frame" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, 60);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 1, -60);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); cfg.button_holder = items[ "button_holder" ];
                
                library:create( "UIListLayout" , {
                    Parent = items[ "button_holder" ];
                    Padding = dim(0, 5);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    PaddingTop = dim(0, 16);
                    PaddingBottom = dim(0, 36);
                    Parent = items[ "button_holder" ];
                    PaddingRight = dim(0, 11);
                    PaddingLeft = dim(0, 10)
                });

                local accent = themes.preset.accent
                items[ "title" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = name;
                    Parent = items[ "side_frame" ];
                    Name = "\0";
                    Text = string.format('<u>%s</u><font color = "rgb(255, 255, 255)">%s</font>', cfg.name, cfg.suffix);
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 70);
                    TextColor3 = themes.preset.accent;
                    BorderSizePixel = 0;
                    RichText = true;
                    TextSize = 30;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "title" ], "accent", "TextColor3");
                
                items[ "multi_holder" ] = library:create( "Frame" , {
                    Parent = items[ "main" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 196, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -196, 0, 56);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); cfg.multi_holder = items[ "multi_holder" ];
                
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "multi_holder" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(21, 21, 23)
                });
                
                items[ "shadow" ] = library:create( "ImageLabel" , {
                    ImageColor3 = rgb(0, 0, 0);
                    ScaleType = Enum.ScaleType.Slice;
                    Parent = items[ "main" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Name = "\0";
                    BackgroundColor3 = rgb(255, 255, 255);
                    Size = dim2(1, 75, 1, 75);
                    AnchorPoint = vec2(0.5, 0.5);
                    Image = "rbxassetid://112971167999062";
                    BackgroundTransparency = 1;
                    Position = dim2(0.5, 0, 0.5, 0);
                    SliceScale = 0.75;
                    ZIndex = -100;
                    BorderSizePixel = 0;
                    SliceCenter = rect(vec2(112, 112), vec2(147, 147))
                });
                
                items[ "global_fade" ] = library:create( "Frame" , {
                    Parent = items[ "main" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 196, 0, 56);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -196, 1, -81);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(14, 14, 16);
                    ZIndex = 2;
                });                

                library:create( "UICorner" , {
                    Parent = items[ "shadow" ];
                    CornerRadius = dim(0, 5)
                });
                
                items[ "info" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "main" ];
                    Name = "\0";
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 25);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(23, 23, 25)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "info" ];
                    CornerRadius = dim(0, 10)
                });
                
                items[ "grey_fill" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = items[ "info" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 6);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(23, 23, 25)
                });
                
                items[ "game" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    Parent = items[ "info" ];
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.game_name;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    AnchorPoint = vec2(0, 0.5);
                    Position = dim2(0, 10, 0.5, -1);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); 
                
                if not LRM_SecondsLeft then
                    LRM_SecondsLeft = math.huge
                end

                local time_left = tostring((LRM_SecondsLeft < math.huge and ""..tostring(math.floor(((LRM_SecondsLeft / 60) / 60) / 24)).." days" or LRM_SecondsLeft == math.huge and "lifetime"))

                items[ "other_info" ] = library:create( "TextLabel" , {
                    Parent = items[ "info" ];
                    RichText = true;
                    Name = "\0";
                    TextColor3 = themes.preset.accent;
                    BorderColor3 = rgb(0, 0, 0);
                    Text = '<font color="rgb(72, 72, 73)">'..time_left..', </font>' .. cfg.name:lower() .. cfg.suffix:lower();
                    Size = dim2(1, 0, 0, 0);
                    Position = dim2(0, -10, 0.5, -1);
                    AnchorPoint = vec2(0, 0.5);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Right;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    FontFace = fonts.font;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "other_info" ], "accent", "TextColor3");        
            end 

            do -- Other
                library:draggify(items[ "main" ])
                library:resizify(items[ "main" ])
            end 

            function cfg.toggle_menu(bool) 
                -- WIP 
                -- if cfg.tween then 
                --     cfg.tween:Cancel()
                -- end 

                -- items[ "main" ].Size = dim2(items[ "main" ].Size.Scale.X, items[ "main" ].Size.Offset.X - 20, items[ "main" ].Size.Scale.Y, items[ "main" ].Size.Offset.Y - 20)
                -- library:tween(items[ "tab_holder" ], {Size = dim2(1, -196, 1, -81)}, Enum.EasingStyle.Quad, 0.4)
                -- cfg.tween = 
                
                items[ "main" ].Visible = bool
            end 

            items[ "close button" ] = library:create( "TextButton" , {
                Parent = library[ "items" ];
                Name = "\0";
                Position = dim2(0, 20, 1, -20);
                AnchorPoint = vec2(0, 1);
                BorderColor3 = rgb(0, 0, 0);
                Size = dim2(0, 75, 0, 50);
                BorderSizePixel = 0;
                Text = "";
                AutoButtonColor = false;
                Visible = true;
                BackgroundColor3 = rgb(25, 25, 29)
            });
            
            items[ "other_info" ] = library:create( "TextLabel" , {
                Parent = items[ "close button" ];
                RichText = true;
                Name = "\0";
                TextColor3 = rgb(245, 245, 245);
                BorderColor3 = rgb(0, 0, 0);
                Text = "toggle ui";
                Size = dim2(1, 0, 1, 0);
                BorderSizePixel = 0;
                BackgroundTransparency = 1;
                TextXAlignment = Enum.TextXAlignment.Center;
                FontFace = fonts.font;
                ZIndex = 2;
                TextSize = 14;
                BackgroundColor3 = rgb(255, 255, 255)
            });

            library:create( "UICorner" , {
                Parent = items[ "close button" ];
                CornerRadius = dim(0, 10)
            });
            
            library:create( "UIStroke" , {
                Color = rgb(23, 23, 29);
                Parent = items[ "close button" ];
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            });

            local open = true 
            items[ "close button" ].InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.Touch then
                    open = not open 

                    cfg.toggle_menu(open)
                end 
            end)
                
            return setmetatable(cfg, library)
        end 

        function library:tab(properties)
            local cfg = {
                name = properties.name or properties.Name or "visuals"; 
                icon = properties.icon or properties.Icon or "http://www.roblox.com/asset/?id=6034767608";
                
                -- multi 
                tabs = properties.tabs or properties.Tabs or {"Main", "Misc.", "Settings"};
                pages = {}; -- data store for multi sections
                current_multi; 
                
                items = {};
            } 

            local items = cfg.items; do 
                items[ "tab_holder" ] = library:create( "Frame" , {
                    Parent = library.cache;
                    Name = "\0";
                    Visible = false;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 196, 0, 56);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -216, 1, -101);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                -- Tab buttons 
                    items[ "button" ] = library:create( "TextButton" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(255, 255, 255);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.items[ "button_holder" ];
                        AutoButtonColor = false;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(1, 0, 0, 35);
                        BorderSizePixel = 0;
                        TextSize = 16;
                        BackgroundColor3 = rgb(29, 29, 29)
                    });
                    
                    items[ "icon" ] = library:create( "ImageLabel" , {
                        ImageColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "button" ];
                        AnchorPoint = vec2(0, 0.5);
                        Image = cfg.icon;
                        BackgroundTransparency = 1;
                        Position = dim2(0, 10, 0.5, 0);
                        Name = "\0";
                        Size = dim2(0, 22, 0, 22);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    }); library:apply_theme(items[ "icon" ], "accent", "ImageColor3");
                    
                    items[ "name" ] = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = cfg.name;
                        Parent = items[ "button" ];
                        Name = "\0";
                        Size = dim2(0, 0, 1, 0);
                        Position = dim2(0, 40, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "name" ];
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "button" ];
                        CornerRadius = dim(0, 7)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(23, 23, 29);
                        Parent = items[ "button" ];
                        Enabled = false;
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    });
                -- 

                -- Multi Sections
                    items[ "multi_section_button_holder" ] = library:create( "Frame" , {
                        Parent = library.cache;
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Visible = false;
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "multi_section_button_holder" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                        FillDirection = Enum.FillDirection.Horizontal
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingTop = dim(0, 8);
                        PaddingBottom = dim(0, 7);
                        Parent = items[ "multi_section_button_holder" ];
                        PaddingRight = dim(0, 7);
                        PaddingLeft = dim(0, 7)
                    });                        

                    for _, section in cfg.tabs do
                        local data = {items = {}} 

                        local multi_items = data.items; do 
                            -- Button
                                multi_items[ "button" ] = library:create( "TextButton" , {
                                    FontFace = fonts.font;
                                    TextColor3 = rgb(255, 255, 255);
                                    BorderColor3 = rgb(0, 0, 0);
                                    AutoButtonColor = false;
                                    Text = "";
                                    Parent = items[ "multi_section_button_holder" ];
                                    Name = "\0";
                                    Size = dim2(0, 0, 0, 39);
                                    BackgroundTransparency = 1;
                                    ClipsDescendants = true;
                                    BorderSizePixel = 0;
                                    AutomaticSize = Enum.AutomaticSize.X;
                                    TextSize = 16;
                                    BackgroundColor3 = rgb(25, 25, 29)
                                });
                                
                                multi_items[ "name" ] = library:create( "TextLabel" , {
                                    FontFace = fonts.font;
                                    TextColor3 = rgb(62, 62, 63);
                                    BorderColor3 = rgb(0, 0, 0);
                                    Text = section;
                                    Parent = multi_items[ "button" ];
                                    Name = "\0";
                                    Size = dim2(0, 0, 1, 0);
                                    BackgroundTransparency = 1;
                                    TextXAlignment = Enum.TextXAlignment.Left;
                                    BorderSizePixel = 0;
                                    AutomaticSize = Enum.AutomaticSize.XY;
                                    TextSize = 16;
                                    BackgroundColor3 = rgb(255, 255, 255)
                                });
                                
                                library:create( "UIPadding" , {
                                    Parent = multi_items[ "name" ];
                                    PaddingRight = dim(0, 5);
                                    PaddingLeft = dim(0, 5)
                                });
                                
                                multi_items[ "accent" ] = library:create( "Frame" , {
                                    BorderColor3 = rgb(0, 0, 0);
                                    AnchorPoint = vec2(0, 1);
                                    Parent = multi_items[ "button" ];
                                    BackgroundTransparency = 1;
                                    Position = dim2(0, 10, 1, 4);
                                    Name = "\0";
                                    Size = dim2(1, -20, 0, 6);
                                    BorderSizePixel = 0;
                                    BackgroundColor3 = themes.preset.accent
                                }); library:apply_theme(multi_items[ "accent" ], "accent", "BackgroundColor3");
                                
                                library:create( "UICorner" , {
                                    Parent = multi_items[ "accent" ];
                                    CornerRadius = dim(0, 999)
                                });
                                
                                library:create( "UIPadding" , {
                                    Parent = multi_items[ "button" ];
                                    PaddingRight = dim(0, 10);
                                    PaddingLeft = dim(0, 10)
                                });
                                
                                library:create( "UICorner" , {
                                    Parent = multi_items[ "button" ];
                                    CornerRadius = dim(0, 7)
                                }); 
                            --

                            -- Tab 
                                multi_items[ "tab" ] = library:create( "Frame" , {
                                    Parent = library.cache;
                                    BackgroundTransparency = 1;
                                    Name = "\0";
                                    BorderColor3 = rgb(0, 0, 0);
                                    Size = dim2(1, -20, 1, -20);
                                    BorderSizePixel = 0;
                                    Visible = false;
                                    BackgroundColor3 = rgb(255, 255, 255)
                                });
                                
                                library:create( "UIListLayout" , {
                                    FillDirection = Enum.FillDirection.Vertical;
                                    HorizontalFlex = Enum.UIFlexAlignment.Fill;
                                    Parent = multi_items[ "tab" ];
                                    Padding = dim(0, 7);
                                    SortOrder = Enum.SortOrder.LayoutOrder;
                                    VerticalFlex = Enum.UIFlexAlignment.Fill
                                });
                                
                                library:create( "UIPadding" , {
                                    PaddingTop = dim(0, 7);
                                    PaddingBottom = dim(0, 7);
                                    Parent = multi_items[ "tab" ];
                                    PaddingRight = dim(0, 7);
                                    PaddingLeft = dim(0, 7)
                                });
                            --
                        end
                        
                        data.text = multi_items[ "name" ]
                        data.accent = multi_items[ "accent" ]
                        data.button = multi_items[ "button" ]
                        data.page = multi_items[ "tab" ]
                        data.parent = setmetatable(data, library):sub_tab({}).items[ "tab_parent" ]
                        
                        -- Old column code
                        -- data.left = multi_items[ "left" ]
                        -- data.right = multi_items[ "right" ]

						function data.open_page()
							local page = cfg.current_multi; 
                            
                            if page and page.text ~= data.text then 
                                self.items[ "global_fade" ].BackgroundTransparency = 0
                                library:tween(self.items[ "global_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                                
                                local old_size = page.page.Size
                                page.page.Size = dim2(1, -20, 1, -20)
                            end

                            if page then
                                library:tween(page.text, {TextColor3 = rgb(62, 62, 63)})
                                library:tween(page.accent, {BackgroundTransparency = 1})
                                library:tween(page.button, {BackgroundTransparency = 1})

                                page.page.Visible = false
                                page.page.Parent = library[ "cache" ] 
                            end 
                            
                            library:tween(data.text, {TextColor3 = rgb(255, 255, 255)})
                            library:tween(data.accent, {BackgroundTransparency = 0})
                            library:tween(data.button, {BackgroundTransparency = 0})
                            library:tween(data.page, {Size = dim2(1, 0, 1, 0)}, Enum.EasingStyle.Quad, 0.4)

                            data.page.Visible = true
                            data.page.Parent = items["tab_holder"]

                            cfg.current_multi = data

                            library:close_element()
						end

						multi_items[ "button" ].InputBegan:Connect(function(Input)
                            if Input.UserInputType ~= Enum.UserInputType.Touch then return end
							data.open_page() 
						end)

						cfg.pages[#cfg.pages + 1] = setmetatable(data, library)
                    end 

                    cfg.pages[1].open_page()
                --
            end 

            function cfg.open_tab() 
                local selected_tab = self.selected_tab
                
                if selected_tab then 
                    if selected_tab[ 4 ] ~= items[ "tab_holder" ] then 
                        self.items[ "global_fade" ].BackgroundTransparency = 0
                        
                        library:tween(self.items[ "global_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                        selected_tab[ 4 ].Size = dim2(1, -216, 1, -101)
                    end

                    library:tween(selected_tab[ 1 ], {BackgroundTransparency = 1})
                    library:tween(selected_tab[ 2 ], {ImageColor3 = rgb(72, 72, 73)})
                    library:tween(selected_tab[ 3 ], {TextColor3 = rgb(72, 72, 73)})

                    selected_tab[ 4 ].Visible = false
                    selected_tab[ 4 ].Parent = library[ "cache" ]
                    selected_tab[ 5 ].Visible = false
                    selected_tab[ 5 ].Parent = library[ "cache" ]
                end

                library:tween(items[ "button" ], {BackgroundTransparency = 0})
                library:tween(items[ "icon" ], {ImageColor3 = themes.preset.accent})
                library:tween(items[ "name" ], {TextColor3 = rgb(255, 255, 255)})
                library:tween(items[ "tab_holder" ], {Size = dim2(1, -196, 1, -81)}, Enum.EasingStyle.Quad, 0.4)
                
                items[ "tab_holder" ].Visible = true 
                items[ "tab_holder" ].Parent = self.items[ "main" ]
                items[ "multi_section_button_holder" ].Visible = true 
                items[ "multi_section_button_holder" ].Parent = self.items[ "multi_holder" ]

                self.selected_tab = {
                    items[ "button" ];
                    items[ "icon" ];
                    items[ "name" ];
                    items[ "tab_holder" ];
                    items[ "multi_section_button_holder" ];
                }

                library:close_element()
            end

            items[ "button" ].InputBegan:Connect(function(Input)
                            if Input.UserInputType ~= Enum.UserInputType.Touch then return end
                cfg.open_tab()
            end)
            
            if not self.selected_tab then 
                cfg.open_tab(true) 
            end

            return unpack(cfg.pages)
        end

        function library:seperator(properties)
            local cfg = {items = {}, name = properties.Name or properties.name or "General"}

            local items = cfg.items do 
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = self.items[ "button_holder" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    Position = dim2(0, 40, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0; 
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });                
            end;    

            return setmetatable(cfg, library)
        end 

        -- Miscellaneous 
            function library:column(properties) 
                local cfg = {items = {}, size = properties.size or 1}

                local items = cfg.items; do     
                    items[ "column" ] = library:create( "Frame" , {
                        Parent = self[ "parent" ] or self.items["tab_parent"];
                        BackgroundTransparency = 1;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, cfg.size, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 10);
                        Parent = items[ "column" ]
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "column" ];
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        Padding = dim(0, 10);
                        FillDirection = Enum.FillDirection.Vertical;
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                end 

                return setmetatable(cfg, library)
            end 

            function library:sub_tab(properties) 
                local cfg = {items = {}, order = properties.order or 0; size = properties.size or 1}

                local items = cfg.items; do 
                    items[ "tab_parent" ] = library:create( "Frame" , {
                        Parent = self.items[ "tab" ];
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(0,0,cfg.size,0);
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        Visible = true;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalFlex = Enum.UIFlexAlignment.Fill;
                        VerticalFlex = Enum.UIFlexAlignment.Fill;
                        Parent = items[ "tab_parent" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder;
                    });
                end

                return setmetatable(cfg, library)
            end 
        --

        function library:section(properties)
            local cfg = {
                name = properties.name or properties.Name or "section"; 
                side = properties.side or properties.Side or "left";
                default = properties.default or properties.Default or false;
                size = properties.size or properties.Size or self.size or 0.5; 
                icon = properties.icon or properties.Icon or "http://www.roblox.com/asset/?id=6022668898";
                fading_toggle = properties.fading or properties.Fading or false;
                items = {};
            };
            
            local items = cfg.items; do 
                items[ "outline" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = self.items[ "column" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, cfg.size, -3);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(25, 25, 29)
                });

                library:create( "UICorner" , {
                    Parent = items[ "outline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "inline" ] = library:create( "Frame" , {
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(22, 22, 24)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "inline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "scrolling" ] = library:create( "ScrollingFrame" , {
                    ScrollBarImageColor3 = rgb(44, 44, 46);
                    Active = true;
                    AutomaticCanvasSize = Enum.AutomaticSize.Y;
                    ScrollBarThickness = 2;
                    Parent = items[ "inline" ];
                    Name = "\0";
                    Size = dim2(1, 0, 1, -40);
                    BackgroundTransparency = 1;
                    Position = dim2(0, 0, 0, 35);
                    BackgroundColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    CanvasSize = dim2(0, 0, 0, 0)
                });
                
                items[ "elements" ] = library:create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "scrolling" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 10, 0, 10);
                    Size = dim2(1, -20, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "elements" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    PaddingBottom = dim(0, 15);
                    Parent = items[ "elements" ]
                });
                
                items[ "button" ] = library:create( "TextButton" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    Size = dim2(1, -2, 0, 35);
                    BorderSizePixel = 0;
                    TextSize = 16;
                    BackgroundColor3 = rgb(19, 19, 21)
                });
                
                library:create( "UIStroke" , {
                    Color = rgb(23, 23, 29);
                    Parent = items[ "button" ];
                    Enabled = false;
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "button" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "Icon" ] = library:create( "ImageLabel" , {
                    ImageColor3 = themes.preset.accent;
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "button" ];
                    AnchorPoint = vec2(0, 0.5);
                    Image = cfg.icon;
                    BackgroundTransparency = 1;
                    Position = dim2(0, 10, 0.5, 0);
                    Name = "\0";
                    Size = dim2(0, 22, 0, 22);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "Icon" ], "accent", "ImageColor3");
                
                items[ "section_title" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "button" ];
                    Name = "\0";
                    Size = dim2(0, 0, 1, 0);
                    Position = dim2(0, 40, 0, -1);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.X;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "button" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
                
                if cfg.fading_toggle then 
                    items[ "toggle" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(1, 0.5);
                        Parent = items[ "button" ];
                        Name = "\0";
                        Position = dim2(1, -9, 0.5, 0);
                        Size = dim2(0, 36, 0, 18);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(58, 58, 62)
                    });  library:apply_theme(items[ "toggle" ], "accent", "BackgroundColor3");
                    
                    library:create( "UICorner" , {
                        Parent = items[ "toggle" ];
                        CornerRadius = dim(0, 999)
                    });
                    
                    items[ "toggle_outline" ] = library:create( "Frame" , {
                        Parent = items[ "toggle" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        BorderMode = Enum.BorderMode.Inset;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(50, 50, 50)
                    });  library:apply_theme(items[ "toggle_outline" ], "accent", "BackgroundColor3");
                    
                    library:create( "UICorner" , {
                        Parent = items[ "toggle_outline" ];
                        CornerRadius = dim(0, 999)
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))};
                        Parent = items[ "toggle_outline" ]
                    });
                    
                    items[ "toggle_circle" ] = library:create( "Frame" , {
                        Parent = items[ "toggle_outline" ];
                        Name = "\0";
                        Position = dim2(0, 2, 0, 2);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 12, 0, 12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(86, 86, 88)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "toggle_circle" ];
                        CornerRadius = dim(0, 999)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "outline" ];
                        CornerRadius = dim(0, 7)
                    });
                
                    items[ "fade" ] = library:create( "Frame" , {
                        Parent = items[ "outline" ];
                        BackgroundTransparency = 0.800000011920929;
                        Name = "\0";
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "fade" ];
                        CornerRadius = dim(0, 7)
                    });
                end 
            end;

            if cfg.fading_toggle then
                items[ "button" ].InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.Touch then
                        cfg.default = not cfg.default 
                        cfg.toggle_section(cfg.default) 
                    end 
                end)

                function cfg.toggle_section(bool)
                    library:tween(items[ "toggle" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "toggle_outline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "toggle_circle" ], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(86, 86, 88), Position = bool and dim2(1, -14, 0, 2) or dim2(0, 2, 0, 2)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "fade" ], {BackgroundTransparency = bool and 1 or 0.8}, Enum.EasingStyle.Quad)
                end 
            end 

            return setmetatable(cfg, library)
        end  

        function library:toggle(options) 
            local rand = math.random(1, 2) 
            local cfg = {
                enabled = options.default or false,
                name = options.name or "Toggle",
                info = options.info or nil,
                flag = options.flag or library:next_flag(),
                
                type = options.type and string.lower(options.type) or rand == 1 and "toggle" or "checkbox"; -- "toggle", "checkbox"

                default = options.default or false,
                folding = options.folding or false, 
                callback = options.callback or function() end,

                items = {};
                seperator = options.seperator or options.Seperator or false;
            }

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do
                items[ "toggle" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "toggle" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                if cfg.info then 
                    items[ "info" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(130, 130, 130);
                        BorderColor3 = rgb(0, 0, 0);
                        TextWrapped = true;
                        Text = cfg.info;
                        Parent = items[ "toggle" ];
                        Name = "\0";
                        Position = dim2(0, 5, 0, 17);
                        Size = dim2(1, -10, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end 
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "toggle" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 9);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                -- Toggle
                    if cfg.type == "checkbox" then 
                        items[ "toggle_button" ] = library:create( "TextButton" , {
                            FontFace = fonts.small;
                            TextColor3 = rgb(0, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "";
                            LayoutOrder = 2;
                            AutoButtonColor = false;
                            AnchorPoint = vec2(1, 0);
                            Parent = items[ "right_components" ];
                            Name = "\0";
                            Position = dim2(1, 0, 0, 0);
                            Size = dim2(0, 16, 0, 16);
                            BorderSizePixel = 0;
                            TextSize = 14;
                            BackgroundColor3 = rgb(67, 67, 68)
                        }); library:apply_theme(items[ "toggle_button" ], "accent", "BackgroundColor3");
                        
                        library:create( "UICorner" , {
                            Parent = items[ "toggle_button" ];
                            CornerRadius = dim(0, 4)
                        });
                        
                        items[ "outline" ] = library:create( "Frame" , {
                            Parent = items[ "toggle_button" ];
                            Size = dim2(1, -2, 1, -2);
                            Name = "\0";
                            BorderMode = Enum.BorderMode.Inset;
                            BorderColor3 = rgb(0, 0, 0);
                            Position = dim2(0, 1, 0, 1);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(22, 22, 24)
                        }); library:apply_theme(items[ "outline" ], "accent", "BackgroundColor3");
                        
                        items[ "tick" ] = library:create( "ImageLabel" , {
                            ImageTransparency = 1;
                            BorderColor3 = rgb(0, 0, 0);
                            Image = "rbxassetid://111862698467575";
                            BackgroundTransparency = 1;
                            Position = dim2(0, -1, 0, 0);
                            Parent = items[ "outline" ];
                            Size = dim2(1, 2, 1, 2);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255);
                            ZIndex = 1;
                        });

                        library:create( "UICorner" , {
                            Parent = items[ "outline" ];
                            CornerRadius = dim(0, 4)
                        });
                        
                        library:create( "UIGradient" , {
                            Enabled = false;
                            Parent = items[ "outline" ];
                            Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))}
                        });  
                    else 
                        items[ "toggle_button" ] = library:create( "TextButton" , {
                            FontFace = fonts.font;
                            TextColor3 = rgb(0, 0, 0);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = "";
                            LayoutOrder = 2;
                            AnchorPoint = vec2(1, 0.5);
                            Parent = items[ "right_components" ];
                            Name = "\0";
                            Position = dim2(1, -9, 0.5, 0);
                            Size = dim2(0, 36, 0, 18);
                            BorderSizePixel = 0;
                            TextSize = 14;
                            BackgroundColor3 = themes.preset.accent
                        }); library:apply_theme(items[ "toggle_button" ], "accent", "BackgroundColor3");
                        
                        library:create( "UICorner" , {
                            Parent = items[ "toggle_button" ];
                            CornerRadius = dim(0, 999)
                        });
                        
                        items[ "inline" ] = library:create( "Frame" , {
                            Parent = items[ "toggle_button" ];
                            Size = dim2(1, -2, 1, -2);
                            Name = "\0";
                            BorderMode = Enum.BorderMode.Inset;
                            BorderColor3 = rgb(0, 0, 0);
                            Position = dim2(0, 1, 0, 1);
                            BorderSizePixel = 0;
                            BackgroundColor3 = themes.preset.accent
                        }); library:apply_theme(items[ "inline" ], "accent", "BackgroundColor3");
                        
                        library:create( "UICorner" , {
                            Parent = items[ "inline" ];
                            CornerRadius = dim(0, 999)
                        });
                        
                        library:create( "UIGradient" , {
                            Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))};
                            Parent = items[ "inline" ]
                        });
                        
                        items[ "circle" ] = library:create( "Frame" , {
                            Parent = items[ "inline" ];
                            Name = "\0";
                            Position = dim2(1, -14, 0, 2);
                            BorderColor3 = rgb(0, 0, 0);
                            Size = dim2(0, 12, 0, 12);
                            BorderSizePixel = 0;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                        
                        library:create( "UICorner" , {
                            Parent = items[ "circle" ];
                            CornerRadius = dim(0, 999)
                        });                        
                    end 
                --                
            end;
            
            function cfg.set(bool)
                if cfg.type == "checkbox" then 
                    library:tween(items[ "tick" ], {Rotation = bool and 0 or 45, ImageTransparency = bool and 0 or 1})
                    library:tween(items[ "toggle_button" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(67, 67, 68)})
                    library:tween(items[ "outline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(22, 22, 24)})
                else
                    library:tween(items[ "toggle_button" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(58, 58, 62)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "inline" ], {BackgroundColor3 = bool and themes.preset.accent or rgb(50, 50, 50)}, Enum.EasingStyle.Quad)
                    library:tween(items[ "circle" ], {BackgroundColor3 = bool and rgb(255, 255, 255) or rgb(86, 86, 88), Position = bool and dim2(1, -14, 0, 2) or dim2(0, 2, 0, 2)}, Enum.EasingStyle.Quad)
                end

                cfg.enabled = bool
                cfg.callback(bool)

                if cfg.folding then 
                    elements.Visible = bool
                end

                flags[cfg.flag] = bool
            end 
            
            items[ "toggle" ].InputBegan:Connect(function(Input)
                if Input.UserInputType ~= Enum.UserInputType.Touch then return end
                cfg.enabled = not cfg.enabled 
                cfg.set(cfg.enabled)
            end)

            items[ "toggle_button" ].InputBegan:Connect(function(Input)
                if Input.UserInputType ~= Enum.UserInputType.Touch then return end
                cfg.enabled = not cfg.enabled 
                cfg.set(cfg.enabled)
            end)
            
            if cfg.seperator then -- ok bro my lua either sucks or this was a pain in the ass to make (simple if statement aswell 💔)
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end

            cfg.set(cfg.default)

            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 
        
        function library:slider(options) 
            local cfg = {
                name = options.name or nil,
                suffix = options.suffix or "",
                flag = options.flag or library:next_flag(),
                callback = options.callback or function() end, 
                info = options.info or nil; 

                -- value settings
                min = options.min or options.minimum or 0,
                max = options.max or options.maximum or 100,
                intervals = options.interval or options.decimal or 1,
                default = options.default or 10,
                value = options.default or 10, 
                seperator = options.seperator or options.Seperator or false;

                dragging = false,
                items = {}
            } 

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do
                items[ "slider_object" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "slider_object" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                if cfg.info then 
                    items[ "info" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(130, 130, 130);
                        BorderColor3 = rgb(0, 0, 0);
                        TextWrapped = true;
                        Text = cfg.info;
                        Parent = items[ "slider_object" ];
                        Name = "\0";
                        Position = dim2(0, 5, 0, 37);
                        Size = dim2(1, -10, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end 

                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "slider_object" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 4, 0, 23);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });
                
                items[ "slider" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    AnchorPoint = vec2(1, 0);
                    Parent = items[ "right_components" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    Size = dim2(1, -4, 0, 4);
                    BorderSizePixel = 0;
                    TextSize = 14;
                    BackgroundColor3 = rgb(33, 33, 35)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "slider" ];
                    CornerRadius = dim(0, 999)
                });
                
                items[ "fill" ] = library:create( "Frame" , {
                    Name = "\0";
                    Parent = items[ "slider" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0.5, 0, 0, 4);
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });  library:apply_theme(items[ "fill" ], "accent", "BackgroundColor3");
                
                library:create( "UICorner" , {
                    Parent = items[ "fill" ];
                    CornerRadius = dim(0, 999)
                });
                
                items[ "circle" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0.5, 0.5);
                    Parent = items[ "fill" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0.5, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 12, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(244, 244, 244)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "circle" ];
                    CornerRadius = dim(0, 999)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "right_components" ];
                    PaddingTop = dim(0, 4)
                });
                
                items[ "value" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "50%";
                    Parent = items[ "slider_object" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    Position = dim2(0, 6, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Right;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "value" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });                
            end 

            function cfg.changetext(text)
                items['name'].Text = text
            end 

            function cfg.set(value)
                cfg.value = clamp(library:round(value, cfg.intervals), cfg.min, cfg.max)

                library:tween(items[ "fill" ], {Size = dim2((cfg.value - cfg.min) / (cfg.max - cfg.min), cfg.value == cfg.min and 0 or -4, 0, 2)}, Enum.EasingStyle.Linear, 0.05)
                items[ "value" ].Text = tostring(cfg.value) .. cfg.suffix

                flags[cfg.flag] = cfg.value
                cfg.callback(flags[cfg.flag])
            end

            items[ "slider" ].InputBegan:Connect(function(Input)
                            if Input.UserInputType ~= Enum.UserInputType.Touch then return end
                cfg.dragging = true 
                library:tween(items[ "value" ], {TextColor3 = rgb(255, 255, 255)}, Enum.EasingStyle.Quad, 0.2)
            end)

            library:connection(uis.InputChanged, function(input)
                if cfg.dragging and input.UserInputType == Enum.UserInputType.Touch then 
                    local size_x = (input.Position.X - items[ "slider" ].AbsolutePosition.X) / items[ "slider" ].AbsoluteSize.X
                    local value = ((cfg.max - cfg.min) * size_x) + cfg.min
                    cfg.set(value)
                end
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    cfg.dragging = false
                    library:tween(items[ "value" ], {TextColor3 = rgb(72, 72, 73)}, Enum.EasingStyle.Quad, 0.2) 
                end 
            end)

            if cfg.seperator then 
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end 

            cfg.set(cfg.default)
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 

        function library:dropdown(options) 
            local cfg = {
                name = options.name or nil;
                info = options.info or nil;
                flag = options.flag or library:next_flag();
                options = options.items or {""};
                callback = options.callback or function() end;
                multi = options.multi or false;
                scrolling = options.scrolling or false;

                width = options.width or 130;

                -- Ignore these 
                open = false;
                option_instances = {};
                multi_items = {};
                ignore = options.ignore or false;
                items = {};
                y_size;
                seperator = options.seperator or options.Seperator or true;
            }   

            cfg.default = options.default or (cfg.multi and {cfg.items[1]}) or cfg.items[1] or "None"
            flags[cfg.flag] = cfg.default

            local items = cfg.items; do 
                -- Element
                    items[ "dropdown_object" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.items[ "elements" ];
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "name" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(245, 245, 245);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "Dropdown";
                        Parent = items[ "dropdown_object" ];
                        Name = "\0";
                        Size = dim2(1, 0, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    if cfg.info then 
                        items[ "info" ] = library:create( "TextLabel" , {
                            FontFace = fonts.small;
                            TextColor3 = rgb(130, 130, 130);
                            BorderColor3 = rgb(0, 0, 0);
                            TextWrapped = true;
                            Text = cfg.info;
                            Parent = items[ "dropdown_object" ];
                            Name = "\0";
                            Position = dim2(0, 5, 0, 17);
                            Size = dim2(1, -10, 0, 0);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            TextSize = 16;
                            BackgroundColor3 = rgb(255, 255, 255)
                        });
                    end 

                    library:create( "UIPadding" , {
                        Parent = items[ "name" ];
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    items[ "right_components" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown_object" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalAlignment = Enum.HorizontalAlignment.Right;
                        Parent = items[ "right_components" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    items[ "dropdown" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = items[ "right_components" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(0, cfg.width, 0, 16);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "dropdown" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "sub_text" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(86, 86, 87);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "awdawdawdawdawdawdawdaw";
                        Parent = items[ "dropdown" ];
                        Name = "\0";
                        Size = dim2(1, -12, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        TextTruncate = Enum.TextTruncate.AtEnd;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "sub_text" ];
                        PaddingTop = dim(0, 1);
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    items[ "indicator" ] = library:create( "ImageLabel" , {
                        ImageColor3 = rgb(86, 86, 87);
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "dropdown" ];
                        AnchorPoint = vec2(1, 0.5);
                        Image = "rbxassetid://101025591575185";
                        BackgroundTransparency = 1;
                        Position = dim2(1, -5, 0.5, 0);
                        Name = "\0";
                        Size = dim2(0, 12, 0, 12);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                -- 

                -- Element Holder
                    items[ "dropdown_holder" ] = library:create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = library[ "items" ];
                        Name = "\0";
                        Visible = true;
                        BackgroundTransparency = 1;
                        Size = dim2(0, 0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0);
                        ZIndex = 10;
                    });
                    
                    items[ "outline" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown_holder" ];
                        Size = dim2(1, 0, 1, 0);
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(33, 33, 35);
                        ZIndex = 10;
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 6);
                        PaddingTop = dim(0, 3);
                        PaddingLeft = dim(0, 3);
                        Parent = items[ "outline" ]
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "outline" ];
                        Padding = dim(0, 5);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "outline" ];
                        CornerRadius = dim(0, 4)
                    });
                -- 
            end 

            function cfg.render_option(text)
                local button = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(72, 72, 73);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = text;
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Size = dim2(1, -12, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255);
                    ZIndex = 10;
                }); library:apply_theme(button, "accent", "TextColor3");
                
                library:create( "UIPadding" , {
                    Parent = button;
                    PaddingTop = dim(0, 1);
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                return button
            end
            
            function cfg.set_visible(bool)
                local a = bool and cfg.y_size or 0
                library:tween(items[ "dropdown_holder" ], {Size = dim_offset(items[ "dropdown" ].AbsoluteSize.X, a)})

                items[ "dropdown_holder" ].Position = dim2(0, items[ "dropdown" ].AbsolutePosition.X, 0, items[ "dropdown" ].AbsolutePosition.Y + 80)
                if not (self.sanity and library.current_open == self) then 
                    library:close_element(cfg)
                end
            end
            
            function cfg.set(value)
                local selected = {}
                local isTable = type(value) == "table"

                for _, option in cfg.option_instances do 
                    if option.Text == value or (isTable and find(value, option.Text)) then 
                        insert(selected, option.Text)
                        cfg.multi_items = selected
                        option.TextColor3 = themes.preset.accent
                    else
                        option.TextColor3 = rgb(72, 72, 73)
                    end
                end

                items[ "sub_text" ].Text = isTable and concat(selected, ", ") or selected[1] or ""
                flags[cfg.flag] = isTable and selected or selected[1]
                
                cfg.callback(flags[cfg.flag]) 
            end
            
            function cfg.refresh_options(list) 
                cfg.y_size = 0

                for _, option in cfg.option_instances do 
                    option:Destroy() 
                end
                
                cfg.option_instances = {} 

                for _, option in list do 
                    local button = cfg.render_option(option)
                    cfg.y_size += button.AbsoluteSize.Y + 6 -- super annoying manual sizing but oh well
                    insert(cfg.option_instances, button)
                    
                    button.InputBegan:Connect(function(Input)
                            if Input.UserInputType ~= Enum.UserInputType.Touch then return end
                        if cfg.multi then 
                            local selected_index = find(cfg.multi_items, button.Text)
                            
                            if selected_index then 
                                remove(cfg.multi_items, selected_index)
                            else
                                insert(cfg.multi_items, button.Text)
                            end
                            
                            cfg.set(cfg.multi_items) 				
                        else 
                            cfg.set_visible(false)
                            cfg.open = false 
                            
                            cfg.set(button.Text)
                        end
                    end)
                end
            end

            items[ "dropdown" ].InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.Touch then
                    cfg.open = not cfg.open  
                    cfg.set_visible(cfg.open)
                end 
            end)

            if cfg.seperator then 
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end 

            flags[cfg.flag] = {} 
            config_flags[cfg.flag] = cfg.set
            
            cfg.refresh_options(cfg.options)
            cfg.set(cfg.default)
                
            return setmetatable(cfg, library)
        end

        function library:label(options)
            local cfg = {
                enabled = options.enabled or nil,
                name = options.name or "Toggle",
                seperator = options.seperator or options.Seperator or false;
                info = options.info or nil; 

                items = {};
            }

            local items = cfg.items; do 
                items[ "label" ] = library:create( "TextButton" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "label" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });

                if cfg.info then 
                    items[ "info" ] = library:create( "TextLabel" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(130, 130, 130);
                        BorderColor3 = rgb(0, 0, 0);
                        TextWrapped = true;
                        Text = cfg.info;
                        Parent = items[ "label" ];
                        Name = "\0";
                        Position = dim2(0, 5, 0, 17);
                        Size = dim2(1, -10, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                end 
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "label" ];
                    Name = "\0";
                    Position = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 1, 0);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    FillDirection = Enum.FillDirection.Horizontal;
                    HorizontalAlignment = Enum.HorizontalAlignment.Right;
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 9);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });                
            end 

            if cfg.seperator then 
                library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = self.items[ "elements" ];
                    Position = dim2(0, 0, 1, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 1, 0, 1);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(36, 36, 37)
                });
            end 

            return setmetatable(cfg, library)
        end 
        
        function library:colorpicker(options) 
            local cfg = {
                name = options.name or "Color", 
                flag = options.flag or library:next_flag(),

                color = options.color or color(1, 1, 1), -- Default to white color if not provided
                alpha = options.alpha and 1 - options.alpha or 0,
                
                open = false, 
                callback = options.callback or function() end,
                items = {};

                seperator = options.seperator or options.Seperator or false;
            }

            local dragging_sat = false 
            local dragging_hue = false 
            local dragging_alpha = false 

            local h, s, v = cfg.color:ToHSV() 
            local a = cfg.alpha 

            flags[cfg.flag] = {Color = cfg.color, Transparency = cfg.alpha}

            local label; 
            if not self.items.right_components then 
                label = self:label({name = cfg.name, seperator = cfg.seperator})
            end

            local items = cfg.items; do 
                -- Component
                    items[ "colorpicker" ] = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = label and label.items.right_components or self.items[ "right_components" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(0, 16, 0, 16);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(54, 31, 184)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "colorpicker" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "colorpicker_inline" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker" ];
                        Size = dim2(1, -2, 1, -2);
                        Name = "\0";
                        BorderMode = Enum.BorderMode.Inset;
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(0, 1, 0, 1);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(54, 31, 184)
                    });

                                    library:create( "UIScale" , {
                    Parent = items[ "colorpicker_inline" ];
                    Scale = scale;
                });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "colorpicker_inline" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(211, 211, 211)), rgbkey(1, rgb(211, 211, 211))};
                        Parent = items[ "colorpicker_inline" ]
                    });         
                --
                
                -- Colorpicker
                    items[ "colorpicker_holder" ] = library:create( "Frame" , {
                        Parent = library[ "other" ];
                        Name = "\0";
                        Position = dim2(0.20000000298023224, 20, 0.296999990940094, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 166, 0, 197);
                        BorderSizePixel = 0;
                        Visible = true;
                        BackgroundColor3 = rgb(25, 25, 29)
                    });

                    items[ "colorpicker_fade" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_holder" ];
                        Name = "\0";
                        BackgroundTransparency = 0;
                        Position = dim2(0, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        ZIndex = 100;
                        BackgroundColor3 = rgb(25, 25, 29)
                    });
                    
                    items[ "colorpicker_components" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_holder" ];
                        Name = "\0";
                        Position = dim2(0, 1, 0, 1);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -2, 1, -2);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(22, 22, 24)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "colorpicker_components" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    items[ "saturation_holder" ] = library:create( "Frame" , {
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        Position = dim2(0, 7, 0, 7);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -14, 1, -80);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 39, 39)
                    });
                    
                    items[ "sat" ] = library:create( "TextButton" , {
                        Parent = items[ "saturation_holder" ];
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
                        Text = "";
                        AutoButtonColor = false;
                        BorderColor3 = rgb(0, 0, 0);
                        ZIndex = 2;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "sat" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    library:create( "UIGradient" , {
                        Rotation = 270;
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)};
                        Parent = items[ "sat" ];
                        Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(0, 0, 0))}
                    });
                    
                    items[ "val" ] = library:create( "Frame" , {
                        Name = "\0";
                        Parent = items[ "saturation_holder" ];
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIGradient" , {
                        Parent = items[ "val" ];
                        Transparency = numseq{numkey(0, 0), numkey(1, 1)}
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "val" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "saturation_holder" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "satvalpicker" ] = library:create( "TextButton" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(0, 1);
                        Parent = items[ "saturation_holder" ];
                        Name = "\0";
                        Position = dim2(0, 0, 4, 0);
                        Size = dim2(0, 8, 0, 8);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "satvalpicker" ];
                        CornerRadius = dim(0, 9999)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        Parent = items[ "satvalpicker" ];
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    });
                    
                    items[ "hue_gradient" ] = library:create( "TextButton" , {
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        Position = dim2(0, 10, 1, -64);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -20, 0, 8);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255);
                        AutoButtonColor = false;
                        Text = "";
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(255, 0, 0)), rgbkey(0.17, rgb(255, 255, 0)), rgbkey(0.33, rgb(0, 255, 0)), rgbkey(0.5, rgb(0, 255, 255)), rgbkey(0.67, rgb(0, 0, 255)), rgbkey(0.83, rgb(255, 0, 255)), rgbkey(1, rgb(255, 0, 0))};
                        Parent = items[ "hue_gradient" ]
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "hue_gradient" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    items[ "hue_picker" ] = library:create( "TextButton" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(0, 0.5);
                        Parent = items[ "hue_gradient" ];
                        Name = "\0";
                        Position = dim2(0, 0, 0.5, 0);
                        Size = dim2(0, 8, 0, 8);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "hue_picker" ];
                        CornerRadius = dim(0, 9999)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        Parent = items[ "hue_picker" ];
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    });
                    
                    items[ "alpha_gradient" ] = library:create( "TextButton" , {
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        Position = dim2(0, 10, 1, -46);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(1, -20, 0, 8);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(25, 25, 29);
                        AutoButtonColor = false;
                        Text = "";
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "alpha_gradient" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    items[ "alpha_picker" ] = library:create( "TextButton" , {
                        BorderColor3 = rgb(0, 0, 0);
                        AutoButtonColor = false;
                        Text = "";
                        AnchorPoint = vec2(0, 0.5);
                        Parent = items[ "alpha_gradient" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0.5, 0);
                        Size = dim2(0, 8, 0, 8);
                        ZIndex = 5;
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 0, 0)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "alpha_picker" ];
                        CornerRadius = dim(0, 9999)
                    });
                    
                    library:create( "UIStroke" , {
                        Color = rgb(255, 255, 255);
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                        Parent = items[ "alpha_picker" ]
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(0, 0, 0)), rgbkey(1, rgb(255, 255, 255))};
                        Parent = items[ "alpha_gradient" ]
                    });
                    
                    items[ "alpha_indicator" ] = library:create( "ImageLabel" , {
                        ScaleType = Enum.ScaleType.Tile;
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = items[ "alpha_gradient" ];
                        Image = "rbxassetid://18274452449";
                        BackgroundTransparency = 1;
                        Name = "\0";
                        Size = dim2(1, 0, 1, 0);
                        TileSize = dim2(0, 6, 0, 6);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    library:create( "UIGradient" , {
                        Color = rgbseq{rgbkey(0, rgb(112, 112, 112)), rgbkey(1, rgb(255, 0, 0))};
                        Transparency = numseq{numkey(0, 0.8062499761581421), numkey(1, 0)};
                        Parent = items[ "alpha_indicator" ]
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "alpha_indicator" ];
                        CornerRadius = dim(0, 6)
                    });
                    
                    library:create( "UIGradient" , {
                        Rotation = 90;
                        Parent = items[ "colorpicker_components" ];
                        Color = rgbseq{rgbkey(0, rgb(255, 255, 255)), rgbkey(1, rgb(66, 66, 66))}
                    });

                    items[ "input" ] = library:create( "TextBox" , {
                        FontFace = fonts.font;
                        AnchorPoint = vec2(1, 1);
                        Text = "";
                        Parent = items[ "colorpicker_components" ];
                        Name = "\0";
                        TextTruncate = Enum.TextTruncate.AtEnd;
                        BorderSizePixel = 0;
                        PlaceholderColor3 = rgb(255, 255, 255);
                        CursorPosition = -1;
                        ClearTextOnFocus = false;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255);
                        TextColor3 = rgb(72, 72, 72);
                        BorderColor3 = rgb(0, 0, 0);
                        Position = dim2(1, -8, 1, -11);
                        Size = dim2(1, -16, 0, 18);
                        BackgroundColor3 = rgb(33, 33, 35)
                    }); 
                    
                    library:create( "UICorner" , {
                        Parent = items[ "input" ];
                        CornerRadius = dim(0, 3)
                    });
                    
                    items[ "UICorenr" ] = library:create( "UICorner" , { -- fire misstypo (im not fixing this RAWR)
                        Parent = items[ "colorpicker_holder" ];
                        Name = "\0";
                        CornerRadius = dim(0, 4)
                    });
                --                  
            end;

            function cfg.set_visible(bool)
                items[ "colorpicker_fade" ].BackgroundTransparency = 0
                items[ "colorpicker_holder" ].Parent = bool and library[ "items" ] or library[ "other" ]
                items[ "colorpicker_holder" ].Position = dim_offset(items[ "colorpicker" ].AbsolutePosition.X, items[ "colorpicker" ].AbsolutePosition.Y + items[ "colorpicker" ].AbsoluteSize.Y + 45)

                library:tween(items[ "colorpicker_fade" ], {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, 0.4)
                library:tween(items[ "colorpicker_holder" ], {Position = items[ "colorpicker_holder" ].Position + dim_offset(0, 20)}) -- p100 check
                
                if not (self.sanity and library.current_open == self and self.open) then 
                    library:close_element(cfg)
                end
            end

            function cfg.set(color, alpha)
                if type(color) == "boolean" then 
                    return
                end 

                if color then 
                    h, s, v = color:ToHSV()
                end
                
                if alpha then 
                    a = alpha
                end 
                
                local Color = hsv(h, s, v)

                -- Ok so quick story, should I cache any of this? no...?? anyways I know this code is very bad but its your fault for buying a ui with animations (on a serious note im too lazy to make this look nice)
                -- Also further note, yeah I kind of did this scale_factor * size-valuesize.plane because then I would have to do tomfoolery to make it clip properly.
                library:tween(items[ "hue_picker" ], {Position = dim2(0, (items[ "hue_gradient" ].AbsoluteSize.X - items[ "hue_picker" ].AbsoluteSize.X) * h, 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
                library:tween(items[ "alpha_picker" ], {Position = dim2(0, (items[ "alpha_gradient" ].AbsoluteSize.X - items[ "alpha_picker" ].AbsoluteSize.X) * (1 - a), 0.5, 0)}, Enum.EasingStyle.Linear, 0.05)
                library:tween(items[ "satvalpicker" ], {Position = dim2(0, s * (items[ "saturation_holder" ].AbsoluteSize.X - items[ "satvalpicker" ].AbsoluteSize.X), 1, 1 - v * (items[ "saturation_holder" ].AbsoluteSize.Y - items[ "satvalpicker" ].AbsoluteSize.Y))}, Enum.EasingStyle.Linear, 0.05)

                items[ "alpha_indicator" ]:FindFirstChildOfClass("UIGradient").Color = rgbseq{rgbkey(0, rgb(112, 112, 112)), rgbkey(1, hsv(h, 1, 1))}; -- shit code
                
                items[ "colorpicker" ].BackgroundColor3 = Color
                items[ "colorpicker_inline" ].BackgroundColor3 = Color
                items[ "saturation_holder" ].BackgroundColor3 = hsv(h, 1, 1)

                items[ "hue_picker" ].BackgroundColor3 = hsv(h, 1, 1)
                items[ "alpha_picker" ].BackgroundColor3 = hsv(h, 1, 1 - a)
                items[ "satvalpicker" ].BackgroundColor3 = hsv(h, s, v)

                flags[cfg.flag] = {
                    Color = Color;
                    Transparency = a 
                }
                
                local color = items[ "colorpicker" ].BackgroundColor3
                items[ "input" ].Text = string.format("%s, %s, %s, ", library:round(color.R * 255), library:round(color.G * 255), library:round(color.B * 255))
                items[ "input" ].Text ..= library:round(1 - a, 0.01)
                
                cfg.callback(Color, a)
            end
            
            function cfg.update_color() 
                local mouse = uis:GetMouseLocation() 
                local offset = vec2(mouse.X, mouse.Y - gui_offset) 

                if dragging_sat then	
                    s = math.clamp((offset - items["sat"].AbsolutePosition).X / items["sat"].AbsoluteSize.X, 0, 1)
                    v = 1 - math.clamp((offset - items["sat"].AbsolutePosition).Y / items["sat"].AbsoluteSize.Y, 0, 1)
                elseif dragging_hue then
                    h = math.clamp((offset - items[ "hue_gradient" ].AbsolutePosition).X / items[ "hue_gradient" ].AbsoluteSize.X, 0, 1)
                elseif dragging_alpha then
                    a = 1 - math.clamp((offset - items[ "alpha_gradient" ].AbsolutePosition).X / items[ "alpha_gradient" ].AbsoluteSize.X, 0, 1)
                end

                cfg.set()
            end

            items[ "colorpicker" ].InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.Touch then
                    cfg.open = not cfg.open 

                    cfg.set_visible(cfg.open)   
                end          
            end)

            uis.InputChanged:Connect(function(input)
                if (dragging_sat or dragging_hue or dragging_alpha) and input.UserInputType == Enum.UserInputType.Touch then
                    cfg.update_color() 
                end
            end)

            library:connection(uis.InputEnded, function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    dragging_sat = false
                    dragging_hue = false
                    dragging_alpha = false
                end
            end)    

            items[ "alpha_gradient" ].InputBegan:Connect(function(Input)
                            if Input.UserInputType ~= Enum.UserInputType.Touch then return end
                dragging_alpha = true 
            end)
            
            items[ "hue_gradient" ].InputBegan:Connect(function(Input)
                            if Input.UserInputType ~= Enum.UserInputType.Touch then return end
                dragging_hue = true 
            end)
            
            items[ "sat" ].InputBegan:Connect(function(Input)
                            if Input.UserInputType ~= Enum.UserInputType.Touch then return end
                dragging_sat = true  
            end)

            items[ "input" ].FocusLost:Connect(function()
                local text = items[ "input" ].Text
                local r, g, b, a = library:convert(text)
                
                if r and g and b and a then 
                    cfg.set(rgb(r, g, b), 1 - a)
                end 
            end)

            items[ "input" ].Focused:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(245, 245, 245)})
            end)

            items[ "input" ].FocusLost:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(72, 72, 72)})
            end)
            
            cfg.set(cfg.color, cfg.alpha)
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end 

        function library:textbox(options) 
            local cfg = {
                name = options.name or "TextBox",
                placeholder = options.placeholder or options.placeholdertext or options.holder or options.holdertext or "type here...",
                default = options.default or "",
                flag = options.flag or library:next_flag(),
                callback = options.callback or function() end,
                visible = options.visible or true,
                items = {};
            }

            flags[cfg.flag] = cfg.default

            local items = cfg.items; do 
                items[ "textbox" ] = library:create( "TextButton" , {
                    LayoutOrder = -1;
                    FontFace = fonts.font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "textbox" ];
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 16;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "name" ];
                    PaddingRight = dim(0, 5);
                    PaddingLeft = dim(0, 5)
                });
                
                items[ "right_components" ] = library:create( "Frame" , {
                    Parent = items[ "textbox" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 4, 0, 19);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, 0, 0, 12);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "right_components" ];
                    Padding = dim(0, 7);
                    SortOrder = Enum.SortOrder.LayoutOrder;
                    FillDirection = Enum.FillDirection.Horizontal
                });
                
                items[ "input" ] = library:create( "TextBox" , {
                    FontFace = fonts.font;
                    Text = "";
                    Parent = items[ "right_components" ];
                    Name = "\0";
                    TextTruncate = Enum.TextTruncate.AtEnd;
                    BorderSizePixel = 0;
                    PlaceholderColor3 = rgb(255, 255, 255);
                    CursorPosition = -1;
                    ClearTextOnFocus = false;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255);
                    TextColor3 = rgb(72, 72, 72);
                    BorderColor3 = rgb(0, 0, 0);
                    Position = dim2(1, 0, 0, 0);
                    Size = dim2(1, -4, 0, 30);
                    BackgroundColor3 = rgb(33, 33, 35)
                }); 

                library:create( "UICorner" , {
                    Parent = items[ "input" ];
                    CornerRadius = dim(0, 3)
                });                
                
                library:create( "UIPadding" , {
                    Parent = items[ "right_components" ];
                    PaddingTop = dim(0, 4);
                    PaddingRight = dim(0, 4)
                });
            end 
            
            function cfg.set(text) 
                flags[cfg.flag] = text

                items[ "input" ].Text = text

                cfg.callback(text)
            end 
            
            items[ "input" ]:GetPropertyChangedSignal("Text"):Connect(function()
                cfg.set(items[ "input" ].Text) 
            end)

            items[ "input" ].Focused:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(245, 245, 245)})
            end)

            items[ "input" ].FocusLost:Connect(function()
                library:tween(items[ "input" ], {TextColor3 = rgb(72, 72, 72)})
            end)
                
            if cfg.default then 
                cfg.set(cfg.default) 
            end

            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end

        function library:keybind(options) 
            local cfg = {
                flag = options.flag or library:next_flag(),
                callback = options.callback or function() end,
                name = options.name or nil, 
                ignore_key = options.ignore or false, 

                key = options.key or nil, 
                mode = options.mode or "Toggle",
                active = options.default or false, 

                open = false,
                binding = nil, 

                hold_instances = {},
                items = {};
            }

            flags[cfg.flag] = {
                mode = cfg.mode,
                key = cfg.key, 
                active = cfg.active
            }

            local items = cfg.items; do 
                -- Component
                    items[ "keybind_element" ] = library:create( "TextButton" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = self.items[ "elements" ];
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Size = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.Y;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    items[ "name" ] = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(245, 245, 245);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = cfg.name;
                        Parent = items[ "keybind_element" ];
                        Name = "\0";
                        Size = dim2(1, 0, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 16;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "name" ];
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });
                    
                    items[ "right_components" ] = library:create( "Frame" , {
                        Parent = items[ "keybind_element" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Size = dim2(0, 0, 1, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIListLayout" , {
                        FillDirection = Enum.FillDirection.Horizontal;
                        HorizontalAlignment = Enum.HorizontalAlignment.Right;
                        Parent = items[ "right_components" ];
                        Padding = dim(0, 7);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    items[ "keybind_holder" ] = library:create( "TextButton" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        Parent = items[ "right_components" ];
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Size = dim2(0, 0, 0, 16);
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "keybind_holder" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    items[ "key" ] = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(86, 86, 87);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "LSHIFT";
                        Parent = items[ "keybind_holder" ];
                        Name = "\0";
                        Size = dim2(1, -12, 0, 0);
                        BackgroundTransparency = 1;
                        TextXAlignment = Enum.TextXAlignment.Left;
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.XY;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UIPadding" , {
                        Parent = items[ "key" ];
                        PaddingTop = dim(0, 1);
                        PaddingRight = dim(0, 5);
                        PaddingLeft = dim(0, 5)
                    });                                  
                -- 
                
                -- Mode Holder
                    items[ "dropdown" ] = library:create( "Frame" , {
                        BorderColor3 = rgb(0, 0, 0);
                        Parent = library.items;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        Position = dim2(0, 0, 0, 0);
                        Size = dim2(0, 0, 0, 0);
                        BorderSizePixel = 0;
                        AutomaticSize = Enum.AutomaticSize.X;
                        BackgroundColor3 = rgb(0, 0, 0)
                    });
                    
                    items[ "inline" ] = library:create( "Frame" , {
                        Parent = items[ "dropdown" ];
                        Size = dim2(1, 0, 1, 0);
                        Name = "\0";
                        ClipsDescendants = true;
                        BorderColor3 = rgb(0, 0, 0);
                        BorderSizePixel = 0;
                        BackgroundColor3 = rgb(22, 22, 24)
                    });
                    
                    library:create( "UIPadding" , {
                        PaddingBottom = dim(0, 6);
                        PaddingTop = dim(0, 3);
                        PaddingLeft = dim(0, 3);
                        Parent = items[ "inline" ]
                    });
                    
                    library:create( "UIListLayout" , {
                        Parent = items[ "inline" ];
                        Padding = dim(0, 5);
                        SortOrder = Enum.SortOrder.LayoutOrder
                    });
                    
                    library:create( "UICorner" , {
                        Parent = items[ "inline" ];
                        CornerRadius = dim(0, 4)
                    });
                    
                    local options = {"Hold", "Toggle", "Always"}
                    
                    cfg.y_size = 20
                    for _, option in options do                        
                        local name = library:create( "TextButton" , {
                            FontFace = fonts.font;
                            TextColor3 = rgb(72, 72, 73);
                            BorderColor3 = rgb(0, 0, 0);
                            Text = option;
                            Parent = items[ "inline" ];
                            Name = "\0";
                            Size = dim2(0, 0, 0, 0);
                            BackgroundTransparency = 1;
                            TextXAlignment = Enum.TextXAlignment.Left;
                            BorderSizePixel = 0;
                            AutomaticSize = Enum.AutomaticSize.XY;
                            TextSize = 14;
                            BackgroundColor3 = rgb(255, 255, 255)
                        }); cfg.hold_instances[option] = name
                        library:apply_theme(name, "accent", "TextColor3")
                        
                        cfg.y_size += name.AbsoluteSize.Y

                        library:create( "UIPadding" , {
                            Parent = name;
                            PaddingTop = dim(0, 1);
                            PaddingRight = dim(0, 5);
                            PaddingLeft = dim(0, 5)
                        });

                        name.InputBegan:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.Touch then
                                cfg.set(option)
                                cfg.set_visible(false)
                                cfg.open = false
                            end 
                        end)
                    end
                -- 
            end 
            
            function cfg.modify_mode_color(path) -- ts so frikin tuff 💀
                for _, v in cfg.hold_instances do 
                    v.TextColor3 = rgb(72, 72, 72)
                end 

                cfg.hold_instances[path].TextColor3 = themes.preset.accent
            end

            function cfg.set_mode(mode) 
                cfg.mode = mode 

                if mode == "Always" then
                    cfg.set(true)
                elseif mode == "Hold" then
                    cfg.set(false)
                end

                flags[cfg.flag]["mode"] = mode
                cfg.modify_mode_color(mode)
            end 

            function cfg.set(input)
                if type(input) == "boolean" then 
                    cfg.active = input

                    if cfg.mode == "Always" then 
                        cfg.active = true
                    end
                elseif tostring(input):find("Enum") then 
                    input = input.Name == "Escape" and "NONE" or input
                    
                    cfg.key = input or "NONE"	
                elseif find({"Toggle", "Hold", "Always"}, input) then 
                    if input == "Always" then 
                        cfg.active = true 
                    end 

                    cfg.mode = input
                    cfg.set_mode(cfg.mode) 
                elseif type(input) == "table" then 
                    input.key = type(input.key) == "string" and input.key ~= "NONE" and library:convert_enum(input.key) or input.key
                    input.key = input.key == Enum.KeyCode.Escape and "NONE" or input.key

                    cfg.key = input.key or "NONE"
                    cfg.mode = input.mode or "Toggle"

                    if input.active then
                        cfg.active = input.active
                    end

                    cfg.set_mode(cfg.mode) 
                end 

                cfg.callback(cfg.active)

                local text = tostring(cfg.key) ~= "Enums" and (keys[cfg.key] or tostring(cfg.key):gsub("Enum.", "")) or nil
                local __text = text and (tostring(text):gsub("KeyCode.", ""):gsub("UserInputType.", ""))
                
                items[ "key" ].Text = __text

                flags[cfg.flag] = {
                    mode = cfg.mode,
                    key = cfg.key, 
                    active = cfg.active
                }
            end

            function cfg.set_visible(bool)
                local size = bool and cfg.y_size or 0
                library:tween(items[ "dropdown" ], {Size = dim_offset(items[ "keybind_holder" ].AbsoluteSize.X, size)})

                items[ "dropdown" ].Position = dim_offset(items[ "keybind_holder" ].AbsolutePosition.X, items[ "keybind_holder" ].AbsolutePosition.Y + items[ "keybind_holder" ].AbsoluteSize.Y + 60)
            end
        
            items[ "keybind_holder" ].InputBegan:Connect(function(Input)
                            if Input.UserInputType ~= Enum.UserInputType.Touch then return end
                task.wait()
                items[ "key" ].Text = "..."	

                cfg.binding = library:connection(uis.InputBegan, function(keycode, game_event)  
                    cfg.set(keycode.KeyCode ~= Enum.KeyCode.Unknown and keycode.KeyCode or keycode.UserInputType)
                    
                    cfg.binding:Disconnect() 
                    cfg.binding = nil
                end)
            end)

            items[ "keybind_holder" ].MouseButton2Down:Connect(function()
                cfg.open = not cfg.open 

                cfg.set_visible(cfg.open)
            end)

            library:connection(uis.InputBegan, function(input, game_event) 
                if not game_event then
                    local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType

                    if selected_key == cfg.key then 
                        if cfg.mode == "Toggle" then 
                            cfg.active = not cfg.active
                            cfg.set(cfg.active)
                        elseif cfg.mode == "Hold" then 
                            cfg.set(true)
                        end
                    end
                end
            end)    

            library:connection(uis.InputEnded, function(input, game_event) 
                if game_event then 
                    return 
                end 

                local selected_key = input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode or input.UserInputType
    
                if selected_key == cfg.key then
                    if cfg.mode == "Hold" then 
                        cfg.set(false)
                    end
                end
            end)
            
            cfg.set({mode = cfg.mode, active = cfg.active, key = cfg.key})           
            config_flags[cfg.flag] = cfg.set

            return setmetatable(cfg, library)
        end

        function library:button(options) 
            local cfg = {
                name = options.name or "TextBox",
                callback = options.callback or function() end,
                items = {};
            }
            
            local items = cfg.items; do 
                items[ "button_element" ] = library:create( "Frame" , {
                    Parent = self.items[ "elements" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                items[ "button" ] = library:create( "TextButton" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = "";
                    AutoButtonColor = false;
                    AnchorPoint = vec2(1, 0);
                    Parent = items[ "button_element" ];
                    Name = "\0";
                    Position = dim2(1, -4, 0, 0);
                    Size = dim2(1, -8, 0, 30);
                    BorderSizePixel = 0;
                    TextSize = 14;
                    BackgroundColor3 = rgb(33, 33, 35)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "button" ];
                    CornerRadius = dim(0, 3)
                });
                
                items[ "name" ] = library:create( "TextLabel" , {
                    FontFace = fonts.small;
                    TextColor3 = rgb(245, 245, 245);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "button" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Size = dim2(1, 0, 1, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                }); library:apply_theme(items[ "name" ], "accent", "BackgroundColor3");                            
            end 

            items[ "button" ].InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.Touch then
                    cfg.callback()

                    items[ "name" ].TextColor3 = themes.preset.accent 
                    library:tween(items[ "name" ], {TextColor3 = rgb(245, 245, 245)})
                end
            end)
            
            return setmetatable(cfg, library)
        end 

        function library:settings(options)  
            local cfg = {
                open = false; 
                items = {}; 
                sanity = true; -- made this for my own sanity.
            }

            local items = cfg.items; do 
                items[ "outline" ] = library:create( "Frame" , {
                    Name = "\0";
                    Visible = true;
                    Parent = library[ "items" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 0);
                    ClipsDescendants = true;
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(25, 25, 29)
                });
                
                library:create( "UIScale" , {
                    Parent = items[ "outline" ];
                    Scale = scale;
                });

                items[ "inline" ] = library:create( "Frame" , {
                    Parent = items[ "outline" ];
                    Name = "\0";
                    Position = dim2(0, 1, 0, 1);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(1, -2, 1, -2);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(22, 22, 24)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "inline" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "elements" ] = library:create( "Frame" , {
                    BorderColor3 = rgb(0, 0, 0);
                    Parent = items[ "inline" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 10, 0, 10);
                    Size = dim2(1, -20, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "elements" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    PaddingBottom = dim(0, 15);
                    Parent = items[ "elements" ]
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "outline" ];
                    CornerRadius = dim(0, 7)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "fade" ];
                    CornerRadius = dim(0, 7)
                });
                
                items[ "tick" ] = library:create( "ImageButton" , {
                    Image = "rbxassetid://128797200442698";
                    Name = "\0";
                    AutoButtonColor = false;
                    Parent = self.items[ "right_components" ];
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 16, 0, 16);
                    BorderSizePixel = 0;
                    BackgroundColor3 = rgb(255, 255, 255)
                });                
            end 

            function cfg.set_visible(bool)                 
                library:tween(items[ "outline" ], {Size = dim_offset(bool and 240 or 0, 0)})
                items[ "outline" ].Position = dim_offset(items[ "tick" ].AbsolutePosition.X, items[ "tick" ].AbsolutePosition.Y + 90)
                library:close_element(cfg)
            end
            
            items[ "tick" ].InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.Touch then
                    cfg.open = not cfg.open
                    cfg.set_visible(cfg.open)
                end 
            end)

            return setmetatable(cfg, library)
        end 

        function library:list(properties) 
            local cfg = {
                items = {};
                options = properties.options or {"1", "2", "3"};
                flag = properties.flag or library:next_flag();    
                callback = properties.callback or function() end;
                data_store = {};        
                current_element;
            }

            local items = cfg.items; do
                items[ "list" ] = library:create( "Frame" , {
                    Parent = self.items[ "elements" ];
                    BackgroundTransparency = 1;
                    Name = "\0";
                    Size = dim2(1, 0, 0, 0);
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIListLayout" , {
                    Parent = items[ "list" ];
                    Padding = dim(0, 10);
                    SortOrder = Enum.SortOrder.LayoutOrder
                });
                
                library:create( "UIPadding" , {
                    Parent = items[ "list" ];
                    PaddingRight = dim(0, 4);
                    PaddingLeft = dim(0, 4)
                });
            end 

            function cfg.refresh_options(options_to_refresh)
                for _,option in cfg.data_store do 
                    option:Destroy()
                end

                for _, option_data in options_to_refresh do
                    local button = library:create( "TextButton" , {
                        FontFace = fonts.small;
                        TextColor3 = rgb(0, 0, 0);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = "";
                        AutoButtonColor = false;
                        AnchorPoint = vec2(1, 0);
                        Parent = items[ "list" ];
                        Name = "\0";
                        Position = dim2(1, 0, 0, 0);
                        Size = dim2(1, 0, 0, 30);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(33, 33, 35)
                    }); cfg.data_store[#cfg.data_store + 1] = button;

                    local name = library:create( "TextLabel" , {
                        FontFace = fonts.font;
                        TextColor3 = rgb(72, 72, 73);
                        BorderColor3 = rgb(0, 0, 0);
                        Text = option_data;
                        Parent = button;
                        Name = "\0";
                        BackgroundTransparency = 1;
                        TextTruncate = Enum.TextTruncate.AtEnd;
                        Size = dim2(1, 0, 1, 0);
                        BorderSizePixel = 0;
                        TextSize = 14;
                        BackgroundColor3 = rgb(255, 255, 255)
                    });
                    
                    library:create( "UICorner" , {
                        Parent = button;
                        CornerRadius = dim(0, 3)
                    });     

                    button.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.Touch then
                            local current = cfg.current_element 

                            if current and current ~= name then 
                                library:tween(current, {TextColor3 = rgb(72, 72, 72)})
                            end
                            
                            flags[cfg.flag] = option_data
                            cfg.callback(option_data)
                            library:tween(name, {TextColor3 = rgb(245, 245, 245)})
                            cfg.current_element = name
                        end 
                    end)

                    name.MouseEnter:Connect(function()
                        if cfg.current_element == name then 
                            return 
                        end 

                        library:tween(name, {TextColor3 = rgb(140, 140, 140)})
                    end)

                    name.MouseLeave:Connect(function()
                        if cfg.current_element == name then 
                            return 
                        end 

                        library:tween(name, {TextColor3 = rgb(72, 72, 72)})
                    end)
                end
            end

            cfg.refresh_options(cfg.options)

            return setmetatable(cfg, library)
        end 

        function library:init_config(window) 
            local text;
            window:seperator({name = "Settings"})
            local main = window:tab({name = "Configs", tabs = {"Main"}})
            
            local column = main:column({})
            local section = column:section({name = "Configs", size = 1, default = true, icon = "rbxassetid://139628202576511"})
            config_holder = section:list({options = {"Report", "This", "Error", "To", "Finobe"}, callback = function(option)
                if text then 
                    text.set(option)
                end 
            end, flag = "config_name_list"}); library:update_config_list()
            
            local column = main:column({})
            local section = column:section({name = "Settings", side = "right", size = 1, default = true, icon = "rbxassetid://129380150574313"})
            text = section:textbox({name = "Config name:", flag = "config_name_text"})
            section:button({name = "Save", callback = function() writefile(library.directory .. "/configs/" .. flags["config_name_text"] .. ".cfg", library:get_config()) library:update_config_list() notifications:create_notification({name = "Configs", info = "Saved config to:\n" .. flags["config_name_text"] or flags["config_name_text"]}) end}) 
            section:button({name = "Load", callback = function() library:load_config(readfile(library.directory .. "/configs/" .. flags["config_name_text"] .. ".cfg"))  library:update_config_list() notifications:create_notification({name = "Configs", info = "Loaded config:\n" .. flags["config_name_text"]}) end})
            section:button({name = "Delete", callback = function() delfile(library.directory .. "/configs/" .. flags["config_name_text"] .. ".cfg")  library:update_config_list() notifications:create_notification({name = "Configs", info = "Deleted config:\n" .. flags["config_name_text"]}) end})
            section:colorpicker({name = "Menu Accent", callback = function(color, alpha) library:update_theme("accent", color) end, color = themes.preset.accent})
            section:keybind({name = "Menu Bind", callback = function(bool) window.toggle_menu(bool) end, default = true})
        end
    --

    -- Notification Library
        function notifications:refresh_notifs() 
            local offset = 50

            for i, v in notifications.notifs do
                local Position = vec2(20, offset)
                library:tween(v, {Position = dim_offset(Position.X, Position.Y)}, Enum.EasingStyle.Quad, 0.4)
                offset += (v.AbsoluteSize.Y + 10)
            end

            return offset
        end
        
        function notifications:fade(path, is_fading)
            local fading = is_fading and 1 or 0 
            
            library:tween(path, {BackgroundTransparency = fading}, Enum.EasingStyle.Quad, 1)

            for _, instance in path:GetDescendants() do 
                if not instance:IsA("GuiObject") then 
                    if instance:IsA("UIStroke") then
                        library:tween(instance, {Transparency = fading}, Enum.EasingStyle.Quad, 1)
                    end
        
                    continue
                end 
        
                if instance:IsA("TextLabel") then
                    library:tween(instance, {TextTransparency = fading})
                elseif instance:IsA("Frame") then
                    library:tween(instance, {BackgroundTransparency = instance.Transparency and 0.6 and is_fading and 1 or 0.6}, Enum.EasingStyle.Quad, 1)
                end
            end
        end 
        
        function notifications:create_notification(options)
            local cfg = {
                name = options.name or "This is a title!";
                info = options.info or "This is extra info!";
                lifetime = options.lifetime or 3;
                items = {};
                outline;
            }

            local items = cfg.items; do 
                items[ "notification" ] = library:create( "Frame" , {
                    Parent = library[ "items" ];
                    Size = dim2(0, 210, 0, 53);
                    Name = "\0";
                    BorderColor3 = rgb(0, 0, 0);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    AnchorPoint = vec2(1, 0);
                    AutomaticSize = Enum.AutomaticSize.Y;
                    BackgroundColor3 = rgb(14, 14, 16)
                });

                library:create( "UIScale" , {
                    Parent = items[ "notification" ];
                    Scale = scale;
                });
                
                library:create( "UIStroke" , {
                    Color = rgb(23, 23, 29);
                    Parent = items[ "notification" ];
                    Transparency = 1;
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                });
                
                items[ "title" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(255, 255, 255);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.name;
                    Parent = items[ "notification" ];
                    Name = "\0";
                    BackgroundTransparency = 1;
                    Position = dim2(0, 7, 0, 6);
                    BorderSizePixel = 0;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "notification" ];
                    CornerRadius = dim(0, 3)
                });
                
                items[ "info" ] = library:create( "TextLabel" , {
                    FontFace = fonts.font;
                    TextColor3 = rgb(145, 145, 145);
                    BorderColor3 = rgb(0, 0, 0);
                    Text = cfg.info;
                    Parent = items[ "notification" ];
                    Name = "\0";
                    Position = dim2(0, 9, 0, 22);
                    BorderSizePixel = 0;
                    BackgroundTransparency = 1;
                    TextXAlignment = Enum.TextXAlignment.Left;
                    TextWrapped = true;
                    AutomaticSize = Enum.AutomaticSize.XY;
                    TextSize = 14;
                    BackgroundColor3 = rgb(255, 255, 255)
                });
                
                library:create( "UIPadding" , {
                    PaddingBottom = dim(0, 17);
                    PaddingRight = dim(0, 8);
                    Parent = items[ "info" ]
                });
                
                items[ "bar" ] = library:create( "Frame" , {
                    AnchorPoint = vec2(0, 1);
                    Parent = items[ "notification" ];
                    Name = "\0";
                    Position = dim2(0, 8, 1, -6);
                    BorderColor3 = rgb(0, 0, 0);
                    Size = dim2(0, 0, 0, 5);
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    BackgroundColor3 = themes.preset.accent
                });
                
                library:create( "UICorner" , {
                    Parent = items[ "bar" ];
                    CornerRadius = dim(0, 999)
                });
                
                library:create( "UIPadding" , {
                    PaddingRight = dim(0, 8);
                    Parent = items[ "notification" ]
                });
            end
            
            local index = #notifications.notifs + 1
            notifications.notifs[index] = items[ "notification" ]

            notifications:fade(items[ "notification" ], false)
            
            local offset = notifications:refresh_notifs()

            items[ "notification" ].Position = dim_offset(20, offset)

            library:tween(items[ "notification" ], {AnchorPoint = vec2(0, 0)}, Enum.EasingStyle.Quad, 1)
            library:tween(items[ "bar" ], {Size = dim2(1, -8, 0, 5)}, Enum.EasingStyle.Quad, cfg.lifetime)

            task.spawn(function()
                task.wait(cfg.lifetime)
                
                notifications.notifs[index] = nil
                
                notifications:fade(items[ "notification" ], true)
                
                library:tween(items[ "notification" ], {AnchorPoint = vec2(1, 0)}, Enum.EasingStyle.Quad, 1)

                task.wait(1)
        
                items[ "notification" ]:Destroy() 
            end)
        end
    --end)()

    end
-- \\ Script

local window = library:window({
    name = "Box", 
    suffix = ".lol", 
    gameInfo = string.format("Box.lol : %s", Game_Name:lower()),
    size = UDim2.new(0, 900, 0, 650) -- Width 500, Height 600 (adjust these values as needed)
})

if Game_Name == "The Bronx" then
    window:seperator({name = "Game"}) do
        local LocalPlayerTab, PlayersTab, PurchaseGunTab, MiscTab, SafeTab = window:tab({name = "Main", tabs = {"Local Player", "Players", "Teleports", "Misc", "Safe"}, icon = GetImage("World.png")}) do
            do -- \\ Safe Tab
                local SafeItemColumn = SafeTab:column({})

                local SafeItemSection = SafeItemColumn:section({name = "Safe Selected Item", side = "left", size = 1, icon = GetImage("Lock.png")})

                local _SafeItem = SafeItemSection:list({flag = "SafeSelectedItem_TheBronx", options = {}, callback = function(state)
                    task.spawn(LPH_NO_VIRTUALIZE(function()
                        if not state then
                            return
                        end

                        local Safe, OldCFrame = GetWorkingSafe(), LocalPlayer.Character.HumanoidRootPart.CFrame
                        pcall(Teleport, Safe.ChestClicker.CFrame)
                        local Tool = tostring(state)
                        LocalPlayer.Character:WaitForChild"Humanoid":UnequipTools()
                        
                        local ItemSafed = false; local OldBackpackRemoved; OldBackpackRemoved = LocalPlayer.Backpack.ChildRemoved:Connect(function(Child)
                            if tostring(Child) == Tool then
                                ItemSafed = true
                                OldBackpackRemoved:Disconnect()
                            end
                        end)

                        task.delay(3, function()
                            ItemSafed = true
                        end)

                        task.wait(0.5)

                        ReplicatedStorage.Inventory:FireServer("Change", Tool, "Backpack", Safe)

                        repeat task.wait() until ItemSafed == true

                        pcall(Teleport, OldCFrame)

                        library.notifications:create_notification({
                            name = "Box.lol",
                            info = `Successfully safed {state}!`,
                            lifetime = 5
                        })
                    end))
                end})

                SafeItemColumn = SafeTab:column({})

                SafeItemSection = SafeItemColumn:section({name = "Take Selected Item", side = "right", size = 1, icon = GetImage("UZI.png")})

                local _TakeItem = SafeItemSection:list({flag = "TakeSelectedItem_TheBronx", options = {}, callback = function(state)
                    task.spawn(LPH_NO_VIRTUALIZE(function()
                        if not state then
                            return
                        end

                        local Safe, OldCFrame = GetWorkingSafe(), LocalPlayer.Character.HumanoidRootPart.CFrame
                        pcall(Teleport, Safe.ChestClicker.CFrame)

                        local Tool = tostring(state);

                        local ItemSafed = false; local OldBackpackChildAdded; OldBackpackChildAdded = LocalPlayer.Backpack.ChildAdded:Connect(function(Child)
                            if tostring(Child) == Tool then
                                ItemSafed = true
                                OldBackpackChildAdded:Disconnect()
                            end
                        end)

                        task.delay(3, function()
                            ItemSafed = true
                        end)

                        task.wait(0.5)

                        ReplicatedStorage.Inventory:FireServer("Change", Tool, "Inv", Safe)

                        repeat task.wait() until ItemSafed == true

                        pcall(Teleport, OldCFrame)

                        library.notifications:create_notification({
                            name = "Box.lol",
                            info = `Successfully took {state} from safe!`,
                            lifetime = 5
                        })
                    end))
                end})

                local Backpack_ChildAdded, Backpack_ChildRemoved

                local ConnectBackpackToRefreshSafeList = LPH_JIT_MAX(function()
                    LocalPlayer:WaitForChild("Backpack")

                    local Refresh = LPH_NO_VIRTUALIZE(function()
                        local Items = {}

                        for Index, Value in LocalPlayer.Backpack:GetChildren() do
                            if Value:IsA("Tool") then
                                table.insert(Items, Value.Name)
                            end
                        end

                        table.sort(Items)

                        _SafeItem.refresh_options(Items)

                        return Items
                    end)

                    task.spawn(Refresh)
                    
                    if Backpack_ChildAdded then
                        Backpack_ChildAdded:Disconnect()
                        Backpack_ChildAdded = nil
                    end
                                    
                    if Backpack_ChildRemoved then
                        Backpack_ChildRemoved:Disconnect()
                        Backpack_ChildRemoved = nil
                    end

                    Backpack_ChildAdded = LocalPlayer.Backpack.ChildAdded:Connect(Refresh)
                    Backpack_ChildRemoved = LocalPlayer.Backpack.ChildRemoved:Connect(Refresh)
                end)

                Players.PlayerRemoving:Connect(LPH_NO_VIRTUALIZE(function(Player)
                    if Player == LocalPlayer then
                        Backpack_ChildAdded:Disconnect(); Backpack_ChildRemoved:Disconnect()
                    end
                end))

                task.spawn(ConnectBackpackToRefreshSafeList)

                LocalPlayer.CharacterAdded:Connect(ConnectBackpackToRefreshSafeList)

                local RefreshTakeItemList = LPH_NO_VIRTUALIZE(function()
                    local Items = {}

                    for Index, Value in LocalPlayer:WaitForChild("InvData"):GetChildren() do
                        table.insert(Items, Value.Name)
                    end

                    table.sort(Items)

                    _TakeItem.refresh_options(Items)

                    return Items
                end)

                task.spawn(RefreshTakeItemList)

                LocalPlayer:WaitForChild("InvData").ChildAdded:Connect(RefreshTakeItemList)
                LocalPlayer:WaitForChild("InvData").ChildRemoved:Connect(RefreshTakeItemList)
            end

            do -- \\ Local Player Tab
                local LocalPlayerColumn = LocalPlayerTab:column({})

                local LocalPlayerModsSection = LocalPlayerColumn:section({name = "Local Player Modifications", side = "left", size = 1.0135})

                local __Modifications = {
                    "Infinite Sleep";
                    "Infinite Hunger";
                    "Infinite Stamina";
                    "Instant Interact";
                    "Instant Revive";
                    "Auto Pickup Cash";
                    "Auto Pickup Bags";
                    "Disable Camera Bobbing";
                    --"Disable Cameras";
                    "Disable Blood Effects";
                    "Bypass Locked Cars";
                    "No Jump Cooldown";
                    "No Rent Pay";
                    "No Fall Damage";
                    "No Knockback";
                    "Respawn Where You Died";
                }

                for _, Index in __Modifications do
                    LocalPlayerModsSection:toggle({type = "toggle", name = Index, flag = Index, default = false, callback = function(state)
                        Config.TheBronx.PlayerModifications[Index:gsub(" ", "")] = state
                    end})
                end

                LocalPlayerColumn = LocalPlayerTab:column({})
                local CharacterModsSection = LocalPlayerColumn:section({name = "Character Modifications", side = "right", size = 0.645, icon = GetImage("Wrench.png")})

                CharacterModsSection:toggle({type = "toggle", name = "Modify WalkSpeed", flag = "ModifyWalkSpeed_TheBronx", default = false, callback = function(state)
                    Config.MiscSettings.ModifySpeed.Enabled = state
                end})

                CharacterModsSection:toggle({type = "toggle", name = "Modify JumpPower", flag = "ModifyJumpPower_TheBronx", default = false, callback = function(state)
                    Config.MiscSettings.ModifyJump.Enabled = state
                end})

                CharacterModsSection:toggle({type = "toggle", name = "Click Teleport", flag = "ClickTeleport_TheBronx", default = false})

                local _NoClipToggle = CharacterModsSection:toggle({type = "toggle", name = "No Clip", flag = "NoClip_TheBronx", seperator = true, default = false, callback = function(state)
                    if state then
                        RunService:BindToRenderStep("NOCLIP", 1, LPH_NO_VIRTUALIZE(function()
                            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                                if LocalPlayer.Character.Humanoid.Health ~= 0 then
                                    for Index, Value in LocalPlayer.Character:GetDescendants() do
                                        if Collide_Data[Value.Name] then
                                            pcall(function()
                                                Value.CanCollide = false
                                            end)
                                        end
                                    end
                                else
                                    for Index, Value in LocalPlayer.Character:GetDescendants() do
                                        if Collide_Data[Value.Name] then
                                            pcall(function()
                                                Value.CanCollide = true
                                            end)
                                        end
                                    end
                                end
                            end
                        end))
                    else
                        RunService:UnbindFromRenderStep("NOCLIP")

                        for Index, Value in LocalPlayer.Character:GetDescendants() do
                            if Collide_Data[Value.Name] then
                                pcall(function()
                                    Value.CanCollide = true
                                end)
                            end
                        end
                    end
                end})

                CharacterModsSection:slider({name = "WalkSpeed Value", flag = "WalkSpeedValue_TheBronx", min = 0, max = 250, default = 50, suffix = "%", callback = function(state)
                    Config.MiscSettings.ModifySpeed.Value = state
                end})

                CharacterModsSection:slider({name = "JumpPower Value", flag = "JumpPowerValue_TheBronx", min = 0, max = 250, default = 7, suffix = "%", callback = function(state)
                    Config.MiscSettings.ModifyJump.Value = state
                end})

                CharacterModsSection:keybind({name = "Click Teleport Key", flag = "ClickTeleportKey_TheBronx", key = Enum.KeyCode.LeftControl, mode = "Hold", callback = function(state)
                    Config.TheBronx.ClickTeleportActive = state
                end})

                local UISection = LocalPlayerColumn:section({name = "Toggle Interfaces Section", side = "right", size = 0.225, icon = GetImage("Settings.png")})

                local _UINames, BlacklistedNames = {'ATM GUI'}, {"Dead", "Settings1", "Controls", "FirstShopGUI", "Freecam", "ThaShop2", "WATCH GUI", "NYPD Cars", "CONSTRUCTION LEVEL", "RobPlayerUI", "Bronx LOCKER", 'MobileBeam', 'Settings', 'Flash', 'Enter', 'CopSirens'}
                
                for Index, Value in LocalPlayer.PlayerGui:GetChildren() do
                    if Value:IsA("ScreenGui") and not Value.Enabled then
                        if table.find(BlacklistedNames, Value.Name) then continue end
                        table.insert(_UINames, Value.Name)
                    end
                end 

                local _UI_EnabledToggle;

                UISection:dropdown({name = "Selected UI", flag = "SelectedUI_TB3", width = 120, items = _UINames, seperator = false, multi = false, default = 'Bronx Market 2'})

                _UI_EnabledToggle = UISection:toggle({name = "UI Enabled", type = 'toggle', callback = function(state)
                    task.spawn(LPH_NO_VIRTUALIZE(function()
                        if tostring(library.flags["SelectedUI_TB3"]) == "ATM GUI" then
                            local SelectedUI = LocalPlayer.PlayerGui:FindFirstChild("ATMGui")

                            if not SelectedUI and state then
                                local _Clone = Lighting.Assets.GUI.ATMGui:Clone()
                                _Clone.Parent = LocalPlayer.PlayerGui
                                SelectedUI = _Clone
                                _Clone.Frame.closeBtn.MouseButton1Click:Connect(function()
                                    _UI_EnabledToggle.set(false)
                                    --_Clone:Destroy()
                                end)
                            end

                            if not state and SelectedUI then
                                SelectedUI:Destroy()
                            end

                            local Old_UI_Value = library.flags["SelectedUI_TB3"]

                            repeat task.wait() until library.flags["SelectedUI_TB3"] ~= Old_UI_Value

                            if SelectedUI then
                                SelectedUI:Destroy()
                            end

                            if _UI_EnabledToggle then
                                _UI_EnabledToggle.set(false)
                            end

                            return
                        end

                        local SelectedUI = LocalPlayer.PlayerGui:FindFirstChild(tostring(library.flags["SelectedUI_TB3"]))

                        if SelectedUI then
                            SelectedUI.Enabled = state

                            local Old_UI_Value = library.flags["SelectedUI_TB3"]

                            repeat task.wait() until library.flags["SelectedUI_TB3"] ~= Old_UI_Value

                            SelectedUI.Enabled = false
                            if _UI_EnabledToggle then
                                _UI_EnabledToggle.set(false)
                            end
                        end 
                    end))
                end})
            end

            do -- \\ Players Tab
                local Column = PlayersTab:column({})

                local PlayerListSection = Column:section({name = "Select Player", size = 1, default = false, side = 'left' --[[3 people icon]]})

                local PlayerList = PlayerListSection:list({flag = "SelectPlayer_TheBronx", options = {}, callback = function(state)
                    Config.TheBronx.PlayerUtilities.SelectedPlayer = tostring(state)
                end})

                local RefreshPlayers = LPH_NO_VIRTUALIZE(function()
                    local Cache = {}

                    for i, Player in Players:GetPlayers() do
                        if Player == LocalPlayer then continue end

                        table.insert(Cache, Player.Name)
                    end

                    table.sort(Cache)

                    PlayerList.refresh_options(Cache)
                end)

                task.spawn(RefreshPlayers)

                Players.PlayerAdded:Connect(RefreshPlayers)

                Players.PlayerRemoving:Connect(RefreshPlayers)

                Column = PlayersTab:column({})

                local PlayerOptionsSection = Column:section({name = "Player Options", size = 1, default = false, side = 'right', icon = GetImage("Wrench.png")})
                
                PlayerOptionsSection:toggle({type = "toggle", name = "Spectate Player", flag = "SpectatePlayer_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.PlayerUtilities.SpectatePlayer = state
                end})

                PlayerOptionsSection:toggle({type = "toggle", name = "Bring Player", flag = "BringPlayer_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.PlayerUtilities.BringingPlayer = state
                end})

                PlayerOptionsSection:toggle({type = "toggle", name = "Bug / Kill Player - Car", flag = "BugPlayer_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.PlayerUtilities.BugPlayer = state
                end})

                PlayerOptionsSection:toggle({type = "toggle", name = "Auto Kill Player - Gun", flag = "AutoKillPlayer_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.PlayerUtilities.AutoKill = state
                end})

                PlayerOptionsSection:toggle({type = "toggle", name = "Auto Ragdoll Player - Gun", flag = "AutoRagdollPlayer_TheBronx", seperator = true, default = false, callback = function(state)
                    Config.TheBronx.PlayerUtilities.AutoRagdoll = state
                end})

                PlayerOptionsSection:button({name = "Teleport To Player", callback = function()
                    task.spawn(Teleport, Players[Config.TheBronx.PlayerUtilities.SelectedPlayer].Character.HumanoidRootPart.CFrame)
                end})

                PlayerOptionsSection:button({name = "Down Player - Hold Gun", callback = function(state)
                    pcall(kill_gun, Config.TheBronx.PlayerUtilities.SelectedPlayer, "HumanoidRootPart", (Players[Config.TheBronx.PlayerUtilities.SelectedPlayer].Character.Humanoid.Health - 5))
                end})

                PlayerOptionsSection:button({name = "Kill Player - Hold Gun", callback = function(state)
                    pcall(kill_gun, Config.TheBronx.PlayerUtilities.SelectedPlayer, "HumanoidRootPart", math.huge)
                end})

                PlayerOptionsSection:button({name = "God Player - Hold Gun", callback = function(state)
                    pcall(kill_gun, Config.TheBronx.PlayerUtilities.SelectedPlayer, "HumanoidRootPart", math.sqrt(-1))
                end})

                PlayerOptionsSection:button({name = "Fling Player - Hold Gun", callback = function(state)
                    for Index=1, 50 do
                        pcall(kill_gun, Config.TheBronx.PlayerUtilities.SelectedPlayer, "RightUpperLeg", 0.01)
                    end
                end})

                PlayerOptionsSection:button({name = "God All Players - Hold Gun", callback = function()
                    task.spawn(LPH_NO_VIRTUALIZE(function()
                        for Index, Value in Players:GetPlayers() do
                            if Value ~= LocalPlayer and Value.Character and Value.Character:FindFirstChild("Humanoid") and Value.Character:FindFirstChild("Humanoid").Health ~= 0 and not Value.Character:FindFirstChildOfClass("ForceField") and Value.Character:FindFirstChild("HumanoidRootPart") then
                                pcall(kill_gun, Value.Name, "HumanoidRootPart", math.sqrt(-1))
                                task.wait(0.1)
                            end
                        end
                    end))
                end})
                
                PlayerOptionsSection:button({name = "Kill All Players - Hold Gun", callback = function()
                    task.spawn(LPH_NO_VIRTUALIZE(function()
                        for Index, Value in Players:GetPlayers() do
                            if Value ~= LocalPlayer and Value.Character and Value.Character:FindFirstChild("Humanoid") and Value.Character:FindFirstChild("Humanoid").Health ~= 0 and not Value.Character:FindFirstChildOfClass("ForceField") and Value.Character:FindFirstChild("HumanoidRootPart") then
                                pcall(kill_gun, Value.Name, "HumanoidRootPart", math.huge)
                                task.wait(0.1)
                            end
                        end
                    end))
                end})
            end
                
            do -- \\ Misc Tab
                local Column = MiscTab:column({})

                local FarmingSection = Column:section({name = "Farming", size = 0.415, default = false, side = 'left', icon = GetImage("Wheatt.png")})

                FarmingSection:toggle({type = "toggle", name = "Auto Farm Construction", flag = "FarmConstruction_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.Farms.FarmConstructionJob = state
                end})

                FarmingSection:toggle({type = "toggle", name = "Auto Farm Bank Robbery", flag = "FarmBank_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.Farms.FarmBank = state
                end})

                FarmingSection:toggle({type = "toggle", name = "Auto Farm House Robbery", flag = "FarmHouses_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.Farms.FarmHouses = state
                end})

                FarmingSection:toggle({type = "toggle", name = "Auto Farm Studio Robbery", flag = "FarmStudio_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.Farms.FarmStudio = state
                end})

                FarmingSection:toggle({type = "toggle", name = "Auto Farm Dumpsters", flag = "FarmDumpsters_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.Farms.FarmTrash = state
                end})

                local ManualFarmSections = Column:section({name = "Manual Farms", size = 0.325, default = false, side = 'left', icon = GetImage("Pickkaxe.png")}) 

                ManualFarmSections:toggle({type = "toggle", name = "Auto Collect Dropped Cash", flag = "FarmDroppedMoney_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.Farms.CollectDroppedMoney = state
                end})

                ManualFarmSections:toggle({type = "toggle", name = "Auto Collect Dropped Bags", flag = "FarmDroppedLoot_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.Farms.CollectDroppedLoot = state
                end})

                ManualFarmSections:button({name = "Clean All Filthy Money", callback = LPH_NO_VIRTUALIZE(function()
                    if LocalPlayer.stored.FilthyStack.Value == 0 then 
                        return library.notifications:create_notification({
                            name = "Box.lol",
                            info = `You have no fucking money poor fuck!`,
                            lifetime = 7.5
                        })
                    end
        
                    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
                    if not LocalPlayer.Character:FindFirstChild("Humanoid") or LocalPlayer.Character:FindFirstChild("Humanoid").Health == 0 then return end
        
                    local Cleaner = GetGoodCleaner()
                    
                    if not Cleaner then
                        return library.notifications:create_notification({
                            name = "Box.lol",
                            info = `Could not find a valid cleaner!`,
                            lifetime = 7.5
                        })
                    end
        
                    Teleport(Cleaner.WorldPivot)
        
                    task.wait(0.4)
        
                    fireproximityprompt(Cleaner:FindFirstChild("CashPrompt", true))
        
                    repeat task.wait() until Cleaner:FindFirstChild("On", true).Color == Color3.fromRGB(74, 156, 69)
        
                    task.wait(0.5)
        
                    fireproximityprompt(Cleaner:FindFirstChild("CashPrompt", true))
                    
                    task.wait(0.25)
        
                    Teleport(Cleaner.WorldPivot)
        
                    task.wait(0.4)
        
                    repeat task.wait() until LocalPlayer.Backpack:FindFirstChild("MoneyReady")
        
                    LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack["MoneyReady"])
        
                    repeat task.wait(0.1) fireproximityprompt(Cleaner:FindFirstChild("GrabPrompt", true)) until not LocalPlayer.Character:FindFirstChild("MoneyReady")
                    
                    repeat task.wait()
                    until LocalPlayer.Backpack:FindFirstChild("BagOfMoney")
        
                    Teleport(CFrame.new(-203, 284, -1201))
        
                    task.wait(0.4)
        
                    LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack["BagOfMoney"])
        
                    task.wait(1)
        
                    fireproximityprompt(Workspace.ATMMoney.Prompt)
                end)})

                local FarmSettingsSection = Column:section({name = "Farming Settings", size = 0.225, default = false, side = 'left', Icon = GetImage("Settings.png")}) 

                FarmSettingsSection:toggle({type = "toggle", name = "AFK Safety Teleport", flag = "AFKCheck_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.Farms.AFKCheck = state
                end})

                FarmSettingsSection:toggle({type = "toggle", name = "Auto Sell Trash", flag = "SellTrash_TheBronx", default = false, callback = function(state)
                    Config.TheBronx.Farms.AutoSellTrash = state
                end})

                Column = MiscTab:column({})

                local DupingSection = Column:section({name = "Duping Section", size = 0.29, default = false, side = 'right', icon = GetImage("Node.png")}) 

                local player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))

local function teleport(x, y, z)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local hrp = character:WaitForChild("HumanoidRootPart")

    humanoid:ChangeState(0)
    if player:GetAttribute("LastACPos") ~= nil then
        repeat task.wait() until not player:GetAttribute("LastACPos")
    end
    hrp.CFrame = CFrame.new(x, y, z)
end

local blacklistedTools = {"Fist", "Phone"}

local function isToolBlacklisted(toolName)
    for _, blacklisted in ipairs(blacklistedTools) do
        if toolName == blacklisted then return true end
    end
    return false
end

local function getPing()
    if typeof(player.GetNetworkPing) == "function" then
        local success, result = pcall(function()
            return tonumber(string.match(player:GetNetworkPing(), "%d+"))
        end)
        if success and result then return result end
    end

    local success2, pingStat = pcall(function()
        return player:FindFirstChild("PlayerGui"):FindFirstChild("Ping") or
               player:FindFirstChild("PlayerScripts"):FindFirstChild("Ping")
    end)
    if success2 and pingStat and pingStat:IsA("TextLabel") then
        local num = tonumber(string.match(pingStat.Text, "%d+"))
        if num then return num end
    end

    local t0 = tick()
    local temp = Instance.new("BoolValue", ReplicatedStorage)
    temp.Name = "PingTest_"..tostring(math.random(10000,99999))
    task.wait(0.1)
    local t1 = tick()
    temp:Destroy()
    return math.clamp((t1-t0)*1000,50,300)
end

DupingSection:button({name = "Duplicate Current Item", callback = function()
    task.spawn(function()
        if Cooldown then
            library.notifications:create_notification({
                name = "Box.lol",
                info = `Please wait!`,
                lifetime = 5
            })
            return
        end
        Cooldown = true
        local Player = Players.LocalPlayer
        local Backpack = Player.Backpack

        local Tool = Player.Character:FindFirstChildOfClass("Tool")

        if not Tool then
            library.notifications:create_notification({
                name = "Box.lol",
                info = `Could not find a tool! you must hold one.`,
                lifetime = 10
            })
            Cooldown = false
            return
        end

        if isToolBlacklisted(Tool.Name) then
            library.notifications:create_notification({
                name = "Box.lol",
                info = `This tool is blacklisted from duplication!`,
                lifetime = 10
            })
            Cooldown = false
            return
        end

        Player.Character.Humanoid:UnequipTools()
        Tool.Parent = Player.Backpack
        task.wait(0.1)

        local ToolName = Tool.Name
        local ToolId

        local Connection = ReplicatedStorage.MarketItems.ChildAdded:Connect(function(item)
            if item.Name == ToolName then
                if item:WaitForChild('owner').Value == Player.Name then
                    ToolId = item:GetAttribute('SpecialId')
                end
            end
        end)

        local ping = getPing()
        local delay = 0.25 + ((math.clamp(ping,0,300)/300)*0.03)

        -- First store/remove/grab sequence
        ReplicatedStorage.ListWeaponRemote:FireServer(ToolName, 99999)
        task.wait(delay)

        -- Store twice
        ReplicatedStorage.BackpackRemote:InvokeServer('Store', ToolName)
        task.wait(0.5)
        ReplicatedStorage.BackpackRemote:InvokeServer('Store', ToolName)
        task.wait(3)

        -- Remove twice if ToolId exists
        if ToolId then
            ReplicatedStorage.BuyItemRemote:FireServer(ToolName, 'Remove', ToolId)
            task.wait(0.5)
            ReplicatedStorage.BuyItemRemote:FireServer(ToolName, 'Remove', ToolId)
            task.wait(0.5)
        end

        -- Grab three times
        ReplicatedStorage.BackpackRemote:InvokeServer("Grab", ToolName)
        task.wait(0.2)
        ReplicatedStorage.BackpackRemote:InvokeServer("Grab", ToolName)
        task.wait(0.2)
        ReplicatedStorage.BackpackRemote:InvokeServer("Grab", ToolName)

        Connection:Disconnect()

        task.wait(1)
        Cooldown = false
        
        library.notifications:create_notification({
            name = "Box.lol",
            info = `Duplication completed for ${ToolName}!`,
            lifetime = 5
        })
    end)
end})
                DupingSection:label({wrapped = true, name = "This might bug if you have more than 1 of the item you're duping!"})

                local VulnerabilitySection = Column:section({name = "Vulnerability Section", size = 0.347, default = false, side = 'right', icon = GetImage("unlocked.png")}) 

                local GetFruitCup = LPH_NO_VIRTUALIZE(function()
                    local Found, Cup = false, nil;

                    for Index, Value in next, {LocalPlayer.Backpack:GetChildren(), LocalPlayer.Character:GetChildren()} do
                        for _Index, _Value in Value do
                            if _Value:IsA("Tool") and _Value.Name == "Ice-Fruit Cupz" then
                                if _Value["IceFruit Cup"]["IceFruit PunchMedium"].Transparency ~= 1 then
                                    Found = true
                                    Cup = _Value
                                    break
                                end
                            end
                        end
                    end 

                    return Found, Cup
                end)

                VulnerabilitySection:button({name = "Generate Max Illegal Money", callback = function()
                    local Found, Cup = GetFruitCup()

                    if Cup and Found then
                        HideUI("generating illegal cash 💷\n please wait.")

                        local OLDCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame

                        if Cup.Parent == LocalPlayer.Backpack then
                            LocalPlayer.Character.Humanoid:EquipTool(Cup)
                            task.wait(1)
                        end 

                        Teleport(Workspace["IceFruit Sell"].CFrame, true)

                        task.wait(.5)

                        for Index=1, 4000 do
                            task.spawn(function()
                                _fireproximityprompt(Workspace["IceFruit Sell"].ProximityPrompt)
                            end)
                        end

                        Teleport(OLDCFrame)

                        DeleteSecretUI()

                        return
                    end

                    HideUI("buying products 🍉\nif you are stuck here, PLEASE WAIT!!")

                    local OLDCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame

                    local Itemz = {"FijiWater", "FreshWater", "Ice-Fruit Bag", "Ice-Fruit Cupz"}
                    local Stove;

                    for Index, Value in Workspace.CookingPots:GetChildren() do
                        if Value:IsA("Model") then
                            if Value:FindFirstChildWhichIsA("ProximityPrompt", true).ActionText == "Turn On" and Value:FindFirstChildWhichIsA("ProximityPrompt", true).Enabled then
                                Stove = Value

                                break
                            end
                        end
                    end

                    for Index, Value in Itemz do
                        if not LocalPlayer.Backpack:FindFirstChild(Value) then
                            ReplicatedStorage:WaitForChild("ExoticShopRemote"):InvokeServer(Value)
                            task.wait(1)
                        end
                    end

                    local Check = false;

                    for Index, Value in Itemz do
                        if not LocalPlayer.Backpack:FindFirstChild(Value) then
                            Check = true
                        end
                    end

                    if Check then
                        DeleteSecretUI()
                        library.notifications:create_notification({
                            name = "Box.lol",
                            info = `Could not find items! Please check you have more than 5000$.`,
                            lifetime = 10
                        })
                        return
                    end

                    DeleteSecretUI()

                    HideUI("generating illegal cash 💷\n this takes around 1-2 minutes.\n please wait.")

                    Teleport(Stove.CookPart.CFrame, true)

                    task.wait(1)

                    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
                    LocalPlayer.Character.HumanoidRootPart.Anchored = true

                    task.wait(1.5)

                    fireproximityprompt(Stove:FindFirstChildWhichIsA("ProximityPrompt", true))

                    task.wait(2)

                    for Index, Value in {"FijiWater", "FreshWater", "Ice-Fruit Bag"} do
                        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack[Value])
                        task.wait(1)
                        fireproximityprompt(Stove:FindFirstChildWhichIsA("ProximityPrompt", true))
                        task.wait(3)
                    end

                    repeat wait() until 
                    Stove.CookPart.Steam.LoadUI.Enabled == false

                    if not LocalPlayer.Character:FindFirstChild("Ice-Fruit Cupz") then
                        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack['Ice-Fruit Cupz'])
                        task.wait(1)
                    end
                    
                    task.wait(1)

                    fireproximityprompt(Stove:FindFirstChildWhichIsA("ProximityPrompt", true))

                    task.wait(3)

                    LocalPlayer.Character.HumanoidRootPart.Anchored = false

                    Teleport(Workspace["IceFruit Sell"].CFrame, true)

                    task.wait(1)

                    LocalPlayer.Character.HumanoidRootPart.Anchored = true

                    task.wait(1.5)

                    if not LocalPlayer.Character:FindFirstChild("Ice-Fruit Cupz") then
                        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack['Ice-Fruit Cupz'])
                        task.wait(1)
                    end

                    Workspace["IceFruit Sell"].ProximityPrompt.HoldDuration = 0

                    for Index=1, 4000 do
                        task.spawn(function()
                            _fireproximityprompt(Workspace["IceFruit Sell"].ProximityPrompt)
                        end)
                    end

                    LocalPlayer.Character.HumanoidRootPart.Anchored = false
                    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)

                    task.wait(0.5)

                    Teleport(OLDCFrame, true)

                    task.wait(2)

                    pcall(DeleteSecretUI)
                end})

                VulnerabilitySection:label({wrapped = true, name = "Money Generator takes around 3 minutes, and can take longer if some items are not in stock. You will need around 5K to do this."})

                local KillAuraSection = Column:section({name = "Kill Aura Section", size = 0.275, default = false, side = 'right', icon = GetImage("Bullet.png")}) 

                KillAuraSection:toggle({name = "Enabled - Hold Gun", flag = "KillAura_Enabled_TB3", type = "toggle", default = false, callback = function(state)
                    Config.TheBronx.KillAura = state
                end})

                KillAuraSection:slider({name = "Kill Aura Range", flag = "KillAuraRange_TB3", min = 0, max = 1000, default = 300, suffix = "st", callback = function(state)
                    Config.TheBronx.KillAuraRange = state
                end})
            end

            do -- \\ Purchase Guns
                local PurchaseGunColumn = PurchaseGunTab:column({})

                local WeaponListSection = PurchaseGunColumn:section({name = "Purchase Selected Item", side = "left", size = 1, icon = GetImage("Cash.png")})

                WeaponListSection:list({flag = "PurchaseSelectedItem_TheBronx", options = Config.Guns, callback = function(state)
                    task.spawn(LPH_NO_VIRTUALIZE(function()
                        if not state then
                            return
                        end

                        Config.TheBronx.Selected_Item = state

                        local self = string.match(Config.TheBronx.Selected_Item, "^(.*) %-");

                        self = self:match("^%s*(.-)%s*$");
                        local OldCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame;
                        local Prompt = Workspace:FindFirstChild("GUNS")[self]:FindFirstChildWhichIsA("ProximityPrompt",true);
                        if (Workspace:FindFirstChild("GUNS")[self]:FindFirstChild("GamepassID", true) and not MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, Workspace:FindFirstChild("GUNS")[self]:FindFirstChild("GamepassID",true).Value)) then 
                            return library.notifications:create_notification({
                                name = "Box.lol",
                                info = `You do not own this gamepass!`,
                                lifetime = 5
                            })
                        end
                        
                        --if Solara then Prompt.HoldDuration = 0; end

                        local Part = Prompt.Parent:IsA("Part") and Prompt.Parent.CFrame or Prompt.Parent:IsA("MeshPart") and Prompt.Parent.CFrame or Prompt.Parent:IsA("UnionOperation") and Prompt.Parent.CFrame;
                        if LocalPlayer.stored.Money.Value < Workspace:FindFirstChild("GUNS")[self]:FindFirstChild("Price",true).Value then
                            return library.notifications:create_notification({
                                name = "Box.lol",
                                info = `You are ${Workspace:FindFirstChild("GUNS")[self]:FindFirstChild("Price",true).Value - LocalPlayer.stored.Money.Value} short.`,
                                lifetime = 5
                            })
                        end;
                        
                        task.spawn(Teleport, Part)

                        task.wait(0.4)

                        local ItemReceieved = false;
                        task.spawn(function()
                            local Check = LocalPlayer.Backpack.ChildAdded:Connect(function(Child)
                                if tostring(Child) == tostring(self) then
                                    ItemReceieved = true
                                end
                            end)

                            task.spawn(function()
                                task.wait(1.5)
                                ItemReceieved = true
                            end)

                            repeat task.wait() until ItemReceieved == true
                            Check:Disconnect()
                        end)

                        repeat task.wait(); fireproximityprompt(Prompt); until ItemReceieved == true;
                        
                        task.wait(0.4)

                        task.spawn(Teleport, OldCFrame)

                        library.notifications:create_notification({
                            name = "Box.lol",
                            info = `Successfully purchased {self}!`,
                            lifetime = 5
                        })
                    end))
                end})

                PurchaseGunColumn = PurchaseGunTab:column({})

                local TeleportListSection = PurchaseGunColumn:section({name = "Teleport To Location", side = "right", size = 1, icon = GetImage("World.png")})

                local List = {}

                for Index, Value in Config.TheBronx.TeleportationList do
                    table.insert(List, Index)
                end

                table.sort(List)

                TeleportListSection:list({flag = "TeleportToPlace_TheBronx", options = List, callback = function(state)
                    task.spawn(LPH_NO_VIRTUALIZE(function()
                        if not state then
                            return
                        end

                        Teleport(Config.TheBronx.TeleportationList[state])

                        library.notifications:create_notification({
                            name = "Box.lol",
                            info = `Successfully teleported to {state}!`,
                            lifetime = 5
                        })
                    end))
                end})
            end
        end
    end
end

if Game_Name == "South Bronx" then
    window:seperator({name = "Game"}) do
        local LocalPlayerTab, PlayersTab, PurchaseGunTab = window:tab({name = "Main", tabs = {"Local Player", "Players", "Teleports"}, icon = GetImage("World.png")}) do
            do -- \\ Local Player
                local LocalPlayerColumn = LocalPlayerTab:column({})
                local LocalPlayerModsSection = LocalPlayerColumn:section({name = "Local Player Modifications", side = "left", size = 0.475})

                local __Modifications = {
                    "Infinite Stamina";
                    "Instant Interact";
                    "Delete On Key";
                    "Hide Name";
                    "No Clip";
                    "Speed";
                }

                for _, Index in __Modifications do
                    LocalPlayerModsSection:toggle({type = "toggle", name = Index, flag = Index.."_SB", default = false, callback = Index ~= "No Clip" and LPH_NO_VIRTUALIZE(function(Value)
                            Index = string.gsub(Index, " ", "")
                            Config.South_Bronx.LocalPlayer_Config[Index] = Value
                        end) or function(Value)
                            if Value and not Solara then
                                RunService:BindToRenderStep("NOCLIP", 1, LPH_NO_VIRTUALIZE(function()
                                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                                        if LocalPlayer.Character.Humanoid.Health ~= 0 then
                                            for Index, Value in LocalPlayer.Character:GetDescendants() do
                                                if Collide_Data[Value.Name] then
                                                    pcall(function()
                                                        Value.CanCollide = false
                                                    end)
                                                end
                                            end
                                        else
                                            for Index, Value in LocalPlayer.Character:GetDescendants() do
                                                if Collide_Data[Value.Name] then
                                                    pcall(function()
                                                        Value.CanCollide = true
                                                    end)
                                                end
                                            end
                                        end
                                    end
                                end))
                            else
                                RunService:UnbindFromRenderStep("NOCLIP")
                
                                for Index, Value in LocalPlayer.Character:GetDescendants() do
                                    if Collide_Data[Value.Name] then
                                        pcall(function()
                                            Value.CanCollide = true
                                        end)
                                    end
                                end
                            end
                    end})
                end

                LocalPlayerModsSection = LocalPlayerColumn:section({name = "Modification Settings", side = "left", size = 0.275, icon = GetImage("Settings.png")})

                LocalPlayerModsSection:slider({name = "WalkSpeed Value", flag = "WalkSpeedValue_SouthBronx", min = 0, max = 50, default = 25, suffix = "%", callback = function(state)
                    Config.South_Bronx.LocalPlayer_Config.SpeedValue = state/100
                end})

                LocalPlayerModsSection:keybind({name = "Delete + Click Key", flag = "DeleteOnKey_SouthBronx", key = Enum.KeyCode.LeftControl, mode = "Hold", callback = function(state)
                    Config.South_Bronx.LocalPlayer_Config.DeleteKey = library.flags["DeleteOnKey_SouthBronx"].key
                end})

                TeleportMethodSection = LocalPlayerColumn:section({name = "Teleportation Method", side = "left", size = 0.175, icon = GetImage("Wrench.png")})

                TeleportMethodSection:dropdown({name = "Select Method", flag = "TeleportMethod_SB", width = 100, items = {"Dirt Bike", "Damage", "Tween"}, seperator = false, multi = false, default = "Damage", callback = function(state)
                    Config.South_Bronx.TeleportMethod = state
                end})

                LocalPlayerColumn = LocalPlayerTab:column({})

                local VulnSection = LocalPlayerColumn:section({name = "Vulnerability Section", side = "right", size = 0.23 , icon = GetImage("unlocked.png")})

                local _OwnedHotChips = LocalPlayer:GetAttribute("ExtraHotChipsMoneyEnabled")

                local OwnedHotChips = _OwnedHotChips

                local _Tiers = {
                    ["TIER_1"] = LocalPlayer:GetAttribute("TIER_1");
                    ["TIER_2"] = LocalPlayer:GetAttribute("TIER_2");
                    ["TIER_3"] = LocalPlayer:GetAttribute("TIER_3");
                }

                local Tiers = {
                    ["TIER_1"] = LocalPlayer:GetAttribute("TIER_1");
                    ["TIER_2"] = LocalPlayer:GetAttribute("TIER_2");
                    ["TIER_3"] = LocalPlayer:GetAttribute("TIER_3");
                }

                local _ScriptLoaded = false;

                VulnSection:toggle({name = "Free Tier 1, 2 and 3", default = false, flag = "Free_Tiers", type = 'toggle', callback = function(state)
                    if not _ScriptLoaded then return end

                    for Index, Value in Tiers do
                        if _Tiers[Index] then continue end

                        local Arguments = {
                            [1] = "UpdateSettingAttribute",
                            [2] = {
                                ["Attribute"] = Index,
                                ["Enabled"] = Tiers[Index]
                            }
                        }
                        
                        FireServer(ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ClientEffects"), table.unpack(Arguments))       
                        
                        Tiers[Index] = not Tiers[Index]
                    end
                end})

                VulnSection:toggle({name = "Free Extra Hot Chips Cash", default = false, flag = "Free_Chips", type = 'toggle', callback = function(state)
                    if not _ScriptLoaded then return end

                    local Arguments = {
                        [1] = "UpdateSettingAttribute",
                        [2] = {
                            ["Attribute"] = "ExtraHotChipsMoneyEnabled",
                            ["Enabled"] = OwnedHotChips
                        }
                    }
                    
                    FireServer(ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("ClientEffects"), table.unpack(Arguments))       

                    OwnedHotChips = not OwnedHotChips
                end})

                local FarmSection = LocalPlayerColumn:section({name = "Auto Farming Section", side = "right", size = 0.54, icon = GetImage("Wheatt.png")})

                FarmSection:toggle({name = "Auto-Farm Cards", default = false, flag = "Card_Auto_Farm", type = "toggle", callback = function(state)
                    task.spawn(function() if not _ScriptLoaded then return end
                        if Config.South_Bronx.OwnedBike == "Unknown" then
                            local Bike = Find_Bike()
                            if Bike == nil then
                                ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("Dealershipinteraction"):FireServer("Spawn", "DirtBike")
                                task.wait(1)
                                Bike = Find_Bike()
                                task.wait(1)
                                if Bike == nil then Config.South_Bronx.OwnedBike = "No" else Config.South_Bronx.OwnedBike = "Yes" end
                            else
                                Config.South_Bronx.OwnedBike = "Yes"
                            end
                            task.wait(0.5)
                        end
                        Config.South_Bronx.FarmingUtilities.CardFarm = state
                        if state then Start_CardFarm() else Stop_CardFarm() end
                    end)
                end})

                FarmSection:toggle({name = "Auto-Farm Boxes", default = false, flag = "Box_Auto_Farm", type = "toggle", callback = function(state)
                    if not _ScriptLoaded then return end
                    Config.South_Bronx.FarmingUtilities.BoxFarm = state
                    if state then Start_BoxFarm() else Stop_BoxFarm() end
                end})

                FarmSection:toggle({name = "Auto-Farm Chips", default = false, flag = "Chip_Auto_Farm", type = "toggle", callback = function(state)
                    task.spawn(function() if not _ScriptLoaded then return end
                        if Config.South_Bronx.OwnedBike == "Unknown" then
                            local Bike = Find_Bike()
                            if Bike == nil then
                                ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("Dealershipinteraction"):FireServer("Spawn", "DirtBike")
                                task.wait(1)
                                Bike = Find_Bike()
                                task.wait(1)
                                if Bike == nil then Config.South_Bronx.OwnedBike = "No" else Config.South_Bronx.OwnedBike = "Yes" end
                            else
                                Config.South_Bronx.OwnedBike = "Yes"
                            end
                            task.wait(0.5)
                        end
                        Config.South_Bronx.FarmingUtilities.ChipFarm = state
                        if state then Start_ChipFarm() else Stop_ChipFarm() end
                    end)
                end})

                FarmSection:toggle({name = "Auto-Farm Marshmallows", default = false, flag = "Marshmallow_Auto_Farm", type = "toggle", callback = function(state)
                    task.spawn(function() if not _ScriptLoaded then return end
                        if Config.South_Bronx.OwnedBike == "Unknown" then
                            local Bike = Find_Bike()
                            if Bike == nil then
                                ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("Dealershipinteraction"):FireServer("Spawn", "DirtBike")
                                task.wait(1)
                                Bike = Find_Bike()
                                task.wait(1)
                                if Bike == nil then Config.South_Bronx.OwnedBike = "No" else Config.South_Bronx.OwnedBike = "Yes" end
                            else
                                Config.South_Bronx.OwnedBike = "Yes"
                            end
                            task.wait(0.5)
                        end
                        Config.South_Bronx.FarmingUtilities.MarshmallowFarm = state
                        if state then Start_MarshmallowFarm() else Stop_MarshmallowFarm() end
                    end)
                end})

                local _MarshMallowDropdown;

                _MarshMallowDropdown = FarmSection:slider({name = "Marshmallow Amount - $950", flag = "Marshmallow_Amount", min = 1, max = 50, default = 5, suffix = "", callback = function(state)
                    Config.South_Bronx.FarmingUtilities.MarshmallowIncrement = state

                    if _MarshMallowDropdown then
                        _MarshMallowDropdown.changetext(string.format("Marshmallow Amount - $%s", (state * 190)))
                    end
                end})

                FarmSection:label({wrapped = true, name = "You must own a house with pots to use the marshmallow farm!"})

                local DupeSection = LocalPlayerColumn:section({name = "Duplication Section", side = "right", size = 0.2, icon = "rbxassetid://139628202576511"})

                DupeSection:button({name = "Duplication Vulnerability", callback = function()
                    FireServer(ReplicatedStorage.RemoteEvents.PurchaseItem, 'Shoes', 'YZ Slides', '\255')
                end})

                _ScriptLoaded = true
            end

            do -- \\ Teleports
                local Location_Names = {"Dirty Hobo 💩"; "Active ATM 🏧"}

                for Index, Value in Config.South_Bronx.Locations do
                    table.insert(Location_Names, Index)
                end

                table.sort(Location_Names)
                
                local PurchaseGunColumn = PurchaseGunTab:column({})

                local WeaponListSection = PurchaseGunColumn:section({name = "Purchase Selected Item", side = "left", size = 1, icon = GetImage("Cash.png")})

                WeaponListSection:list({flag = "PurchaseSelectedItem_SouthBronx", options = Config.South_Bronx.Guns, callback = function(v)
                    task.spawn(LPH_NO_VIRTUALIZE(function()
                        if not v then return end

                        Config.South_Bronx.Selected_Item = tostring(v)

                        local self = string.match(Config.South_Bronx.Selected_Item, "^(.*) %-");

                        local DidntBuy = false
                            
                        local suc, err = pcall(function()
                            self = self:match("^%s*(.-)%s*$");

                            local PromptCFrame = GunPosition[self];
                            local OldCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame

                            task.spawn(function()
                                ItemReceieved = false;
                                local Check = LocalPlayer.Backpack.ChildAdded:Connect(function(Child)
                                    if tostring(Child) == tostring(self) then
                                        ItemReceieved = true
                                    end
                                end)

                                task.spawn(function()
                                    task.wait(10)
                                    ItemReceieved = true
                                end)

                                repeat RunService.RenderStepped:Wait() until ItemReceieved == true
                                Check:Disconnect()
                            end)

                            local Teleport_Status = Teleport(PromptCFrame)

                            if Teleport_Status == "Failed" then
                                library.notifications:create_notification({
                                    name = "Box.lol",
                                    info = `Failed to purchase {self}!`,
                                    lifetime = 7.5
                                })

                                DidntBuy = true

                                return
                            end

                            repeat RunService.RenderStepped:Wait() until LocalPlayer.Character.Humanoid.SeatPart == nil

                            for Index = 1, Config.South_Bronx.Item_Amount do
                                fireproximityprompt(Workspace:FindFirstChild("PromptPurchases")[self].proxprompt:FindFirstChildOfClass("ProximityPrompt"))
                            end

                            repeat RunService.RenderStepped:Wait() until ItemReceieved == true

                            repeat RunService.RenderStepped:Wait() until Teleport_Status == "Success"

                            task.wait(1.5)

                            Teleport(OldCFrame)
                        end)

                        if not LocalPlayer.Backpack:FindFirstChild(self) and not LocalPlayer.Character:FindFirstChild(self) then
                            library.notifications:create_notification({
                                name = "Box.lol",
                                info = `Failed to purchase {self}!`,
                                lifetime = 7.5
                            })

                            return
                        end

                        if not DidntBuy then
                            if suc then
                                library.notifications:create_notification({
                                    name = "Box.lol",
                                    info = `Successfully purchased {self}!`,
                                    lifetime = 5
                                })
                            else
                                library.notifications:create_notification({
                                    name = "Box.lol",
                                    info = `Failed to purchase item {self} . error : {err}`,
                                    lifetime = 15
                                })
                            end
                        end
                    end))
                end})

                PurchaseGunColumn = PurchaseGunTab:column({})

                local TeleportListSection = PurchaseGunColumn:section({name = "Teleport To Location", side = "right", size = 1, icon = GetImage("World.png")})

                local Location_Names = {"Dirty Hobo 💩"; "Active ATM 🏧"}

                for Index, Value in Config.South_Bronx.Locations do
                    table.insert(Location_Names, Index)
                end

                table.sort(Location_Names, function(...)
                    return select(1, ...) < select(2, ...)
                end)

                local TP_Debounce = false

                TeleportListSection:list({flag = "TeleportToPlace_SouthBronx", options = Location_Names, callback = function(state)
                    task.spawn(LPH_NO_VIRTUALIZE(function()
                        if not state then
                            return
                        end

                        if TP_Debounce then
                            library.notifications:create_notification({
                                name = "Box.lol",
                                info = `Please wait!`,
                                lifetime = 5
                            })

                            return
                        end

                        Config.South_Bronx.Selected_Location = state

                        local _Position = CFrame.new(0,0,0)

                        TP_Debounce = true

                        local suc, error = pcall(function()
                            if Config.South_Bronx.Selected_Location ~= "Dirty Hobo 💩" and Config.South_Bronx.Selected_Location ~= "Active ATM 🏧" then
                            _Position = Config.South_Bronx.Locations[Config.South_Bronx.Selected_Location]
                            Teleport(Config.South_Bronx.Locations[Config.South_Bronx.Selected_Location])
                            elseif Config.South_Bronx.Selected_Location == "Dirty Hobo 💩" then
                                if Workspace.Folders.HomelessPeople:FindFirstChild("RightLowerLeg", true) then
                                    local _Hobo = Workspace.Folders.HomelessPeople:FindFirstChild("RightLowerLeg", true).CFrame
                                    _Position = _Hobo
                                    Teleport(_Hobo)
                                else
                                    library.notifications:create_notification({
                                        name = "Box.lol",
                                        info = `Failed to locate dirty hobo crackhead!`,
                                        lifetime = 5
                                    })
                                end
                            elseif Config.South_Bronx.Selected_Location == "Active ATM 🏧" then
                                local ATMPositions = {
                                    ATM1 = CFrame.new(-30, 4, -300);
                                    ATM2 = CFrame.new(539, 4, -353);
                                    ATM3 = CFrame.new(497, 4, 403);
                                    ATM4 = CFrame.new(236, 4, -158);
                                    ATM5 = CFrame.new(525, -8, -92);
                                    ATM6 = CFrame.new(-450, 4, 370);
                                    ATM7 = CFrame.new(-266, 4, -209);
                                    ATM8 = CFrame.new(-11, 4, 231);
                                    ATM9 = CFrame.new(717, 4, 410);
                                    ATM10 = CFrame.new(-532, 3, -21);
                                    ATM11 = CFrame.new(-646, 4, 155);
                                    ATM12 = CFrame.new(698, 3, -241);
                                    ATM13 = CFrame.new(-315, 4, 142);
                                    ATM14 = CFrame.new(-378, 4, -365);
                                    ATM15 = CFrame.new(360, 4, -364);
                                    ATM16 = CFrame.new(870, 3, -346);
                                    ATM17 = CFrame.new(904, 3, -99);
                                    ATM18 = CFrame.new(1095, 3, 178);
                                    ATM19 = CFrame.new(1054, 4, 585);
                                    ATM20 = CFrame.new(895, 4, 142);
                                    ATM21 = CFrame.new(1021, 3, -229);
                                };

                                local ATM;

                                for Index, Value in Workspace.Map.ATMS:GetChildren() do
                                    if Value.ATMScreen.Transparency == 0 then
                                        ATM = Value
                                        break
                                    end
                                end

                                _Position = ATMPositions[tostring(ATM)]

                                Teleport(ATMPositions[tostring(ATM)])
                            end
                        end)

                        TP_Debounce = false

                        if (LocalPlayer.Character.HumanoidRootPart.Position - _Position.Position).Magnitude > 20 then
                            library.notifications:create_notification({
                                name = "Box.lol",
                                info = `Failed teleported to {state}!`,
                                lifetime = 7.5
                            })

                            return
                        end

                        if suc then
                            library.notifications:create_notification({
                                name = "Box.lol",
                                info = `Successfully teleported to {state}!`,
                                lifetime = 5
                            })
                        else
                            library.notifications:create_notification({
                                name = "Box.lol",
                                info = `Teleportation to {state}. error : {err}`,
                                lifetime = 15
                            })
                        end
                    end))
                end})
            end

            do -- \\ Player Tab        
                local Column = PlayersTab:column({})

                local PlayerListSection = Column:section({name = "Select Player", size = 1, default = false, side = 'left' --[[3 people icon]]})

                local PlayerList = PlayerListSection:list({flag = "SelectPlayer_SouthBronx", options = {}, callback = function(state)
                    Config.South_Bronx.PlayerUtilities.SelectedPlayer = tostring(state)
                end})

                local RefreshPlayers = LPH_NO_VIRTUALIZE(function()
                    local Cache = {}

                    for i, Player in Players:GetPlayers() do
                        if Player == LocalPlayer then continue end

                        table.insert(Cache, Player.Name)
                    end

                    table.sort(Cache)

                    PlayerList.refresh_options(Cache)
                end)

                task.spawn(RefreshPlayers)

                Players.PlayerAdded:Connect(RefreshPlayers)

                Players.PlayerRemoving:Connect(RefreshPlayers)

                Column = PlayersTab:column({})

                local PlayerOptionsSection = Column:section({name = "Player Options", size = 1, default = false, side = 'right', icon = GetImage("Wrench.png")})
            
                PlayerOptionsSection:toggle({type = "toggle", name = "Spectate Player", flag = "SpectatePlayer_SouthBronx", default = false, callback = function(state)
                    Config.South_Bronx.PlayerUtilities.SpectatePlayer = state
                end})

                PlayerOptionsSection:toggle({type = "toggle", name = "Bring Player", flag = "BringPlayer_SouthBronx", default = false, callback = function(state)
                    Config.South_Bronx.PlayerUtilities.BringingPlayer = state
                end})

                PlayerOptionsSection:button({name = "Teleport To Player", callback = function()
                    task.spawn(function()
                        if not Config.South_Bronx.PlayerUtilities.SelectedPlayer then return end

                        local Success, Error = pcall(function()
                            Teleport(Players[Config.South_Bronx.PlayerUtilities.SelectedPlayer].Character.HumanoidRootPart.CFrame)
                        end)

                        if (LocalPlayer.Character.HumanoidRootPart.Position - Players[Config.South_Bronx.PlayerUtilities.SelectedPlayer].Character.HumanoidRootPart.Position).Magnitude > 20 then
                            library.notifications:create_notification({
                                name = "Box.lol",
                                info = `Failed to teleport to {Config.South_Bronx.PlayerUtilities.SelectedPlayer}!`,
                                lifetime = 7.5
                            })

                            return
                        end

                        if Success then
                            library.notifications:create_notification({
                                name = "Box.lol",
                                info = `Successfully teleported to {Config.South_Bronx.PlayerUtilities.SelectedPlayer}!`,
                                lifetime = 7.5
                            })
                        else
                            library.notifications:create_notification({
                                name = "Box.lol",
                                info = `Failed to teleport to {Config.South_Bronx.PlayerUtilities.SelectedPlayer}. Error : {Error}`,
                                lifetime = 10
                            })
                        end
                    end)
                end})
                
                PlayerOptionsSection:button({name = "Get Into Players Car", callback = function()
                    pcall(SitInPlayersVehicle, Players[Config.South_Bronx.PlayerUtilities.SelectedPlayer])
                end})
            end
        end
    end
end

if Game_Name == "BlockSpin" then
    window:seperator({name = "Game"}) do
        local LocalPlayerTab, PlayersTab, PurchaseGunTab, MiscTab = window:tab({name = "Main", tabs = {"Local Player"}, icon = GetImage("World.png")}) do
            local LocalPlayerColumn = LocalPlayerTab:column({})
            local LocalPlayerModsSection = LocalPlayerColumn:section({name = "Local Player Modifications", side = "left", size = 0.475})

            local FarmingSection = LocalPlayerColumn:section({name = "Auto-Farming Utilities", side = "left", size = 0.475, icon = GetImage("Wheatt.png")})

            local _ScriptLoaded = false

            FarmingSection:dropdown({name = "Mope Type", flag = "MopType_BlockSpin", width = 120, items = {"Default", "Silver", "Gold", "Diamond"}, seperator = false, multi = false, default = 'Default', callback = function(state)
                Config.BlockSpin.AutoFarming.MopType = state
            end})

            FarmingSection:toggle({name = "Auto-Farm Mop Job", flag = "JanitorFarm_BlockSpin", type = "toggle", callback = function(state)
                if not _ScriptLoaded then return end
                Config.BlockSpin.AutoFarming.FarmMops = state

                task.spawn(function()
                    if Config.BlockSpin.AutoFarming.FarmMops then
                        Start_MopFarm()
                    else
                        Stop_MopFarm()
                    end
                end)
            end})

            _ScriptLoaded = true
        end
    end
end

window:seperator({name = "Combat"}) do
    local SilentAimTab = window:tab({name = "Silent Aim", tabs = {"General Settings"}, icon = GetImage("Pistol.png")}) do
        local SilentAimColumn = SilentAimTab:column({})

        local GeneralSection = SilentAimColumn:section({name = "General", side = "left", size = 0.23, icon = GetImage("UZI.png")})

        GeneralSection:toggle({type = "toggle", name = "Enabled", flag = "SilentAim_Enabled", default = false, callback = function(state)
            Config.Silent.Enabled = state
        end})
            
        GeneralSection:keybind({name = "Keybind", flag = "SilentAim_Bind", mode = "Always", callback = function(state)
            Config.Silent.Targetting = state
        end})

        local SettingsSection = SilentAimColumn:section({name = "Settings", side = "left", size = 0.455, icon = GetImage("Settings.png")})

        SettingsSection:toggle({name = "Visible Check", flag = "SilentAim_Wallcheck", type = "toggle", default = false, callback = function(state)
            Config.Silent.WallCheck = state
        end})

        local BodyParts = {}

        local RigType = "R15"

        if LocalPlayer.Character then
            RigType = LocalPlayer.Character:WaitForChild("Humanoid").RigType.Name
        else
            LocalPlayer.CharacterAdded:Wait()

            RigType = LocalPlayer.Character:WaitForChild("Humanoid").RigType.Name
        end

        BodyParts = (RigType == "R6") and {
            "Head",
            "Torso",
            "Left Arm",
            "Right Arm",
            "Left Leg",
            "Right Leg",
            "HumanoidRootPart"
        } or (RigType == "R15") and {
            "Head",
            "UpperTorso",
            "LowerTorso",
            "LeftUpperArm",
            "LeftLowerArm",
            "RightUpperArm",
            "RightLowerArm",
            "LeftUpperLeg",
            "LeftLowerLeg",
            "RightUpperLeg",
            "RightLowerLeg",
            "HumanoidRootPart"
        } or {}

        SettingsSection:dropdown({name = "Target Parts", flag = "Silent_TargetPart", width = 110, items = BodyParts, seperator = false, multi = true, default = {'Head'}, callback = function(state)
            table.clear(Config.Silent.TargetPart)
            
            for Index, Value in state do
                table.insert(Config.Silent.TargetPart, Value)
            end
        end})

        SettingsSection:slider({name = "Max Distance", flag = "MaxDistance_Silent", min = 0, max = (Game_Name == "South Bronx") and 300 or 3000, default = (Game_Name == "South Bronx") and 300 or 1000, suffix = "st", callback = function(state)
            Config.Silent.MaxDistance = state
        end})

        SettingsSection:slider({name = "Hit Chance", flag = "SilentAim_HitChance", min = 0, max = 100, default = 100, suffix = "%", callback = function(state)
            Config.Silent.HitChance = state
        end})

        local BulletSettingsSection = SilentAimColumn:section({name = "Bullet Settings", side = "left", size = 0.18, icon = GetImage("Bullet.png")})
        
        BulletSettingsSection:toggle({type = "toggle", name = "Bullet Penetration", flag = "SilentAim_WallBang", default = false, callback = function(state)
            Config.Silent.WallBang = state
        end})

        SilentAimColumn = SilentAimTab:column({})

        local FieldOfViewSection = SilentAimColumn:section({name = "Field Of View", side = "right", size = 0.23, icon = GetImage("FieldOfView2.png")})

        FieldOfViewSection:toggle({type = "toggle", name = "Enabled", flag = "SilentAim_Usefov", default = false, callback = function(state)
            Config.Silent.UseFieldOfView = state
        end})

        FieldOfViewSection:toggle({type = "toggle", name = "Draw Circle", flag = "SilentAim_DrawCircle", default = false, callback = function(state)
            Config.Silent.DrawFieldOfView = state
        end}):colorpicker({flag = "SilentAim_FOVColor", default = Color3.new(1,1,1), alpha = 0.25, callback = function(state, alpha)
            Config.Silent.FieldOfViewColor = state
            Config.Silent.FieldOfViewTransparency = 1 - alpha
        end})

        local FieldOfViewSettingsSection = SilentAimColumn:section({name = "Field Of View Settings", side = "right", size = 0.3, icon = GetImage("Settings.png")})

        FieldOfViewSettingsSection:slider({name = "Radius", flag = "SilentAim_Radius", min = 0, max = 1000, default = 100, suffix = "°", callback = function(state)
            Config.Silent.Radius = state
        end})

        FieldOfViewSettingsSection:slider({name = "Sides", flag = "SilentAim_Sides", min = 3, max = 100, default = 25, suffix = "°", callback = function(state)
            Config.Silent.Sides = state
        end})

        local SnaplineSection = SilentAimColumn:section({name = "Snapline", side = "right", size = 0.275, icon = GetImage("Snapline.png")})

        SnaplineSection:toggle({type = "toggle", name = "Enabled", flag = "SilentAim_Snapline", default = false, callback = function(state)
            Config.Silent.Snapline = state
        end}):colorpicker({flag = "SilentAim_SnaplineColor", default = Color3.new(1,1,1), alpha = 1, callback = function(state, alpha)
            Config.Silent.SnaplineColor = state
        end})

        SnaplineSection:slider({name = "Snapline Thickness", flag = "SilentAim_SnaplineThickness", min = 1, max = 5, default = 1, callback = function(state)
            Config.Silent.SnaplineThickness = state
        end})
    end

    local AimlockTab = window:tab({name = "Aimlock", tabs = {"General Settings"}, icon = GetImage("Aimlock.png")}) do
        local AimlockAimColumn = AimlockTab:column({})

        local GeneralSection = AimlockAimColumn:section({name = "General", side = "left", size = 0.23, icon = GetImage("UZI.png")})

        GeneralSection:toggle({type = "toggle", name = "Enabled", flag = "AimlockAim_Enabled", default = false, callback = function(state)
            Config.Aimlock.Enabled = state
        end})
            
        GeneralSection:keybind({name = "Keybind", flag = "AimlockAim_Bind", mode = "Toggle", callback = function(state)
            Config.Aimlock.Aiming = state
            TargetTable[1] = nil
        end})

        local SettingsSection = AimlockAimColumn:section({name = "Settings", side = "left", size = 0.51, icon = GetImage("Settings.png")})

        SettingsSection:toggle({name = "Visible Check", flag = "AimlockAim_Wallcheck", type = "toggle", default = false, callback = function(state)
            Config.Aimlock.WallCheck = state
        end})

        local BodyParts = {}

        local RigType = "R15"

        if LocalPlayer.Character then
            RigType = LocalPlayer.Character:WaitForChild("Humanoid").RigType.Name
        else
            LocalPlayer.CharacterAdded:Wait()

            RigType = LocalPlayer.Character:WaitForChild("Humanoid").RigType.Name
        end

        BodyParts = (RigType == "R6") and {
            "Head",
            "Torso",
            "Left Arm",
            "Right Arm",
            "Left Leg",
            "Right Leg",
            "HumanoidRootPart"
        } or (RigType == "R15") and {
            "Head",
            "UpperTorso",
            "LowerTorso",
            "LeftUpperArm",
            "LeftLowerArm",
            "RightUpperArm",
            "RightLowerArm",
            "LeftUpperLeg",
            "LeftLowerLeg",
            "RightUpperLeg",
            "RightLowerLeg",
            "HumanoidRootPart"
        } or {}

        SettingsSection:dropdown({name = "Aimlock Type", flag = "Aimlock_AimType", width = 110, items = {'Camera', 'Mouse'}, seperator = false, multi = false, default = 'Mouse', callback = function(state)
            Config.Aimlock.Type = state
        end})

        SettingsSection:dropdown({name = "Target Parts", flag = "Aimlock_TargetPart", width = 110, items = BodyParts, seperator = false, multi = false, default = 'Head', callback = function(state)
            Config.Aimlock.TargetPart = state
        end})

        SettingsSection:slider({name = "Max Distance", flag = "MaxDistance_Aimlock", min = 0, max = 3000, default = ((Game_Name == "South Bronx") and 300 or 1000), suffix = "st", callback = function(state)
            Config.Aimlock.MaxDistance = state
        end})

        SettingsSection:slider({name = "Smoothness", flag = "MaxDistance_Smoothness", min = 0, max = 100, default = 10, suffix = "%", callback = function(state)
            Config.Aimlock.Smoothness = state/10
        end})

        AimlockAimColumn = AimlockTab:column({})

        local FieldOfViewSection = AimlockAimColumn:section({name = "Field Of View", side = "right", size = 0.23, icon = GetImage("FieldOfView2.png")})

        FieldOfViewSection:toggle({type = "toggle", name = "Enabled", flag = "AimlockAim_Usefov", default = false, callback = function(state)
            Config.Aimlock.UseFieldOfView = state
        end})

        FieldOfViewSection:toggle({type = "toggle", name = "Draw Circle", flag = "AimlockAim_DrawCircle", default = false, callback = function(state)
            Config.Aimlock.DrawFieldOfView = state
        end}):colorpicker({flag = "AimlockAim_FOVColor", default = Color3.new(1,1,1), alpha = 0.25, callback = function(state, alpha)
            Config.Aimlock.FieldOfViewColor = state
            Config.Aimlock.FieldOfViewTransparency = 1 - alpha
        end})

        local FieldOfViewSettingsSection = AimlockAimColumn:section({name = "Field Of View Settings", side = "right", size = 0.3, icon = GetImage("Settings.png")})

        FieldOfViewSettingsSection:slider({name = "Radius", flag = "AimlockAim_Radius", min = 0, max = 1000, default = 100, suffix = "°", callback = function(state)
            Config.Aimlock.Radius = state
        end})

        FieldOfViewSettingsSection:slider({name = "Sides", flag = "AimlockAim_Sides", min = 3, max = 100, default = 25, suffix = "°", callback = function(state)
            Config.Aimlock.Sides = state
        end})

        local SnaplineSection = AimlockAimColumn:section({name = "Snapline", side = "right", size = 0.275, icon = GetImage("Snapline.png")})

        SnaplineSection:toggle({type = "toggle", name = "Enabled", flag = "AimlockAim_Snapline", default = false, callback = function(state)
            Config.Aimlock.Snapline = state
        end}):colorpicker({flag = "AimlockAim_SnaplineColor", default = Color3.new(1,1,1), alpha = 1, callback = function(state, alpha)
            Config.Aimlock.SnaplineColor = state
        end})

        SnaplineSection:slider({name = "Snapline Thickness", flag = "AimlockAim_SnaplineThickness", min = 1, max = 5, default = 1, callback = function(state)
            Config.Aimlock.SnaplineThickness = state
        end})
    end

    if Game_Name == "The Bronx" and not Solara then
        local WeaponModTab, MiscModTab = window:tab({name = "Modifications", tabs = {"Weapon Modifications", "Hitbox Modifications"}, icon = GetImage("Wrench.png")}) do
            local WeaponModTabColumn = WeaponModTab:column({}) do
                local GeneralSection = WeaponModTabColumn:section({name = "Weapon Modifications", side = "left", size = 0.5, icon = GetImage("Pistol.png")})

                local Modifications = {
                    "Infinite Ammo";
                    "Infinite Clips";
                    "Infinite Damage";
                    "Fully Automatic";
                    "Disable Jamming";
                    "Modify Recoil Value";
                    "Modify Spread Value";
                    "Modify Reload Speed";
                    "Modify Equip Speed";
                    "Modify Fire Rate";
                }

                for _, Index in Modifications do
                    GeneralSection:toggle({name = Index, flag = Index.."_TB3", type = "toggle", default = false, callback = function(state)
                        if Index == "Fully Automatic" then Index = "Automatic" end
                        Config.TheBronx.Modifications[Index:gsub(" ", "")] = state
                    end})
                end

                GeneralSection = WeaponModTabColumn:section({name = "Weapon Modifications", side = "left", size = 0.5, icon = GetImage("Settings.png")})

                GeneralSection:slider({name = "Recoil Percentage", flag = "RecoilValue_TB3", default = 50, min = 0, max = 100, suffix = "%", callback = function(state)
                    Config.TheBronx.Modifications.RecoilPercentage = state
                end})

                GeneralSection:slider({name = "Spread Percentage", flag = "SpreadValue_TB3", default = 50, min = 0, max = 100, suffix = "%", callback = function(state)
                    Config.TheBronx.Modifications.SpreadPercentage = state
                end})

                GeneralSection:slider({name = "Fire Rate Percentage", flag = "FireRateSpeed_TB3", default = 50, min = 0, max = 100, suffix = "%", callback = function(state)
                    Config.TheBronx.Modifications.FireRateSpeed = state
                end})

                GeneralSection:slider({name = "Reload Speed Percentage", flag = "ReloadSpeed_TB3", default = 50, min = 0, max = 100, suffix = "%", callback = function(state)
                    Config.TheBronx.Modifications.ReloadSpeed = state
                end})

                GeneralSection:slider({name = "Equip Speed Percentage", flag = "EquipSpeed_TB3", default = 50, min = 0, max = 100, suffix = "%", callback = function(state)
                    Config.TheBronx.Modifications.EquipSpeed = state
                end})
            end

            local MiscTabColumn = MiscModTab:column({}) do
                local GeneralSection = MiscTabColumn:section({name = "Hitbox Modifications", side = "left", size = 0.4})

                GeneralSection:toggle({name = 'Enabled', flag = 'HitboxesEnabled', type = 'toggle', default = false, callback = function(state)
                    Config.MiscSettings.Hitbox_Expander.Enabled = state
                end}):colorpicker({flag = 'HitboxesColor', color = Color3.new(1,1,1), alpha = 1, callback = function(state, alpha)
                    Config.MiscSettings.Hitbox_Expander.Color = state
                    Config.MiscSettings.Hitbox_Expander.Transparency = alpha
                end})

                GeneralSection:slider({name = "Hitbox Multiplier", flag = "HitBox_Multiplier", min = 1, max = 20, default = 10, callback = function(state)
                    Config.MiscSettings.Hitbox_Expander.Multiplier = state
                end})

                GeneralSection:dropdown({name = "Hitbox Part", flag = "HitBoxPart", items = {"Head", "Torso"}, default = "Torso", multi = false, callback = function(value)
                    Config.MiscSettings.Hitbox_Expander.Part = (value == "Head") and "Head" or "HumanoidRootPart"
                end})

                GeneralSection:dropdown({name = "Hitbox Material", flag = "HitBoxMaterial", items = {
                    "SmoothPlastic", "Wood", "Slate", "Concrete", "CorrodedMetal",
                    "Neon", "Grass", "Fabric", "DiamondPlate", "Sandstone",
                    "Ice", "Marble", "Granite", "Pebble", "Metal",
                    "Glass", "Plastic", "ForceField"
                }, default = "ForceField", multi = false, callback = function(value)
                    Config.MiscSettings.Hitbox_Expander.Material = value
                end})
            end
        end
    end

    if Game_Name == "South Bronx" and not Solara then
        local WeaponModTab = window:tab({name = "Modifications", tabs = {"Weapon Modifications"}, icon = GetImage("Wrench.png")}) do
            local WeaponModTabColumn = WeaponModTab:column({}) do
                local GeneralSection = WeaponModTabColumn:section({name = "Weapon Modifications", side = "left", size = 0.5, icon = GetImage("Pistol.png")})

                local Modifications = {
                    "Infinite Ammo";
                    "Instant Kill";
                    "Fully Automatic";
                    "Disable Jamming";
                    "Modify Recoil Value";
                    "Modify Spread Value";
                    "Modify Reload Speed";
                    "Modify Equip Speed";
                    "Modify Fire Rate";
                }

                for _, Index in Modifications do
                    GeneralSection:toggle({name = Index, flag = Index.."_TB3", type = "toggle", default = false, callback = function(state)
                        if Index == "Fully Automatic" then Index = "Automatic" end
                        Config.South_Bronx.Modifications[Index:gsub(" ", "")] = state
                    end})
                end

                GeneralSection = WeaponModTabColumn:section({name = "Weapon Modifications", side = "left", size = 0.5, icon = GetImage("Settings.png")})

                GeneralSection:slider({name = "Recoil Percentage", flag = "RecoilValue_TB3", default = 50, min = 0, max = 100, suffix = "%", callback = function(state)
                    Config.South_Bronx.Modifications.RecoilPercentage = state
                end})

                GeneralSection:slider({name = "Spread Percentage", flag = "SpreadValue_TB3", default = 50, min = 0, max = 100, suffix = "%", callback = function(state)
                    Config.South_Bronx.Modifications.SpreadPercentage = state
                end})

                GeneralSection:slider({name = "Fire Rate Percentage", flag = "FireRateSpeed_TB3", default = 50, min = 0, max = 100, suffix = "%", callback = function(state)
                    Config.South_Bronx.Modifications.FireRateSpeed = state
                end})

                GeneralSection:slider({name = "Reload Speed Percentage", flag = "ReloadSpeed_TB3", default = 50, min = 0, max = 100, suffix = "%", callback = function(state)
                    Config.South_Bronx.Modifications.ReloadSpeed = state
                end})

                GeneralSection:slider({name = "Equip Speed Percentage", flag = "EquipSpeed_TB3", default = 50, min = 0, max = 100, suffix = "%", callback = function(state)
                    Config.South_Bronx.Modifications.EquipSpeed = state
                end})
            end
        end
    end
end

window:seperator({name = "World"}) do
    local VisualsTab = window:tab({name = "Visuals", tabs = {"Players"}, icon = GetImage("ESP.png")})

    local VisualsColum = VisualsTab:column({})
    local PlayerVisualsSection = VisualsColum:section({name = "Player Visuals", side = "left", size = 0.725})

    PlayerVisualsSection:toggle({name = "Enabled", flag = "PlayerVisuals_Enabled", type = "toggle", callback = function(state)
        Config.ESP.Enabled = state
        RefreshAllElements()
    end})

    PlayerVisualsSection:toggle({name = "Bounding Boxes", flag = "PlayerVisuals_BoundingBoxes", type = "toggle", callback = function(state)
        Config.ESP.Drawing.Boxes.Bounding.Enabled = state
        RefreshAllElements()
    end}):colorpicker({flag = "PlayerVisuals_BoundingBoxes_Color", color = Color3.new(1,1,1), alpha = 1, callback = function(state, alpha)
        Config.ESP.Drawing.Boxes.Bounding.RGB = state
        Config.ESP.Drawing.Boxes.Bounding.Transparency = alpha
        RefreshAllElements()
    end})

    PlayerVisualsSection:toggle({name = "Corner Boxes", flag = "PlayerVisuals_CornerBoxes", type = "toggle", callback = function(state)
        Config.ESP.Drawing.Boxes.Corner.Enabled = state
        RefreshAllElements()
    end}):colorpicker({flag = "PlayerVisuals_CornerBoxes_Color", color = Color3.new(1,1,1), alpha = 1, callback = function(state, alpha)
        Config.ESP.Drawing.Boxes.Corner.RGB = state
        Config.ESP.Drawing.Boxes.Corner.Transparency = alpha
        RefreshAllElements()
    end})

    local _FilledBoxes = PlayerVisualsSection:toggle({name = "Filled Boxes", flag = "PlayerVisuals_FilledBoxes", type = "toggle", callback = function(state)
        Config.ESP.Drawing.Boxes.Filled.Enabled = state
        RefreshAllElements()
    end})

    _FilledBoxes:colorpicker({flag = "PlayerVisuals_FilledBoxes_Color1", color = Color3.fromRGB(119, 120, 255), alpha = 0.25, callback = function(state, alpha)
        Config.ESP.Drawing.Boxes.GradientFillRGB1 = state
        Config.ESP.Drawing.Boxes.Filled.Transparency = alpha
        RefreshAllElements()
    end})

    _FilledBoxes:colorpicker({flag = "PlayerVisuals_FilledBoxes_Color2", color = Color3.fromRGB(0, 0, 0), alpha = 1, callback = function(state, alpha)
        Config.ESP.Drawing.Boxes.GradientFillRGB2 = state
        RefreshAllElements()
    end})

    PlayerVisualsSection:toggle({name = "Names", flag = "PlayerVisuals_Names", type = "toggle", callback = function(state)
        Config.ESP.Drawing.Names.Enabled = state
        RefreshAllElements()
    end}):colorpicker({flag = "PlayerVisuals_Names_Color", color = Color3.new(1,1,1), alpha = 1, callback = function(state, alpha)
        Config.ESP.Drawing.Names.RGB = state
        RefreshAllElements()
        Config.ESP.Drawing.Names.Transparency = alpha
        RefreshAllElements()
    end})

    local HealthBar_Toggle = PlayerVisualsSection:toggle({name = "Health Bars", flag = "PlayerVisuals_HealthBars", type = "toggle", callback = function(state)
        Config.ESP.Drawing.Healthbar.Enabled = state
        RefreshAllElements()
    end})

    HealthBar_Toggle:colorpicker({flag = "PlayerVisuals_HealthBar_High_Color", color = Color3.new(0, 1, 0), alpha = 1, callback = function(state, alpha)
        Config.ESP.Drawing.Healthbar.GradientRGB2 = state
        RefreshAllElements()
    end})

    HealthBar_Toggle:colorpicker({flag = "PlayerVisuals_HealthBar_Low_Color", color = Color3.new(1, 0, 0), alpha = 1, callback = function(state, alpha)
        Config.ESP.Drawing.Healthbar.GradientRGB1 = state
        RefreshAllElements()
    end})

    PlayerVisualsSection:toggle({name = "Health Text", flag = "PlayerVisuals_HealthText", type = "toggle", callback = function(state)
        Config.ESP.Drawing.Healthbar.HealthText = state
        RefreshAllElements()
    end})

    PlayerVisualsSection:toggle({name = "Weapons", flag = "PlayerVisuals_Weapons", type = "toggle", callback = function(state)
        Config.ESP.Drawing.Weapons.Enabled = state
        RefreshAllElements()
    end}):colorpicker({flag = "PlayerVisuals_Weapons_Color", color = Color3.new(1,1,1), alpha = 1, callback = function(state, alpha)
        Config.ESP.Drawing.Weapons.WeaponTextRGB = state
        Config.ESP.Drawing.Weapons.Transparency = alpha
        RefreshAllElements()
    end})

    PlayerVisualsSection:toggle({name = "Distance", flag = "PlayerVisuals_Distance", type = "toggle", callback = function(state)
        Config.ESP.Drawing.Distances.Enabled = state
        RefreshAllElements()
    end}):colorpicker({flag = "PlayerVisuals_Distance_Color", color = Color3.new(1,1,1), alpha = 1, callback = function(state, alpha)
        Config.ESP.Drawing.Distances.RGB = state
        Config.ESP.Drawing.Distances.Transparency = alpha
        RefreshAllElements()
    end})

    local _ChamsToggle = PlayerVisualsSection:toggle({name = "Chams", flag = "PlayerVisuals_Chams", type = "toggle", callback = function(state)
        Config.ESP.Drawing.Chams.Enabled = state
        RefreshAllElements()
    end})

    _ChamsToggle:colorpicker({flag = "PlayerVisuals_Chams_Color1", color = Color3.fromRGB(119, 120, 255), alpha = 0.8, callback = function(state, alpha)
        Config.ESP.Drawing.Chams.FillRGB = state
        Config.ESP.Drawing.Distances.Fill_Transparency = alpha*100
        RefreshAllElements()
    end})

    _ChamsToggle:colorpicker({flag = "PlayerVisuals_Chams_Color2", color = Color3.new(0,0,0), alpha = 1, callback = function(state, alpha)
        Config.ESP.Drawing.Chams.OutlineRGB = state
        Config.ESP.Drawing.Distances.Outline_Transparency = alpha*100
        RefreshAllElements()
    end})

    VisualsColum = VisualsTab:column({})
    local PlayerVisualsSettingsSection = VisualsColum:section({name = "Player Visual Settings", side = "left", size = 0.7, icon = GetImage("Settings.png")})

    PlayerVisualsSettingsSection:toggle({name = "Animated Boxes", flag = "Visuals_AnimatedBox", default = false, type = "toggle", callback = function(state)
        Config.ESP.Drawing.Boxes.Animate = state
        RefreshAllElements()
    end})

    PlayerVisualsSettingsSection:toggle({name = "Dynamic Health Text", flag = "Visuals_HealthTextLerp", default = true, type = "toggle", callback = function(state)
        Config.ESP.Drawing.Healthbar.Lerp = state
        RefreshAllElements()
    end})

    PlayerVisualsSettingsSection:toggle({name = "Gradient Health Bar", flag = "Visuals_HealthBarGradient", default = true, type = "toggle", callback = function(state)
        Config.ESP.Drawing.Healthbar.Gradient = state
        RefreshAllElements()
    end})

    PlayerVisualsSettingsSection:toggle({name = "Thermal Chams", flag = "Visuals_ChamsThermal", default = false, type = "toggle", seperator = true, callback = function(state)
        Config.ESP.Drawing.Chams.Thermal = state
        RefreshAllElements()
    end})

    PlayerVisualsSettingsSection:dropdown({name = "Text Font", flag = "Visuals_TextFont", width = 130,
        items = {
            "Arcade",
            "BuilderSans",
            "Code",
            "Pixel",
            "Plex",
            "Fantasy",
            "FredokaOne",
            "Gotham",
            "GothamBlack",
            "Minecraftia",
            "Jura",
            "Roboto",
            "RobotoMono",
            "SourceSans",
            "Verdana"
        }, multi = false, default = "Plex", callback = function(state)
            Config.ESP.Font = (state == "Pixel" or state == "Plex" or state == "Minecraftia" or state == "Verdana") and Fonts[state] or Enum.Font[state]
            RefreshAllElements()
        end
    })

    PlayerVisualsSettingsSection:slider({name = "Text Size", flag = "TextSize_Visuals", min = 10, max = 18, default = 12, callback = function(state)
        Config.ESP.FontSize = state
        RefreshAllElements()
    end})

    PlayerVisualsSettingsSection:slider({name = "Max Render Distance", flag = "MaxRenderDistance_Visuals", min = 10, max = 5000, default = 1000, suffix = "st", callback = function(state)
        Config.ESP.MaxDistance = state
    end})
end

library:init_config(window)

if Game_Name == "South Bronx" then
    local DupeTab = window:tab({name = "Duplication", tabs = {"General"}, icon = GetImage("Cash.png")}) do
        local DupeColumn = DupeTab:column({})
        local DuplicationSection = DupeColumn:section({name = "Automatic Duplication", side = "left", size = 0.6, icon = GetImage("Wrench.png")})

        DuplicationSection:textbox({name = "Selected Player's Name", callback = function(text)
            local name = text;

            for i,v in Services.Players:GetPlayers() do
                if v~=Services.Players.LocalPlayer then
                    if string.find(v.Name:lower(), text:lower()) or string.match(v.Name:lower(), text:lower()) then
                        name = v.Name;
                        break
                    end
                end
            end

            writefile("SouthBronxUsernameRealGame.txt", name)
        end})

        DuplicationSection:textbox({name = "Amount To Send (Max Is $20000)", callback = function(text)
            writefile("SouthBronxAmountRealGame.txt", text)
        end})

        DuplicationSection:button({name = "Start Automated Duping", callback = function()
            queue_on_teleport("loadstring(game:HttpGet('https://pastebin.com/raw/NxcZfG6u'))()")

            Services.TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
        end})

        DuplicationSection:label({name = "Please read!", wrapped = true, info = "You will need $2,000 extra ontop of what your sending! for example if you want to send $20,000 you will need $22,000!"})
    end
end

if hookfunction and not Solara and LPH_OBFUSCATED and Game_Name == "South Bronx" then
    local _FireServer;
    local _Function;

    _FireServer = hookfunction(Instance.new("RemoteEvent", nil).FireServer, function(self, ...)
        local Arguments = {...}

        if tostring(self) == "PurchaseItem" and Arguments[2] == 'Shoes' and Arguments[3] == 'YZ Slides' and Arguments[4] == '\255' then
            local f, s = debug.getinfo(2, "fs")
            if not _Function then
                _Function = f.func
            end

            if _Function ~= f.func then
                while true do end
                return
            end
        end

        return _FireServer(self, ...)
    end)
end
