

## Netflix Smart Contract

Similarly to the ERC-1155 contract, or as an extension of that, we can create a **Subscription** contract. This will work for the user as a funding wallet, where he deposits a certain amount of tokens, he subscribes to multiple services (**"Netflix" Smart Contract**) and those services will take tokens from the subscription contract according to predefined rules signed by the user.

#### Admin actions:
Whitelist tokenIDs which are accepted in the subscription contract.

#### Services actions:
Registers itself as a service
Define price and periodicity for their services. One service can offer multiple services.
`
#### User actions:
Deposit/withdraw tokens
Subscribe to services by approving/signing the conditions of selected services.
If the user signs a transaction in which he says approve@service1@service2@service5 - it means he agrees with the conditions
When a user subscribes to a service, the SC has to save the information regarding that service - like the service is allowed to take 5$ worth of tokens from the deposited tokens
Unsubscribe from services

#### Price:
Services might define that the price is in $ worth of X tokens. Like 5$ worth of eGLD. In this case the subscription contract has to integrate safePrice (an existing contract on the chain) which knows the price
https://github.com/multiversx/mx-exchange-sc/blob/main/dex/pair/README.md#safe-price-v2
Using the safePrice computation, the service will take X tokens which are worth Y$ at the periodicity approved by the user. (Once per week, once per month, once per day).


### Features 
* #### Smart contract owner can:
    + Add allowed payment tokens (```addToken```)
    + Add services (```addService```)  
    + Get tokens as payment for the services that a contract subscribed to (```getSubscriptionsTokens```) 

* #### Architecture:
<img src="assets/arch.jpg" alt="Impl1" width="70%"/>
 
