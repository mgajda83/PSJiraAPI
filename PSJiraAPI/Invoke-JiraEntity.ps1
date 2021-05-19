Function Invoke-JiraEntity
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)] 
        [Alias('self')]   
        [String]$Uri,
        [Parameter()]
        [ValidateSet("GET","POST","PUT","DELETE")]
        [String]$Method = "GET",
        [Parameter(Mandatory)]
        $Headers,
        [Parameter()]
        $Body
    )

    Begin
    {
        $Responses = @()
    }

    Process
    {
        $RestParameters = @{
            Uri = $Uri
            ContentType = "application/json"
            Method = $Method
            Headers = $Headers
            Body = $Body
        }

        try {
            $Responses += Invoke-RestMethod @restParameters 
            if($Method -ne "GET")
            {
                Start-Sleep -seconds 1      #Api Jiry czasem nie wyrabia i jak zbyt szybko się wysyła modyfikacje to wywala blad ze nie znaleziono elementu
            }
        }
        catch {
            Write-Error $_ #-ErrorAction Stop
        }
    }

    End
    {
        Return $Responses
    }
}
