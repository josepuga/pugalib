local PL = PugaLib


--
-- Creates and registers a new link handler.
--
function PL.UI:NewLinkHandler(
    Type,
    Callback
)
    if LinkUtil.IsLinkHandlerRegistered(Type) then
        return nil
    end


    LinkUtil.RegisterLinkHandler(
        Type,
        function(
            Link,
            Text,
            LinkData,
            ContextData
        )
            Callback(
                LinkData.options,
                Text,
                ContextData
            )
        end
    )


    return {
        Type = Type,
    }
end


--
-- Creates a new hyperlink.
--
function PL.UI:NewLink(
    Handler,
    Text,
    Data
)
    if Handler == nil then
        return nil
    end


    return LinkUtil.FormatLink(
        Handler.Type,
        Text,
        Data
    )
end