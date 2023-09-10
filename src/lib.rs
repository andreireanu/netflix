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
    #[endpoint(addToken)]
    fn add_token(&self, token: TokenIdentifier) {
        self.tokens().insert(token);
    }

    #[only_owner]
    #[endpoint(addService)]
    fn add_service(&self, price: u16, periodicity: u64) {
        self.services_count().update(|id| {
            self.services(id).set(Service { price, periodicity });
            *id += 1;
        });

    }


    ////////////////
    // WARNING: DANGER ZONE!
    // THESE CALLS BREAK THE STORAGE LOGIC

    // Clear token count if needed (After deploying contract)
    #[only_owner]
    #[endpoint(initServicesCount)]
    fn init_services_count(&self) {
        self.services_count().set(1usize);
    }
}
