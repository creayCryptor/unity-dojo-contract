
// dojo decorator
#[dojo::contract]
mod actions {
    use starknet::{ContractAddress, get_caller_address, get_block_timestamp };
    use dojo_demo::interfaces::IGameSystems;
    use dojo_demo::models::{ Owner, Score, Records, Config, MintRecords, TestData };
    use starknet::info::get_contract_address;
    use core::serde::Serde;
    use starknet::SyscallResultTrait;
    use core::zeroable::Zeroable;
    use poseidon::PoseidonTrait;

    // declaring custom event struct
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        MintEvent: MintEvent,
    }

    // declaring custom event struct
    #[derive(Drop, starknet::Event)]
    struct MintEvent {
        from: ContractAddress,
        to: ContractAddress,
        tokenId: u256
    }

    // impl: implement functions specified in trait
    #[external(v0)]
    impl GameSystemsImpl of IGameSystems<ContractState> {
        fn initialize(
            self: @ContractState,
            tokenContractAddr: ContractAddress,
            admin: ContractAddress,
            multiple: u256
        ) {
            let world = self.world_dispatcher.read() ;
            let contractAddress = get_contract_address() ;
            let mut config = get!(world, contractAddress, (Config)) ;
            assert(config.tokenContractAddr.is_zero(), 'already initialized');        
            config.contractAddress = contractAddress;
            config.tokenContractAddr = tokenContractAddr;
            config.multiple = multiple;
            config.pause = false ;

            let player = get_caller_address();
           
            set!(world, (config, Owner { contractAddress, admin: player, isSure: true }, Owner { contractAddress, admin, isSure: true } )) ;
        }

        fn assertAdminRole(self: @ContractState) {
            let world = self.world_dispatcher.read() ;
            let contractAddress = get_contract_address() ;
            let player = get_caller_address() ;
            let owner = get!(world, (contractAddress, player), (Owner)) ;
            assert(owner.isSure, 'Illegal operation') ;
        }

        fn changeAdmin(
            self: @ContractState,
            admin: ContractAddress
        ) {
            let world = self.world_dispatcher.read() ;
            let contractAddress = get_contract_address() ;
            let player = get_caller_address() ;
            let owner = get!(world, ( contractAddress, player ), (Owner)) ;
            self.assertAdminRole() ;

            let mut oldAdmin = get!(world, ( contractAddress, admin ), (Owner)) ;
            oldAdmin.isSure = !oldAdmin.isSure ;
            set!(world, (oldAdmin)) ;
        }

        fn changeStatus(
            self: @ContractState,
        ) {
            self.assertAdminRole() ;
            let world = self.world_dispatcher.read() ;
            let contractAddress = get_contract_address() ;
            let mut config = get!(world, contractAddress, (Config)) ;
            config.pause = !config.pause ;
            set!(world, (config)) ;
        }

        fn changeMultiple(
            self: @ContractState,
            newMultiple: u256        
        ) {
            self.assertAdminRole() ;
            let world = self.world_dispatcher.read() ;
            let contractAddress = get_contract_address() ;
            let mut config = get!(world, contractAddress, (Config)) ;
            config.multiple = newMultiple ;
            set!(world, (config)) ;
        }

        fn mint(
            self: @ContractState,
            tokenURI: felt252
        ) {
            let world = self.world_dispatcher.read() ;
            let contractAddress = get_contract_address();
            let config = get!(world, contractAddress, (Config)) ;
            assert(!config.tokenContractAddr.is_zero(), 'Not yet initialized') ;

            // store record
            let player = get_caller_address() ;
            let mut mintRecords = get!( world, ( contractAddress, player ), (MintRecords)) ;
            mintRecords.mintCount = mintRecords.mintCount + 1;
            set!(world, (mintRecords)) ;

            // init params 
            let mut call_data: Array<felt252> = ArrayTrait::new();
            Serde::serialize(@player, ref call_data);
            Serde::serialize(@tokenURI, ref call_data);
            let mut res = starknet::call_contract_syscall(
                config.tokenContractAddr, selector!("mint"), call_data.span()
            ).unwrap_syscall();
        }

        fn player(
            self: @ContractState,
            id: u256
        ) {
            let world = self.world_dispatcher.read() ;
            let contractAddress = get_contract_address() ; 
            let player = get_caller_address() ;

            let mintRecords = get!(world, ( contractAddress, player ), (MintRecords)) ;
            assert(mintRecords.mintCount > 0,'No NFT available') ;

            let mut score = get!(world, (contractAddress, player), (Score)) ;
            let mut win:bool = true ;
            let mut newScoreValue:u256 = score.scoreValue ;
            if(newScoreValue < 10000) {
                newScoreValue = newScoreValue + 50 ;
            } else if(newScoreValue < 20000) {
                let timestap = get_block_timestamp() ;
                win = (timestap % 2) == 0 ;

                if(win) {
                   newScoreValue = newScoreValue + 200 ;
                } else {
                   newScoreValue = newScoreValue - 1000 ;
                }

            } else {
                let timestap = get_block_timestamp() ;
                win = (timestap % 9) == 0 ;

                if(win) {
                   newScoreValue = newScoreValue + 500 ;
                } else {
                   newScoreValue = newScoreValue - 3000 ;
                }

            }
        
            // store data 
            score.scoreValue = newScoreValue ;
            set!(world, ( score, Records { contractAddress, id, win } )) ;
        }

        fn setTestData(
            self: @ContractState, 
            newData: u128 
        ) {
            let player = get_caller_address() ;
            let world = self.world_dispatcher.read() ;
            let mut testData = get!(world, ( player ), ( TestData )) ;
            testData.data = newData ;
            set!(world, ( testData )) ;
        }

        fn setTestData2(
            self: @ContractState
        ) {

        }
    }
}