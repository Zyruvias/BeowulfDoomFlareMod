--[[
    BeowulfDoomFlare mod
    Author: Zyruvias (Zyruvias on discord, youtube, twitch)
    Note:   the actual flare implementation is not mine -- it is
            commented out code already within Hades game files. This mod
            just explicitly enables them and makes it more accessible for
            use by the general public.
]]
ModUtil.Mod.Register("BeowulfFlareMod")

local config = {
    ModName = "BeowulfFlareMod",
    Enabled = true,
}
BeowulfFlareMod.config = config
ModUtil.LoadOnce(
    function ()
    
        if config.Enabled then
            -- Change Beowulf Ares' Flare PropertyChanges to use Doom Flare.
            ModUtil.Table.Replace(TraitData.ShieldLoadAmmo_AresRangedTrait.PropertyChanges, {
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    WeaponProperty = "Projectile",
                    ChangeValue = "AresBeowulfProjectile",
                    ChangeType = "Absolute",
                },
        
                {
                    WeaponNames = WeaponSets.HeroNonPhysicalWeapons,
                    EffectName = "DelayedDamage",
                    EffectProperty = "Amount",
                    BaseMin = 100,
                    BaseMax = 100,
                    AsInt = true,
                    MinMultiplier = 0.025,
                    IdenticalMultiplier =
                    {
                        Value = -0.35,
                    },
                    ExtractValue =
                    {
                        ExtractAs = "TooltipDamage",
                    }
                },
            })
            -- Add doom flare to ME pre-reqs for in-run accessibility.
            ModUtil.Table.Replace(LootData.AresUpgrade.LinkedUpgrades.TriggerCurseTrait, {
                OneFromEachSet =
                {
                    { "AresWeaponTrait", "AresSecondaryTrait", "ShieldLoadAmmo_AresRangedTrait" },
                    { "AthenaWeaponTrait", "AthenaSecondaryTrait" },
                },
            })
            -- Add doom flare to Impending Doom pre-reqs -- it's already listed in a valid damage source in TraitData lmfao
            ModUtil.Table.Replace(LootData.AresUpgrade.LinkedUpgrades.AresLongCurseTrait, {
                OneOf = { "AresWeaponTrait", "AresSecondaryTrait", "AresRetaliateTrait", "ShieldLoadAmmo_AresRangedTrait" },
            })
            -- TODO: disable Ares's T2 boons from appearing when enabled. Haelian doesn't care so I'll do this before putting on github.
        end
    end
)