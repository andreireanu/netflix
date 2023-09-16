#![no_std]

multiversx_sc::imports!();
multiversx_sc::derive_imports!();

mod storage;
use storage::Service;

#[multiversx_sc::contract]
pub trait NetflixContract: crate::storage::StorageModule {
    #[init]
    fn init(&self) {}

    #[only_owner]
    #[endpoint(setSafePriceView)]
    fn set_safe_price_view(&self, safe_price_view_address: ManagedAddress) {
        self.safe_price_view().set(safe_price_view_address);
    }    

    #[only_owner]
    #[endpoint(addToken)]
    fn add_token(&self, token: TokenIdentifier, lp_address: ManagedAddress) {
        self.tokens_count().update(|id| {
            self.tokens(id).set(token);
            self.lp_address(id).set( lp_address);
            *id += 1;
        });
    }

    #[only_owner]
    #[endpoint(addService)]
    fn add_service(&self, price: BigUint, periodicity: u64) {
        self.services_count().update(|id| {
            self.services(id).set(Service { price, periodicity });
            *id += 1;
        });
    }

    ////////////////
    // WARNING: DANGER ZONE!
    // THESE CALLS BREAK THE STORAGE LOGIC

    // Init services count
    #[only_owner]
    #[endpoint(initServicesCount)]
    fn init_services_count(&self) {
        self.services_count().set(1usize);
    }

    // Init services count
    #[only_owner]
    #[endpoint(initTokensCount)]
    fn init_tokens_count(&self) {
        self.tokens_count().set(1usize);
    }
}
