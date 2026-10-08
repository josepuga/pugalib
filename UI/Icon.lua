local PL = PugaLib
local GetOption = PL.UI.Widget.GetOption


--
-- Default options for icons.
--
PL.UI.IconDefaults = {
    TextureID = nil,

    X = nil,
    Y = nil,

    Width = 32,
    Height = 32,

    Visible = true,
}


--
-- Creates an icon using a WoW texture ID.
--
function PL.UI:NewIcon(Parent, Options)
    Options = Options or {}

    local Defaults = self.IconDefaults

    local TextureID =
        GetOption(
            Options.TextureID,
            Defaults.TextureID
        )

    local X =
        GetOption(
            Options.X,
            Defaults.X
        )

    local Y =
        GetOption(
            Options.Y,
            Defaults.Y
        )

    local Width =
        GetOption(
            Options.Width,
            Defaults.Width
        )

    local Height =
        GetOption(
            Options.Height,
            Defaults.Height
        )

    local Visible =
        GetOption(
            Options.Visible,
            Defaults.Visible
        )


    local Icon = Parent:CreateTexture(
        nil,
        "ARTWORK"
    )

    Icon:SetSize(
        Width,
        Height
    )

    PL.UI.Widget:SetPosition(
        Icon,
        Parent,
        X,
        Y
    )


    if TextureID ~= nil then
        Icon:SetTexture(TextureID)
    end


    if Visible then
        Icon:Show()
    else
        Icon:Hide()
    end


    return Icon
end