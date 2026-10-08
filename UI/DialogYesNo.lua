local PL = PugaLib


PL.UI.DialogYesNoDefaults = {
    Title = "",
    Message = "",

    TextYes = "Yes",
    TextNo = "No",

    Width = 300,
    Height = 150,

    MemoWidth = 250,
    MemoHeight = 65,

    ButtonWidth = 100,
    ButtonHeight = 24,
}


--
-- Creates a Yes/No dialog.
--
function PL.UI:NewDialogYesNo(Options)
    Options = Options or {}


    local Defaults =
        self.DialogYesNoDefaults


    --
    -- Window
    --
    local Window = self:NewWindow({
        Title = Options.Title 
                or Defaults.Title,

        Width =
            Options.Width
            or Defaults.Width,

        Height =
            Options.Height
            or Defaults.Height,

        Transparent = true,
        Closable = false,
        Movable = false,
    })


--
-- Message
--
local Message = self:NewMemo(Window, {
    X = nil,
    Y = 30,

    Width =
        Options.MemoWidth
        or Defaults.MemoWidth,

    Height =
        Options.MemoHeight
        or Defaults.MemoHeight,

    MaxLength = 0,
})


Message.Edit:SetText(
    Options.Message
    or Defaults.Message
)


--
-- Message is read-only.
--
Message.Edit:SetEnabled(false)


    --
    -- Yes
    --
    local ButtonYes =
        self:NewButton(Window, {
            Text =
                Options.TextYes
                or Defaults.TextYes,

            X = 35,
            Y = 105,

            Width =
                Defaults.ButtonWidth,

            Height =
                Defaults.ButtonHeight,
        })


    --
    -- No
    --
    local ButtonNo =
        self:NewButton(Window, {
            Text =
                Options.TextNo
                or Defaults.TextNo,

            X = 165,
            Y = 105,

            Width =
                Defaults.ButtonWidth,

            Height =
                Defaults.ButtonHeight,
        })


    --
    -- Yes callback.
    --
    ButtonYes:SetScript(
        "OnClick",
        function()
            Window:Hide()

            if Options.OnYes then
                Options.OnYes()
            end
        end
    )


    --
    -- No callback.
    --
    ButtonNo:SetScript(
        "OnClick",
        function()
            Window:Hide()

            if Options.OnNo then
                Options.OnNo()
            end
        end
    )


    return Window
end