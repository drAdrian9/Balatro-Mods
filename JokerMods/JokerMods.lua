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

SMODS.Joker {
    key = 'mult_fest_v2',
    loc_txt = 
    {
        name = "Mult Fest V2",
        text = 
        {
            "{C:green}#1# in #2#{} chance to gains",
            "{C:mult}+#4#{} mult",
            "{C:inactive}(currently {C:mult}+#3#{C:inactive} mult)"
        }
    },
    config = {extra = {mult_gain = 1000, mult = 0, odds = 10} },
    rarity = 3,
    atlas = 'JokerMods',
    pos = { x = 0, y = 0 },
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                colour = G.C.MULT
            }
        end
        if context.before and not context.blueprint then 
            if pseudorandom('mult_fest_v2') < G.GAME.probabilities.normal / card.ability.extra.odds then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = 'Upgrade!',
                    colour = G.C.MULT, 
                    card = card
                }
            else
                return {
                    message = 'Out of luck, eh?'
                }
            end
        end
    end -- End calculate
}

----------------------------------------------
------------MOD CODE END----------------------
