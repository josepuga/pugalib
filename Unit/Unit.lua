local PL = PugaLib

PL.Unit = {}
PL.Unit.__index = PL.Unit




function PL.Unit:New(entity)
    local Unit = setmetatable({
        Entity = entity,

        -- Identity
        GUID = nil,
        Name = nil,
        Server = nil,
        Sex = nil,

        Race = {
            Id = nil,
            Token = nil,
            Name = nil,
        },

        Class = {
            Id = nil,
            Token = nil,
            Name = nil,
        },

        Faction = {
            Token = nil,
            Name = nil,
        },

        -- Progression
        Level = 0,

        XP = {
            Current = 0,
            Max = 0,
            Rested = 0,
        },

        -- Location
        Location = {
            Zone = nil,
            SubZone = nil,
            MapId = nil,
            X = nil,
            Y = nil,
        },

        -- Economy
        Money = 0,

        -- Guild
        Guild = {
            Name = nil,
            Rank = nil,
            RankIndex = nil,
        },

        -- Status
        Health = {
            Current = 0,
            Max = 0,
        },

        Power = {
            Current = 0,
            Max = 0,

            Type = {
                Id = nil,
                Token = nil,
            },
        },

        -- Equipment
        ItemLevel = {
            Overall = 0,
            Equipped = 0,
        },

        -- Specialization
        Specialization = {
            Id = nil,
            Name = nil,
            Role = nil,
        },
    }, self)

    Unit:Init()

    return Unit
end


function PL.Unit:Init()
    -- Static / mostly static data

    self.GUID = UnitGUID(self.Entity)

    local Name, Server =
        UnitName(self.Entity)
    self.Name = Name
    self.Server = Server

    --
    -- UnitName() may not return the realm
    -- for the player's own character.
    --
    if self.Entity == "player"
            and not self.Server then
        self.Server = GetRealmName()
    end

    local RaceName, RaceToken, RaceId =
        UnitRace(self.Entity)

    self.Race.Id = RaceId
    self.Race.Token = RaceToken
    self.Race.Name = RaceName

    local ClassName, ClassToken, ClassId =
        UnitClass(self.Entity)

    self.Class.Id = ClassId
    self.Class.Token = ClassToken
    self.Class.Name = ClassName

    self.Sex = UnitSex(self.Entity)

    local FactionToken, FactionName =
        UnitFactionGroup(self.Entity)

    self.Faction.Token = FactionToken
    self.Faction.Name = FactionName

    self:Refresh()
end


function PL.Unit:Refresh()
    self.Level = UnitLevel(self.Entity)

    self:RefreshGuild()
    self:RefreshStatus()

    --
    -- These values only make sense / are available
    -- for the player's own character.
    --
    if self.Entity == "player" then
        self:RefreshPlayerData()
    end
end


function PL.Unit:RefreshGuild()
    local Name, Rank, RankIndex =
        GetGuildInfo(self.Entity)

    self.Guild.Name = Name
    self.Guild.Rank = Rank
    self.Guild.RankIndex = RankIndex
end


function PL.Unit:RefreshStatus()
    self.Health.Current =
        UnitHealth(self.Entity)

    self.Health.Max =
        UnitHealthMax(self.Entity)

    self.Power.Current =
        UnitPower(self.Entity)

    self.Power.Max =
        UnitPowerMax(self.Entity)

    local PowerType, PowerToken =
        UnitPowerType(self.Entity)

    self.Power.Type.Id = PowerType
    self.Power.Type.Token = PowerToken
end


function PL.Unit:RefreshPlayerData()
    self.XP.Current = UnitXP("player")
    self.XP.Max = UnitXPMax("player")
    self.XP.Rested = GetXPExhaustion() or 0

    self.Money = GetMoney()

    self:RefreshLocation()
    self:RefreshItemLevel()
    self:RefreshSpecialization()
end


function PL.Unit:RefreshLocation()
    --
    -- WoW only gives us the player's map position here.
    --
    if self.Entity ~= "player" then
        return
    end

    self.Location.Zone = GetZoneText()
    self.Location.SubZone = GetSubZoneText()

    self.Location.MapId = nil
    self.Location.X = nil
    self.Location.Y = nil

    if C_Map == nil then
        return
    end

    local MapId =
        C_Map.GetBestMapForUnit("player")

    if MapId == nil then
        return
    end

    self.Location.MapId = MapId

    local Position =
        C_Map.GetPlayerMapPosition(
            MapId,
            "player"
        )

    if Position == nil then
        return
    end

    self.Location.X = Position.x
    self.Location.Y = Position.y
end


function PL.Unit:RefreshItemLevel()
    if self.Entity ~= "player" then
        return
    end

    if GetAverageItemLevel == nil then
        return
    end

    local Overall, Equipped =
        GetAverageItemLevel()

    self.ItemLevel.Overall = Overall
    self.ItemLevel.Equipped = Equipped
end


function PL.Unit:RefreshSpecialization()
    if self.Entity ~= "player" then
        return
    end

    if GetSpecialization == nil
        or GetSpecializationInfo == nil then
        return
    end

    local Index = GetSpecialization()

    if Index == nil then
        return
    end

    local Id, Name, _, _, Role =
        GetSpecializationInfo(Index)

    self.Specialization.Id = Id
    self.Specialization.Name = Name
    self.Specialization.Role = Role
end