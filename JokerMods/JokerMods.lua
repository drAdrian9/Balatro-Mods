SMODS.Atlas {
    key = "JokerMods",
    path = "JokerMods.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'mult-fest',
    loc_txt = {
        name = 'Mult Fest',
        text = {
            "+1000 Mult when used",
            "{C:mult}+#1# {} Mult",
            "{C:red}X1000{} Mult", 
            "{C:inactive}Out of luck, eh?"
        }
    },
    config = { extra = { mult = 1000 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    rarity = 5, --1 for testing purposes
    atlas = 'JokerMods',
    pos = { x = 0, y = 0 },
    cost = 10, --1 for testing purposes
    unlocked = true,
    discovered = true,
    blueprint_compability = true,
    external_compability = true,
    calculate = function(self, card, context)
        if context.joker_main then
            local chance = math.random(1, 10) -- Generate a random number between 1 and 10
            if chance == 1 then
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            else
                return {
                    mult_mod = 0,
                    message = localize { type = 'variable', key = 'no_mult', vars = {} }
                }
            end
        end
    end
}

----------------------------------------------
------------MOD CODE END----------------------
