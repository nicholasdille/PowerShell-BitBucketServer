$script:BitBucketServerUrl   = ''
$script:BitBucketServerUser  = ''
$script:BitBucketServerToken = ''

Get-ChildItem -Path "$PSScriptRoot" -Filter '*.ps1' -Recurse | ForEach-Object {
    . "$($_.FullName)"
}