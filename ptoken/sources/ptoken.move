module ptoken::ptoken {

    use sui::tx_context::{TxContext, sender};
    use sui::coin::{Self, TreasuryCap};
    use sui::transfer;

    struct PTOKEN has drop{}

    fun init(witness: PTOKEN, ctx: &mut TxContext){
        let ptoken = coin::create_currency(witness, 9, ctx);
        transfer::transfer(ptoken, sender(ctx));
    }

    public entry fun mint_to(cap: &mut TreasuryCap<PTOKEN>, amount: u64, addr: address, ctx: &mut TxContext){
        let tk = coin::mint(cap, amount, ctx);
        transfer::transfer(tk, addr)
    }

}
