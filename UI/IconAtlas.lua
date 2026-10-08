local PL = PugaLib
local GetOption = PL.UI.Widget.GetOption


--
-- AtlasInfo describes a region inside a texture atlas.
--
-- {
--     Texture = string,
--     Left = number,
--     Right = number,
--     Top = number,
--     Bottom = number,
-- }
--


--
-- Default options for atlas icons.
--
PL.UI.IconAtlasDefaults = {
    AtlasInfo = nil,

    X = nil,
    Y = nil,

    Width = 32,
    Height = 32,

    Visible = true,
}


--
-- Creates an icon from a region inside a texture atlas.
--
function PL.UI:NewIconAtlas(Parent, Options)
    Options = Options or {}

    local Defaults = self.IconAtlasDefaults

    local AtlasInfo =
        GetOption(
            Options.AtlasInfo,
            Defaults.AtlasInfo
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


    if AtlasInfo ~= nil then
        Icon:SetTexture(
            AtlasInfo.Texture
        )

        Icon:SetTexCoord(
            AtlasInfo.Left,
            AtlasInfo.Right,
            AtlasInfo.Top,
            AtlasInfo.Bottom
        )
    end


    if Visible then
        Icon:Show()
    else
        Icon:Hide()
    end


    return Icon
end