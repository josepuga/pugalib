local PL = PugaLib
local C = PL.Constants.UI
local GetOption = PL.UI.Widget.GetOption


--
-- Default options for labels.
--
PL.UI.LabelDefaults = {
    Text = "",

    X = nil,
    Y = nil,

    Width = nil,
    Height = nil,

    FontSize = nil,

    Font = C.FONT_NORMAL,

    Visible = true,
}



--
-- Creates a new label.
--
function PL.UI:NewLabel(Parent, Options)
    Options = Options or {}

    local Defaults = self.LabelDefaults

    local Text =
        GetOption(Options.Text, Defaults.Text)

    local X =
        GetOption(Options.X, Defaults.X)

    local Y =
        GetOption(Options.Y, Defaults.Y)

    local Width =
        GetOption(Options.Width, Defaults.Width)

    local Height =
        GetOption(Options.Height, Defaults.Height)

    local Font =
        GetOption(Options.Font, Defaults.Font)

    local Visible =
        GetOption(Options.Visible, Defaults.Visible)

    local FontSize =
        GetOption(Options.FontSize, Defaults.FontSize)

    local Label = Parent:CreateFontString(
        nil,
        "OVERLAY",
        Font
    )


    PL.UI.Widget:SetPosition(
        Label,
        Parent,
        X,
        Y
    )


    if Width ~= nil and Height ~= nil then
        Label:SetSize(
            Width,
            Height
        )
    end


    Label:SetText(Text)

    if FontSize ~= nil then
        local Font, _, Flags =
            Label:GetFont()

        Label:SetFont(
            Font,
            FontSize,
            Flags
        )
    end

    if Visible then
        Label:Show()
    else
        Label:Hide()
    end


    return Label
end
