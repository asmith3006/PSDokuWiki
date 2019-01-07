﻿function Get-DokuTitle {
<#
	.SYNOPSIS
		Returns the title of the wiki

	.DESCRIPTION
		Returns the title of the wiki

	.PARAMETER DokuSession
		The DokuSession (generated by New-DokuSession) from which to get the wiki title.

	.EXAMPLE
		PS C:\> $DokuTitleObj = Get-DokuTitle -DokuSession $DokuSession

	.EXAMPLE
		PS C:\> $DokuTitleObj = Get-DokuTitle -DokuSession $DokuSession

	.OUTPUTS
		System.Management.Automation.PSObject

	.NOTES
		AndyDLP - 2018-05-26
		Test
#>

	[CmdletBinding(PositionalBinding = $true)]
	[OutputType([psobject])]
	param
	(
		[Parameter(Mandatory = $true,
				   Position = 1,
				   ValueFromPipeline = $true,
				   HelpMessage = 'The DokuSession from which to get the wiki title.')]
		[ValidateNotNullOrEmpty()]
		[psobject]$DokuSession
	)

	begin {

	} # begin

	process {
		$payload = (ConvertTo-XmlRpcMethodCall -Name "dokuwiki.getTitle") -replace "<value></value>", ""
		if ($DokuSession.SessionMethod -eq "HttpBasic") {
			$httpResponse = Invoke-WebRequest -Uri $DokuSession.TargetUri -Method Post -Headers $DokuSession.Headers -Body $payload -ErrorAction Stop
		} else {
			$httpResponse = Invoke-WebRequest -Uri $DokuSession.TargetUri -Method Post -Headers $DokuSession.Headers -Body $payload -ErrorAction Stop -WebSession $DokuSession.WebSession
		}
		[string]$DokuTitle = ([xml]$httpResponse.Content | Select-Xml -XPath "//value/string").node.InnerText
		$Titlebject = New-Object PSObject -Property @{
			Server = $DokuSession.Server
			Title = $DokuTitle
		}
		$Titlebject
	} # process

	end {

	} # end
}