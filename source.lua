local Kavo = {}
local TweenService = game:GetService('TweenService')
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local HttpService = game:GetService('HttpService')
local Players = game:GetService('Players')
local CoreGui = game:GetService('CoreGui')
local tweeninfo = TweenInfo.new
local Utility = {}
local Objects = {}
local Settings = {}
local Name = 'KavoConfig.JSON'

Kavo.DraggingEnabled = function(self, frame, parent)
    parent = parent or frame

    local dragging = false
    local dragStartPos
    local frameStartPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStartPos = input.Position
            frameStartPos = parent.Position

            local inputChangedConnection
            local inputEndedConnection

            inputChangedConnection = UserInputService.InputChanged:Connect(function(
                io
            )
                if io.UserInputType == Enum.UserInputType.MouseMovement or io.UserInputType == Enum.UserInputType.Touch then
                    if dragging then
                        local delta = io.Position - dragStartPos

                        parent.Position = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X, frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y)
                    end
                end
            end)
            inputEndedConnection = UserInputService.InputEnded:Connect(function(
                io
            )
                if io.UserInputType == Enum.UserInputType.MouseButton1 or io.UserInputType == Enum.UserInputType.Touch then
                    dragging = false

                    inputChangedConnection:Disconnect()
                    inputEndedConnection:Disconnect()
                end
            end)
        end
    end)
end
Utility.TweenObject = function(self, obj, properties, duration, ...)
    TweenService:Create(obj, tweeninfo(duration, ...), properties):Play()
end

local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(32, 32, 38),
}
local themeStyles = {
    DarkTheme = {
        SchemeColor = Color3.fromRGB(64, 64, 64),
        Background = Color3.fromRGB(0, 0, 0),
        Header = Color3.fromRGB(0, 0, 0),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(20, 20, 20),
    },
    LightTheme = {
        SchemeColor = Color3.fromRGB(150, 150, 150),
        Background = Color3.fromRGB(255, 255, 255),
        Header = Color3.fromRGB(200, 200, 200),
        TextColor = Color3.fromRGB(0, 0, 0),
        ElementColor = Color3.fromRGB(224, 224, 224),
    },
    BloodTheme = {
        SchemeColor = Color3.fromRGB(227, 27, 27),
        Background = Color3.fromRGB(10, 10, 10),
        Header = Color3.fromRGB(5, 5, 5),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(20, 20, 20),
    },
    GrapeTheme = {
        SchemeColor = Color3.fromRGB(166, 71, 214),
        Background = Color3.fromRGB(64, 50, 71),
        Header = Color3.fromRGB(36, 28, 41),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(74, 58, 84),
    },
    Ocean = {
        SchemeColor = Color3.fromRGB(86, 76, 251),
        Background = Color3.fromRGB(26, 32, 58),
        Header = Color3.fromRGB(38, 45, 71),
        TextColor = Color3.fromRGB(200, 200, 200),
        ElementColor = Color3.fromRGB(38, 45, 71),
    },
    Midnight = {
        SchemeColor = Color3.fromRGB(26, 189, 158),
        Background = Color3.fromRGB(44, 62, 82),
        Header = Color3.fromRGB(57, 81, 105),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(52, 74, 95),
    },
    Sentinel = {
        SchemeColor = Color3.fromRGB(230, 35, 69),
        Background = Color3.fromRGB(32, 32, 32),
        Header = Color3.fromRGB(24, 24, 24),
        TextColor = Color3.fromRGB(119, 209, 138),
        ElementColor = Color3.fromRGB(24, 24, 24),
    },
    Synapse = {
        SchemeColor = Color3.fromRGB(46, 48, 43),
        Background = Color3.fromRGB(13, 15, 12),
        Header = Color3.fromRGB(36, 38, 35),
        TextColor = Color3.fromRGB(152, 99, 53),
        ElementColor = Color3.fromRGB(24, 24, 24),
    },
    Serpent = {
        SchemeColor = Color3.fromRGB(0, 166, 58),
        Background = Color3.fromRGB(31, 41, 43),
        Header = Color3.fromRGB(22, 29, 31),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(22, 29, 31),
    },
}

do
    local SettingsT = {}
    local success, content = pcall(readfile, Name)

    if not success or content == nil then
        pcall(writefile, Name, HttpService:JSONEncode(SettingsT))

        Settings = SettingsT
    else
        local decodeSuccess, decodedSettings = pcall(HttpService.JSONDecode, HttpService, content)

        if decodeSuccess then
            Settings = decodedSettings
        else
            warn(
[[Kavo UI: Failed to decode settings, falling back to defaults.]])

            Settings = SettingsT
        end
    end
end

local LibName = 'KavoLib_' .. tostring(math.random(1000, 9999))

Kavo.ToggleUI = function(self)
    local screenGui = CoreGui:FindFirstChild(LibName)

    if screenGui then
        screenGui.Enabled = not screenGui.Enabled
    end
end
Kavo.CreateLib = function(self, kavName, themeInput)
    kavName = kavName or 'Library'

    local themeList = {}

    for k, v in pairs(themes)do
        themeList[k] = v
    end

    local selectedTheme = themeStyles[themeInput] or (type(themeInput) == 'table' and themeInput)

    if selectedTheme then
        for k, v in pairs(selectedTheme)do
            themeList[k] = v
        end
    end

    for _, v in pairs(CoreGui:GetChildren())do
        if v:IsA('ScreenGui') and v.Name == LibName then
            v:Destroy()
        end
    end

    local ScreenGui = Instance.new('ScreenGui')
    local Main = Instance.new('Frame')
    local MainCorner = Instance.new('UICorner')
    local MainHeader = Instance.new('Frame')
    local headerCover = Instance.new('UICorner')
    local coverup = Instance.new('Frame')
    local title = Instance.new('TextLabel')
    local close = Instance.new('ImageButton')
    local MainSide = Instance.new('Frame')
    local sideCorner = Instance.new('UICorner')
    local coverup_2 = Instance.new('Frame')
    local tabFrames = Instance.new('Frame')
    local tabListing = Instance.new('UIListLayout')
    local pages = Instance.new('Frame')
    local Pages = Instance.new('Folder')
    local infoContainer = Instance.new('Frame')
    local blurFrame = Instance.new('Frame')

    self:DraggingEnabled(MainHeader, Main)

    blurFrame.Name = 'blurFrame'
    blurFrame.Parent = pages
    blurFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blurFrame.BackgroundTransparency = 1
    blurFrame.BorderSizePixel = 0
    blurFrame.Position = UDim2.new(0, 0, 0, 0)
    blurFrame.Size = UDim2.new(1, 0, 1, 0)
    blurFrame.ZIndex = 999
    ScreenGui.Parent = CoreGui
    ScreenGui.Name = LibName
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    Main.Name = 'Main'
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = themeList.Background
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.5, -262, 0.5, -159)
    Main.Size = UDim2.new(0, 525, 0, 318)
    MainCorner.CornerRadius = UDim.new(0, 4)
    MainCorner.Name = 'MainCorner'
    MainCorner.Parent = Main
    MainHeader.Name = 'MainHeader'
    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themeList.Header
    MainHeader.Size = UDim2.new(1, 0, 0, 29)
    headerCover.CornerRadius = UDim.new(0, 4)
    headerCover.Name = 'headerCover'
    headerCover.Parent = MainHeader
    coverup.Name = 'coverup'
    coverup.Parent = MainHeader
    coverup.BackgroundColor3 = themeList.Header
    coverup.BorderSizePixel = 0
    coverup.Position = UDim2.new(0, 0, 1, -7)
    coverup.Size = UDim2.new(1, 0, 0, 7)
    title.Name = 'title'
    title.Parent = MainHeader
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0.017, 0, 0, 0)
    title.Size = UDim2.new(0.5, 0, 1, 0)
    title.Font = Enum.Font.Gotham
    title.RichText = true
    title.Text = kavName
    title.TextColor3 = themeList.TextColor
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    close.Name = 'close'
    close.Parent = MainHeader
    close.BackgroundTransparency = 1
    close.Position = UDim2.new(1, -26, 0.5, -10.5)
    close.Size = UDim2.new(0, 21, 0, 21)
    close.ZIndex = 2
    close.Image = 'rbxassetid://3926305904'
    close.ImageRectOffset = Vector2.new(284, 4)
    close.ImageRectSize = Vector2.new(24, 24)

    close.MouseButton1Click:Connect(function()
        TweenService:Create(close, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {ImageTransparency = 1}):Play()
        task.wait(0.1)
        TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(Main.Position.X.Scale, Main.Position.X.Offset + Main.AbsoluteSize.X / 2, Main.Position.Y.Scale, Main.Position.Y.Offset + Main.AbsoluteSize.Y / 2),
        }):Play()
        task.wait(0.2)
        ScreenGui:Destroy()
    end)

    MainSide.Name = 'MainSide'
    MainSide.Parent = Main
    MainSide.BackgroundColor3 = themeList.Header
    MainSide.Position = UDim2.new(0, 0, 0, 29)
    MainSide.Size = UDim2.new(0, 149, 1, -29)
    sideCorner.CornerRadius = UDim.new(0, 4)
    sideCorner.Name = 'sideCorner'
    sideCorner.Parent = MainSide
    coverup_2.Name = 'coverup'
    coverup_2.Parent = MainSide
    coverup_2.BackgroundColor3 = themeList.Header
    coverup_2.BorderSizePixel = 0
    coverup_2.Position = UDim2.new(1, -7, 0, 0)
    coverup_2.Size = UDim2.new(0, 7, 1, 0)
    tabFrames.Name = 'tabFrames'
    tabFrames.Parent = MainSide
    tabFrames.BackgroundTransparency = 1
    tabFrames.Position = UDim2.new(0.043, 0, 0.01, 0)
    tabFrames.Size = UDim2.new(0.9, 0, 0.98, 0)
    tabListing.Name = 'tabListing'
    tabListing.Parent = tabFrames
    tabListing.FillDirection = Enum.FillDirection.Vertical
    tabListing.SortOrder = Enum.SortOrder.LayoutOrder
    tabListing.Padding = UDim.new(0, 5)
    pages.Name = 'pages'
    pages.Parent = Main
    pages.BackgroundTransparency = 1
    pages.Position = UDim2.new(0.299, 0, 0.091, 0)
    pages.Size = UDim2.new(0.701, -8, 0.78, 0)
    Pages.Name = 'Pages'
    Pages.Parent = pages
    infoContainer.Name = 'infoContainer'
    infoContainer.Parent = Main
    infoContainer.BackgroundTransparency = 1
    infoContainer.ClipsDescendants = true
    infoContainer.Position = UDim2.new(0.299, 0, 0.874, 0)
    infoContainer.Size = UDim2.new(0.701, -8, 0, 33)

    task.spawn(function()
        while ScreenGui.Parent do
            Main.BackgroundColor3 = themeList.Background
            MainHeader.BackgroundColor3 = themeList.Header
            MainSide.BackgroundColor3 = themeList.Header
            coverup_2.BackgroundColor3 = themeList.Header
            coverup.BackgroundColor3 = themeList.Header
            title.TextColor3 = themeList.TextColor

            task.wait()
        end
    end)

    Kavo.ChangeColor = function(self, prope, color)
        themeList[prope] = color
    end

    local Tabs = {}
    local first = true

    Tabs.NewTab = function(self, tabName)
        tabName = tabName or 'Tab'

        local tabButton = Instance.new('TextButton')
        local UICorner = Instance.new('UICorner')
        local page = Instance.new('ScrollingFrame')
        local pageListing = Instance.new('UIListLayout')

        local function UpdateSize()
            task.wait()

            page.CanvasSize = UDim2.new(0, 0, 0, pageListing.AbsoluteContentSize.Y)
        end

        page.Name = tabName .. 'Page'
        page.Parent = Pages
        page.Active = true
        page.BackgroundColor3 = themeList.Background
        page.BorderSizePixel = 0
        page.Size = UDim2.new(1, 0, 1, 0)
        page.ScrollBarThickness = 5
        page.Visible = false
        page.ScrollBarImageColor3 = themeList.SchemeColor
        pageListing.Name = 'pageListing'
        pageListing.Parent = page
        pageListing.FillDirection = Enum.FillDirection.Vertical
        pageListing.SortOrder = Enum.SortOrder.LayoutOrder
        pageListing.Padding = UDim.new(0, 5)
        tabButton.Name = tabName .. 'TabButton'
        tabButton.Parent = tabFrames
        tabButton.BackgroundColor3 = themeList.SchemeColor
        tabButton.Size = UDim2.new(1, 0, 0, 28)
        tabButton.AutoButtonColor = false
        tabButton.Font = Enum.Font.Gotham
        tabButton.Text = tabName
        tabButton.TextColor3 = themeList.TextColor
        tabButton.TextSize = 14
        tabButton.BackgroundTransparency = 1
        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = tabButton

        if first then
            first = false
            page.Visible = true
            tabButton.BackgroundTransparency = 0

            UpdateSize()
        end

        page.ChildAdded:Connect(UpdateSize)
        page.ChildRemoved:Connect(UpdateSize)
        tabButton.MouseButton1Click:Connect(function()
            UpdateSize()

            for _, v in pairs(Pages:GetChildren())do
                v.Visible = false
            end

            page.Visible = true

            for _, v in pairs(tabFrames:GetChildren())do
                if v:IsA('TextButton') then
                    self:TweenObject(v, {BackgroundTransparency = 1}, 0.2)
                end
            end

            self:TweenObject(tabButton, {BackgroundTransparency = 0}, 0.2)
        end)

        local Sections = {}

        task.spawn(function()
            while tabButton.Parent do
                page.BackgroundColor3 = themeList.Background
                page.ScrollBarImageColor3 = themeList.SchemeColor
                tabButton.TextColor3 = themeList.TextColor

                if tabButton.BackgroundTransparency == 0 then
                    tabButton.BackgroundColor3 = themeList.SchemeColor
                end

                task.wait()
            end
        end)

        Sections.NewSection = function(self, secName, hidden)
            secName = secName or 'Section'

            local sectionFrame = Instance.new('Frame')
            local sectionListLayout = Instance.new('UIListLayout')
            local sectionHead = Instance.new('Frame')
            local sHeadCorner = Instance.new('UICorner')
            local sectionName = Instance.new('TextLabel')
            local sectionInners = Instance.new('Frame')
            local sectionElListing = Instance.new('UIListLayout')

            sectionHead.Visible = not hidden
            sectionFrame.Name = 'sectionFrame'
            sectionFrame.Parent = page
            sectionFrame.BackgroundColor3 = themeList.Background
            sectionFrame.BorderSizePixel = 0
            sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            sectionListLayout.Parent = sectionFrame
            sectionListLayout.FillDirection = Enum.FillDirection.Vertical
            sectionListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            sectionListLayout.Padding = UDim.new(0, 5)
            sectionHead.Name = 'sectionHead'
            sectionHead.Parent = sectionFrame
            sectionHead.BackgroundColor3 = themeList.SchemeColor
            sectionHead.Size = UDim2.new(1, 0, 0, 33)
            sHeadCorner.CornerRadius = UDim.new(0, 4)
            sHeadCorner.Parent = sectionHead
            sectionName.Name = 'sectionName'
            sectionName.Parent = sectionHead
            sectionName.BackgroundTransparency = 1
            sectionName.Position = UDim2.new(0.02, 0, 0, 0)
            sectionName.Size = UDim2.new(0.96, 0, 1, 0)
            sectionName.Font = Enum.Font.Gotham
            sectionName.Text = secName
            sectionName.RichText = true
            sectionName.TextColor3 = themeList.TextColor
            sectionName.TextSize = 14
            sectionName.TextXAlignment = Enum.TextXAlignment.Left
            sectionInners.Name = 'sectionInners'
            sectionInners.Parent = sectionFrame
            sectionInners.BackgroundTransparency = 1
            sectionInners.AutomaticSize = Enum.AutomaticSize.Y
            sectionElListing.Name = 'sectionElListing'
            sectionElListing.Parent = sectionInners
            sectionElListing.FillDirection = Enum.FillDirection.Vertical
            sectionElListing.SortOrder = Enum.SortOrder.LayoutOrder
            sectionElListing.Padding = UDim.new(0, 3)

            task.spawn(function()
                while sectionFrame.Parent do
                    sectionHead.BackgroundColor3 = themeList.SchemeColor
                    sectionName.TextColor3 = themeList.TextColor

                    task.wait()
                end
            end)

            local Elements = {}

            Elements.NewButton = function(self, bname, tipINf, callback)
                bname = bname or 'Click Me!'
                tipINf = tipINf or 'Tip: Clicking this nothing will happen!'
                callback = callback or function() end

                local buttonElement = Instance.new('TextButton')
                local UICorner = Instance.new('UICorner')
                local btnInfo = Instance.new('TextLabel')
                local viewInfo = Instance.new('ImageButton')
                local touch = Instance.new('ImageLabel')
                local Sample = Instance.new('ImageLabel')

                buttonElement.Name = bname
                buttonElement.Parent = sectionInners
                buttonElement.BackgroundColor3 = themeList.ElementColor
                buttonElement.ClipsDescendants = true
                buttonElement.Size = UDim2.new(1, 0, 0, 33)
                buttonElement.AutoButtonColor = false
                buttonElement.Text = ''
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = buttonElement
                viewInfo.Name = 'viewInfo'
                viewInfo.Parent = buttonElement
                viewInfo.BackgroundTransparency = 1
                viewInfo.Position = UDim2.new(1, -28, 0.5, -11.5)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = 'rbxassetid://3926305904'
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)
                Sample.Name = 'Sample'
                Sample.Parent = buttonElement
                Sample.BackgroundTransparency = 1
                Sample.Image = 'http://www.roblox.com/asset/?id=4560909609'
                Sample.ImageColor3 = themeList.SchemeColor
                Sample.ImageTransparency = 0.6
                Sample.ZIndex = 0

                local moreInfo = Instance.new('TextLabel')
                local moreInfoCorner = Instance.new('UICorner')

                moreInfo.Name = 'TipMore'
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(1, 0, 1, 0)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = '  ' .. tipINf
                moreInfo.RichText = true
                moreInfo.TextColor3 = themeList.TextColor
                moreInfo.TextSize = 14
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left
                moreInfoCorner.CornerRadius = UDim.new(0, 4)
                moreInfoCorner.Parent = moreInfo
                touch.Name = 'touch'
                touch.Parent = buttonElement
                touch.BackgroundTransparency = 1
                touch.Position = UDim2.new(0.02, 0, 0.5, -10.5)
                touch.Size = UDim2.new(0, 21, 0, 21)
                touch.Image = 'rbxassetid://3926305904'
                touch.ImageColor3 = themeList.SchemeColor
                touch.ImageRectOffset = Vector2.new(84, 204)
                touch.ImageRectSize = Vector2.new(36, 36)
                btnInfo.Name = 'btnInfo'
                btnInfo.Parent = buttonElement
                btnInfo.BackgroundTransparency = 1
                btnInfo.Position = UDim2.new(0.096, 0, 0, 0)
                btnInfo.Size = UDim2.new(0.8, 0, 1, 0)
                btnInfo.Font = Enum.Font.GothamSemibold
                btnInfo.Text = bname
                btnInfo.RichText = true
                btnInfo.TextColor3 = themeList.TextColor
                btnInfo.TextSize = 14
                btnInfo.TextXAlignment = Enum.TextXAlignment.Left

                local ms = Players.LocalPlayer:GetMouse()
                local focusing = false
                local viewDe = false
                local hovering = false

                buttonElement.MouseButton1Click:Connect(function()
                    if focusing then
                        Utility:TweenObject(moreInfo, {
                            Position = UDim2.new(0, 0, 2, 0),
                        }, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)

                        focusing = false

                        return
                    end

                    pcall(callback)

                    local c = Sample:Clone()

                    c.Parent = buttonElement

                    local x, y = (ms.X - buttonElement.AbsolutePosition.X), (ms.Y - buttonElement.AbsolutePosition.Y)

                    c.Position = UDim2.new(0, x - c.AbsoluteSize.X / 2, 0, y - c.AbsoluteSize.Y / 2)

                    local len, size = 0.35, math.max(buttonElement.AbsoluteSize.X, buttonElement.AbsoluteSize.Y) * 1.5

                    c:TweenSize(UDim2.new(0, size, 0, size), 'Out', 'Quad', len)

                    c.Position = UDim2.fromOffset(x - size / 2, y - size / 2)

                    for i = 1, 10 do
                        c.ImageTransparency = i / 10

                        task.wait(len / 10)
                    end

                    c:Destroy()
                end)
                buttonElement.MouseEnter:Connect(function()
                    if not focusing then
                        hovering = true

                        Utility:TweenObject(buttonElement, {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
                        }, 0.1)
                    end
                end)
                buttonElement.MouseLeave:Connect(function()
                    if not focusing then
                        hovering = false

                        Utility:TweenObject(buttonElement, {
                            BackgroundColor3 = themeList.ElementColor,
                        }, 0.1)
                    end
                end)
                viewInfo.MouseButton1Click:Connect(function()
                    if viewDe then
                        return
                    end

                    viewDe = true
                    focusing = true

                    for _, v in pairs(infoContainer:GetChildren())do
                        if v ~= moreInfo then
                            Utility:TweenObject(v, {
                                Position = UDim2.new(0, 0, 2, 0),
                            }, 0.2)
                        end
                    end

                    Utility:TweenObject(moreInfo, {
                        Position = UDim2.new(0, 0, 0, 0),
                    }, 0.2)
                    Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                    task.wait(1.5)

                    focusing = false

                    Utility:TweenObject(moreInfo, {
                        Position = UDim2.new(0, 0, 2, 0),
                    }, 0.2)
                    Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    task.wait(0.2)

                    viewDe = false
                end)
                task.spawn(function()
                    while buttonElement.Parent do
                        if not hovering then
                            buttonElement.BackgroundColor3 = themeList.ElementColor
                        end

                        viewInfo.ImageColor3 = themeList.SchemeColor
                        Sample.ImageColor3 = themeList.SchemeColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        moreInfo.TextColor3 = themeList.TextColor
                        touch.ImageColor3 = themeList.SchemeColor
                        btnInfo.TextColor3 = themeList.TextColor

                        task.wait()
                    end
                end)

                local ButtonFunction = {}

                ButtonFunction.UpdateButton = function(self, newTitle)
                    btnInfo.Text = newTitle
                end

                return ButtonFunction
            end
            Elements.NewToggle = function(self, tname, nTip, callback)
                tname = tname or 'Toggle'
                nTip = nTip or 'Prints Current Toggle State'
                callback = callback or function() end

                local toggled = false
                local toggleElement = Instance.new('TextButton')
                local UICorner = Instance.new('UICorner')
                local toggleDisabled = Instance.new('ImageLabel')
                local toggleEnabled = Instance.new('ImageLabel')
                local togName = Instance.new('TextLabel')
                local viewInfo = Instance.new('ImageButton')
                local Sample = Instance.new('ImageLabel')

                toggleElement.Name = 'toggleElement'
                toggleElement.Parent = sectionInners
                toggleElement.BackgroundColor3 = themeList.ElementColor
                toggleElement.ClipsDescendants = true
                toggleElement.Size = UDim2.new(1, 0, 0, 33)
                toggleElement.AutoButtonColor = false
                toggleElement.Text = ''
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = toggleElement
                toggleDisabled.Name = 'toggleDisabled'
                toggleDisabled.Parent = toggleElement
                toggleDisabled.BackgroundTransparency = 1
                toggleDisabled.Position = UDim2.new(0.02, 0, 0.5, -10.5)
                toggleDisabled.Size = UDim2.new(0, 21, 0, 21)
                toggleDisabled.Image = 'rbxassetid://3926309567'
                toggleDisabled.ImageColor3 = themeList.SchemeColor
                toggleDisabled.ImageRectOffset = Vector2.new(628, 420)
                toggleDisabled.ImageRectSize = Vector2.new(48, 48)
                toggleEnabled.Name = 'toggleEnabled'
                toggleEnabled.Parent = toggleElement
                toggleEnabled.BackgroundTransparency = 1
                toggleEnabled.Position = UDim2.new(0.02, 0, 0.5, -10.5)
                toggleEnabled.Size = UDim2.new(0, 21, 0, 21)
                toggleEnabled.Image = 'rbxassetid://3926309567'
                toggleEnabled.ImageColor3 = themeList.SchemeColor
                toggleEnabled.ImageRectOffset = Vector2.new(784, 420)
                toggleEnabled.ImageRectSize = Vector2.new(48, 48)
                toggleEnabled.ImageTransparency = 1
                togName.Name = 'togName'
                togName.Parent = toggleElement
                togName.BackgroundTransparency = 1
                togName.Position = UDim2.new(0.096, 0, 0, 0)
                togName.Size = UDim2.new(0.8, 0, 1, 0)
                togName.Font = Enum.Font.GothamSemibold
                togName.Text = tname
                togName.RichText = true
                togName.TextColor3 = themeList.TextColor
                togName.TextSize = 14
                togName.TextXAlignment = Enum.TextXAlignment.Left
                viewInfo.Name = 'viewInfo'
                viewInfo.Parent = toggleElement
                viewInfo.BackgroundTransparency = 1
                viewInfo.Position = UDim2.new(1, -28, 0.5, -11.5)
                viewInfo.Size = UDim2.new(0, 23, 0, 23)
                viewInfo.ZIndex = 2
                viewInfo.Image = 'rbxassetid://3926305904'
                viewInfo.ImageColor3 = themeList.SchemeColor
                viewInfo.ImageRectOffset = Vector2.new(764, 764)
                viewInfo.ImageRectSize = Vector2.new(36, 36)
                Sample.Name = 'Sample'
                Sample.Parent = toggleElement
                Sample.BackgroundTransparency = 1
                Sample.Image = 'http://www.roblox.com/asset/?id=4560909609'
                Sample.ImageColor3 = themeList.SchemeColor
                Sample.ImageTransparency = 0.6
                Sample.ZIndex = 0

                local moreInfo = Instance.new('TextLabel')
                local moreInfoCorner = Instance.new('UICorner')

                moreInfo.Name = 'TipMore'
                moreInfo.Parent = infoContainer
                moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                moreInfo.Position = UDim2.new(0, 0, 2, 0)
                moreInfo.Size = UDim2.new(1, 0, 1, 0)
                moreInfo.ZIndex = 9
                moreInfo.Font = Enum.Font.GothamSemibold
                moreInfo.Text = '  ' .. nTip
                moreInfo.RichText = true
                moreInfo.TextColor3 = themeList.TextColor
                moreInfo.TextSize = 14
                moreInfo.TextXAlignment = Enum.TextXAlignment.Left
                moreInfoCorner.CornerRadius = UDim.new(0, 4)
                moreInfoCorner.Parent = moreInfo

                local ms = Players.LocalPlayer:GetMouse()
                local focusing = false
                local viewDe = false
                local hovering = false

                toggleElement.MouseButton1Click:Connect(function()
                    if focusing then
                        Utility:TweenObject(moreInfo, {
                            Position = UDim2.new(0, 0, 2, 0),
                        }, 0.2)
                        Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)

                        focusing = false

                        return
                    end

                    toggled = not toggled

                    Utility:TweenObject(toggleEnabled, {
                        ImageTransparency = toggled and 0 or 1,
                    }, 0.11)
                    pcall(callback, toggled)

                    local c = Sample:Clone()

                    c.Parent = toggleElement

                    local x, y = (ms.X - toggleElement.AbsolutePosition.X), (ms.Y - toggleElement.AbsolutePosition.Y)

                    c.Position = UDim2.new(0, x - c.AbsoluteSize.X / 2, 0, y - c.AbsoluteSize.Y / 2)

                    local len, size = 0.35, math.max(toggleElement.AbsoluteSize.X, toggleElement.AbsoluteSize.Y) * 1.5

                    c:TweenSize(UDim2.new(0, size, 0, size), 'Out', 'Quad', len)

                    c.Position = UDim2.fromOffset(x - size / 2, y - size / 2)

                    for i = 1, 10 do
                        c.ImageTransparency = i / 10

                        task.wait(len / 10)
                    end

                    c:Destroy()
                end)
                toggleElement.MouseEnter:Connect(function()
                    if not focusing then
                        hovering = true

                        Utility:TweenObject(toggleElement, {
                            BackgroundColor3 = Color3.fromRGB(themeList.ElementColor.r * 255 + 8, themeList.ElementColor.g * 255 + 9, themeList.ElementColor.b * 255 + 10),
                        }, 0.1)
                    end
                end)
                toggleElement.MouseLeave:Connect(function()
                    if not focusing then
                        hovering = false

                        Utility:TweenObject(toggleElement, {
                            BackgroundColor3 = themeList.ElementColor,
                        }, 0.1)
                    end
                end)
                viewInfo.MouseButton1Click:Connect(function()
                    if viewDe then
                        return
                    end

                    viewDe = true
                    focusing = true

                    for _, v in pairs(infoContainer:GetChildren())do
                        if v ~= moreInfo then
                            Utility:TweenObject(v, {
                                Position = UDim2.new(0, 0, 2, 0),
                            }, 0.2)
                        end
                    end

                    Utility:TweenObject(moreInfo, {
                        Position = UDim2.new(0, 0, 0, 0),
                    }, 0.2)
                    Utility:TweenObject(blurFrame, {BackgroundTransparency = 0.5}, 0.2)
                    task.wait(1.5)

                    focusing = false

                    Utility:TweenObject(moreInfo, {
                        Position = UDim2.new(0, 0, 2, 0),
                    }, 0.2)
                    Utility:TweenObject(blurFrame, {BackgroundTransparency = 1}, 0.2)
                    task.wait(0.2)

                    viewDe = false
                end)
                task.spawn(function()
                    while toggleElement.Parent do
                        if not hovering then
                            toggleElement.BackgroundColor3 = themeList.ElementColor
                        end

                        toggleDisabled.ImageColor3 = themeList.SchemeColor
                        toggleEnabled.ImageColor3 = themeList.SchemeColor
                        togName.TextColor3 = themeList.TextColor
                        viewInfo.ImageColor3 = themeList.SchemeColor
                        Sample.ImageColor3 = themeList.SchemeColor
                        moreInfo.BackgroundColor3 = Color3.fromRGB(themeList.SchemeColor.r * 255 - 14, themeList.SchemeColor.g * 255 - 17, themeList.SchemeColor.b * 255 - 13)
                        moreInfo.TextColor3 = themeList.TextColor

                        task.wait()
                    end
                end)

                local TogFunction = {}

                TogFunction.UpdateToggle = function(self, newText, isTogOn)
                    if newText then
                        togName.Text = newText
                    end
                    if isTogOn ~= nil and toggled ~= isTogOn then
                        toggled = isTogOn

                        Utility:TweenObject(toggleEnabled, {
                            ImageTransparency = toggled and 0 or 1,
                        }, 0.11)
                        pcall(callback, toggled)
                    end
                end

                return TogFunction
            end

            return Elements
        end

        return Sections
    end

    return Tabs
end

return Kavo
