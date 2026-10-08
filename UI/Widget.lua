local PL = PugaLib

PL.UI.Widget = {}


--
-- Sets the position of a widget relative to its parent.
-- A nil coordinate centers the widget on that axis.
--
function PL.UI.Widget:SetPosition(
    Widget,
    Parent,
    X,
    Y
)
    local Point
    local RelativePoint
    local OffsetX
    local OffsetY


    if X == nil then
        OffsetX = 0
    else
        OffsetX = X
    end


    if Y == nil then
        OffsetY = 0
    else
        OffsetY = -Y
    end


    if X == nil and Y == nil then
        Point = "CENTER"
        RelativePoint = "CENTER"

    elseif X == nil then
        Point = "TOP"
        RelativePoint = "TOP"

    elseif Y == nil then
        Point = "LEFT"
        RelativePoint = "LEFT"

    else
        Point = "TOPLEFT"
        RelativePoint = "TOPLEFT"
    end


    -- WoW API
    Widget:SetPoint(
        Point,
        Parent,
        RelativePoint,
        OffsetX,
        OffsetY
    )
end

--
-- Centers the widget relative to its parent. (Explicit)
--
function PL.UI.Widget:Center(
    Widget,
    Parent
)
    self:SetPosition(
        Widget,
        Parent,
        nil,
        nil
    )
end


--
-- Returns Value unless it is nil.
-- Otherwise returns Default.
--
function PL.UI.Widget.GetOption(
    Value,
    Default
)
    if Value == nil then
        return Default
    end

    return Value
end

--
-- Adds common methods to a widget when they are not
-- already provided by the underlying WoW control.
--
-- Control may be used to delegate these operations to
-- an internal control. Unsupported operations are ignored.
--
function PL.UI.Widget:Setup(Widget, Control)
    Control = Control or Widget

    Widget.GetText = function()
        if Control.GetText ~= nil then
            return Control:GetText()
        end

        return nil
    end

    Widget.SetText = function(_, Text)
        if Control.SetText ~= nil then
            Control:SetText(Text)
        end
    end

    Widget.SetFocus = function()
        if Control.SetFocus ~= nil then
            Control:SetFocus()
        end
    end

    Widget.ClearFocus = function()
        if Control.ClearFocus ~= nil then
            Control:ClearFocus()
        end
    end
end