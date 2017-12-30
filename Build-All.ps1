$ErrorActionPreference = "Stop"

# set build variables
.\tools\Start-VSDevCmd.ps1

$vsfolder = "vs2017"

# root dependency
msbuild .\modules\libbitcoin\builds\msvc\$vsfolder\libbitcoin.sln
# other root dependency
msbuild .\modules\libbitcoin-consensus\builds\msvc\$vsfolder\libbitcoin-consensus.sln

# level 1 
msbuild .\modules\libbitcoin-database\builds\msvc\$vsfolder\libbitcoin-database.sln
msbuild .\modules\libbitcoin-network\builds\msvc\$vsfolder\libbitcoin-network.sln
msbuild .\modules\libbitcoin-protocol\builds\msvc\$vsfolder\libbitcoin-protocol.sln

# level 2
msbuild .\modules\libbitcoin-blockchain\builds\msvc\$vsfolder\libbitcoin-blockchain.sln

# level 3
msbuild .\modules\libbitcoin-node\builds\msvc\$vsfolder\libbitcoin-node.sln

# level 4
msbuild .\modules\libbitcoin-server\builds\msvc\$vsfolder\libbitcoin-server.sln