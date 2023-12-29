use starknet::ContractAddress;

#[derive(Model, Drop, Serde)]
struct Config {
    #[key]
    contractAddress: ContractAddress,

    tokenContractAddr: ContractAddress,

    multiple: u256,

    pause: bool
}

#[derive(Model, Drop, Serde)]
struct Owner {
    #[key]
    contractAddress: ContractAddress,

    #[key]
    admin: ContractAddress,

    isSure: bool
}

#[derive(Model, Drop, Serde)]
struct Score {
    #[key]
    contractAddress: ContractAddress,

    #[key]
    player: ContractAddress,

    scoreValue: u256
}

#[derive(Model, Drop, Serde)]
struct Records {
    #[key]
    contractAddress: ContractAddress,
    
    #[key]
    id: u256,

    win: bool
}


#[derive(Model, Drop, Serde)]
struct MintRecords {
    #[key]
    contractAddress: ContractAddress,
    
    #[key]
    player: ContractAddress,

    mintCount: u256
}

#[derive(Model, Drop, Serde)]
struct TestData {
    #[key]
    contractAddress: ContractAddress,
    
    data: u128
}