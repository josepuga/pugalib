local PL = PugaLib


--
-- Creates a tooltip associated with a widget.
--
function PL.UI:NewTooltip(Owner, Options)
    Options = Options or {}

    local Tooltip = {
        Owner = Owner,
        Anchor = Options.Anchor or "ANCHOR_RIGHT",
        Lines = {},
    }


    --
    -- Adds a normal text line.
    --
--
-- Adds a normal text line.
--
function Tooltip:AddLine(
    Text,
    R,
    G,
    B
)
    table.insert(
        self.Lines,
        {
            Text = Text,
            Header = false,
            R = R or 1,
            G = G or 1,
            B = B or 1,
        }
    )
end


    --
    -- Adds a header line.
    --
    function Tooltip:AddHeader(Text)
        table.insert(
            self.Lines,
            {
                Text = Text,
                Header = true,
            }
        )
    end


    --
    -- Removes all stored lines.
    --
    function Tooltip:Clear()
        self.Lines = {}
    end


    --
    -- Shows the tooltip.
    --
    function Tooltip:Show()
        GameTooltip:SetOwner(
            self.Owner,
            self.Anchor
        )

        GameTooltip:ClearLines()


        for _, Line in ipairs(self.Lines) do
            if Line.Header then
                GameTooltip:AddLine(
                    Line.Text,
                    1,
                    0.82,
                    0
                )
            else
                GameTooltip:AddLine(
                    Line.Text,
                    Line.R,
                    Line.G,
                    Line.B,
                    true
                )
            end
        end


        GameTooltip:Show()
    end


    --
    -- Hides the tooltip.
    --
    function Tooltip:Hide()
        GameTooltip:Hide()
    end


    --
    -- Automatically show/hide the tooltip
    -- when hovering the owner.
    --
    Owner:EnableMouse(true)

    Owner:SetScript(
        "OnEnter",
        function()
            Tooltip:Show()
        end
    )

    Owner:SetScript(
        "OnLeave",
        function()
            Tooltip:Hide()
        end
    )


    return Tooltip
end