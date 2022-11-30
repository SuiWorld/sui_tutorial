module stoken::stoken {
    use sui::tx_context::{TxContext, sender};
    use sui::coin::{Self, TreasuryCap, Coin};
    use sui::transfer;
    use sui::balance;

    struct STOKEN has drop{}

    fun init(witness: STOKEN, ctx: &mut TxContext){
        transfer::share_object(coin::create_currency(witness, 9, ctx))
    }

    public entry fun mint_to_me(cap: &mut TreasuryCap<STOKEN>, amount: u64, ctx: &mut TxContext){
        transfer::transfer(coin::mint(cap, amount, ctx), sender(ctx))
    }

    public entry fun pay_coin(cap: &mut TreasuryCap<STOKEN>, self: &mut Coin<STOKEN>, value: u64, ctx: &mut TxContext){
        let coin_balance = coin::balance_mut(self);
        let paid_value = balance::split<STOKEN>(coin_balance, value);

        let paid_coin = coin::from_balance(paid_value, ctx);
        coin::burn(cap, paid_coin);
    }
}
