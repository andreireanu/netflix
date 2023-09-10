multiversx_sc::imports!();
multiversx_sc::derive_imports!();

// CUSTOM FORMAT
#[derive(PartialEq, TypeAbi, TopEncode, TopDecode, NestedEncode, NestedDecode, Clone)]
pub struct Service  {
    pub price: u16,  // Price stored as a 2 decimal value so 3.25$ will be stored as 325
    pub periodicity: u64, // Periodicity stored in seconds
}


// STORAGE

#[multiversx_sc::module]
pub trait StorageModule {
    // Allowed tokens
    #[view(getTokens)]
    #[storage_mapper("tokens")]
    fn tokens(&self) -> UnorderedSetMapper<TokenIdentifier>;

    // Id To Services mapper
    #[view(getServices)]
    #[storage_mapper("services")]
    fn services(&self, id: &usize) -> SingleValueMapper<Service>;

    // Number of Services mapper 
    #[view(getServicesCount)]
    #[storage_mapper("services_count")]
    fn services_count(&self) -> SingleValueMapper<usize>;
}
