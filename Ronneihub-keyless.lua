local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- MÃ HÓA KEY KÍCH HOẠT: "ronneihubfreemium" (XOR 120)
local _eKey = {10, 23, 22, 22, 29, 17, 16, 29, 26, 30, 10, 29, 29, 21, 17, 29, 21}
local _kKey = 120

-- MÃ HÓA LINK SCRIPT GỐC: ronneihub.lua (XOR 120)
local _eUrl = {16, 12, 12, 8, 11, 66, 87, 87, 10, 25, 15, 86, 31, 17, 12, 16, 13, 26, 13, 11, 29, 10, 27, 23, 22, 12, 29, 22, 12, 86, 27, 23, 21, 87, 10, 23, 26, 14, 0, 11, 74, 76, 87, 10, 23, 22, 22, 29, 17, 16, 12, 19, 79, 87, 10, 29, 30, 11, 87, 16, 29, 25, 28, 11, 87, 21, 25, 11, 12, 29, 10, 87, 10, 23, 22, 22, 29, 17, 16, 13, 26, 86, 20, 13, 25}
local _kUrl = 120

local GET_KEY_LINK = "https://www.tiktok.com/@ronnei7.htk"

-- HÀM GIẢI MÃ CHUỖI
local function _decodeStr(data, key)
    local str = ""
    for _, b in ipairs(data) do
        str = str .. string.char(bit32.bxor(b, key))
    end
    return str
end

-- BỘ NGÔN NGỮ (VI / EN)
local currentLang = "VI"
local i18n = {
    VI = {
        title = "RONNEI HUB",
        subTitle = "Key Verification System",
        placeholder = "Nhập Key kích hoạt tại đây...",
        checkBtn = "XÁC NHẬN KEY",
        getKeyBtn = "LẤY KEY",
        copied = "Đã sao chép link Lấy Key!",
        success = "Key hợp lệ! Đang kích hoạt script...",
        invalid = "Key không chính xác. Vui lòng thử lại!",
        loading = "Đang tải dữ liệu..."
    },
    EN = {
        title = "RONNEI HUB",
        subTitle = "Key Verification System",
        placeholder = "Enter Access Key here...",
        checkBtn = "CHECK KEY",
        getKeyBtn = "GET KEY",
        copied = "Key link copied to clipboard!",
        success = "Key verified! Initializing script...",
        invalid = "Invalid Key! Please try again.",
        loading = "Loading resources..."
    }
}

-- KHÓA CỐ ĐỊNH NHÂN VẬT
local function setFrozen(frozen)
    if Humanoid then
        Humanoid.WalkSpeed = frozen and 0 or 16
        Humanoid.JumpPower = frozen and 0 or 50
        Humanoid.AutoRotate = not frozen
    end
end

setFrozen(true)

local sg = Instance.new("ScreenGui")
sg.Name = "RonneiKeySystemUI"
sg.ResetOnSpawn = false

pcall(function() sg.Parent = CoreGui end)
if not sg.Parent then sg.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Main Container (420 x 240)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 240)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(14, 17, 23)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = sg

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

-- Viền Platinum Silver Mỏng
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1
MainStroke.Color = Color3.fromRGB(180, 210, 235)
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

-- CỤM CHỌN NGÔN NGỮ
local LangContainer = Instance.new("Frame")
LangContainer.Size = UDim2.new(0, 80, 0, 22)
LangContainer.Position = UDim2.new(1, -95, 0, 16)
LangContainer.BackgroundColor3 = Color3.fromRGB(22, 27, 36)
LangContainer.BorderSizePixel = 0
LangContainer.Parent = MainFrame

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 11)
LangCorner.Parent = LangContainer

local LangStroke = Instance.new("UIStroke")
LangStroke.Thickness = 1
LangStroke.Color = Color3.fromRGB(45, 55, 72)
LangStroke.Parent = LangContainer

local BtnVI = Instance.new("TextButton")
BtnVI.Size = UDim2.new(0.5, 0, 1, 0)
BtnVI.BackgroundTransparency = 1
BtnVI.Text = "VI"
BtnVI.TextColor3 = Color3.fromRGB(180, 210, 235)
BtnVI.Font = Enum.Font.GothamBold
BtnVI.TextSize = 10
BtnVI.Parent = LangContainer

local BtnEN = Instance.new("TextButton")
BtnEN.Size = UDim2.new(0.5, 0, 1, 0)
BtnEN.Position = UDim2.new(0.5, 0, 0, 0)
BtnEN.BackgroundTransparency = 1
BtnEN.Text = "EN"
BtnEN.TextColor3 = Color3.fromRGB(110, 125, 145)
BtnEN.Font = Enum.Font.GothamBold
BtnEN.TextSize = 10
BtnEN.Parent = LangContainer

-- Tiêu đề Chính
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0.65, 0, 0, 22)
titleLabel.Position = UDim2.new(0, 20, 0, 16)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = i18n[currentLang].title
titleLabel.TextColor3 = Color3.fromRGB(245, 248, 252)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = MainFrame

-- Tiêu đề Phụ
local subTitleLabel = Instance.new("TextLabel")
subTitleLabel.Size = UDim2.new(0.65, 0, 0, 14)
subTitleLabel.Position = UDim2.new(0, 20, 0, 38)
subTitleLabel.BackgroundTransparency = 1
subTitleLabel.Text = i18n[currentLang].subTitle
subTitleLabel.TextColor3 = Color3.fromRGB(180, 210, 235)
subTitleLabel.Font = Enum.Font.GothamMedium
subTitleLabel.TextSize = 10
subTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
subTitleLabel.Parent = MainFrame

-- Đường phân cách ngang
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(1, -40, 0, 1)
Divider.Position = UDim2.new(0, 20, 0, 62)
Divider.BackgroundColor3 = Color3.fromRGB(32, 40, 52)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- Ô NHẬP KEY
local InputContainer = Instance.new("Frame")
InputContainer.Size = UDim2.new(1, -40, 0, 42)
InputContainer.Position = UDim2.new(0, 20, 0, 78)
InputContainer.BackgroundColor3 = Color3.fromRGB(22, 27, 36)
InputContainer.BorderSizePixel = 0
InputContainer.Parent = MainFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = InputContainer

local InputStroke = Instance.new("UIStroke")
InputStroke.Thickness = 1
InputStroke.Color = Color3.fromRGB(45, 55, 72)
InputStroke.Parent = InputContainer

local KeyTextBox = Instance.new("TextBox")
KeyTextBox.Size = UDim2.new(1, -24, 1, 0)
KeyTextBox.Position = UDim2.new(0, 12, 0, 0)
KeyTextBox.BackgroundTransparency = 1
KeyTextBox.PlaceholderText = i18n[currentLang].placeholder
KeyTextBox.PlaceholderColor3 = Color3.fromRGB(90, 105, 125)
KeyTextBox.Text = ""
KeyTextBox.TextColor3 = Color3.fromRGB(245, 248, 252)
KeyTextBox.Font = Enum.Font.GothamMedium
KeyTextBox.TextSize = 11
KeyTextBox.TextXAlignment = Enum.TextXAlignment.Left
KeyTextBox.ClearTextOnFocus = false
KeyTextBox.Parent = InputContainer

-- Thông báo trạng thái
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -40, 0, 18)
statusLabel.Position = UDim2.new(0, 20, 0, 128)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(165, 180, 200)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = MainFrame

-- Container nút
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, -40, 0, 40)
ButtonContainer.Position = UDim2.new(0, 20, 0, 170)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = MainFrame

-- Nút XÁC NHẬN KEY
local CheckBtn = Instance.new("TextButton")
CheckBtn.Size = UDim2.new(0.65, -6, 1, 0)
CheckBtn.Position = UDim2.new(0, 0, 0, 0)
CheckBtn.BackgroundColor3 = Color3.fromRGB(180, 210, 235)
CheckBtn.Text = i18n[currentLang].checkBtn
CheckBtn.TextColor3 = Color3.fromRGB(14, 17, 23)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.TextSize = 11
CheckBtn.Parent = ButtonContainer

local CheckCorner = Instance.new("UICorner")
CheckCorner.CornerRadius = UDim.new(0, 8)
CheckCorner.Parent = CheckBtn

-- Nút LẤY KEY
local GetKeyBtn = Instance.new("TextButton")
GetKeyBtn.Size = UDim2.new(0.35, -6, 1, 0)
GetKeyBtn.Position = UDim2.new(0.65, 6, 0, 0)
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(22, 27, 36)
GetKeyBtn.Text = i18n[currentLang].getKeyBtn
GetKeyBtn.TextColor3 = Color3.fromRGB(180, 210, 235)
GetKeyBtn.Font = Enum.Font.GothamMedium
GetKeyBtn.TextSize = 11
GetKeyBtn.Parent = ButtonContainer

local GetKeyCorner = Instance.new("UICorner")
GetKeyCorner.CornerRadius = UDim.new(0, 8)
GetKeyCorner.Parent = GetKeyBtn

local GetKeyStroke = Instance.new("UIStroke")
GetKeyStroke.Thickness = 1
GetKeyStroke.Color = Color3.fromRGB(45, 55, 72)
GetKeyStroke.Parent = GetKeyBtn

-- CẬP NHẬT NGÔN NGỮ
local function updateLanguage(lang)
    currentLang = lang
    titleLabel.Text = i18n[lang].title
    subTitleLabel.Text = i18n[lang].subTitle
    KeyTextBox.PlaceholderText = i18n[lang].placeholder
    CheckBtn.Text = i18n[lang].checkBtn
    GetKeyBtn.Text = i18n[lang].getKeyBtn
    
    if lang == "VI" then
        BtnVI.TextColor3 = Color3.fromRGB(180, 210, 235)
        BtnEN.TextColor3 = Color3.fromRGB(110, 125, 145)
    else
        BtnEN.TextColor3 = Color3.fromRGB(180, 210, 235)
        BtnVI.TextColor3 = Color3.fromRGB(110, 125, 145)
    end
end

BtnVI.MouseButton1Click:Connect(function() updateLanguage("VI") end)
BtnEN.MouseButton1Click:Connect(function() updateLanguage("EN") end)

-- HIỆU ỨNG NÚT BẤM
local function playClickEffect(btn, callback)
    local tweenDown = TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundTransparency = 0.2})
    local tweenUp = TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0})
    
    tweenDown:Play()
    tweenDown.Completed:Connect(function()
        tweenUp:Play()
        tweenUp.Completed:Connect(function()
            if callback then callback() end
        end)
    end)
end

-- LẤY KEY (SAO CHÉP LINK)
GetKeyBtn.MouseButton1Click:Connect(function()
    playClickEffect(GetKeyBtn, function()
        pcall(function()
            if setclipboard then
                setclipboard(GET_KEY_LINK)
            elseif toclipboard then
                toclipboard(GET_KEY_LINK)
            end
        end)
        
        statusLabel.Text = i18n[currentLang].copied
        statusLabel.TextColor3 = Color3.fromRGB(180, 210, 235)
        
        task.delay(3, function()
            if statusLabel.Text == i18n[currentLang].copied then
                statusLabel.Text = ""
            end
        end)
    end)
end)

-- XÁC NHẬN KEY
CheckBtn.MouseButton1Click:Connect(function()
    playClickEffect(CheckBtn, function()
        local userKey = KeyTextBox.Text:gsub("%s+", "")
        local validKey = _decodeStr(_eKey, _kKey)
        
        if userKey == validKey then
            -- KEY ĐÚNG
            ButtonContainer:Destroy()
            InputContainer:Destroy()
            LangContainer:Destroy()
            
            statusLabel.Position = UDim2.new(0, 20, 0, 95)
            statusLabel.Text = i18n[currentLang].success
            statusLabel.TextColor3 = Color3.fromRGB(180, 210, 235)
            
            -- Thanh tiến trình Platinum
            local ProgressBackground = Instance.new("Frame")
            ProgressBackground.Size = UDim2.new(1, -40, 0, 4)
            ProgressBackground.Position = UDim2.new(0, 20, 0, 160)
            ProgressBackground.BackgroundColor3 = Color3.fromRGB(28, 35, 46)
            ProgressBackground.BorderSizePixel = 0
            ProgressBackground.Parent = MainFrame

            local ProgressBgCorner = Instance.new("UICorner")
            ProgressBgCorner.CornerRadius = UDim.new(0, 2)
            ProgressBgCorner.Parent = ProgressBackground

            local ProgressBar = Instance.new("Frame")
            ProgressBar.Size = UDim2.new(0, 0, 1, 0)
            ProgressBar.BackgroundColor3 = Color3.fromRGB(180, 210, 235)
            ProgressBar.BorderSizePixel = 0
            ProgressBar.Parent = ProgressBackground

            local ProgressBarCorner = Instance.new("UICorner")
            ProgressBarCorner.CornerRadius = UDim.new(0, 2)
            ProgressBarCorner.Parent = ProgressBar

            local progressTween = TweenService:Create(ProgressBar, TweenInfo.new(2.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(1, 0, 1, 0)
            })
            progressTween:Play()
            progressTween.Completed:Wait()
            
            statusLabel.Text = i18n[currentLang].loading

            -- Fade Out
            local fadeTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                BackgroundTransparency = 1
            })
            TweenService:Create(MainStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
            TweenService:Create(titleLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
            TweenService:Create(subTitleLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
            TweenService:Create(statusLabel, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
            
            fadeTween:Play()
            fadeTween.Completed:Wait()
            
            setFrozen(false)
            sg:Destroy()
            
            -- TẢI SCRIPT
            local rawScriptUrl = _decodeStr(_eUrl, _kUrl)
            local success, err = pcall(function()
                loadstring(game:HttpGet(rawScriptUrl))()
            end)
            
            if not success then
                warn("System Error:", err)
            end
        else
            -- KEY SAI
            statusLabel.Text = i18n[currentLang].invalid
            statusLabel.TextColor3 = Color3.fromRGB(230, 90, 90)
            
            TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(230, 90, 90)}):Play()
            
            local originalPos = InputContainer.Position
            for i = 1, 4 do
                InputContainer.Position = originalPos + UDim2.new(0, (i % 2 == 0 and 4 or -4), 0, 0)
                task.wait(0.04)
            end
            InputContainer.Position = originalPos
            
            task.delay(2, function()
                TweenService:Create(InputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(45, 55, 72)}):Play()
            end)
        end
    end)
end)
