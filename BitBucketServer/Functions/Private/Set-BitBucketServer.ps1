#requires -Module Helpers

function Set-BitBucketServer {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Url
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $User
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Token = (Read-Host -Prompt 'Password' -AsSecureString | Get-PlaintextFromSecureString)
    )
    
    begin {
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
    }

    process {
        if ($Force -or $PSCmdlet.ShouldProcess("Update credentials to user URL '$Url' and user '$User'?")) {
            $script:BitBucketServerUrl   = $Url
            $script:BitBucketServerUser  = $User
            $script:BitBucketServerToken = $Token
        }
    }
}
