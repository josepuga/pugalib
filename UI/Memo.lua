local PL = PugaLib
local C = PL.Constants.UI
local GetOption = PL.UI.Widget.GetOption

--
-- Default options for memo controls.
--
PL.UI.MemoDefaults = {
    Text = "",

    X = nil,
    Y = nil,

    Width = 300,
    Height = 100,

    MaxLength = nil,

    Visible = true,
}


--
-- Creates a new multiline text control.
--
function PL.UI:NewMemo(Parent, Options)
    Options = Options or {}

    local Defaults = self.MemoDefaults

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
        GetOption(
            Options.MaxLength,
            Defaults.MaxLength
        )

    local Visible =
        GetOption(
            Options.Visible,
            Defaults.Visible
        )


    --
    -- Memo container.
    --
    local Memo = CreateFrame(
        "Frame",
        nil,
        Parent,
        C.BACKDROP_TEMPLATE
    )

    Memo:SetSize(
        Width,
        Height
    )

    PL.UI.Widget:SetPosition(
        Memo,
        Parent,
        X,
        Y
    )


    --
    -- Background and border.
    --
    Memo:SetBackdrop({
        bgFile =
            "Interface\\Buttons\\WHITE8X8",

        edgeFile =
            "Interface\\Tooltips\\UI-Tooltip-Border",

        tile = true,
        tileSize = 16,
        edgeSize = 16,

        insets = {
            left = 4,
            right = 4,
            top = 4,
            bottom = 4,
        },
    })

    Memo:SetBackdropColor(
        0,
        0,
        0,
        0.5
    )


    --
    -- Multiline EditBox.
    --
    local Edit = CreateFrame(
        "EditBox",
        nil,
        Memo
    )

    Edit:SetPoint(
        "TOPLEFT",
        Memo,
        "TOPLEFT",
        8,
        -8
    )

    Edit:SetPoint(
        "BOTTOMRIGHT",
        Memo,
        "BOTTOMRIGHT",
        -8,
        8
    )

    Edit:SetMultiLine(true)
    Edit:SetAutoFocus(false)

    Edit:SetFontObject(
        C.FONT_NORMAL
    )

    Edit:SetTextInsets(
        0,
        0,
        0,
        0
    )

    if MaxLength ~= nil then
        Edit:SetMaxLetters(MaxLength)
    end

    Edit:SetText(Text)


    --
    -- Escape releases keyboard focus.
    --
    Edit:SetScript(
        "OnEscapePressed",
        function(Self)
            Self:ClearFocus()
        end
    )


    --
    -- Keep the internal EditBox accessible.
    --
    Memo.Edit = Edit
    
    --
    -- Returns memo text.
    --
    function Memo:GetText()
        return self.Edit:GetText()
    end    


    --
    -- Initial visibility.
    --
    if Visible then
        Memo:Show()
    else
        Memo:Hide()
    end


    return Memo
end