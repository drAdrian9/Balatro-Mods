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
            "{C:green}#2# in #3#{} chance to grant {X:mult,C:white} X#4# {} Mult.",
            "Grants {C:mult}+#1#{} mult instead if it fails."
        }
    },
    config = { extra = { mult = 1, Xmult = 10, odds = 5}},
    rarity = 3,
    atlas = 'JokerMods',
    pos = { x = 0, y = 0 },
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,                            --does joker work with blueprint
    eternal_compat = true,                              --can joker be eternal
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, (G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            -- Another pseudorandom thing, randomly generates a decimal between 0 and 1, so effectively a random percentage.
            if pseudorandom('mult-fest') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    Xmult_mod = card.ability.extra.Xmult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
                }
            else
                return {
                    mult_mod = card.ability.extra.mult,
                    message = localize { type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult} }
                }
            end
        end
    end
}

SMODS.Joker {
    key = 'slot_machine',
    loc_txt = 
    {
        name = "Slot Machine",
        text = 
        {
            "{C:green}#1# in #2#{} chance to gains {C:mult}+#4#{} mult.",
            "if it fails, lose {C:mult}-#5#{} mult instead",
            "{C:inactive}(currently {C:mult}+#3#{C:inactive} mult)"
        }
    },
    config = {extra = {mult_gain = 15, mult_loss = 1, mult = 10, odds = 10} },
    rarity = 2,
    cost = 5,
    atlas = 'JokerMods',
    pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,                            --does joker work with blueprint
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            (G.GAME.probabilities.normal or 1), 
            card.ability.extra.odds, 
            card.ability.extra.mult, 
            card.ability.extra.mult_gain, 
            card.ability.extra.mult_loss } }
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
            if pseudorandom('slot_machine') < G.GAME.probabilities.normal / card.ability.extra.odds then
                -- add mult
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    message = 'Upgrade!',
                    colour = G.C.MULT, 
                    card = card
                }
            else -- reduce mult
                card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.mult_loss
                return {
                    message = 'Out of luck, eh?',
                    colour = G.C.MULT, 
                    card = card
                }
            end
        end
    end -- End calculate
}

SMODS.Joker {
    key = 'midas_factor',
    loc_txt = 
    {
        name = "Midas Factor",
        text = 
        {
            "Each played card has {C:green}#1# in #2#{} chance",
            "to be enhanced into a gold card."
        }
    },
    config = {extra = {odds = 2} },
    rarity = 3,
    cost = 6,
    atlas = 'JokerMods',
    pos = { x = 3, y = 0 },
    unlocked = true,
    discovered = true,
    blueprint_compat = false,                            --does joker work with blueprint
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            (G.GAME.probabilities.normal or 1), 
            card.ability.extra.odds} }
    end,
    calculate = function(self, card, context)
        -- * 1st method. Do not delete this code, m8 be useful for other joker idea
        -- if context.before then
        --     for i=1, #context.scoring_hand do
        --         if pseudorandom('midas_factor') < G.GAME.probabilities.normal / card.ability.extra.odds then
        --             G.E_MANAGER:add_event(Event({
        --                 func = function()
        --                     context.scoring_hand[i]:set_ability(G.P_CENTERS.m_gold)
        --                     context.scoring_hand[i]:juice_up()
        --                     return true
        --                 end
        --             })) 
        --             return {
        --                 message = localize('k_gold'),
        --                 colour = G.C.MONEY,
        --                 card = card
        --             }
        --         end
        --     end
        -- end

        -- * better method
        if context.cardarea == G.play then
            if pseudorandom('midas_factor') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_card:set_ability(G.P_CENTERS.m_gold)
                        context.other_card:juice_up()
                        return true
                    end
                })) 
                return {
                    message = localize('k_gold'),
                    colour = G.C.MONEY,
                    card = card
                }
            end
        end
    end
}

----------------------------------------------
------------MOD CODE END----------------------
