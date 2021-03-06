@{
    RootModule = 'BitBucketServer.psm1'
    ModuleVersion = '0.5.0'
    GUID = '49685ee4-411d-4f9e-b9c4-b79545437e3b'
    Author = 'Nicholas Dille'
    #CompanyName = ''
    Copyright = '(c) 2017 Nicholas Dille. All rights reserved.'
    Description = 'Cmdlets for Atlassian BitBucket Server'
    # PowerShellVersion = ''
    RequiredModules = @(
        @{
            ModuleName = 'Helpers'
            RequiredVersion = '0.4.0.24'
        }
    )
    FunctionsToExport = @(
        'Set-BitBucketServer'
        'Get-BitBucketServerGroup'
        'Get-BitBucketServerProject'
        'Get-BitBucketServerRepository'
        'Get-BitBucketServerUser'
    )
    CmdletsToExport = @()
    VariablesToExport = '*'
    AliasesToExport = @()
    #FormatsToProcess = @()
    PrivateData = @{
        PSData = @{
            # Tags = @()
            # LicenseUri = ''
            # ProjectUri = ''
            # ReleaseNotes = ''
        }
    }
}

