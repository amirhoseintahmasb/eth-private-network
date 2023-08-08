#!/bin/bash

# Creation of the genesis block of our ethereum network
geth init --datadir . ./genesis.json

# Setup the account
geth account import --password ./password --datadir . ./*.prv  

# Run node
echo "Peer : ${peer_env}"

if [ "$peer_env" == "none" ];
then                                                                                            
    geth --identity=$identity_env --datadir . --networkid 9511 --unlock=0x1DbDD701Fa93B5349925C2DE81990F488aD9155C --mine  --miner.etherbase=0x1DbDD701Fa93B5349925C2DE81990F488aD9155C --http --http.corsdomain "*" --http.port $rpcport_env --http.addr 0.0.0.0 --http.api eth,web3,net,personal,admin,miner --nat "any" --ipcdisable  --maxpeers 1  --password ./password --allow-insecure-unlock
else 
    geth --identity=$identity_env --datadir . --networkid 9511 --unlock=0x1DbDD701Fa93B5349925C2DE81990F488aD9155C --mine  --miner.etherbase=0x1DbDD701Fa93B5349925C2DE81990F488aD9155C --http --http.corsdomain "*" --http.port $rpcport_env --http.addr 0.0.0.0 --http.api eth,web3,net,personal,admin,miner --nat "any" --ipcdisable  --maxpeers 1 --password ./password --allow-insecure-unlock --bootnodes $peer_env
fi
