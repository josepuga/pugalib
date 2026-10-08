local PL = PugaLib
local GetOption = PL.UI.Widget.GetOption


--
-- Default options for images.
--
PL.UI.ImageDefaults = {
    Texture = nil,

    X = nil,
    Y = nil,

    Width = 32,
    Height = 32,

    Visible = true,
}


--
-- Creates an image using an external texture.
--
function PL.UI:NewImage(Parent, Options)
    Options = Options or {}

    local Defaults = self.ImageDefaults

    local Texture =
        GetOption(
            Options.Texture,
            Defaults.Texture
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


    local Image = Parent:CreateTexture(
        nil,
        "ARTWORK"
    )

    Image:SetSize(
        Width,
        Height
    )

    PL.UI.Widget:SetPosition(
        Image,
        Parent,
        X,
        Y
    )


    if Texture ~= nil then
        Image:SetTexture(Texture)
    end


    if Visible then
        Image:Show()
    else
        Image:Hide()
    end


    return Image
end