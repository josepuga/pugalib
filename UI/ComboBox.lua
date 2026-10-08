local PL = PugaLib
local GetOption = PL.UI.Widget.GetOption


--
-- Default options for combo boxes.
--
PL.UI.ComboBoxDefaults = {
    Items = {},
    Selected = 1,

    X = nil,
    Y = nil,

    Width = 150,
    Height = 24,

    Visible = true,
}


--
-- Creates a combo box.
--
function PL.UI:NewComboBox(Parent, Options)
    Options = Options or {}

    local Defaults = self.ComboBoxDefaults

    local Items =
        GetOption(
            Options.Items,
            Defaults.Items
        )

    local Selected =
        GetOption(
            Options.Selected,
            Defaults.Selected
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
    -- Create the dropdown.
    --
    local ComboBox = CreateFrame(
        "DropdownButton",
        nil,
        Parent,
        "WowStyle1DropdownTemplate"
    )

    ComboBox:SetSize(
        Width,
        Height
    )

    PL.UI.Widget:SetPosition(
        ComboBox,
        Parent,
        X,
        Y
    )


    --
    -- PugaUI data.
    --
    ComboBox.Items = Items
    ComboBox.Selected = Selected


    --
    -- Returns the selected item index.
    --
    function ComboBox:GetSelected()
        return self.Selected
    end


    --
    -- Returns the text of the selected item.
    --
    function ComboBox:GetText()
        return self.Items[self.Selected] or ""
    end


    --
    -- Selects an item by index.
    --
    function ComboBox:SetSelected(Index)
        if self.Items[Index] == nil then
            return
        end

        self.Selected = Index

        self:SetDefaultText(
            self.Items[Index]
        )
    end


    --
    -- Build dropdown menu.
    --
    ComboBox:SetupMenu(function(_, RootDescription)
        for Index, Text in ipairs(Items) do
            RootDescription:CreateRadio(
                Text,
                function()
                    return ComboBox.Selected == Index
                end,
                function()
                    ComboBox:SetSelected(Index)
                end
            )
        end
    end)


    --
    -- Set initial selection.
    --
    ComboBox:SetSelected(
        Selected
    )


    if Visible then
        ComboBox:Show()
    else
        ComboBox:Hide()
    end


    return ComboBox
end