
local PL = PugaLib
local GetOption = PL.UI.Widget.GetOption


--
-- Default options for checkboxes.
--
PL.UI.CheckBoxDefaults = {
    Text = "",
    Checked = false,

    X = nil,
    Y = nil,

    Visible = true,
}


--
-- Creates a checkbox.
--
function PL.UI:NewCheckBox(Parent, Options)
    Options = Options or {}

    local Defaults = self.CheckBoxDefaults

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
    -- Create checkbox.
    --
    local CheckBox = CreateFrame(
        "CheckButton",
        nil,
        Parent,
        "UICheckButtonTemplate"
    )


    PL.UI.Widget:SetPosition(
        CheckBox,
        Parent,
        X,
        Y
    )


    --
    -- Create checkbox label.
    --
    local Label = CheckBox:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontNormal"
    )

    Label:SetPoint(
        "LEFT",
        CheckBox,
        "RIGHT",
        4,
        0
    )

    CheckBox.Label = Label


    --
    -- Returns the checkbox text.
    --
    function CheckBox:GetText()
        return self.Label:GetText()
    end


    --
    -- Sets the checkbox text.
    --
    function CheckBox:SetText(Text)
        self.Label:SetText(
            Text or ""
        )
    end


    --
    -- Initial values.
    --
    CheckBox:SetText(
        Text
    )

    CheckBox:SetChecked(
        Checked
    )


    if Visible then
        CheckBox:Show()
    else
        CheckBox:Hide()
    end


    return CheckBox
end
