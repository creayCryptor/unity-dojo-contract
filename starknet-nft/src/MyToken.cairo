// SPDX-License-Identifier: MIT
use starknet::ContractAddress ;
const PAUSER_ROLE: felt252 = selector!("PAUSER_ROLE");
const MINTER_ROLE: felt252 = selector!("MINTER_ROLE");

#[starknet::interface]
trait IMinter<TContractState> {
    fn mint(ref self: TContractState, to: ContractAddress, tokenURI: felt252) ;
    fn transfer(ref self: TContractState, to: ContractAddress, tokenId: u256) ;
    fn getNextTokenId(self: @TContractState) -> u256 ;
}


#[starknet::contract]
mod MyToken {
    use openzeppelin::token::erc721::erc721::ERC721Component::InternalTrait;
    use openzeppelin::token::erc721::ERC721Component;
    use openzeppelin::token::erc721::interface;
    use openzeppelin::introspection::src5::SRC5Component;
    use openzeppelin::security::pausable::PausableComponent;
    use openzeppelin::access::accesscontrol::AccessControlComponent;
    use openzeppelin::access::accesscontrol::DEFAULT_ADMIN_ROLE;
    use starknet::{ ContractAddress, get_caller_address };
    use super::{PAUSER_ROLE, MINTER_ROLE};

    component!(path: ERC721Component, storage: erc721, event: ERC721Event);
    component!(path: SRC5Component, storage: src5, event: SRC5Event);
    component!(path: PausableComponent, storage: pausable, event: PausableEvent);
    component!(path: AccessControlComponent, storage: accesscontrol, event: AccessControlEvent);

    #[abi(embed_v0)]
    impl ERC721MetadataImpl = ERC721Component::ERC721MetadataImpl<ContractState>;
    #[abi(embed_v0)]
    impl ERC721MetadataCamelOnly = ERC721Component::ERC721MetadataCamelOnlyImpl<ContractState>;
    #[abi(embed_v0)]
    impl SRC5Impl = SRC5Component::SRC5Impl<ContractState>;
    #[abi(embed_v0)]
    impl PausableImpl = PausableComponent::PausableImpl<ContractState>;
    #[abi(embed_v0)]
    impl AccessControlImpl = AccessControlComponent::AccessControlImpl<ContractState>;
    #[abi(embed_v0)]
    impl AccessControlCamelImpl = AccessControlComponent::AccessControlCamelImpl<ContractState>;

    impl ERC721InternalImpl = ERC721Component::InternalImpl<ContractState>;
    impl PausableInternalImpl = PausableComponent::InternalImpl<ContractState>;
    impl AccessControlInternalImpl = AccessControlComponent::InternalImpl<ContractState>;

    #[storage]
    struct Storage {
        #[substorage(v0)]
        erc721: ERC721Component::Storage,
        #[substorage(v0)]
        src5: SRC5Component::Storage,
        #[substorage(v0)]
        pausable: PausableComponent::Storage,
        #[substorage(v0)]
        accesscontrol: AccessControlComponent::Storage,
        nextTokenId: u256
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        ERC721Event: ERC721Component::Event,
        #[flat]
        SRC5Event: SRC5Component::Event,
        #[flat]
        PausableEvent: PausableComponent::Event,
        #[flat]
        AccessControlEvent: AccessControlComponent::Event,
    }

    #[constructor]
    fn constructor(ref self: ContractState, default_admin: ContractAddress) {
        self.erc721.initializer('MyToken', 'MTK');
        self.accesscontrol.initializer();

        self.accesscontrol._grant_role(DEFAULT_ADMIN_ROLE, default_admin);
        self.accesscontrol._grant_role(PAUSER_ROLE, default_admin);
        self.accesscontrol._grant_role(MINTER_ROLE, default_admin) ;
        self.nextTokenId.write(1);
    }

    #[external(v0)]
    impl ERC721Impl of interface::IERC721<ContractState> {
        fn balance_of(self: @ContractState, account: ContractAddress) -> u256 {
            self.erc721.balance_of(account)
        }

        fn owner_of(self: @ContractState, token_id: u256) -> ContractAddress {
            self.erc721.owner_of(token_id)
        }

        fn safe_transfer_from(
            ref self: ContractState,
            from: ContractAddress,
            to: ContractAddress,
            token_id: u256,
            data: Span<felt252>,
        ) {
            self.pausable.assert_not_paused();
            self.erc721.safe_transfer_from(from, to, token_id, data);
        }

        fn transfer_from(
            ref self: ContractState,
            from: ContractAddress,
            to: ContractAddress,
            token_id: u256,
        ) {
            self.pausable.assert_not_paused();
            self.erc721.transfer_from(from, to, token_id);
        }

        fn approve(ref self: ContractState, to: ContractAddress, token_id: u256) {
            self.pausable.assert_not_paused();
            self.erc721.approve(to, token_id);
        }

        fn set_approval_for_all(ref self: ContractState, operator: ContractAddress, approved: bool) {
            self.pausable.assert_not_paused();
            self.erc721.set_approval_for_all(operator, approved);
        }

        fn get_approved(self: @ContractState, token_id: u256) -> ContractAddress {
            self.erc721.get_approved(token_id)
        }

        fn is_approved_for_all(self: @ContractState, owner: ContractAddress, operator: ContractAddress) -> bool {
            self.erc721.is_approved_for_all(owner, operator)
        }
    }

    #[external(v0)]
    impl ERC721CamelOnlyImpl of interface::IERC721CamelOnly<ContractState> {
        fn balanceOf(self: @ContractState, account: ContractAddress) -> u256 {
            self.balance_of(account)
        }

        fn ownerOf(self: @ContractState, tokenId: u256) -> ContractAddress {
            self.owner_of(tokenId)
        }

        fn safeTransferFrom(
            ref self: ContractState,
            from: ContractAddress,
            to: ContractAddress,
            tokenId: u256,
            data: Span<felt252>,
        ) {
            self.pausable.assert_not_paused();
            self.safe_transfer_from(from, to, tokenId, data);
        }

        fn transferFrom(
            ref self: ContractState,
            from: ContractAddress,
            to: ContractAddress,
            tokenId: u256,
        ) {
            self.pausable.assert_not_paused();
            self.transfer_from(from, to, tokenId);
        }

        fn setApprovalForAll(ref self: ContractState, operator: ContractAddress, approved: bool) {
            self.pausable.assert_not_paused();
            self.set_approval_for_all(operator, approved);
        }

        fn getApproved(self: @ContractState, tokenId: u256) -> ContractAddress {
            self.get_approved(tokenId)
        }

        fn isApprovedForAll(self: @ContractState, owner: ContractAddress, operator: ContractAddress) -> bool {
            self.is_approved_for_all(owner, operator)
        }
    }

    #[generate_trait]
    #[external(v0)]
    impl ExternalImpl of ExternalTrait {
        fn pause(ref self: ContractState) {
            self.accesscontrol.assert_only_role(PAUSER_ROLE);
            self.pausable._pause();
        }

        fn unpause(ref self: ContractState) {
            self.accesscontrol.assert_only_role(PAUSER_ROLE);
            self.pausable._unpause();
        }

        fn burn(ref self: ContractState, token_id: u256) {
            self.pausable.assert_not_paused();
            let caller = get_caller_address();
            assert(self.erc721._is_approved_or_owner(caller, token_id), ERC721Component::Errors::UNAUTHORIZED);
            self.erc721._burn(token_id);
        }
    }

    #[external(v0)]
    impl MinterImpl of super::IMinter<ContractState>{
        fn mint(ref self: ContractState, to: ContractAddress, tokenURI: felt252) { 
            self.pausable.assert_not_paused();
            self.accesscontrol.assert_only_role(MINTER_ROLE);
            let currentTokenId = self.nextTokenId.read() ;
            self.nextTokenId.write(currentTokenId + 1) ;
            self.erc721._mint(to, currentTokenId);
            self.erc721._set_token_uri(currentTokenId, tokenURI);
        }

        fn transfer(ref self: ContractState, to: ContractAddress, tokenId: u256) {
            self.pausable.assert_not_paused();
            let from = get_caller_address() ;
            self.erc721._transfer(from, to, tokenId) ;
        } 

        fn getNextTokenId(self: @ContractState) -> u256 {
            self.nextTokenId.read()
        }
    }
}
