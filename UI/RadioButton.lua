local PL = PugaLib
local GetOption = PL.UI.Widget.GetOption


--
-- Default options for radio buttons.
--
PL.UI.RadioButtonDefaults = {
    Text = "",
    Checked = false,

    X = nil,
    Y = nil,

    Visible = true,
}


--
-- Creates a radio button.
--
function PL.UI:NewRadioButton(Parent, Options)
    Options = Options or {}

    local Defaults = self.RadioButtonDefaults

    local Text =
        GetOption(
            Options.Text,
            Defaults.Text
        )

    local Checked =
        GetOption(
            Options.Checked,
            Defaults.Checked
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

    local Visible =
        GetOption(
            Options.Visible,
            Defaults.Visible
        )


    --
    -- Create radio button.
    --
    local RadioButton = CreateFrame(
        "CheckButton",
        nil,
        Parent,
        "UIRadioButtonTemplate"
    )


    PL.UI.Widget:SetPosition(
        RadioButton,
        Parent,
        X,
        Y
    )


    --
    -- Create radio button label.
    --
    local Label = RadioButton:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontNormal"
    )

    Label:SetPoint(
        "LEFT",
        RadioButton,
        "RIGHT",
        4,
        0
    )

    RadioButton.Label = Label


    --
    -- Returns the radio button text.
    --
    function RadioButton:GetText()
        return self.Label:GetText()
    end


    --
    -- Sets the radio button text.
    --
    function RadioButton:SetText(Text)
        self.Label:SetText(
            Text or ""
        )
    end


    --
    -- Initial values.
    --
    RadioButton:SetText(
        Text
    )

    RadioButton:SetChecked(
        Checked
    )


    if Visible then
        RadioButton:Show()
    else
        RadioButton:Hide()
    end


    return RadioButton
end