multiversx_sc::imports!();
multiversx_sc::derive_imports!();

// CUSTOM FORMAT
#[derive(PartialEq, TypeAbi, TopEncode, TopDecode, NestedEncode, NestedDecode, Clone)]
pub struct Service<M: ManagedTypeApi> {
    pub price: BigUint<M>,
    pub periodicity: u64, // Periodicity stored in seconds
}


// STORAGE

#[multiversx_sc::module]
pub trait StorageModule {
    // Token count
    #[view(getTokensCount)]
    #[storage_mapper("tokens_count")]
    fn tokens_count(&self) -> SingleValueMapper<usize>;

    // Allowed tokens
    #[view(getTokens)]
    #[storage_mapper("tokens")]
    fn tokens(&self, id: &usize) -> SingleValueMapper<TokenIdentifier>;

    // Allowed tokens LP address
    #[view(getLPAddress)]
    #[storage_mapper("lp_address")]
    fn lp_address(&self, id: &usize) -> SingleValueMapper<ManagedAddress>;

    // Number of Services mapper
    #[view(getServicesCount)]
    #[storage_mapper("services_count")]
    fn services_count(&self) -> SingleValueMapper<usize>;

    // Id To Services mapper
    #[view(getServices)]
    #[storage_mapper("services")]
    fn services(&self, id: &usize) -> SingleValueMapper<Service<Self::Api>>;

    // Safe Price view address
    #[view(getSafePriceView)]
    #[storage_mapper("safe_price_view")]
    fn safe_price_view(&self) -> SingleValueMapper<ManagedAddress>;
}
