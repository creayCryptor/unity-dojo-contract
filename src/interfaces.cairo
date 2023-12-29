use dojo::world::IWorldDispatcher;
use starknet::ContractAddress;

#[starknet::interface]
trait IGameSystems<TContractState> {

    fn initialize(
        self: @TContractState,
        tokenContractAddr: ContractAddress,
        admin: ContractAddress,
        multiple: u256
    );

    fn assertAdminRole(self: @TContractState) ;

    fn changeAdmin(
        self: @TContractState,
        admin: ContractAddress
    ) ;

    fn changeStatus(
        self: @TContractState
    ) ;

    fn changeMultiple(
        self: @TContractState,
        newMultiple: u256        
    ) ;

    fn mint(
        self: @TContractState,
        tokenURI: felt252
    ) ;

    fn player(
        self: @TContractState,
        id: u256
    ) ;
    
    fn setTestData(
        self: @TContractState, 
        newData: u128
    );

    fn setTestData2(
        self: @TContractState
    );
}
