# load file with ". /path/to/file"

PROXY=https://devnet-gateway.multiversx.com
CHAIN_ID="D"
WALLET_ALICE="${PWD}/netflix/wallets/alice.pem"
WALLET_BOB="${PWD}/netflix/wallets/bob.pem"
CONTRACT_ADDRESS="erd1qqqqqqqqqqqqqpgqfldvjsvemctf6p3vfc2k7tt83u4zpwe6y8dqmhkke2"
CONTRACT_ADDRESS_HEX="$(mxpy wallet bech32 --decode ${CONTRACT_ADDRESS})"
ALICE_ADDRESS="erd1aqd2v3hsrpgpcscls6a6al35uc3vqjjmskj6vnvl0k93e73x7wpqtpctqw"
ALICE_ADDRESS_HEX="$(mxpy wallet bech32 --decode ${ALICE_ADDRESS})"
ALICE_ADDRESS_HEXX="0x$(mxpy wallet bech32 --decode ${ALICE_ADDRESS})"
BOB_ADDRESS="erd1wh2rz67zlq5nea7j4lvs39n0yavjlaxal88f744k2ps036ary8dq3ptyd4"
BOB_ADDRESS_HEX="$(mxpy wallet bech32 --decode ${BOB_ADDRESS})"
BOB_ADDRESS_HEXX="0x$(mxpy wallet bech32 --decode ${BOB_ADDRESS})"
MARTA_ADDRESS="erd1uycnjd0epww6xrmn0xjdkfhjengpaf4l5866rlrd8qpcsamrqr8qs6ucxx"
MARTA_ADDRESS_HEX="$(mxpy wallet bech32 --decode ${MARTA_ADDRESS})"
MARTA_ADDRESS_HEXX="0x$(mxpy wallet bech32 --decode ${MARTA_ADDRESS})"

SAFE_PRICE_VIEW="erd1qqqqqqqqqqqqqpgqs5t29sk6v0knxxnnc29pv6y0zgmemh287wpqmcx970"


### MAIN

deploy() {
 mxpy contract deploy --proxy=${PROXY} \
    --chain=${CHAIN_ID} \
    --bytecode=netflix/output/netflix.wasm \
    --pem="netflix/wallets/bob.pem" \
    --gas-limit=60000000 \
    --recall-nonce \
    --send \
    --metadata-payable
}

upgrade() {
 mxpy contract upgrade ${CONTRACT_ADDRESS} \
    --pem="netflix/wallets/bob.pem" \
    --chain=${CHAIN_ID} \
    --proxy=${PROXY} \
    --recall-nonce \
    --bytecode=netflix/output/netflix.wasm \
    --gas-limit=80000000 \
    --send \
    --metadata-payable
}


setSafePriceView() {
    mxpy --verbose contract call ${CONTRACT_ADDRESS} \
    --send \
    --proxy=${PROXY} \
    --chain=${CHAIN_ID} \
    --recall-nonce \
    --pem="erc1155/wallets/bob.pem" \
    --gas-limit=100000000 \
    --function="setSafePriceView" \
    --arguments ${SAFE_PRICE_VIEW} 
}

getSafePriceView() {
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
    --proxy=${PROXY} \
    --function="getSafePriceView"
}


TOKEN_1=AMS-3a6740
LP_ADDRESS_TOKEN_1="erd1qqqqqqqqqqqqqpgqfs5vg9n23hvrgfmye4h9vj8p6ljtz2m37wpqj726a5"
TOKEN_2=BMS-e00535
LP_ADDRESS_TOKEN_2="erd1qqqqqqqqqqqqqpgqe92zyh296kxrmeszg5cynxcuj4vzckxg7wpqp89fmz"
TOKEN_3=USDC-79d9a4
# Zero address for stablecoin
LP_ADDRESS_TOKEN_3="erd1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq6gq4hu"



addToken() {
    mxpy --verbose contract call ${CONTRACT_ADDRESS} \
    --send \
    --proxy=${PROXY} \
    --chain=${CHAIN_ID} \
    --recall-nonce \
    --pem="erc1155/wallets/bob.pem" \
    --gas-limit=100000000 \
    --function="addToken" \
    --arguments "str:"${TOKEN_3}  ${LP_ADDRESS_TOKEN_3}
}

getTokensCount() {
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
    --proxy=${PROXY} \
    --function="getTokensCount"  
}

TOKEN_ID_1=1
TOKEN_ID_2=2
TOKEN_ID_3=3

getTokens() {
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
    --proxy=${PROXY} \
    --function="getTokens" \
    --arguments ${TOKEN_ID_1} 
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
    --proxy=${PROXY} \
    --function="getTokens" \
    --arguments ${TOKEN_ID_2} 
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
    --proxy=${PROXY} \
    --function="getTokens" \
    --arguments ${TOKEN_ID_3} 
}


getAddresses() {
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
    --proxy=${PROXY} \
    --function="getLPAddress" \
    --arguments ${TOKEN_ID_1} 
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
    --proxy=${PROXY} \
    --function="getLPAddress" \
    --arguments ${TOKEN_ID_2} 
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
    --proxy=${PROXY} \
    --function="getLPAddress" \
    --arguments ${TOKEN_ID_3} 
}



SERVICE1_PRICE=315 # we define the price with 2 decimals so 315 is equivalent to 3.15 $
POWER=16 # we multiply with 16 to get 18 decimals value
POWERED=$((10**${POWER}))
SERVICE1_PRICE_POWERED=$( printf "%.0f" $(echo "${SERVICE1_PRICE} * ${POWERED}" | bc) ) 
SERVICE1_PERIODICITY=86400

SERVICE2_PRICE=1000
SERVICE2_PRICE_POWERED=$( printf "%.0f" $(echo "${SERVICE2_PRICE} * ${POWERED}" | bc) ) 
SERVICE2_PERIODICITY=604800

SERVICE3_PRICE=3000
SERVICE3_PRICE_POWERED=$( printf "%.0f" $(echo "${SERVICE3_PRICE} * ${POWERED}" | bc) ) 
SERVICE3_PERIODICITY=2678400
 
addService() {
    mxpy --verbose contract call ${CONTRACT_ADDRESS} \
    --send \
    --proxy=${PROXY} \
    --chain=${CHAIN_ID} \
    --recall-nonce \
    --pem="erc1155/wallets/bob.pem" \
    --gas-limit=100000000 \
    --function="addService" \
    --arguments ${SERVICE3_PRICE_POWERED} ${SERVICE1_PERIODICITY}
}

SERVICE_ID_1=1
SERVICE_ID_2=2
SERVICE_ID_3=3

getServices() {
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
    --proxy=${PROXY} \
    --function="getServices" \
    --arguments ${SERVICE_ID_1}
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
    --proxy=${PROXY} \
    --function="getServices" \
    --arguments ${SERVICE_ID_2} 
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
    --proxy=${PROXY} \
    --function="getServices" \
    --arguments ${SERVICE_ID_3}  
}


getServicesCount() {
    mxpy --verbose contract query ${CONTRACT_ADDRESS} \
    --proxy=${PROXY} \
    --function="getServicesCount"  
}


### DEV CALLS (HANDLE WITH CARE)

initServicesCount() {
    mxpy --verbose contract call ${CONTRACT_ADDRESS} \
    --send \
    --proxy=${PROXY} \
    --chain=${CHAIN_ID} \
    --recall-nonce \
    --pem="erc1155/wallets/bob.pem" \
    --gas-limit=100000000 \
    --function="initServicesCount"
}

initTokensCount() {
    mxpy --verbose contract call ${CONTRACT_ADDRESS} \
    --send \
    --proxy=${PROXY} \
    --chain=${CHAIN_ID} \
    --recall-nonce \
    --pem="erc1155/wallets/bob.pem" \
    --gas-limit=100000000 \
    --function="initTokensCount"
}



