local PL = PugaLib
local C = PL.Constants.UI
local GetOption = PL.UI.Widget.GetOption


--
-- Default options for edit controls.
--
PL.UI.EditDefaults = {
    Text = "",

    X = 0,
    Y = 0,

    Width = 200,
    Height = 30,

    MaxLength = nil,

    Visible = true,
}


--
-- Creates a new edit control.
--
function PL.UI:NewEdit(Parent, Options)
    Options = Options or {}

    local Defaults = self.EditDefaults

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

    local MaxLength =
        GetOption(Options.MaxLength, Defaults.MaxLength)

    local Visible =
        GetOption(Options.Visible, Defaults.Visible)


    local Edit = CreateFrame(
        "EditBox",
        nil,
        Parent,
        "InputBoxTemplate"
    )

    Edit:SetSize(
        Width,
        Height
    )

    PL.UI.Widget:SetPosition(
        Edit,
        Parent,
        X,
        Y
    )

    Edit:SetAutoFocus(false)

    if MaxLength ~= nil then
        Edit:SetMaxLetters(MaxLength)
    end

    Edit:SetText(Text)

    if Visible then
        Edit:Show()
    else
        Edit:Hide()
    end

    return Edit
end