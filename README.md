<picture>
  <source media="(prefers-color-scheme: dark)" srcset=".github/mark-dark.svg">
  <img alt="Dojo logo" align="right" width="120" src=".github/mark-light.svg">
</picture>[readme.md](https://github.com/creayCryptor/unity-dojo-contract/files/13795341/readme.md)

How to verify minted NFT in craftpunk

## Install starkli client
```
curl https://get.starkli.sh | sh
```
## Restart the terminal
## Execute starkliup command
## Restart the terminal
## Execute starkli --version to view the starkli version number


## View account NFT balance
```
starkli call 0x06fc941fec3ef5929d73b6213a66e98b5d7088a07942ece4eb96875b816fe430 balanceOf 0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973
```

## Query the owner based on tokenId

```
starkli call 0x06fc941fec3ef5929d73b6213a66e98b5d7088a07942ece4eb96875b816fe430 ownerOf u256:62
```

## Query tokenUri based on tokenId
```
starkli call 0x06fc941fec3ef5929d73b6213a66e98b5d7088a07942ece4eb96875b816fe430 token_uri u256:62
```
## Parsing NFT short strings
```
starkli parse-cairo-string 0x000000000000687474703a2f2f35322e3139362e3235312e3130362f6a2f3534
```

## Get the corresponding nft attribute information based on url
```
curl http://52.196.251.106/j/54

{
    "name":"spaceship #54", 
    "image":"http://52.196.251.106/images/ef57ce656be60bcfae725f0f5c3aa944.png", 
    "attributes":[ 
        {"trait_type":"level","value":3},    
        {"trait_type":"quality","value":3},  
        {"trait_type":"gas","value":5},      
        {"trait_type":"rigidity","value":85} 
    ]
}
```
## Get the  provable battle results zkp txt
```
curl http://52.196.251.106/battle/hash

{
    "hash":"hash", 
    "result":"loss"
    
}
```

<a href="https://twitter.com/dojostarknet">
<img src="https://img.shields.io/twitter/follow/dojostarknet?style=social"/>
</a>
<a href="https://github.com/dojoengine/dojo">
<img src="https://img.shields.io/github/stars/dojoengine/dojo?style=social"/>
</a>

[![discord](https://img.shields.io/badge/join-dojo-green?logo=discord&logoColor=white)](https://discord.gg/PwDa2mKhR4)
[![Telegram Chat][tg-badge]][tg-url]

[tg-badge]: https://img.shields.io/endpoint?color=neon&logo=telegram&label=chat&style=flat-square&url=https%3A%2F%2Ftg.sumanjay.workers.dev%2Fdojoengine
[tg-url]: https://t.me/dojoengine

# Dojo Starter: Official Guide

The official Dojo Starter guide, the quickest and most streamlined way to get your Dojo Autonomous World up and running. This guide will assist you with the initial setup, from cloning the repository to deploying your world.

Read the full tutorial [here](https://book.dojoengine.org/cairo/hello-dojo.html)

---

## Contribution

The main body of the project is developed by the unity-dojo library.
It is the first practice of perfecting the dojo-unity library plug-in and opening up the difference between the unity engine and full-chain games.
Usage can be referred to
https://github.com/dojoengine/dojo.unity

1. **Report a Bug**

    - If you think you have encountered a bug, and we should know about it, feel free to report it [here](https://github.com/dojoengine/dojo-starter/issues) and we will take care of it.

2. **Request a Feature**

    - You can also request for a feature [here](https://github.com/dojoengine/dojo-starter/issues), and if it's viable, it will be picked for development.

3. **Create a Pull Request**
    - It can't get better then this, your pull request will be appreciated by the community.

For any other questions, feel free to reach out to us [here](https://dojoengine.org/contact).

Happy coding!
