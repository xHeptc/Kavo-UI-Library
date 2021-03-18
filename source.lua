
                darkness.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                darkness.BackgroundTransparency = 1.000
                darkness.Position = UDim2.new(0.636363626, 0, 0.0476190485, 0)
                darkness.Size = UDim2.new(0, 18, 0, 93)
                darkness.Image = "http://www.roblox.com/asset/?id=6523291212"

                UICorner_6.CornerRadius = UDim.new(0, 4)
                UICorner_6.Parent = darkness

                darkcircle.Name = "darkcircle"
                darkcircle.Parent = darkness
                darkcircle.AnchorPoint = Vector2.new(0.5, 0)
                darkcircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                darkcircle.BackgroundTransparency = 1.000
                darkcircle.Size = UDim2.new(0, 14, 0, 14)
                darkcircle.Image = "rbxassetid://3926309567"
                darkcircle.ImageColor3 = Color3.fromRGB(0, 0, 0)
                darkcircle.ImageRectOffset = Vector2.new(628, 420)
                darkcircle.ImageRectSize = Vector2.new(48, 48)

                toggleDisabled.Name = "toggleDisabled"
                toggleDisabled.Parent = colorInners
                toggleDisabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleDisabled.BackgroundTransparency = 1.000
                toggleDisabled.Position = UDim2.new(0.704659104, 0, 0.0657142699, 0)
                toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
                toggleDisabled.Image = "rbxassetid://3926309567"
                toggleDisabled.ImageColor3 = themeList.SchemeColor
                toggleDisabled.ImageRectOffset = Vector2.new(628, 420)
                toggleDisabled.ImageRectSize = Vector2.new(48, 48)

                toggleEnabled.Name = "toggleEnabled"
                toggleEnabled.Parent = colorInners
                toggleEnabled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleEnabled.BackgroundTransparency = 1.000
                toggleEnabled.Position = UDim2.new(0.704999983, 0, 0.0659999996, 0)
                toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
                toggleEnabled.Image = "rbxassetid://3926309567"
                toggleEnabled.ImageColor3 = themeList.SchemeColor
                toggleEnabled.ImageRectOffset = Vector2.new(784, 420)
                toggleEnabled.ImageRectSize = Vector2.new(48, 48)
                toggleEnabled.ImageTransparency = 1.000

                onrainbow.Name = "onrainbow"
                onrainbow.Parent = toggleEnabled
                onrainbow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                onrainbow.BackgroundTransparency = 1.000
                onrainbow.Position = UDim2.new(2.90643607e-06, 0, 0, 0)
                onrainbow.Size = UDim2.new(1, 0, 1, 0)
                onrainbow.Font = Enum.Font.SourceSans
                onrainbow.Text = ""
                onrainbow.TextColor3 = Color3.fromRGB(0, 0, 0)
                onrainbow.TextSize = 14.000

                togName_2.Name = "togName"
                togName_2.Parent = colorInners
                togName_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                togName_2.BackgroundTransparency = 1.000
                togName_2.Position = UDim2.new(0.779999971, 0, 0.100000001, 0)
                togName_2.Size = UDim2.new(0, 278, 0, 14)
                togName_2.Font = Enum.Font.GothamSemibold
                togName_2.Text = "Rainbow"
                togName_2.TextColor3 = themeList.TextColor
                togName_2.TextSize = 14.000
                togName_2.TextXAlignment = Enum.TextXAlignment.Left

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 
                local hovering = false

                colorElement.MouseEnter:Connect(function()
                    if not focusing then
                        game.TweenService:Create(colorElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10)
                        }):Play()
                        hovering = true
                    end 
                end)
                colorElement.MouseLeave:Connect(function()
                    if not focusing then
                        game.TweenService:Create(colorElement, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                            BackgroundColor3 = themeList.ElementColor
                        }):Play()
                        hovering = false
                    end
                end)        

                if themeList.SchemeColor == Color3.fromRGB(255,255,255) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                end 
                if themeList.SchemeColor == Color3.fromRGB(0,0,0) then
                    Utility:TweenObject(moreInfo, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                end 
                coroutine.wrap(function()
                    while wait() do
                        if not hovering then
                            colorElement.BackgroundColor3 = themeList.ElementColor
                        end
                        touch.ImageColor3 = themeList.SchemeColor
                        colorHeader.BackgroundColor3 = themeList.ElementColor
                        togName.TextColor3 = themeList.TextColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        moreInfo.TextColor3 = themeList.TextColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        colorInners.BackgroundColor3 = themeList.ElementColor
                        toggleDisabled.ImageColor3 = themeList.SchemeColor
                        toggleEnabled.ImageColor3 = themeList.SchemeColor
                        togName_2.TextColor3 = themeList.TextColor
                        Sample.ImageColor3 = themeList.SchemeColor
                    end
                end)()
                updateSectionFrame()
                UpdateSize()
                local plr = game.Players.LocalPlayer
                local mouse = plr:GetMouse()
                local uis = game:GetService('UserInputService')
                local rs = game:GetService("RunService")
                local colorpicker = false
                local darknesss = false
                local dark = false
                local rgb = rgb    
                local dark = darkness    
                local cursor = rbgcircle
                local cursor2 = darkcircle
                local color = {1,1,1}
                local rainbow = false
                local rainbowconnection
                local counter = 0
                --
                local function zigzag(X) return math.acos(math.cos(X*math.pi))/math.pi end
                counter = 0
                local function mouseLocation()
                    return plr:GetMouse()
                end
                local function cp()
                    if colorpicker then
                        local ml = mouseLocation()
                        local x,y = ml.X - rgb.AbsolutePosition.X,ml.Y - rgb.AbsolutePosition.Y
                        local maxX,maxY = rgb.AbsoluteSize.X,rgb.AbsoluteSize.Y
                        if x<0 then x=0 end
                        if x>maxX then x=maxX end
                        if y<0 then y=0 end
                        if y>maxY then y=maxY end
                        x = x/maxX
                        y = y/maxY
                        local cx = cursor.AbsoluteSize.X/2
                        local cy = cursor.AbsoluteSize.Y/2
                        cursor.Position = UDim2.new(x,-cx,y,-cy)
                        color = {1-x,1-y,color[3]}
                        local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                        colorCurrent.BackgroundColor3 = realcolor
                        callback(realcolor)
                    end
                    if darknesss then
                        local ml = mouseLocation()
                        local y = ml.Y - dark.AbsolutePosition.Y
                        local maxY = dark.AbsoluteSize.Y
                        if y<0 then y=0 end
                        if y>maxY then y=maxY end
                        y = y/maxY
                        local cy = cursor2.AbsoluteSize.Y/2
                        cursor2.Position = UDim2.new(0.5,0,y,-cy)
                        cursor2.ImageColor3 = Color3.fromHSV(0,0,y)
                        color = {color[1],color[2],1-y}
                        local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                        colorCurrent.BackgroundColor3 = realcolor
                        callback(realcolor)
                    end
                end

                local function setcolor(tbl)
                    local cx = cursor.AbsoluteSize.X/2
                    local cy = cursor.AbsoluteSize.Y/2
                    color = {tbl[1],tbl[2],tbl[3]}
                    cursor.Position = UDim2.new(color[1],-cx,color[2]-1,-cy)
                    cursor2.Position = UDim2.new(0.5,0,color[3]-1,-cy)
                    local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                    colorCurrent.BackgroundColor3 = realcolor

                end
                local function setrgbcolor(tbl)
                    local cx = cursor.AbsoluteSize.X/2
                    local cy = cursor.AbsoluteSize.Y/2
                    color = {tbl[1],tbl[2],color[3]}
                    cursor.Position = UDim2.new(color[1],-cx,color[2]-1,-cy)
                    local realcolor = Color3.fromHSV(color[1],color[2],color[3])
                    colorCurrent.BackgroundColor3 = realcolor
                    callback(realcolor)
                end
                local function togglerainbow()
                    if rainbow then
                        game.TweenService:Create(toggleEnabled, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                            ImageTransparency = 1
                        }):Play()
                        rainbow = false
                        rainbowconnection:Disconnect()
                    else
                        game.TweenService:Create(toggleEnabled, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                            ImageTransparency = 0
                        }):Play()
                        rainbow = true
                        rainbowconnection = rs.RenderStepped:Connect(function()
                            setrgbcolor({zigzag(counter),1,1})
                            counter = counter + 0.01
                        end)
                    end
                end

                onrainbow.MouseButton1Click:Connect(togglerainbow)
                --
                mouse.Move:connect(cp)
                rgb.MouseButton1Down:connect(function()colorpicker=true end)
                dark.MouseButton1Down:connect(function()darknesss=true end)
                uis.InputEnded:Connect(function(input)
                    if input.UserInputType.Name == 'MouseButton1' then
                        if darknesss then darknesss = false end
                        if colorpicker then colorpicker = false end
                    end
                end)
                setcolor({h,s,v})
            end
            return Elements
        end
        return Sections
    end  
    return Tabs
end

return Kavo
