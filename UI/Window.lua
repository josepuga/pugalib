local PL = PugaLib
local C = PL.Constants.UI
local GetOption = PL.UI.Widget.GetOption


--
-- Default options for windows.
--
PL.UI.WindowDefaults = {
    Name = nil,
    Title = nil,

    Width = 400,
    Height = 300,

    X = nil,
    Y = nil,

    Closable = false,
    Movable = false,
    Resizable = false,

    Transparent = false,
    Visible = true,
}


--
-- Creates a new window.
--
function PL.UI:NewWindow(Options)
    Options = Options or {}

    local Defaults = self.WindowDefaults

    local Name =
        GetOption(Options.Name, Defaults.Name)

    local Title =
        GetOption(Options.Title, Defaults.Title)

    local Width =
        GetOption(Options.Width, Defaults.Width)

    local Height =
        GetOption(Options.Height, Defaults.Height)

    local X =
        GetOption(Options.X, Defaults.X)

    local Y =
        GetOption(Options.Y, Defaults.Y)

    local Closable =
        GetOption(Options.Closable, Defaults.Closable)

    local Movable =
        GetOption(Options.Movable, Defaults.Movable)

    local Resizable =
        GetOption(Options.Resizable, Defaults.Resizable)

    local Transparent =
        GetOption(Options.Transparent, Defaults.Transparent)

    local Visible =
        GetOption(Options.Visible, Defaults.Visible)


    --
    -- Main frame.
    --
    local Window = CreateFrame(
        "Frame",
        Name,
        UIParent,
        C.BACKDROP_TEMPLATE
    )

    Window:SetSize(Width, Height)

    Window:SetSize(Width, Height)

    if X == nil or Y == nil then
        PL.UI.Widget:Center(
            Window,
            UIParent
        )
    else
        PL.UI.Widget:SetPosition(
            Window,
            UIParent,
            X,
            Y
        )
    end


    --
    -- Standard WoW background.
    --
local Background

if Transparent then
    Background = C.DIALOG_BACKGROUND
else
    -- TODO: Find a suitable opaque/native WoW window style.
    Background = C.DIALOG_BACKGROUND_DARK
end

Window:SetBackdrop({
    bgFile = Background,
    edgeFile = C.DIALOG_BORDER,

    tile = true,
    tileSize = 32,
    edgeSize = 32,

    insets = {
        left = 11,
        right = 12,
        top = 12,
        bottom = 11,
    },
})


    --
    -- Optional title.
    --
    if Title ~= nil then
        local TitleText = Window:CreateFontString(
            nil,
            "OVERLAY",
            "GameFontNormalLarge"
        )

        TitleText:SetPoint(
            "TOP",
            Window,
            "TOP",
            0,
            -10
        )

        TitleText:SetText(Title)
        Window.Title = TitleText
    end


    --
    -- Optional close button.
    --
    if Closable then
        local CloseButton = CreateFrame(
            "Button",
            nil,
            Window,
            C.CLOSE_BUTTON_TEMPLATE
        )

        CloseButton:SetPoint(
            "TOPRIGHT",
            Window,
            "TOPRIGHT",
            -5,
            -5
        )

        CloseButton:SetScript(
            "OnClick",
            function()
                Window:Hide()
            end
        )

        Window.CloseButton = CloseButton
    end


    --
    -- Optional window dragging.
    --
    if Movable then
        Window:SetMovable(true)
        Window:EnableMouse(true)
        Window:RegisterForDrag("LeftButton")

        Window:SetScript(
            "OnDragStart",
            function(Self)
                Self:StartMoving()
            end
        )

        Window:SetScript(
            "OnDragStop",
            function(Self)
                Self:StopMovingOrSizing()
            end
        )
    end


    --
    -- Optional resizing.
    --
    Window:SetResizable(Resizable)


    --
    -- Initial visibility.
    --
    if Visible then
        Window:Show()
    else
        Window:Hide()
    end


    return Window
end