SMODS.Voucher { -- First Voucher
    key = 'Impostor',
    loc_txt = {
        name = 'Impostor',
        text = {
            '{C:attention}The Trickster{} has now a',
            '{C:green}1 in 1{} chance to copy a',
            'random {C:legendary,E:1}Legendary{} Joker.',
            '{C:spectral}The Soul{} appears',
            '{C:attention}2X{} times more often.'
        },
    },
    config = {},
    pos = {x = 0, y = 0},
    atlas = 'Vouchers',
    cost = 10,
    unlocked = true,
    discovered = false,
    redeem = function(self)
    end
}

SMODS.Voucher { -- Second Voucher
    key = 'Second',
    loc_txt = {
        name = 'Impersonator',
        text = {
            'You can choose which',
            '{C:legendary,E:1}Legendary{} Joker',
            '{C:attention}The Trickster{} will copy.',
            '{C:spectral}The Soul{} appears',
            '{C:attention}4X{} times more often.'
        },
    },
    config = {},
    pos = {x = 1, y = 0},
    soul_pos = {x = 2, y = 0},
    atlas = 'Vouchers',
    cost = 10,
    unlocked = true,
    discovered = false,
    requires = 'v_Trick_Impostor',
    redeem = function(self)
    end
}