dfx identity new minter
dfx identity use minter
export MINT_ACC=$(dfx ledger account-id)

dfx identity use local_wallet 
export LEDGER_ACC=$(dfx ledger account-id)
export TEST_ACC="cd60093cef12e11d7b8e791448023348103855f682041e93f7d0be451f48118b"

# Use private api for install
rm src/ledger/ledger.did
cp src/ledger/ledger.private.did src/ledger/ledger.did

dfx deploy ledger --argument '(record {minting_account = "'${MINT_ACC}'"; initial_values = vec { record { "'${LEDGER_ACC}'"; record { e8s=100_000_000_000 } }; record { "'${TEST_ACC}'"; record { e8s=100_000_000_000 } }; }; send_whitelist = vec {}})'

# Replace with public api
rm src/ledger/ledger.did
cp src/ledger/ledger.public.did src/ledger/ledger.did

dfx deploy invoice

#get your ledger account id
#dfx canister ledger account-id

#replace that accountidentifier identifier below to what you get
#dfx canister call invoice accountIdentifierToBlob '(variant{"text" = "aabd94a4f40cf02a2926ccece42beef401642408b9bfda5d309bc96c2357fdc5"})'

#replace that accountidentifier identifier below to what you get
#dfx canister call ledger account_balance '(record {account=blob "\aa\bd\94\a4\f4\0c\f0*)&\cc\ec\e4+\ee\f4\01d$\08\b9\bf\da]0\9b\c9l#W\fd\c5"})'

#get your invoice canister id
#dfx identity get-principal

#create an invoice canister 
#dfx canister call create_invoice '(record{amount=50000000000;token=record{"symbol"="ICP"};permissions=null;details=null})'

#you will get an account identifier
#Next convert that account identifier to blob
#dfx canister call invoice accountIdentifierToBlob '(variant{"text" = "d5e096baacc51037cc3f5d5f12ec51dc1337d01d1c4ef3eb4de96fc67bbe6a76"})'

#now you will send to that blob account
#dfx canister call ledger transfer '(record {memo=1;amount= record {e8s = 50000000000};fee=record {e8s=10000};from_subaccount=null;to= blob "\d5\e0\96\ba\ac\c5\107\cc?]_\12\ecQ\dc\137\d0\1d\1cN\f3\ebM\e9o\c6{\bejv";created_at_time=null;})'

#take ur invoice id and then do 
#dfx canister call invoice verify_invoice '(record {id=0})'

#check ur balance of that account
#dfx canister call invoice get_balance '(record {token=record{symbol="ICP"}})'


