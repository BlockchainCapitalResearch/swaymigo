contract;
use std::{address::Address, contract_id::ContractId, identity::Identity};
use swaymigo::token::vote_token::delegate as _delegate;
use swaymigo::token::vote_token::get_supply_checkpoint as _get_supply_checkpoint;
use swaymigo::token::vote_token::get_voting_power as _get_voting_power;
use swaymigo::token::vote_token::mint as _mint;
use swaymigo::token::vote_token::burn as _burn;
use swaymigo::token::vote_token::transfer as _transfer;

abi Governor {
    #[storage(write)]fn set_vote_asset(contract_id: ContractId);
    #[storage(read)]fn get_vote_asset() -> ContractId;
    #[storage(read, write)]fn transfer(from: Identity, to: Identity, amount: u64);
    #[storage(read, write)]fn delegate(from: Identity, to: Identity, amount: u64);
    #[storage(read)]fn get_supply_checkpoint(block: u64) -> u64;
    #[storage(read)]fn get_voting_power(block: u64, of: Identity) -> u64;
}

storage {
    contract_id: ContractId,
}

impl Governor for Contract {
    #[storage(write)]pub fn set_vote_asset(contract_id: ContractId) {
        storage.contract_id = contract_id;
    }

    #[storage(read)]pub fn get_vote_asset() -> ContractId {
        storage.contract_id
    }

    #[storage(read, write)]pub fn transfer(from: Identity, to: Identity, amount: u64) {
        _transfer(from, to, amount);
    }

    #[storage(read, write)]pub fn delegate(from: Identity, to: Identity, amount: u64) {
        _delegate(from, to, amount);
    }

    #[storage(read)]pub fn get_supply_checkpoint(block: u64) -> u64 {
        _get_supply_checkpoint(block)
    }

    #[storage(read)]pub fn get_voting_power(block: u64, of: Identity) -> u64 {
        _get_voting_power(block, of)
    }
}
