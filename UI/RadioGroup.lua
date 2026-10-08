local PL = PugaLib


--
-- Creates a radio button group.
--
function PL.UI:NewRadioGroup(Buttons)
    Buttons = Buttons or {}

    local RadioGroup = {
        Buttons = Buttons,
        Selected = nil,
    }


    --
    -- Returns the selected radio button index.
    --
    function RadioGroup:GetSelected()
        return self.Selected
    end


    --
    -- Selects a radio button by index.
    --
    function RadioGroup:SetSelected(Index)
        if self.Buttons[Index] == nil then
            return
        end

        for i, Button in ipairs(self.Buttons) do
            Button:SetChecked(
                i == Index
            )
        end

        self.Selected = Index
    end


    --
    -- Configure buttons.
    --
    for Index, Button in ipairs(Buttons) do
        Button:SetScript(
            "OnClick",
            function()
                RadioGroup:SetSelected(
                    Index
                )
            end
        )

        --
        -- Keep the first checked button
        -- as the initial selection.
        --
        if RadioGroup.Selected == nil
            and Button:GetChecked() then

            RadioGroup.Selected = Index
        end
    end


    --
    -- Ensure that only one button is selected.
    --
    if RadioGroup.Selected ~= nil then
        RadioGroup:SetSelected(
            RadioGroup.Selected
        )
    end


    return RadioGroup
end