param(
    [Parameter()]
    [ValidateSet('vs2013','vs2015', 'vs2017')]
    [string]
    $vsFolder = 'vs2017',
    [Parameter()]
    [ValidateSet('x64','Win32')]
    [string]
    $targetPlatform = 'x64',
    [Parameter()]
    [ValidateSet('StaticDebug','StaticRelease')]
    [string]
    $targetConfiguration = 'StaticDebug'
)
# change MS annoying default value
$ErrorActionPreference = "Stop"
# Set build environment variables
.\tools\Start-VSDevCmd.ps1

function Build-Solution ($solutionPath) {
    # be aware that powershell is insane when passing arguments to executables
    # this works but is sensitive
    & msbuild /m /p:Platform=$targetPlatform /p:Configuration=$targetConfiguration $solutionPath
}

# root dependency
Build-Solution .\modules\libbitcoin\builds\msvc\$vsfolder\libbitcoin.sln
# other root dependency
Build-Solution .\modules\libbitcoin-consensus\builds\msvc\$vsfolder\libbitcoin-consensus.sln

# level 1 
Build-Solution .\modules\libbitcoin-database\builds\msvc\$vsfolder\libbitcoin-database.sln
Build-Solution .\modules\libbitcoin-network\builds\msvc\$vsfolder\libbitcoin-network.sln
Build-Solution .\modules\libbitcoin-protocol\builds\msvc\$vsfolder\libbitcoin-protocol.sln

# level 2
Build-Solution .\modules\libbitcoin-blockchain\builds\msvc\$vsfolder\libbitcoin-blockchain.sln

# level 3
Build-Solution .\modules\libbitcoin-node\builds\msvc\$vsfolder\libbitcoin-node.sln

# level 4
Build-Solution .\modules\libbitcoin-server\builds\msvc\$vsfolder\libbitcoin-server.sln