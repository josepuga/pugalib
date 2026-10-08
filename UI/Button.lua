local PL = PugaLib
local GetOption = PL.UI.Widget.GetOption


--
-- Default options for buttons.
--
PL.UI.ButtonDefaults = {
    Text = "",

    X = nil,
    Y = nil,

    Width = 100,
    Height = 24,

    Visible = true,
}


--
-- Creates a button.
--
function PL.UI:NewButton(Parent, Options)
    Options = Options or {}

    local Defaults = self.ButtonDefaults

    local Text =
        GetOption(
            Options.Text,
            Defaults.Text
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


    --
    -- Create button.
    --
    local Button = CreateFrame(
        "Button",
        nil,
        Parent,
        "UIPanelButtonTemplate"
    )

    Button:SetSize(
        Width,
        Height
    )

    PL.UI.Widget:SetPosition(
        Button,
        Parent,
        X,
        Y
    )


    --
    -- Initial values.
    --
    Button:SetText(
        Text
    )


    if Visible then
        Button:Show()
    else
        Button:Hide()
    end


    return Button
end