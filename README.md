[readMe.md](https://github.com/creayCryptor/unity-dojo-contract/files/13797445/readMe.md)<picture>
  <source media="(prefers-color-scheme: dark)" srcset=".github/mark-dark.svg">
  <img alt="Dojo logo" align="right" width="120" src=".github/mark-light.svg">
</picture>[readme.md](https://github.com/creayCryptor/unity-dojo-contract/files/13795341/readme.md)

How to verify minted NFT in craftpunk

[Uploading re## 部署 NFT 时, admin 账号信息


## Install starkli client
```
curl https://get.starkli.sh | sh
```

## Restart the terminal
## excute starkliup 
## Restart terminal
## excute starkli --version starkli 

![image-1](https://github.com/creayCryptor/unity-dojo-contract/assets/155175555/ee54d109-a63c-431d-aaf0-d4ddd6596654)

## Append environment path

<img width="798" alt="image-2" src="https://github.com/creayCryptor/unity-dojo-contract/assets/155175555/c6765614-fc40-4c43-b6ec-566ae7851a37">

## Check account NFT balance
```
starkli call 0x064ce5d864bd1541a009ec11af78994172129bc51eea5a4a4335d260d81d9c60 balanceOf 0x517ececd29116499f4a1b64b094da79ba08dfd54a3edaa316134c41f8160973
```
![image-6](https://github.com/creayCryptor/unity-dojo-contract/assets/155175555/7ce2bf45-76ed-46ce-af0a-eb1439bbd915)


## Query the owner based on tokenId
```
starkli call 0x064ce5d864bd1541a009ec11af78994172129bc51eea5a4a4335d260d81d9c60 ownerOf u256:7
```
![image-7](https://github.com/creayCryptor/unity-dojo-contract/assets/155175555/0444922b-6842-469e-bb47-c904b94121dd)


## Query tokenUri based on tokenId
‵‵`
starkli call 0x064ce5d864bd1541a009ec11af78994172129bc51eea5a4a4335d260d81d9c60 token_uri u256:2
![image-8](https://github.com/creayCryptor/unity-dojo-contract/assets/155175555/ed936d04-ab2f-4b45-bc19-81b83a3c6cb7)


## Query battle zero-knowledge proof results
```
starkli parse-cairo-string 0x000000000000687474703a2f2f35322e3139362e3235312e3130362f6a2f3534
```
![Alt text](image-9.png)

## Get the battle zero-knowledge proof results
```
curl http://52.196.251.106/verify/zkp

{
    "reslut":"win", 
}

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
    ]}

```adMe.md…]()


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
