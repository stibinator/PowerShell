
# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Gets information about a database.
.Description
Gets information about a database.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/get-azmysqldatabase
#>
function Get-AzMySqlDatabase {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase])]
[CmdletBinding(DefaultParameterSetName='List', PositionalBinding=$false)]
param(
    [Parameter(ParameterSetName='Get', Mandatory)]
    [Alias('DatabaseName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the database.
    ${Name},

    [Parameter(ParameterSetName='Get', Mandatory)]
    [Parameter(ParameterSetName='List', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Get', Mandatory)]
    [Parameter(ParameterSetName='List', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Get')]
    [Parameter(ParameterSetName='List')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String[]]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='GetViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Get = 'Az.MySql.private\Get-AzMySqlDatabase_Get';
            GetViaIdentity = 'Az.MySql.private\Get-AzMySqlDatabase_GetViaIdentity';
            List = 'Az.MySql.private\Get-AzMySqlDatabase_List';
        }
        if (('Get', 'List') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Gets a server key.
.Description
Gets a server key.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerKey
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/get-azmysqlflexibleserverkey
#>
function Get-AzMySqlFlexibleServerKey {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerKey])]
[CmdletBinding(DefaultParameterSetName='List', PositionalBinding=$false)]
param(
    [Parameter(ParameterSetName='Get', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server key.
    ${KeyName},

    [Parameter(ParameterSetName='Get', Mandatory)]
    [Parameter(ParameterSetName='List', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Get', Mandatory)]
    [Parameter(ParameterSetName='List', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Get')]
    [Parameter(ParameterSetName='List')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String[]]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='GetViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Get = 'Az.MySql.private\Get-AzMySqlFlexibleServerKey_Get';
            GetViaIdentity = 'Az.MySql.private\Get-AzMySqlFlexibleServerKey_GetViaIdentity';
            List = 'Az.MySql.private\Get-AzMySqlFlexibleServerKey_List';
        }
        if (('Get', 'List') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Get capabilities at specified location in a given subscription.
.Description
Get capabilities at specified location in a given subscription.
.Example
PS C:\> Get-AzMySqlFlexibleServerLocationBasedCapability -Location westus2
"Please refer to https://aka.ms/mysql-pricing for pricing details"

SKU               Tier            Memory vCore
---               ----            ------ -----
Standard_B1s      Burstable         1024     1
Standard_B1ms     Burstable         2048     1
Standard_B2s      Burstable         2048     2
Standard_D2ds_v4  GeneralPurpose    4096     2
Standard_D4ds_v4  GeneralPurpose    4096     4
Standard_D8ds_v4  GeneralPurpose    4096     8
Standard_D16ds_v4 GeneralPurpose    4096    16
Standard_D32ds_v4 GeneralPurpose    4096    32
Standard_D48ds_v4 GeneralPurpose    4096    48
Standard_D64ds_v4 GeneralPurpose    4096    64
Standard_E2ds_v4  MemoryOptimized   8192     2
Standard_E4ds_v4  MemoryOptimized   8192     4
Standard_E8ds_v4  MemoryOptimized   8192     8
Standard_E16ds_v4 MemoryOptimized   8192    16
Standard_E32ds_v4 MemoryOptimized   8192    32
Standard_E48ds_v4 MemoryOptimized   8192    48
Standard_E64ds_v4 MemoryOptimized   8192    64


.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.ICapabilityProperties
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/get-azmysqlflexibleserverlocationbasedcapability
#>
function Get-AzMySqlFlexibleServerLocationBasedCapability {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.ICapabilityProperties])]
[CmdletBinding(DefaultParameterSetName='List', PositionalBinding=$false)]
param(
    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the location.
    ${LocationName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String[]]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            List = 'Az.MySql.private\Get-AzMySqlFlexibleServerLocationBasedCapability_List';
        }
        if (('List') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Get virtual network subnet usage for a given vNet resource id.
.Description
Get virtual network subnet usage for a given vNet resource id.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IVirtualNetworkSubnetUsageParameter
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IDelegatedSubnetUsage
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IVirtualNetworkSubnetUsageParameter>: Virtual network subnet usage parameter
  [VirtualNetworkArmResourceId <String>]: Virtual network resource id.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/get-azmysqlflexibleservervirtualnetworksubnetusage
#>
function Get-AzMySqlFlexibleServerVirtualNetworkSubnetUsage {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IDelegatedSubnetUsage])]
[CmdletBinding(DefaultParameterSetName='GetExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Get', Mandatory)]
    [Parameter(ParameterSetName='GetExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the location.
    ${LocationName},

    [Parameter(ParameterSetName='Get')]
    [Parameter(ParameterSetName='GetExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String[]]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='GetViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='GetViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Get', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='GetViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IVirtualNetworkSubnetUsageParameter]
    # Virtual network subnet usage parameter
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='GetExpanded')]
    [Parameter(ParameterSetName='GetViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Virtual network resource id.
    ${VirtualNetworkArmResourceId},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Get = 'Az.MySql.private\Get-AzMySqlFlexibleServerVirtualNetworkSubnetUsage_Get';
            GetExpanded = 'Az.MySql.private\Get-AzMySqlFlexibleServerVirtualNetworkSubnetUsage_GetExpanded';
            GetViaIdentity = 'Az.MySql.private\Get-AzMySqlFlexibleServerVirtualNetworkSubnetUsage_GetViaIdentity';
            GetViaIdentityExpanded = 'Az.MySql.private\Get-AzMySqlFlexibleServerVirtualNetworkSubnetUsage_GetViaIdentityExpanded';
        }
        if (('Get', 'GetExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
List all the performance tiers at specified location in a given subscription.
.Description
List all the performance tiers at specified location in a given subscription.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IPerformanceTierProperties
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/get-azmysqllocationbasedperformancetier
#>
function Get-AzMySqlLocationBasedPerformanceTier {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IPerformanceTierProperties])]
[CmdletBinding(DefaultParameterSetName='List', PositionalBinding=$false)]
param(
    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the location.
    ${LocationName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String[]]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            List = 'Az.MySql.private\Get-AzMySqlLocationBasedPerformanceTier_List';
        }
        if (('List') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
List all the log files in a given server.
.Description
List all the log files in a given server.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.ILogFile
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/get-azmysqllogfile
#>
function Get-AzMySqlLogFile {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.ILogFile])]
[CmdletBinding(DefaultParameterSetName='List', PositionalBinding=$false)]
param(
    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String[]]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            List = 'Az.MySql.private\Get-AzMySqlLogFile_List';
        }
        if (('List') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Lists all of the available REST API operations.
.Description
Lists all of the available REST API operations.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IOperation
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IOperationListResultAutoGenerated
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/get-azmysqloperation
#>
function Get-AzMySqlOperation {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IOperation], [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IOperationListResultAutoGenerated])]
[CmdletBinding(DefaultParameterSetName='List', PositionalBinding=$false)]
param(
    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            List = 'Az.MySql.private\Get-AzMySqlOperation_List';
            List1 = 'Az.MySql.private\Get-AzMySqlOperation_List1';
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Gets information about a AAD server administrator.
.Description
Gets information about a AAD server administrator.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerAdministratorResource
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/get-azmysqlserveradministrator
#>
function Get-AzMySqlServerAdministrator {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerAdministratorResource])]
[CmdletBinding(DefaultParameterSetName='Get', PositionalBinding=$false)]
param(
    [Parameter(ParameterSetName='Get', Mandatory)]
    [Parameter(ParameterSetName='List', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Get', Mandatory)]
    [Parameter(ParameterSetName='List', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Get')]
    [Parameter(ParameterSetName='List')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String[]]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='GetViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Get = 'Az.MySql.private\Get-AzMySqlServerAdministrator_Get';
            GetViaIdentity = 'Az.MySql.private\Get-AzMySqlServerAdministrator_GetViaIdentity';
            List = 'Az.MySql.private\Get-AzMySqlServerAdministrator_List';
        }
        if (('Get', 'List') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Get a server's security alert policy.
.Description
Get a server's security alert policy.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerSecurityAlertPolicy
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/get-azmysqlserversecurityalertpolicy
#>
function Get-AzMySqlServerSecurityAlertPolicy {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerSecurityAlertPolicy])]
[CmdletBinding(DefaultParameterSetName='Get', PositionalBinding=$false)]
param(
    [Parameter(ParameterSetName='Get', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Get', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Get')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String[]]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='GetViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Returns true when the command succeeds
    ${PassThru},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Get = 'Az.MySql.private\Get-AzMySqlServerSecurityAlertPolicy_Get';
            GetViaIdentity = 'Az.MySql.private\Get-AzMySqlServerSecurityAlertPolicy_GetViaIdentity';
        }
        if (('Get') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Updates a configuration of a server.
.Description
Updates a configuration of a server.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IConfiguration
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IConfiguration
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IConfiguration>: Represents a Configuration.
  [Source <String>]: Source of the configuration.
  [Value <String>]: Value of the configuration.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlconfiguration
#>
function New-AzMySqlConfiguration {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IConfiguration])]
[CmdletBinding(DefaultParameterSetName='CreateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Alias('ConfigurationName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server configuration.
    ${Name},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Create')]
    [Parameter(ParameterSetName='CreateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Create', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IConfiguration]
    # Represents a Configuration.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Source of the configuration.
    ${Source},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Value of the configuration.
    ${Value},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Create = 'Az.MySql.private\New-AzMySqlConfiguration_Create';
            CreateExpanded = 'Az.MySql.private\New-AzMySqlConfiguration_CreateExpanded';
            CreateViaIdentity = 'Az.MySql.private\New-AzMySqlConfiguration_CreateViaIdentity';
            CreateViaIdentityExpanded = 'Az.MySql.private\New-AzMySqlConfiguration_CreateViaIdentityExpanded';
        }
        if (('Create', 'CreateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates a new database or updates an existing database.
.Description
Creates a new database or updates an existing database.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IDatabase>: Represents a Database.
  [Charset <String>]: The charset of the database.
  [Collation <String>]: The collation of the database.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqldatabase
#>
function New-AzMySqlDatabase {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase])]
[CmdletBinding(DefaultParameterSetName='CreateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Alias('DatabaseName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the database.
    ${Name},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Create')]
    [Parameter(ParameterSetName='CreateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Create', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase]
    # Represents a Database.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The charset of the database.
    ${Charset},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The collation of the database.
    ${Collation},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Create = 'Az.MySql.private\New-AzMySqlDatabase_Create';
            CreateExpanded = 'Az.MySql.private\New-AzMySqlDatabase_CreateExpanded';
            CreateViaIdentity = 'Az.MySql.private\New-AzMySqlDatabase_CreateViaIdentity';
            CreateViaIdentityExpanded = 'Az.MySql.private\New-AzMySqlDatabase_CreateViaIdentityExpanded';
        }
        if (('Create', 'CreateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates a new firewall rule or updates an existing firewall rule.
.Description
Creates a new firewall rule or updates an existing firewall rule.
.Example
PS C:\> New-AzMySqlFirewallRule -Name rule -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -EndIPAddress 0.0.0.1 -StartIPAddress 0.0.0.0

Name StartIPAddress EndIPAddress
---- -------------- ------------
rule 0.0.0.0        0.0.0.1
.Example
PS C:\> New-AzMySqlFirewallRule -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -ClientIPAddress 0.0.0.1

Name                                StartIPAddress EndIPAddress
----                                -------------- ------------
ClientIPAddress_2020-08-11_18-19-27 0.0.0.1        0.0.0.1
.Example
PS C:\> New-AzMySqlFirewallRule -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -AllowAll

Name                         StartIPAddress EndIPAddress
----                         -------------- ------------
AllowAll_2020-08-11_18-19-27 0.0.0.0        255.255.255.255

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IFirewallRule>: Represents a server firewall rule.
  EndIPAddress <String>: The end IP address of the server firewall rule. Must be IPv4 format.
  StartIPAddress <String>: The start IP address of the server firewall rule. Must be IPv4 format.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlfirewallrule
#>
function New-AzMySqlFirewallRule {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule])]
[CmdletBinding(DefaultParameterSetName='CreateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Alias('FirewallRuleName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server firewall rule.
    ${Name},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Create')]
    [Parameter(ParameterSetName='CreateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Create', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule]
    # Represents a server firewall rule.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The end IP address of the server firewall rule.
    # Must be IPv4 format.
    ${EndIPAddress},

    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The start IP address of the server firewall rule.
    # Must be IPv4 format.
    ${StartIPAddress},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Create = 'Az.MySql.private\New-AzMySqlFirewallRule_Create';
            CreateExpanded = 'Az.MySql.private\New-AzMySqlFirewallRule_CreateExpanded';
            CreateViaIdentity = 'Az.MySql.private\New-AzMySqlFirewallRule_CreateViaIdentity';
            CreateViaIdentityExpanded = 'Az.MySql.private\New-AzMySqlFirewallRule_CreateViaIdentityExpanded';
        }
        if (('Create', 'CreateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates a new database or updates an existing database.
.Description
Creates a new database or updates an existing database.
.Example
PS C:\> New-AzMySqlFlexibleServerDatabase -Name databasetest -ResourceGroupName PowershellMySqlTest -ServerName mysql-test

Name            Charset     Collation              
----            -------- ------------------
databasetest   latin1   latin1_swedish_ci  

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IDatabase>: Represents a Database.
  [Charset <String>]: The charset of the database.
  [Collation <String>]: The collation of the database.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlflexibleserverdatabase
#>
function New-AzMySqlFlexibleServerDatabase {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase])]
[CmdletBinding(DefaultParameterSetName='CreateViaIdentity', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Create', Mandatory)]
    [Alias('DatabaseName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the database.
    ${Name},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Create')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase]
    # Represents a Database.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Create = 'Az.MySql.private\New-AzMySqlFlexibleServerDatabase_Create';
            CreateViaIdentity = 'Az.MySql.private\New-AzMySqlFlexibleServerDatabase_CreateViaIdentity';
        }
        if (('Create') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates a new firewall rule or updates an existing firewall rule.
.Description
Creates a new firewall rule or updates an existing firewall rule.
.Example
PS C:\> New-AzMySqlFlexibleServerFirewallRule -Name firewallrule-test -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -EndIPAddress 0.0.0.1 -StartIPAddress 0.0.0.0

Name              StartIPAddress EndIPAddress
----------------- -------------- ------------
firewallrule-test 0.0.0.0        0.0.0.1
.Example
PS C:\> New-AzMySqlFlexibleServerFirewallRule -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -ClientIPAddress 0.0.0.1

Name                                StartIPAddress EndIPAddress
----                                -------------- ------------
ClientIPAddress_2020-08-11_18-19-27 0.0.0.1        0.0.0.1
.Example
PS C:\> New-AzMySqlFlexibleServerFirewallRule -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -AllowAll

Name                         StartIPAddress EndIPAddress
----                         -------------- ------------
AllowAll_2020-08-11_18-19-27 0.0.0.0        255.255.255.255

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IFirewallRule>: Represents a server firewall rule.
  EndIPAddress <String>: The end IP address of the server firewall rule. Must be IPv4 format.
  StartIPAddress <String>: The start IP address of the server firewall rule. Must be IPv4 format.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlflexibleserverfirewallrule
#>
function New-AzMySqlFlexibleServerFirewallRule {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule])]
[CmdletBinding(DefaultParameterSetName='CreateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Alias('FirewallRuleName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server firewall rule.
    ${Name},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Create')]
    [Parameter(ParameterSetName='CreateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Create', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule]
    # Represents a server firewall rule.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The end IP address of the server firewall rule.
    # Must be IPv4 format.
    ${EndIPAddress},

    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The start IP address of the server firewall rule.
    # Must be IPv4 format.
    ${StartIPAddress},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Create = 'Az.MySql.private\New-AzMySqlFlexibleServerFirewallRule_Create';
            CreateExpanded = 'Az.MySql.private\New-AzMySqlFlexibleServerFirewallRule_CreateExpanded';
            CreateViaIdentity = 'Az.MySql.private\New-AzMySqlFlexibleServerFirewallRule_CreateViaIdentity';
            CreateViaIdentityExpanded = 'Az.MySql.private\New-AzMySqlFlexibleServerFirewallRule_CreateViaIdentityExpanded';
        }
        if (('Create', 'CreateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates or updates a MySQL Server key.
.Description
Creates or updates a MySQL Server key.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerKey
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerKey
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IServerKey>: A MySQL Server key.
  [Uri <String>]: The URI of the key.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlflexibleserverkey
#>
function New-AzMySqlFlexibleServerKey {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerKey])]
[CmdletBinding(DefaultParameterSetName='CreateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server key.
    ${KeyName},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Create')]
    [Parameter(ParameterSetName='CreateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Create', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerKey]
    # A MySQL Server key.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The URI of the key.
    ${Uri},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Create = 'Az.MySql.private\New-AzMySqlFlexibleServerKey_Create';
            CreateExpanded = 'Az.MySql.private\New-AzMySqlFlexibleServerKey_CreateExpanded';
            CreateViaIdentity = 'Az.MySql.private\New-AzMySqlFlexibleServerKey_CreateViaIdentity';
            CreateViaIdentityExpanded = 'Az.MySql.private\New-AzMySqlFlexibleServerKey_CreateViaIdentityExpanded';
        }
        if (('Create', 'CreateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates a new server or updates an existing server.
The update action will overwrite the existing server.
.Description
Creates a new server or updates an existing server.
The update action will overwrite the existing server.
.Example
PS C:\> New-AzMySqlFlexibleServer -Name mysql-test -ResourceGroupName PowershellMySqlTest \
-Location eastus -AdministratorUserName mysqltest -AdministratorLoginPassword $password -Sku Standard_B1ms -SkuTier Burstable -Version 12 -StorageInMb 10240 -PublicAccess none

Checking the existence of the resource group PowershellMySqlTest ...
Resource group PowershellMySqlTest exists ? : True
Creating MySQL server mysql-test in group MySqlTest...
Your server mysql-test is using sku Standard_B1ms (Paid Tier). Please refer to https://aka.ms/mysql-pricing for pricing details

Name             Location  SkuName       SkuTier   AdministratorLogin Version StorageProfileStorageMb
----             --------  -------       -------   ------------------ ------- -----------------------
mysql-test       West US 2 Standard_B1ms Burstable mysqltest          5.7     10240

.Example
PS C:\> New-AzMySqlFlexibleServer

Creating resource group group00000000...
Creating new vnet VNETserver00000000 in resource group group00000000
Creating new subnet Subnetserver00000000 in resource group group00000000 and delegating it to Microsoft.DBforMySQL/flexibleServers
Creating MySQL server server00000000 in group group00000000...
Your server mysql-test is using sku Standard_B1ms (Paid Tier). Please refer to https://aka.ms/mysql-pricing for pricing details
Creating database flexibleserverdb...

Name             Location  SkuName       SkuTier   AdministratorLogin Version StorageProfileStorageMb
----             --------  -------       -------   ------------------ ------- -----------------------
mysql-test       West US 2 Standard_B1ms Burstable mysqltest          5.7     10240
.Example
PS C:\> $Vnet = 'vnetname'
PS C:\> New-AzMySqlFlexibleServer -ResourceGroupName PowershellMySqlTest -Vnet $Vnet

or

PS C:\> $Vnet = '/subscriptions/00000000-0000-0000-0000-0000000000/resourceGroups/PowershellMySqlTest/providers/Microsoft.Network/virtualNetworks/vnetname'
PS C:\> New-AzMySqlFlexibleServer  -ResourceGroupName PowershellMySqlTest -Vnet $Vnet

Resource group PowershellMySqlTest exists ? : True
You have supplied a vnet Id/name. Verifying its existence...
Creating new vnet vnetname in resource group PowershellMySqlTest
Creating new subnet Subnetserver00000000 in resource group PowershellMySqlTest and delegating it to Microsoft.DBforMySQL/flexibleServers
Creating MySQL server server00000000 in group PowershellMySqlTest...
Your server server00000000 is using sku Standard_B1ms (Paid Tier). Please refer to https://aka.ms/mysql-pricing for pricing details
Creating database flexibleserverdb...

Name             Location  SkuName       SkuTier   AdministratorLogin Version StorageProfileStorageMb
----             --------  -------       -------   ------------------ ------- -----------------------
mysql-test       West US 2 Standard_B1ms Burstable mysqltest          5.7     10240

.Example
PS C:\> New-AzMySqlFlexibleServer -Name mysql-test -ResourceGroupName PowershellMySqlTest -Vnet mysql-vnet -Subnet mysql-subnet -VnetPrefix 10.0.0.0/16 -SubnetPrefix 10.0.0.0/24

Resource group PowershellMySqlTest exists ? : True
Creating new vnet mysql-vnet in resource group PowershellMySqlTest
Creating new subnet mysql-subnet in resource group PowershellMySqlTest and delegating it to Microsoft.DBforMySQL/flexibleServers
Creating MySQL server mysql-test in group PowershellMySqlTest...
Your server mysql-test is using sku Standard_B1ms (Paid Tier). Please refer to https://aka.ms/mysql-pricing for pricing details
Creating database flexibleserverdb...

Name             Location  SkuName       SkuTier   AdministratorLogin Version StorageProfileStorageMb
----             --------  -------       -------   ------------------ ------- -----------------------
mysql-test       West US 2 Standard_B1ms Burstable mysqltest          5.7     10240

.Example
PS C:\> New-AzMySqlFlexibleServer -Name mysql-test -ResourceGroupName PowershellMySqlTest -PublicAccess All

Resource group PowershellMySqlTest exists ? : True
Creating MySQL server mysql-test in group PowershellMySqlTest...
Your server mysql-test is using sku Standard_B1ms (Paid Tier). Please refer to https://aka.ms/mysql-pricing for pricing details
Creating database flexibleserverdb...
Configuring server firewall rule to accept connections from 0.0.0.0 to 255.255.255.255

Name             Location  SkuName       SkuTier   AdministratorLogin Version StorageProfileStorageMb
----             --------  -------       -------   ------------------ ------- -----------------------
mysql-test       West US 2 Standard_B1ms Burstable mysqltest          5.7     10240
.Example
PS C:\> New-AzMySqlFlexibleServer -Name mysql-test -ResourceGroupName PowershellMySqlTest -PublicAccess 10.10.10.10-10.10.10.12

Resource group PowershellMySqlTest exists ? : True
Creating MySQL server mysql-test in group PowershellMySqlTest...
Your server mysql-test is using sku Standard_B1ms (Paid Tier). Please refer to https://aka.ms/mysql-pricing for pricing details
Creating database flexibleserverdb...
Configuring server firewall rule to accept connections from 10.10.10.10 to 10.10.10.12

Name             Location  SkuName       SkuTier   AdministratorLogin Version StorageProfileStorageMb
----             --------  -------       -------   ------------------ ------- -----------------------
mysql-test       West US 2 Standard_B1ms Burstable mysqltest          5.7     10240


.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerAutoGenerated
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerAutoGenerated
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IServerAutoGenerated>: Represents a server.
  Location <String>: The geo-location where the resource lives
  [Tag <ITrackedResourceTags>]: Resource tags.
    [(Any) <String>]: This indicates any property can be added to this object.
  [AdministratorLogin <String>]: The administrator's login name of a server. Can only be specified when the server is being created (and is required for creation).
  [AdministratorLoginPassword <String>]: The password of the administrator login (required for server creation).
  [AvailabilityZone <String>]: availability Zone information of the server.
  [CreateMode <CreateMode?>]: The mode to create a new MySQL server.
  [DelegatedSubnetArgumentSubnetArmResourceId <String>]: delegated subnet arm resource id.
  [HaEnabled <HaEnabledEnum?>]: Enable HA or not for a server.
  [IdentityType <ResourceIdentityType?>]: The identity type.
  [InfrastructureEncryption <InfrastructureEncryptionEnum?>]: Status showing whether the server enabled infrastructure encryption.
  [MaintenanceWindowCustomWindow <String>]: indicates whether custom window is enabled or disabled
  [MaintenanceWindowDayOfWeek <Int32?>]: day of week for maintenance window
  [MaintenanceWindowStartHour <Int32?>]: start hour for maintenance window
  [MaintenanceWindowStartMinute <Int32?>]: start minute for maintenance window
  [PropertiesTag <IServerPropertiesTags>]: Application-specific metadata in the form of key-value pairs.
    [(Any) <String>]: This indicates any property can be added to this object.
  [ReplicationRole <String>]: The replication role.
  [RestorePointInTime <DateTime?>]: Restore point creation time (ISO8601 format), specifying the time to restore from.
  [SkuName <String>]: The name of the sku, e.g. Standard_D32s_v3.
  [SkuTier <SkuTier?>]: The tier of the particular SKU, e.g. GeneralPurpose.
  [SourceServerId <String>]: The source MySQL server id.
  [SslEnforcement <SslEnforcementEnum?>]: Enable ssl enforcement or not when connect to server.
  [StorageProfileBackupRetentionDay <Int32?>]: Backup retention days for the server.
  [StorageProfileStorageAutogrow <StorageAutogrow?>]: Enable Storage Auto Grow.
  [StorageProfileStorageIop <Int32?>]: Storage IOPS for a server.
  [StorageProfileStorageMb <Int32?>]: Max storage allowed for a server.
  [Version <ServerVersion?>]: Server version.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlflexibleserver
#>
function New-AzMySqlFlexibleServer {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerAutoGenerated])]
[CmdletBinding(DefaultParameterSetName='CreateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Alias('ServerName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${Name},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Create')]
    [Parameter(ParameterSetName='CreateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Create', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerAutoGenerated]
    # Represents a server.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The geo-location where the resource lives
    ${Location},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The administrator's login name of a server.
    # Can only be specified when the server is being created (and is required for creation).
    ${AdministratorLogin},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The password of the administrator login (required for server creation).
    ${AdministratorLoginPassword},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # availability Zone information of the server.
    ${AvailabilityZone},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.CreateMode])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.CreateMode]
    # The mode to create a new MySQL server.
    ${CreateMode},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # delegated subnet arm resource id.
    ${DelegatedSubnetArgumentSubnetArmResourceId},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.HaEnabledEnum])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.HaEnabledEnum]
    # Enable HA or not for a server.
    ${HaEnabled},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ResourceIdentityType])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ResourceIdentityType]
    # The identity type.
    ${IdentityType},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.InfrastructureEncryptionEnum])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.InfrastructureEncryptionEnum]
    # Status showing whether the server enabled infrastructure encryption.
    ${InfrastructureEncryption},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # indicates whether custom window is enabled or disabled
    ${MaintenanceWindowCustomWindow},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # day of week for maintenance window
    ${MaintenanceWindowDayOfWeek},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # start hour for maintenance window
    ${MaintenanceWindowStartHour},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # start minute for maintenance window
    ${MaintenanceWindowStartMinute},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.Info(PossibleTypes=([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerPropertiesTags]))]
    [System.Collections.Hashtable]
    # Application-specific metadata in the form of key-value pairs.
    ${PropertiesTag},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The replication role.
    ${ReplicationRole},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.DateTime]
    # Restore point creation time (ISO8601 format), specifying the time to restore from.
    ${RestorePointInTime},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The name of the sku, e.g.
    # Standard_D32s_v3.
    ${SkuName},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SkuTier])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SkuTier]
    # The tier of the particular SKU, e.g.
    # GeneralPurpose.
    ${SkuTier},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The source MySQL server id.
    ${SourceServerId},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SslEnforcementEnum])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SslEnforcementEnum]
    # Enable ssl enforcement or not when connect to server.
    ${SslEnforcement},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # Backup retention days for the server.
    ${StorageProfileBackupRetentionDay},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.StorageAutogrow])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.StorageAutogrow]
    # Enable Storage Auto Grow.
    ${StorageProfileStorageAutogrow},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # Storage IOPS for a server.
    ${StorageProfileStorageIop},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # Max storage allowed for a server.
    ${StorageProfileStorageMb},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.Info(PossibleTypes=([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api10.ITrackedResourceTags]))]
    [System.Collections.Hashtable]
    # Resource tags.
    ${Tag},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ServerVersion])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ServerVersion]
    # Server version.
    ${Version},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Create = 'Az.MySql.private\New-AzMySqlFlexibleServer_Create';
            CreateExpanded = 'Az.MySql.private\New-AzMySqlFlexibleServer_CreateExpanded';
            CreateViaIdentity = 'Az.MySql.private\New-AzMySqlFlexibleServer_CreateViaIdentity';
            CreateViaIdentityExpanded = 'Az.MySql.private\New-AzMySqlFlexibleServer_CreateViaIdentityExpanded';
        }
        if (('Create', 'CreateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates or update active directory administrator on an existing server.
The update action will overwrite the existing administrator.
.Description
Creates or update active directory administrator on an existing server.
The update action will overwrite the existing administrator.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerAdministratorResource
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerAdministratorResource
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PROPERTY <IServerAdministratorResource>: Represents a and external administrator to be created.
  [Login <String>]: The server administrator login account name.
  [Sid <String>]: The server administrator Sid (Secure ID).
  [TenantId <String>]: The server Active Directory Administrator tenant id.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlserveradministrator
#>
function New-AzMySqlServerAdministrator {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerAdministratorResource])]
[CmdletBinding(DefaultParameterSetName='CreateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Create')]
    [Parameter(ParameterSetName='CreateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Create', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerAdministratorResource]
    # Represents a and external administrator to be created.
    # To construct, see NOTES section for PROPERTY properties and create a hash table.
    ${Property},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The server administrator login account name.
    ${Login},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The server administrator Sid (Secure ID).
    ${Sid},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The server Active Directory Administrator tenant id.
    ${TenantId},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Create = 'Az.MySql.private\New-AzMySqlServerAdministrator_Create';
            CreateExpanded = 'Az.MySql.private\New-AzMySqlServerAdministrator_CreateExpanded';
            CreateViaIdentity = 'Az.MySql.private\New-AzMySqlServerAdministrator_CreateViaIdentity';
            CreateViaIdentityExpanded = 'Az.MySql.private\New-AzMySqlServerAdministrator_CreateViaIdentityExpanded';
        }
        if (('Create', 'CreateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates or updates a threat detection policy.
.Description
Creates or updates a threat detection policy.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerSecurityAlertPolicy
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerSecurityAlertPolicy
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IServerSecurityAlertPolicy>: A server security alert policy.
  [DisabledAlert <String[]>]: Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly
  [EmailAccountAdmin <Boolean?>]: Specifies that the alert is sent to the account administrators.
  [EmailAddress <String[]>]: Specifies an array of e-mail addresses to which the alert is sent.
  [RetentionDay <Int32?>]: Specifies the number of days to keep in the Threat Detection audit logs.
  [State <ServerSecurityAlertPolicyState?>]: Specifies the state of the policy, whether it is enabled or disabled.
  [StorageAccountAccessKey <String>]: Specifies the identifier key of the Threat Detection audit storage account.
  [StorageEndpoint <String>]: Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlserversecurityalertpolicy
#>
function New-AzMySqlServerSecurityAlertPolicy {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerSecurityAlertPolicy])]
[CmdletBinding(DefaultParameterSetName='CreateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Create')]
    [Parameter(ParameterSetName='CreateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Create', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerSecurityAlertPolicy]
    # A server security alert policy.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String[]]
    # Specifies an array of alerts that are disabled.
    # Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly
    ${DisabledAlert},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Management.Automation.SwitchParameter]
    # Specifies that the alert is sent to the account administrators.
    ${EmailAccountAdmin},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String[]]
    # Specifies an array of e-mail addresses to which the alert is sent.
    ${EmailAddress},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # Specifies the number of days to keep in the Threat Detection audit logs.
    ${RetentionDay},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ServerSecurityAlertPolicyState])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ServerSecurityAlertPolicyState]
    # Specifies the state of the policy, whether it is enabled or disabled.
    ${State},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Specifies the identifier key of the Threat Detection audit storage account.
    ${StorageAccountAccessKey},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Specifies the blob storage endpoint (e.g.
    # https://MyAccount.blob.core.windows.net).
    # This blob storage will hold all Threat Detection audit logs.
    ${StorageEndpoint},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Returns true when the command succeeds
    ${PassThru},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Create = 'Az.MySql.private\New-AzMySqlServerSecurityAlertPolicy_Create';
            CreateExpanded = 'Az.MySql.private\New-AzMySqlServerSecurityAlertPolicy_CreateExpanded';
            CreateViaIdentity = 'Az.MySql.private\New-AzMySqlServerSecurityAlertPolicy_CreateViaIdentity';
            CreateViaIdentityExpanded = 'Az.MySql.private\New-AzMySqlServerSecurityAlertPolicy_CreateViaIdentityExpanded';
        }
        if (('Create', 'CreateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates a new server or updates an existing server.
The update action will overwrite the existing server.
.Description
Creates a new server or updates an existing server.
The update action will overwrite the existing server.
.Example
PS C:\> New-AzMySqlServer -Name mysql-test -ResourceGroupName PowershellMySqlTest -Location eastus -AdministratorUser mysql_test -AdministratorLoginPassword $password -Sku GP_Gen5_4

Name          Location AdministratorLogin Version StorageProfileStorageMb SkuName   SkuTier        SslEnforcement
----          -------- ------------------ ------- ----------------------- -------   -------        ------------
mysql-test    eastus   mysql_test         5.7     5120                    GP_Gen5_4 GeneralPurpose Enabled

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerForCreate
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServer
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IServerForCreate>: Represents a server to be created.
  CreateMode <CreateMode>: The mode to create a new server.
  Location <String>: The location the resource resides in.
  [IdentityType <IdentityType?>]: The identity type. Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.
  [InfrastructureEncryption <InfrastructureEncryption?>]: Status showing whether the server enabled infrastructure encryption.
  [MinimalTlsVersion <MinimalTlsVersionEnum?>]: Enforce a minimal Tls version for the server.
  [PublicNetworkAccess <PublicNetworkAccessEnum?>]: Whether or not public network access is allowed for this server. Value is optional but if passed in, must be 'Enabled' or 'Disabled'
  [SkuCapacity <Int32?>]: The scale up/out capacity, representing server's compute units.
  [SkuFamily <String>]: The family of hardware.
  [SkuName <String>]: The name of the sku, typically, tier + family + cores, e.g. B_Gen4_1, GP_Gen5_8.
  [SkuSize <String>]: The size code, to be interpreted by resource as appropriate.
  [SkuTier <SkuTier?>]: The tier of the particular SKU, e.g. Basic.
  [SslEnforcement <SslEnforcementEnum?>]: Enable ssl enforcement or not when connect to server.
  [StorageProfileBackupRetentionDay <Int32?>]: Backup retention days for the server.
  [StorageProfileGeoRedundantBackup <GeoRedundantBackup?>]: Enable Geo-redundant or not for server backup.
  [StorageProfileStorageAutogrow <StorageAutogrow?>]: Enable Storage Auto Grow.
  [StorageProfileStorageMb <Int32?>]: Max storage allowed for a server.
  [Tag <IServerForCreateTags>]: Application-specific metadata in the form of key-value pairs.
    [(Any) <String>]: This indicates any property can be added to this object.
  [Version <ServerVersion?>]: Server version.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlserver
#>
function New-AzMySqlServer {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServer])]
[CmdletBinding(DefaultParameterSetName='CreateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Alias('ServerName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${Name},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Create')]
    [Parameter(ParameterSetName='CreateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Create', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerForCreate]
    # Represents a server to be created.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory)]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.CreateMode])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.CreateMode]
    # The mode to create a new server.
    ${CreateMode},

    [Parameter(ParameterSetName='CreateExpanded', Mandatory)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The location the resource resides in.
    ${Location},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.IdentityType])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.IdentityType]
    # The identity type.
    # Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.
    ${IdentityType},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.InfrastructureEncryption])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.InfrastructureEncryption]
    # Status showing whether the server enabled infrastructure encryption.
    ${InfrastructureEncryption},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.MinimalTlsVersionEnum])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.MinimalTlsVersionEnum]
    # Enforce a minimal Tls version for the server.
    ${MinimalTlsVersion},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.PublicNetworkAccessEnum])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.PublicNetworkAccessEnum]
    # Whether or not public network access is allowed for this server.
    # Value is optional but if passed in, must be 'Enabled' or 'Disabled'
    ${PublicNetworkAccess},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # The scale up/out capacity, representing server's compute units.
    ${SkuCapacity},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The family of hardware.
    ${SkuFamily},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The name of the sku, typically, tier + family + cores, e.g.
    # B_Gen4_1, GP_Gen5_8.
    ${SkuName},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The size code, to be interpreted by resource as appropriate.
    ${SkuSize},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SkuTier])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SkuTier]
    # The tier of the particular SKU, e.g.
    # Basic.
    ${SkuTier},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SslEnforcementEnum])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SslEnforcementEnum]
    # Enable ssl enforcement or not when connect to server.
    ${SslEnforcement},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # Backup retention days for the server.
    # Day count is between 7 and 35.
    ${StorageProfileBackupRetentionDay},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.GeoRedundantBackup])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.GeoRedundantBackup]
    # Enable Geo-redundant or not for server backup.
    ${StorageProfileGeoRedundantBackup},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.StorageAutogrow])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.StorageAutogrow]
    # Enable Storage Auto Grow.
    ${StorageProfileStorageAutogrow},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # Max storage allowed for a server.
    ${StorageProfileStorageMb},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.Info(PossibleTypes=([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerForCreateTags]))]
    [System.Collections.Hashtable]
    # Application-specific metadata in the form of key-value pairs.
    ${Tag},

    [Parameter(ParameterSetName='CreateExpanded')]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ServerVersion])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ServerVersion]
    # Server version.
    ${Version},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Create = 'Az.MySql.private\New-AzMySqlServer_Create';
            CreateExpanded = 'Az.MySql.private\New-AzMySqlServer_CreateExpanded';
            CreateViaIdentity = 'Az.MySql.private\New-AzMySqlServer_CreateViaIdentity';
            CreateViaIdentityExpanded = 'Az.MySql.private\New-AzMySqlServer_CreateViaIdentityExpanded';
        }
        if (('Create', 'CreateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates or updates an existing virtual network rule.
.Description
Creates or updates an existing virtual network rule.
.Example
PS C:\> $ID = "/subscriptions/<SubscriptionId>/resourceGroups/PowershellMySqlTest/providers/Microsoft.Network/virtualNetworks/MySqlVNet/subnets/MysqlSubnet1"
PS C:\> New-AzMySqlVirtualNetworkRule -Name vnet -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -SubnetId $ID

Name Type
---- ----
vnet Microsoft.DBforMySQL/servers/virtualNetworkRules

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IVirtualNetworkRule
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IVirtualNetworkRule
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IVirtualNetworkRule>: A virtual network rule.
  VirtualNetworkSubnetId <String>: The ARM resource id of the virtual network subnet.
  [IgnoreMissingVnetServiceEndpoint <Boolean?>]: Create firewall rule before the virtual network has vnet service endpoint enabled.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/new-azmysqlvirtualnetworkrule
#>
function New-AzMySqlVirtualNetworkRule {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IVirtualNetworkRule])]
[CmdletBinding(DefaultParameterSetName='CreateViaIdentity', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Create', Mandatory)]
    [Alias('VirtualNetworkRuleName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the virtual network rule.
    ${Name},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Create', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Create')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Create', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='CreateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IVirtualNetworkRule]
    # A virtual network rule.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='CreateViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The ARM resource id of the virtual network subnet.
    ${SubnetId},

    [Parameter(ParameterSetName='CreateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Management.Automation.SwitchParameter]
    # Create firewall rule before the virtual network has vnet service endpoint enabled.
    ${IgnoreMissingVnetServiceEndpoint},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Returns true when the command succeeds
    ${PassThru},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Create = 'Az.MySql.private\New-AzMySqlVirtualNetworkRule_Create';
            CreateViaIdentity = 'Az.MySql.private\New-AzMySqlVirtualNetworkRule_CreateViaIdentity';
            CreateViaIdentityExpanded = 'Az.MySql.private\New-AzMySqlVirtualNetworkRule_CreateViaIdentityExpanded';
        }
        if (('Create') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Deletes a database.
.Description
Deletes a database.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
System.Boolean
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/remove-azmysqldatabase
#>
function Remove-AzMySqlDatabase {
[OutputType([System.Boolean])]
[CmdletBinding(DefaultParameterSetName='Delete', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Delete', Mandatory)]
    [Alias('DatabaseName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the database.
    ${Name},

    [Parameter(ParameterSetName='Delete', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Delete', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Delete')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='DeleteViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Returns true when the command succeeds
    ${PassThru},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Delete = 'Az.MySql.private\Remove-AzMySqlDatabase_Delete';
            DeleteViaIdentity = 'Az.MySql.private\Remove-AzMySqlDatabase_DeleteViaIdentity';
        }
        if (('Delete') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Deletes the MySQL Server key with the given name.
.Description
Deletes the MySQL Server key with the given name.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
System.Boolean
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/remove-azmysqlflexibleserverkey
#>
function Remove-AzMySqlFlexibleServerKey {
[OutputType([System.Boolean])]
[CmdletBinding(DefaultParameterSetName='Delete', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Delete', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server key.
    ${KeyName},

    [Parameter(ParameterSetName='Delete', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Delete', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Delete')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='DeleteViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Returns true when the command succeeds
    ${PassThru},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Delete = 'Az.MySql.private\Remove-AzMySqlFlexibleServerKey_Delete';
            DeleteViaIdentity = 'Az.MySql.private\Remove-AzMySqlFlexibleServerKey_DeleteViaIdentity';
        }
        if (('Delete') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Deletes server active directory administrator.
.Description
Deletes server active directory administrator.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
System.Boolean
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/remove-azmysqlserveradministrator
#>
function Remove-AzMySqlServerAdministrator {
[OutputType([System.Boolean])]
[CmdletBinding(DefaultParameterSetName='Delete', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Delete', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Delete', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Delete')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='DeleteViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Returns true when the command succeeds
    ${PassThru},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Delete = 'Az.MySql.private\Remove-AzMySqlServerAdministrator_Delete';
            DeleteViaIdentity = 'Az.MySql.private\Remove-AzMySqlServerAdministrator_DeleteViaIdentity';
        }
        if (('Delete') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates a new database or updates an existing database.
.Description
Creates a new database or updates an existing database.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

PARAMETER <IDatabase>: Represents a Database.
  [Charset <String>]: The charset of the database.
  [Collation <String>]: The collation of the database.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/set-azmysqldatabase
#>
function Set-AzMySqlDatabase {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase])]
[CmdletBinding(DefaultParameterSetName='UpdateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory)]
    [Alias('DatabaseName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the database.
    ${Name},

    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='Update', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase]
    # Represents a Database.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The charset of the database.
    ${Charset},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The collation of the database.
    ${Collation},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Update = 'Az.MySql.private\Set-AzMySqlDatabase_Update';
            UpdateExpanded = 'Az.MySql.private\Set-AzMySqlDatabase_UpdateExpanded';
        }
        if (('Update', 'UpdateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates or updates a MySQL Server key.
.Description
Creates or updates a MySQL Server key.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerKey
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerKey
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

PARAMETER <IServerKey>: A MySQL Server key.
  [Uri <String>]: The URI of the key.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/set-azmysqlflexibleserverkey
#>
function Set-AzMySqlFlexibleServerKey {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerKey])]
[CmdletBinding(DefaultParameterSetName='UpdateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server key.
    ${KeyName},

    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='Update', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerKey]
    # A MySQL Server key.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The URI of the key.
    ${Uri},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Update = 'Az.MySql.private\Set-AzMySqlFlexibleServerKey_Update';
            UpdateExpanded = 'Az.MySql.private\Set-AzMySqlFlexibleServerKey_UpdateExpanded';
        }
        if (('Update', 'UpdateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates or update active directory administrator on an existing server.
The update action will overwrite the existing administrator.
.Description
Creates or update active directory administrator on an existing server.
The update action will overwrite the existing administrator.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerAdministratorResource
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerAdministratorResource
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

PROPERTY <IServerAdministratorResource>: Represents a and external administrator to be created.
  [Login <String>]: The server administrator login account name.
  [Sid <String>]: The server administrator Sid (Secure ID).
  [TenantId <String>]: The server Active Directory Administrator tenant id.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/set-azmysqlserveradministrator
#>
function Set-AzMySqlServerAdministrator {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerAdministratorResource])]
[CmdletBinding(DefaultParameterSetName='UpdateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='Update', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerAdministratorResource]
    # Represents a and external administrator to be created.
    # To construct, see NOTES section for PROPERTY properties and create a hash table.
    ${Property},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The server administrator login account name.
    ${Login},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The server administrator Sid (Secure ID).
    ${Sid},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The server Active Directory Administrator tenant id.
    ${TenantId},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Update = 'Az.MySql.private\Set-AzMySqlServerAdministrator_Update';
            UpdateExpanded = 'Az.MySql.private\Set-AzMySqlServerAdministrator_UpdateExpanded';
        }
        if (('Update', 'UpdateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates or updates a threat detection policy.
.Description
Creates or updates a threat detection policy.
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerSecurityAlertPolicy
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerSecurityAlertPolicy
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

PARAMETER <IServerSecurityAlertPolicy>: A server security alert policy.
  [DisabledAlert <String[]>]: Specifies an array of alerts that are disabled. Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly
  [EmailAccountAdmin <Boolean?>]: Specifies that the alert is sent to the account administrators.
  [EmailAddress <String[]>]: Specifies an array of e-mail addresses to which the alert is sent.
  [RetentionDay <Int32?>]: Specifies the number of days to keep in the Threat Detection audit logs.
  [State <ServerSecurityAlertPolicyState?>]: Specifies the state of the policy, whether it is enabled or disabled.
  [StorageAccountAccessKey <String>]: Specifies the identifier key of the Threat Detection audit storage account.
  [StorageEndpoint <String>]: Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/set-azmysqlserversecurityalertpolicy
#>
function Set-AzMySqlServerSecurityAlertPolicy {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerSecurityAlertPolicy])]
[CmdletBinding(DefaultParameterSetName='UpdateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='Update', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerSecurityAlertPolicy]
    # A server security alert policy.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String[]]
    # Specifies an array of alerts that are disabled.
    # Allowed values are: Sql_Injection, Sql_Injection_Vulnerability, Access_Anomaly
    ${DisabledAlert},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Management.Automation.SwitchParameter]
    # Specifies that the alert is sent to the account administrators.
    ${EmailAccountAdmin},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String[]]
    # Specifies an array of e-mail addresses to which the alert is sent.
    ${EmailAddress},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # Specifies the number of days to keep in the Threat Detection audit logs.
    ${RetentionDay},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ServerSecurityAlertPolicyState])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ServerSecurityAlertPolicyState]
    # Specifies the state of the policy, whether it is enabled or disabled.
    ${State},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Specifies the identifier key of the Threat Detection audit storage account.
    ${StorageAccountAccessKey},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Specifies the blob storage endpoint (e.g.
    # https://MyAccount.blob.core.windows.net).
    # This blob storage will hold all Threat Detection audit logs.
    ${StorageEndpoint},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Returns true when the command succeeds
    ${PassThru},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Update = 'Az.MySql.private\Set-AzMySqlServerSecurityAlertPolicy_Update';
            UpdateExpanded = 'Az.MySql.private\Set-AzMySqlServerSecurityAlertPolicy_UpdateExpanded';
        }
        if (('Update', 'UpdateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Check the availability of name for server
.Description
Check the availability of name for server
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.INameAvailabilityRequest
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.INameAvailability
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

NAMEAVAILABILITYREQUEST <INameAvailabilityRequest>: Request from client to check resource name availability.
  Name <String>: Resource name to verify.
  [Type <String>]: Resource type used for verification.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/test-azmysqlflexibleservernameavailability
#>
function Test-AzMySqlFlexibleServerNameAvailability {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.INameAvailability])]
[CmdletBinding(DefaultParameterSetName='TestExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Test')]
    [Parameter(ParameterSetName='TestExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='TestViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='TestViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Test', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='TestViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.INameAvailabilityRequest]
    # Request from client to check resource name availability.
    # To construct, see NOTES section for NAMEAVAILABILITYREQUEST properties and create a hash table.
    ${NameAvailabilityRequest},

    [Parameter(ParameterSetName='TestExpanded', Mandatory)]
    [Parameter(ParameterSetName='TestViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Resource name to verify.
    ${Name},

    [Parameter(ParameterSetName='TestExpanded')]
    [Parameter(ParameterSetName='TestViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Resource type used for verification.
    ${Type},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Test = 'Az.MySql.private\Test-AzMySqlFlexibleServerNameAvailability_Test';
            TestExpanded = 'Az.MySql.private\Test-AzMySqlFlexibleServerNameAvailability_TestExpanded';
            TestViaIdentity = 'Az.MySql.private\Test-AzMySqlFlexibleServerNameAvailability_TestViaIdentity';
            TestViaIdentityExpanded = 'Az.MySql.private\Test-AzMySqlFlexibleServerNameAvailability_TestViaIdentityExpanded';
        }
        if (('Test', 'TestExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Check the availability of name for resource
.Description
Check the availability of name for resource
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}
.Example
PS C:\> {{ Add code here }}

{{ Add output here }}

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.INameAvailabilityRequest
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.INameAvailability
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

NAMEAVAILABILITYREQUEST <INameAvailabilityRequest>: Request from client to check resource name availability.
  Name <String>: Resource name to verify.
  [Type <String>]: Resource type used for verification.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/test-azmysqlnameavailability
#>
function Test-AzMySqlNameAvailability {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.INameAvailability])]
[CmdletBinding(DefaultParameterSetName='TestExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Test')]
    [Parameter(ParameterSetName='TestExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='TestViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='TestViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Test', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='TestViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.INameAvailabilityRequest]
    # Request from client to check resource name availability.
    # To construct, see NOTES section for NAMEAVAILABILITYREQUEST properties and create a hash table.
    ${NameAvailabilityRequest},

    [Parameter(ParameterSetName='TestExpanded', Mandatory)]
    [Parameter(ParameterSetName='TestViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Resource name to verify.
    ${Name},

    [Parameter(ParameterSetName='TestExpanded')]
    [Parameter(ParameterSetName='TestViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Resource type used for verification.
    ${Type},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Test = 'Az.MySql.private\Test-AzMySqlNameAvailability_Test';
            TestExpanded = 'Az.MySql.private\Test-AzMySqlNameAvailability_TestExpanded';
            TestViaIdentity = 'Az.MySql.private\Test-AzMySqlNameAvailability_TestViaIdentity';
            TestViaIdentityExpanded = 'Az.MySql.private\Test-AzMySqlNameAvailability_TestViaIdentityExpanded';
        }
        if (('Test', 'TestExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Updates a configuration of a server.
.Description
Updates a configuration of a server.
.Example
PS C:\> Update-AzMySqlConfiguration -Name net_retry_count -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -Value 15

Name            Value
----            -----
net_retry_count 15
.Example
PS C:\> $ID = "/subscriptions/<SubscriptionId>/resourceGroups/PowershellMySqlTest/providers/Microsoft.DBforMySQL/servers/mysql-test/configurations/wait_timeout"
PS C:\> Update-AzMySqlConfiguration -InputObject $ID -Value 150

Name         Value
----         -----
wait_timeout 150

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IConfiguration
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IConfiguration
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IConfiguration>: Represents a Configuration.
  [Source <String>]: Source of the configuration.
  [Value <String>]: Value of the configuration.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/update-azmysqlconfiguration
#>
function Update-AzMySqlConfiguration {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IConfiguration])]
[CmdletBinding(DefaultParameterSetName='UpdateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Alias('ConfigurationName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server configuration.
    ${Name},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Update')]
    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Update', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IConfiguration]
    # Represents a Configuration.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Source of the configuration.
    ${Source},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Value of the configuration.
    ${Value},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Update = 'Az.MySql.private\Update-AzMySqlConfiguration_Update';
            UpdateExpanded = 'Az.MySql.private\Update-AzMySqlConfiguration_UpdateExpanded';
            UpdateViaIdentity = 'Az.MySql.private\Update-AzMySqlConfiguration_UpdateViaIdentity';
            UpdateViaIdentityExpanded = 'Az.MySql.private\Update-AzMySqlConfiguration_UpdateViaIdentityExpanded';
        }
        if (('Update', 'UpdateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates a new firewall rule or updates an existing firewall rule.
.Description
Creates a new firewall rule or updates an existing firewall rule.
.Example
PS C:\> Update-AzMySqlFirewallRule -Name rule -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -EndIPAddress 0.0.0.3 -StartIPAddress 0.0.0.2

Name StartIPAddress EndIPAddress
---- -------------- ------------
rule 0.0.0.2        0.0.0.3
.Example
PS C:\> $ID = "/subscriptions/<SubscriptionId>/resourceGroups/PowershellMySqlTest/providers/Microsoft.DBforMySQL/servers/mysql-test/firewallRules/rule"
PS C:\> Update-AzMySqlFirewallRule -InputObject $ID -EndIPAddress 0.0.0.3 -StartIPAddress 0.0.0.2

Name StartIPAddress EndIPAddress
---- -------------- ------------
rule 0.0.0.2        0.0.0.3
.Example
PS C:\> $ID = "/subscriptions/<SubscriptionId>/resourceGroups/PowershellMySqlTest/providers/Microsoft.DBforMySQL/servers/mysql-test/firewallRules/rule"
PS C:\> Update-AzMySqlFirewallRule -InputObject $ID --ClientIPAddress 0.0.0.2

Name StartIPAddress EndIPAddress
---- -------------- ------------
rule 0.0.0.2        0.0.0.2

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IFirewallRule>: Represents a server firewall rule.
  EndIPAddress <String>: The end IP address of the server firewall rule. Must be IPv4 format.
  StartIPAddress <String>: The start IP address of the server firewall rule. Must be IPv4 format.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/update-azmysqlfirewallrule
#>
function Update-AzMySqlFirewallRule {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule])]
[CmdletBinding(DefaultParameterSetName='UpdateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Alias('FirewallRuleName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server firewall rule.
    ${Name},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Update')]
    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Update', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule]
    # Represents a server firewall rule.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The end IP address of the server firewall rule.
    # Must be IPv4 format.
    ${EndIPAddress},

    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The start IP address of the server firewall rule.
    # Must be IPv4 format.
    ${StartIPAddress},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Update = 'Az.MySql.private\Update-AzMySqlFirewallRule_Update';
            UpdateExpanded = 'Az.MySql.private\Update-AzMySqlFirewallRule_UpdateExpanded';
            UpdateViaIdentity = 'Az.MySql.private\Update-AzMySqlFirewallRule_UpdateViaIdentity';
            UpdateViaIdentityExpanded = 'Az.MySql.private\Update-AzMySqlFirewallRule_UpdateViaIdentityExpanded';
        }
        if (('Update', 'UpdateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Updates a configuration of a server.
.Description
Updates a configuration of a server.
.Example
PS C:\> Update-AzMySqlFlexibleServer -Name net_retry_count -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -Value 15

Name          Value   DefaultValue  Source        AllowedValues DataType
----          ------  ------------  -------       ------------- ---------
net_retry_count 15    10            user-override  1-4294967295   Integer
.Example
PS C:\> $ID = "/subscriptions/<SubscriptionId>/resourceGroups/PowershellMySqlTest/providers/Microsoft.DBForMySql/flexibleServers/mysql-test/configurations/wait_timeout"
PS C:\> Update-AzMySqlFlexibleServer -InputObject $ID -Value 150

Name          Value   DefaultValue  Source        AllowedValues DataType
----          ------  ------------  -------       ------------- ---------
wait_timeout   150    28800         system-default   1-31536000   Integer

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IConfigurationAutoGenerated
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IConfigurationAutoGenerated
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IConfigurationAutoGenerated>: Represents a Configuration.
  [Source <String>]: Source of the configuration.
  [Value <String>]: Value of the configuration.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/update-azmysqlflexibleserverconfiguration
#>
function Update-AzMySqlFlexibleServerConfiguration {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IConfigurationAutoGenerated])]
[CmdletBinding(DefaultParameterSetName='UpdateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Alias('ConfigurationName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server configuration.
    ${Name},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Update')]
    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Update', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IConfigurationAutoGenerated]
    # Represents a Configuration.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Source of the configuration.
    ${Source},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # Value of the configuration.
    ${Value},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Update = 'Az.MySql.private\Update-AzMySqlFlexibleServerConfiguration_Update';
            UpdateExpanded = 'Az.MySql.private\Update-AzMySqlFlexibleServerConfiguration_UpdateExpanded';
            UpdateViaIdentity = 'Az.MySql.private\Update-AzMySqlFlexibleServerConfiguration_UpdateViaIdentity';
            UpdateViaIdentityExpanded = 'Az.MySql.private\Update-AzMySqlFlexibleServerConfiguration_UpdateViaIdentityExpanded';
        }
        if (('Update', 'UpdateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates a new database or updates an existing database.
.Description
Creates a new database or updates an existing database.
.Example
PS C:\> Update-AzMySqlFlexibleServerDatabase -Name database-test -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -Charset utf8

Name            Charset     Collation              
----            -------- ------------------
databasetest   utf8      latin1_swedish_ci  
.Example
PS C:\> $ID = "/subscriptions/<SubscriptionId>/resourceGroups/PowershellMySqlTest/providers/Microsoft.DBForMySql/servers/mysql-test/databases/databasetest"
PS C:\> Update-AzMySqlFlexibleServerDatabase -Parameter $ID -Charset utf8

Name            Charset     Collation              
----            -------- ------------------
databasetest   utf8      latin1_swedish_ci  

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IDatabase>: Represents a Database.
  [Charset <String>]: The charset of the database.
  [Collation <String>]: The collation of the database.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/update-azmysqlflexibleserverdatabase
#>
function Update-AzMySqlFlexibleServerDatabase {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase])]
[CmdletBinding(DefaultParameterSetName='UpdateViaIdentity', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Update', Mandatory)]
    [Alias('DatabaseName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the database.
    ${Name},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Update')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IDatabase]
    # Represents a Database.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Update = 'Az.MySql.private\Update-AzMySqlFlexibleServerDatabase_Update';
            UpdateViaIdentity = 'Az.MySql.private\Update-AzMySqlFlexibleServerDatabase_UpdateViaIdentity';
        }
        if (('Update') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates a new firewall rule or updates an existing firewall rule.
.Description
Creates a new firewall rule or updates an existing firewall rule.
.Example
PS C:\> Update-AzMySqlFlexibleServerFirewallRule -Name rule -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -EndIPAddress 0.0.0.3 -StartIPAddress 0.0.0.2

Name StartIPAddress EndIPAddress
---- -------------- ------------
rule 0.0.0.2        0.0.0.3
.Example
PS C:\> $ID = "/subscriptions/<SubscriptionId>/resourceGroups/PowershellMySqlTest/providers/Microsoft.DBForMySql/flexibleServers/mysql-test/firewallRules/rule"
PS C:\> Update-AzMySqlFlexibleServerFirewallRule -InputObject $ID -EndIPAddress 0.0.0.3 -StartIPAddress 0.0.0.2

Name StartIPAddress EndIPAddress
---- -------------- ------------
rule 0.0.0.2        0.0.0.3

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IFirewallRule>: Represents a server firewall rule.
  EndIPAddress <String>: The end IP address of the server firewall rule. Must be IPv4 format.
  StartIPAddress <String>: The start IP address of the server firewall rule. Must be IPv4 format.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/update-azmysqlflexibleserverfirewallrule
#>
function Update-AzMySqlFlexibleServerFirewallRule {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule])]
[CmdletBinding(DefaultParameterSetName='UpdateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Alias('FirewallRuleName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server firewall rule.
    ${Name},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Update')]
    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Update', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IFirewallRule]
    # Represents a server firewall rule.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The end IP address of the server firewall rule.
    # Must be IPv4 format.
    ${EndIPAddress},

    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The start IP address of the server firewall rule.
    # Must be IPv4 format.
    ${StartIPAddress},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Update = 'Az.MySql.private\Update-AzMySqlFlexibleServerFirewallRule_Update';
            UpdateExpanded = 'Az.MySql.private\Update-AzMySqlFlexibleServerFirewallRule_UpdateExpanded';
            UpdateViaIdentity = 'Az.MySql.private\Update-AzMySqlFlexibleServerFirewallRule_UpdateViaIdentity';
            UpdateViaIdentityExpanded = 'Az.MySql.private\Update-AzMySqlFlexibleServerFirewallRule_UpdateViaIdentityExpanded';
        }
        if (('Update', 'UpdateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Updates an existing server.
The request body can contain one to many of the properties present in the normal server definition.
.Description
Updates an existing server.
The request body can contain one to many of the properties present in the normal server definition.
.Example
PS C:\> Update-AzMySqlFlexibleServer -ResourceGroupName PowershellMySqlTest -Name mysql-test -Sku Standard_D4ds_v4

Name          Location AdministratorLogin Version StorageProfileStorageMb SkuName          SkuTier        
----          -------- ------------------ ------- ----------------------- ---------------- -------------
mysql-test    westus2   mysql_test         5.7     5120                    Standard_D4ds_v4 GeneralPurpose
.Example
PS C:\> Get-AzMySqlFlexibleServer -ResourceGroupName PowershellMySqlTest -ServerName mysql-test | Update-AzMySqlFlexibleServer -BackupRetentionDay 23 -StorageInMb 10240

Name          Location AdministratorLogin Version StorageProfileStorageMb SkuName          SkuTier        
----          -------- ------------------ ------- ----------------------- ---------------- -------------
mysql-test    westus2   mysql_test         5.7     5120                    Standard_D2ds_v4 GeneralPurpose

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerForUpdate
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerAutoGenerated
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IServerForUpdate>: Parameters allowed to update for a server.
  [AdministratorLoginPassword <String>]: The password of the administrator login.
  [DelegatedSubnetArgumentSubnetArmResourceId <String>]: delegated subnet arm resource id.
  [HaEnabled <HaEnabledEnum?>]: Enable HA or not for a server.
  [MaintenanceWindowCustomWindow <String>]: indicates whether custom window is enabled or disabled
  [MaintenanceWindowDayOfWeek <Int32?>]: day of week for maintenance window
  [MaintenanceWindowStartHour <Int32?>]: start hour for maintenance window
  [MaintenanceWindowStartMinute <Int32?>]: start minute for maintenance window
  [ReplicationRole <String>]: The replication role of the server.
  [SkuName <String>]: The name of the sku, e.g. Standard_D32s_v3.
  [SkuTier <SkuTier?>]: The tier of the particular SKU, e.g. GeneralPurpose.
  [SslEnforcement <SslEnforcementEnum?>]: Enable ssl enforcement or not when connect to server.
  [StorageProfileBackupRetentionDay <Int32?>]: Backup retention days for the server.
  [StorageProfileStorageAutogrow <StorageAutogrow?>]: Enable Storage Auto Grow.
  [StorageProfileStorageIop <Int32?>]: Storage IOPS for a server.
  [StorageProfileStorageMb <Int32?>]: Max storage allowed for a server.
  [Tag <IServerForUpdateTags>]: Application-specific metadata in the form of key-value pairs.
    [(Any) <String>]: This indicates any property can be added to this object.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/update-azmysqlflexibleserver
#>
function Update-AzMySqlFlexibleServer {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerAutoGenerated])]
[CmdletBinding(DefaultParameterSetName='UpdateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Alias('ServerName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${Name},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Update')]
    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Update', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerForUpdate]
    # Parameters allowed to update for a server.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The password of the administrator login.
    ${AdministratorLoginPassword},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # delegated subnet arm resource id.
    ${DelegatedSubnetArgumentSubnetArmResourceId},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.HaEnabledEnum])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.HaEnabledEnum]
    # Enable HA or not for a server.
    ${HaEnabled},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # indicates whether custom window is enabled or disabled
    ${MaintenanceWindowCustomWindow},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # day of week for maintenance window
    ${MaintenanceWindowDayOfWeek},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # start hour for maintenance window
    ${MaintenanceWindowStartHour},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # start minute for maintenance window
    ${MaintenanceWindowStartMinute},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The replication role of the server.
    ${ReplicationRole},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The name of the sku, e.g.
    # Standard_D32s_v3.
    ${SkuName},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SkuTier])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SkuTier]
    # The tier of the particular SKU, e.g.
    # GeneralPurpose.
    ${SkuTier},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SslEnforcementEnum])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SslEnforcementEnum]
    # Enable ssl enforcement or not when connect to server.
    ${SslEnforcement},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # Backup retention days for the server.
    ${StorageProfileBackupRetentionDay},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.StorageAutogrow])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.StorageAutogrow]
    # Enable Storage Auto Grow.
    ${StorageProfileStorageAutogrow},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # Storage IOPS for a server.
    ${StorageProfileStorageIop},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # Max storage allowed for a server.
    ${StorageProfileStorageMb},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.Info(PossibleTypes=([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20200701Preview.IServerForUpdateTags]))]
    [System.Collections.Hashtable]
    # Application-specific metadata in the form of key-value pairs.
    ${Tag},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Update = 'Az.MySql.private\Update-AzMySqlFlexibleServer_Update';
            UpdateExpanded = 'Az.MySql.private\Update-AzMySqlFlexibleServer_UpdateExpanded';
            UpdateViaIdentity = 'Az.MySql.private\Update-AzMySqlFlexibleServer_UpdateViaIdentity';
            UpdateViaIdentityExpanded = 'Az.MySql.private\Update-AzMySqlFlexibleServer_UpdateViaIdentityExpanded';
        }
        if (('Update', 'UpdateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Updates an existing server.
The request body can contain one to many of the properties present in the normal server definition.
.Description
Updates an existing server.
The request body can contain one to many of the properties present in the normal server definition.
.Example
PS C:\> Update-AzMySqlServer -ResourceGroupName PowershellMySqlTest -ServerName mysql-test -SslEnforcement Disabled

Name          Location AdministratorLogin Version StorageProfileStorageMb SkuName   SkuTier        SslEnforcement
----          -------- ------------------ ------- ----------------------- -------   -------        --------------
mysql-test    eastus   mysql_test         5.7     5120                    GP_Gen5_4 GeneralPurpose Disabled
.Example
PS C:\> Get-AzMySqlServer -ResourceGroupName PowershellMySqlTest -ServerName mysql-test | Update-AzMySqlServer -BackupRetentionDay 23 -StorageMb 10240

Name          Location AdministratorLogin Version StorageProfileStorageMb SkuName   SkuTier        SslEnforcement
----          -------- ------------------ ------- ----------------------- -------   -------        --------------
mysql-test    eastus   mysql_test         5.7     10240                   GP_Gen5_4 GeneralPurpose Disabled

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerUpdateParameters
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServer
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IServerUpdateParameters>: Parameters allowed to update for a server.
  [AdministratorLoginPassword <String>]: The password of the administrator login.
  [IdentityType <IdentityType?>]: The identity type. Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.
  [MinimalTlsVersion <MinimalTlsVersionEnum?>]: Enforce a minimal Tls version for the server.
  [PublicNetworkAccess <PublicNetworkAccessEnum?>]: Whether or not public network access is allowed for this server. Value is optional but if passed in, must be 'Enabled' or 'Disabled'
  [ReplicationRole <String>]: The replication role of the server.
  [SkuCapacity <Int32?>]: The scale up/out capacity, representing server's compute units.
  [SkuFamily <String>]: The family of hardware.
  [SkuName <String>]: The name of the sku, typically, tier + family + cores, e.g. B_Gen4_1, GP_Gen5_8.
  [SkuSize <String>]: The size code, to be interpreted by resource as appropriate.
  [SkuTier <SkuTier?>]: The tier of the particular SKU, e.g. Basic.
  [SslEnforcement <SslEnforcementEnum?>]: Enable ssl enforcement or not when connect to server.
  [StorageProfileBackupRetentionDay <Int32?>]: Backup retention days for the server.
  [StorageProfileGeoRedundantBackup <GeoRedundantBackup?>]: Enable Geo-redundant or not for server backup.
  [StorageProfileStorageAutogrow <StorageAutogrow?>]: Enable Storage Auto Grow.
  [StorageProfileStorageMb <Int32?>]: Max storage allowed for a server.
  [Tag <IServerUpdateParametersTags>]: Application-specific metadata in the form of key-value pairs.
    [(Any) <String>]: This indicates any property can be added to this object.
  [Version <ServerVersion?>]: The version of a server.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/update-azmysqlserver
#>
function Update-AzMySqlServer {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServer])]
[CmdletBinding(DefaultParameterSetName='UpdateExpanded', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Alias('ServerName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${Name},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Parameter(ParameterSetName='UpdateExpanded', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Update')]
    [Parameter(ParameterSetName='UpdateExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(ParameterSetName='Update', Mandatory, ValueFromPipeline)]
    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerUpdateParameters]
    # Parameters allowed to update for a server.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The password of the administrator login.
    ${AdministratorLoginPassword},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.IdentityType])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.IdentityType]
    # The identity type.
    # Set this to 'SystemAssigned' in order to automatically create and assign an Azure Active Directory principal for the resource.
    ${IdentityType},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.MinimalTlsVersionEnum])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.MinimalTlsVersionEnum]
    # Enforce a minimal Tls version for the server.
    ${MinimalTlsVersion},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.PublicNetworkAccessEnum])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.PublicNetworkAccessEnum]
    # Whether or not public network access is allowed for this server.
    # Value is optional but if passed in, must be 'Enabled' or 'Disabled'
    ${PublicNetworkAccess},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The replication role of the server.
    ${ReplicationRole},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # The scale up/out capacity, representing server's compute units.
    ${SkuCapacity},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The family of hardware.
    ${SkuFamily},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The name of the sku, typically, tier + family + cores, e.g.
    # B_Gen4_1, GP_Gen5_8.
    ${SkuName},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.String]
    # The size code, to be interpreted by resource as appropriate.
    ${SkuSize},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SkuTier])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SkuTier]
    # The tier of the particular SKU, e.g.
    # Basic.
    ${SkuTier},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SslEnforcementEnum])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.SslEnforcementEnum]
    # Enable ssl enforcement or not when connect to server.
    ${SslEnforcement},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # Backup retention days for the server.
    # Day count is between 7 and 35.
    ${StorageProfileBackupRetentionDay},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.GeoRedundantBackup])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.GeoRedundantBackup]
    # Enable Geo-redundant or not for server backup.
    ${StorageProfileGeoRedundantBackup},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.StorageAutogrow])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.StorageAutogrow]
    # Enable Storage Auto Grow.
    ${StorageProfileStorageAutogrow},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [System.Int32]
    # Max storage allowed for a server.
    ${StorageProfileStorageMb},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.Info(PossibleTypes=([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IServerUpdateParametersTags]))]
    [System.Collections.Hashtable]
    # Application-specific metadata in the form of key-value pairs.
    ${Tag},

    [Parameter(ParameterSetName='UpdateExpanded')]
    [Parameter(ParameterSetName='UpdateViaIdentityExpanded')]
    [ArgumentCompleter([Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ServerVersion])]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Support.ServerVersion]
    # The version of a server.
    ${Version},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Update = 'Az.MySql.private\Update-AzMySqlServer_Update';
            UpdateExpanded = 'Az.MySql.private\Update-AzMySqlServer_UpdateExpanded';
            UpdateViaIdentity = 'Az.MySql.private\Update-AzMySqlServer_UpdateViaIdentity';
            UpdateViaIdentityExpanded = 'Az.MySql.private\Update-AzMySqlServer_UpdateViaIdentityExpanded';
        }
        if (('Update', 'UpdateExpanded') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.Synopsis
Creates or updates an existing virtual network rule.
.Description
Creates or updates an existing virtual network rule.
.Example
PS C:\> $ID = "/subscriptions/<SubscriptionId>/resourceGroups/PowershellMySqlTest/providers/Microsoft.Network/virtualNetworks/MySqlVNet/subnets/MysqlSubnet2"
PS C:\> Update-AzMySqlVirtualNetworkRule -Name $env.VNetName -ResourceGroupName $env.resourceGroup -ServerName $env.serverName -SubnetId $ID

Name Type
---- ----
vnet Microsoft.DBforMySQL/servers/virtualNetworkRules
.Example
PS C:\> $SubnetID = "/subscriptions/<SubscriptionId>/resourceGroups/PowershellMySqlTest/providers/Microsoft.Network/virtualNetworks/MySqlVNet/subnets/MysqlSubnet1"
PS C:\> $VNetID = "/subscriptions/<SubscriptionId>/resourceGroups/PowershellMySqlTest/providers/Microsoft.DBforMySQL/servers/mysql-test/virtualNetworkRules/vnet"
PS C:\> Update-AzMySqlVirtualNetworkRule -InputObject $VNetID -SubnetId $SubnetID

Name Type
---- ----
vnet Microsoft.DBforMySQL/servers/virtualNetworkRules

.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IVirtualNetworkRule
.Inputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity
.Outputs
Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IVirtualNetworkRule
.Notes
COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.

INPUTOBJECT <IMySqlIdentity>: Identity Parameter
  [ConfigurationName <String>]: The name of the server configuration.
  [DatabaseName <String>]: The name of the database.
  [FirewallRuleName <String>]: The name of the server firewall rule.
  [Id <String>]: Resource identity path
  [KeyName <String>]: The name of the server key.
  [LocationName <String>]: The name of the location.
  [ResourceGroupName <String>]: The name of the resource group. The name is case insensitive.
  [SecurityAlertPolicyName <SecurityAlertPolicyName?>]: The name of the security alert policy.
  [ServerName <String>]: The name of the server.
  [SubscriptionId <String>]: The ID of the target subscription.
  [VirtualNetworkRuleName <String>]: The name of the virtual network rule.

PARAMETER <IVirtualNetworkRule>: A virtual network rule.
  VirtualNetworkSubnetId <String>: The ARM resource id of the virtual network subnet.
  [IgnoreMissingVnetServiceEndpoint <Boolean?>]: Create firewall rule before the virtual network has vnet service endpoint enabled.
.Link
https://docs.microsoft.com/en-us/powershell/module/az.mysql/update-azmysqlvirtualnetworkrule
#>
function Update-AzMySqlVirtualNetworkRule {
[OutputType([Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IVirtualNetworkRule])]
[CmdletBinding(DefaultParameterSetName='UpdateViaIdentity', PositionalBinding=$false, SupportsShouldProcess, ConfirmImpact='Medium')]
param(
    [Parameter(ParameterSetName='Update', Mandatory)]
    [Alias('VirtualNetworkRuleName')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the virtual network rule.
    ${Name},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the resource group.
    # The name is case insensitive.
    ${ResourceGroupName},

    [Parameter(ParameterSetName='Update', Mandatory)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [System.String]
    # The name of the server.
    ${ServerName},

    [Parameter(ParameterSetName='Update')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.DefaultInfo(Script='(Get-AzContext).Subscription.Id')]
    [System.String]
    # The ID of the target subscription.
    ${SubscriptionId},

    [Parameter(ParameterSetName='UpdateViaIdentity', Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Path')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.IMySqlIdentity]
    # Identity Parameter
    # To construct, see NOTES section for INPUTOBJECT properties and create a hash table.
    ${InputObject},

    [Parameter(Mandatory, ValueFromPipeline)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Body')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Models.Api20171201.IVirtualNetworkRule]
    # A virtual network rule.
    # To construct, see NOTES section for PARAMETER properties and create a hash table.
    ${Parameter},

    [Parameter()]
    [Alias('AzureRMContext', 'AzureCredential')]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Azure')]
    [System.Management.Automation.PSObject]
    # The credentials, account, tenant, and subscription used for communication with Azure.
    ${DefaultProfile},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command as a job
    ${AsJob},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Wait for .NET debugger to attach
    ${Break},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be appended to the front of the pipeline
    ${HttpPipelineAppend},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Runtime.SendAsyncStep[]]
    # SendAsync Pipeline Steps to be prepended to the front of the pipeline
    ${HttpPipelinePrepend},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Run the command asynchronously
    ${NoWait},

    [Parameter()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Returns true when the command succeeds
    ${PassThru},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Uri]
    # The URI for the proxy server to use
    ${Proxy},

    [Parameter(DontShow)]
    [ValidateNotNull()]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.PSCredential]
    # Credentials for a proxy server to use for the remote call
    ${ProxyCredential},

    [Parameter(DontShow)]
    [Microsoft.Azure.PowerShell.Cmdlets.MySql.Category('Runtime')]
    [System.Management.Automation.SwitchParameter]
    # Use the default credentials for the proxy
    ${ProxyUseDefaultCredentials}
)

begin {
    try {
        $outBuffer = $null
        if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer)) {
            $PSBoundParameters['OutBuffer'] = 1
        }
        $parameterSet = $PSCmdlet.ParameterSetName
        $mapping = @{
            Update = 'Az.MySql.private\Update-AzMySqlVirtualNetworkRule_Update';
            UpdateViaIdentity = 'Az.MySql.private\Update-AzMySqlVirtualNetworkRule_UpdateViaIdentity';
        }
        if (('Update') -contains $parameterSet -and -not $PSBoundParameters.ContainsKey('SubscriptionId')) {
            $PSBoundParameters['SubscriptionId'] = (Get-AzContext).Subscription.Id
        }
        $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(($mapping[$parameterSet]), [System.Management.Automation.CommandTypes]::Cmdlet)
        $scriptCmd = {& $wrappedCmd @PSBoundParameters}
        $steppablePipeline = $scriptCmd.GetSteppablePipeline($MyInvocation.CommandOrigin)
        $steppablePipeline.Begin($PSCmdlet)
    } catch {
        throw
    }
}

process {
    try {
        $steppablePipeline.Process($_)
    } catch {
        throw
    }
}

end {
    try {
        $steppablePipeline.End()
    } catch {
        throw
    }
}
}

# SIG # Begin signature block
# MIIjlAYJKoZIhvcNAQcCoIIjhTCCI4ECAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCiprhfi1PGy/em
# DNcbZnopDcEjWwU4lYSctA9KtspdoqCCDYUwggYDMIID66ADAgECAhMzAAABiK9S
# 1rmSbej5AAAAAAGIMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjAwMzA0MTgzOTQ4WhcNMjEwMzAzMTgzOTQ4WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQCSCNryE+Cewy2m4t/a74wZ7C9YTwv1PyC4BvM/kSWPNs8n0RTe+FvYfU+E9uf0
# t7nYlAzHjK+plif2BhD+NgdhIUQ8sVwWO39tjvQRHjP2//vSvIfmmkRoML1Ihnjs
# 9kQiZQzYRDYYRp9xSQYmRwQjk5hl8/U7RgOiQDitVHaU7BT1MI92lfZRuIIDDYBd
# vXtbclYJMVOwqZtv0O9zQCret6R+fRSGaDNfEEpcILL+D7RV3M4uaJE4Ta6KAOdv
# V+MVaJp1YXFTZPKtpjHO6d9pHQPZiG7NdC6QbnRGmsa48uNQrb6AfmLKDI1Lp31W
# MogTaX5tZf+CZT9PSuvjOCLNAgMBAAGjggGCMIIBfjAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUj9RJL9zNrPcL10RZdMQIXZN7MG8w
# VAYDVR0RBE0wS6RJMEcxLTArBgNVBAsTJE1pY3Jvc29mdCBJcmVsYW5kIE9wZXJh
# dGlvbnMgTGltaXRlZDEWMBQGA1UEBRMNMjMwMDEyKzQ1ODM4NjAfBgNVHSMEGDAW
# gBRIbmTlUAXTgqoXNzcitW2oynUClTBUBgNVHR8ETTBLMEmgR6BFhkNodHRwOi8v
# d3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NybC9NaWNDb2RTaWdQQ0EyMDExXzIw
# MTEtMDctMDguY3JsMGEGCCsGAQUFBwEBBFUwUzBRBggrBgEFBQcwAoZFaHR0cDov
# L3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9jZXJ0cy9NaWNDb2RTaWdQQ0EyMDEx
# XzIwMTEtMDctMDguY3J0MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQELBQADggIB
# ACnXo8hjp7FeT+H6iQlV3CcGnkSbFvIpKYafgzYCFo3UHY1VHYJVb5jHEO8oG26Q
# qBELmak6MTI+ra3WKMTGhE1sEIlowTcp4IAs8a5wpCh6Vf4Z/bAtIppP3p3gXk2X
# 8UXTc+WxjQYsDkFiSzo/OBa5hkdW1g4EpO43l9mjToBdqEPtIXsZ7Hi1/6y4gK0P
# mMiwG8LMpSn0n/oSHGjrUNBgHJPxgs63Slf58QGBznuXiRaXmfTUDdrvhRocdxIM
# i8nXQwWACMiQzJSRzBP5S2wUq7nMAqjaTbeXhJqD2SFVHdUYlKruvtPSwbnqSRWT
# GI8s4FEXt+TL3w5JnwVZmZkUFoioQDMMjFyaKurdJ6pnzbr1h6QW0R97fWc8xEIz
# LIOiU2rjwWAtlQqFO8KNiykjYGyEf5LyAJKAO+rJd9fsYR+VBauIEQoYmjnUbTXM
# SY2Lf5KMluWlDOGVh8q6XjmBccpaT+8tCfxpaVYPi1ncnwTwaPQvVq8RjWDRB7Pa
# 8ruHgj2HJFi69+hcq7mWx5nTUtzzFa7RSZfE5a1a5AuBmGNRr7f8cNfa01+tiWjV
# Kk1a+gJUBSP0sIxecFbVSXTZ7bqeal45XSDIisZBkWb+83TbXdTGMDSUFKTAdtC+
# r35GfsN8QVy59Hb5ZYzAXczhgRmk7NyE6jD0Ym5TKiW5MIIHejCCBWKgAwIBAgIK
# YQ6Q0gAAAAAAAzANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMCVVMxEzARBgNV
# BAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jv
# c29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJvb3QgQ2VydGlm
# aWNhdGUgQXV0aG9yaXR5IDIwMTEwHhcNMTEwNzA4MjA1OTA5WhcNMjYwNzA4MjEw
# OTA5WjB+MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UE
# BxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSgwJgYD
# VQQDEx9NaWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQSAyMDExMIICIjANBgkqhkiG
# 9w0BAQEFAAOCAg8AMIICCgKCAgEAq/D6chAcLq3YbqqCEE00uvK2WCGfQhsqa+la
# UKq4BjgaBEm6f8MMHt03a8YS2AvwOMKZBrDIOdUBFDFC04kNeWSHfpRgJGyvnkmc
# 6Whe0t+bU7IKLMOv2akrrnoJr9eWWcpgGgXpZnboMlImEi/nqwhQz7NEt13YxC4D
# dato88tt8zpcoRb0RrrgOGSsbmQ1eKagYw8t00CT+OPeBw3VXHmlSSnnDb6gE3e+
# lD3v++MrWhAfTVYoonpy4BI6t0le2O3tQ5GD2Xuye4Yb2T6xjF3oiU+EGvKhL1nk
# kDstrjNYxbc+/jLTswM9sbKvkjh+0p2ALPVOVpEhNSXDOW5kf1O6nA+tGSOEy/S6
# A4aN91/w0FK/jJSHvMAhdCVfGCi2zCcoOCWYOUo2z3yxkq4cI6epZuxhH2rhKEmd
# X4jiJV3TIUs+UsS1Vz8kA/DRelsv1SPjcF0PUUZ3s/gA4bysAoJf28AVs70b1FVL
# 5zmhD+kjSbwYuER8ReTBw3J64HLnJN+/RpnF78IcV9uDjexNSTCnq47f7Fufr/zd
# sGbiwZeBe+3W7UvnSSmnEyimp31ngOaKYnhfsi+E11ecXL93KCjx7W3DKI8sj0A3
# T8HhhUSJxAlMxdSlQy90lfdu+HggWCwTXWCVmj5PM4TasIgX3p5O9JawvEagbJjS
# 4NaIjAsCAwEAAaOCAe0wggHpMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBRI
# bmTlUAXTgqoXNzcitW2oynUClTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTAL
# BgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBRyLToCMZBD
# uRQFTuHqp8cx0SOJNDBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3JsLm1pY3Jv
# c29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3JsMF4GCCsGAQUFBwEBBFIwUDBOBggrBgEFBQcwAoZCaHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNSb29DZXJBdXQyMDExXzIwMTFf
# MDNfMjIuY3J0MIGfBgNVHSAEgZcwgZQwgZEGCSsGAQQBgjcuAzCBgzA/BggrBgEF
# BQcCARYzaHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3BraW9wcy9kb2NzL3ByaW1h
# cnljcHMuaHRtMEAGCCsGAQUFBwICMDQeMiAdAEwAZQBnAGEAbABfAHAAbwBsAGkA
# YwB5AF8AcwB0AGEAdABlAG0AZQBuAHQALiAdMA0GCSqGSIb3DQEBCwUAA4ICAQBn
# 8oalmOBUeRou09h0ZyKbC5YR4WOSmUKWfdJ5DJDBZV8uLD74w3LRbYP+vj/oCso7
# v0epo/Np22O/IjWll11lhJB9i0ZQVdgMknzSGksc8zxCi1LQsP1r4z4HLimb5j0b
# pdS1HXeUOeLpZMlEPXh6I/MTfaaQdION9MsmAkYqwooQu6SpBQyb7Wj6aC6VoCo/
# KmtYSWMfCWluWpiW5IP0wI/zRive/DvQvTXvbiWu5a8n7dDd8w6vmSiXmE0OPQvy
# CInWH8MyGOLwxS3OW560STkKxgrCxq2u5bLZ2xWIUUVYODJxJxp/sfQn+N4sOiBp
# mLJZiWhub6e3dMNABQamASooPoI/E01mC8CzTfXhj38cbxV9Rad25UAqZaPDXVJi
# hsMdYzaXht/a8/jyFqGaJ+HNpZfQ7l1jQeNbB5yHPgZ3BtEGsXUfFL5hYbXw3MYb
# BL7fQccOKO7eZS/sl/ahXJbYANahRr1Z85elCUtIEJmAH9AAKcWxm6U/RXceNcbS
# oqKfenoi+kiVH6v7RyOA9Z74v2u3S5fi63V4GuzqN5l5GEv/1rMjaHXmr/r8i+sL
# gOppO6/8MO0ETI7f33VtY5E90Z1WTk+/gFcioXgRMiF670EKsT/7qMykXcGhiJtX
# cVZOSEXAQsmbdlsKgEhr/Xmfwb1tbWrJUnMTDXpQzTGCFWUwghVhAgEBMIGVMH4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01p
# Y3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTECEzMAAAGIr1LWuZJt6PkAAAAA
# AYgwDQYJYIZIAWUDBAIBBQCgga4wGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
# HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwLwYJKoZIhvcNAQkEMSIEIB9f
# DzsbfWEqgwPiChLyUcF7SNhnFKkepw4hwF8bWfegMEIGCisGAQQBgjcCAQwxNDAy
# oBSAEgBNAGkAYwByAG8AcwBvAGYAdKEagBhodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20wDQYJKoZIhvcNAQEBBQAEggEAh6M3ochU7HUnPKuUQLQ8KNSHer0F3AcBtkYC
# a9JXWc1SPbHy7Ng6Bkrf2fo5qZH0esi/EsLQkDB4v8n/FiJFXgFrcKbQRiC8z0+W
# oQQhewpgp6Ne0nC+s9I4ZtTZOY64OK8Wgv4IIHghJ7bUqO9RoBWqTReOA/CYVdo/
# Dq2D3QjMfgTCaFpOyzSl58QoML+YDK1OtNiRJNnV+DiOMqz1bHSfrzEs+5Wn5gMC
# wi6xKxDB5JHm/0o9RakjBXTgvozsdExKH0Apr0AGPJzsEL7VgDN4Q5fLVG4u6Gme
# x+rQycCL5M45OHP8ZPBl+uwCJNXUHh89OjKa5l5DlU0eG3q1zaGCEu8wghLrBgor
# BgEEAYI3AwMBMYIS2zCCEtcGCSqGSIb3DQEHAqCCEsgwghLEAgEDMQ8wDQYJYIZI
# AWUDBAIBBQAwggFTBgsqhkiG9w0BCRABBKCCAUIEggE+MIIBOgIBAQYKKwYBBAGE
# WQoDATAxMA0GCWCGSAFlAwQCAQUABCBHbQeewMd+gJ5ymb8tyqE32sV6rwBMrjID
# 30Ydm3zfLQIGX9uZUsW6GBEyMDIxMDExNDEzMDc1NC4xWjAEgAIB9KCB1KSB0TCB
# zjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1Jl
# ZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEpMCcGA1UECxMg
# TWljcm9zb2Z0IE9wZXJhdGlvbnMgUHVlcnRvIFJpY28xJjAkBgNVBAsTHVRoYWxl
# cyBUU1MgRVNOOjREMkYtRTNERC1CRUVGMSUwIwYDVQQDExxNaWNyb3NvZnQgVGlt
# ZS1TdGFtcCBTZXJ2aWNloIIORDCCBPUwggPdoAMCAQICEzMAAAErk9Dtjgr38EcA
# AAAAASswDQYJKoZIhvcNAQELBQAwfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldh
# c2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBD
# b3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIw
# MTAwHhcNMTkxMjE5MDExNTAyWhcNMjEwMzE3MDExNTAyWjCBzjELMAkGA1UEBhMC
# VVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNV
# BAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEpMCcGA1UECxMgTWljcm9zb2Z0IE9w
# ZXJhdGlvbnMgUHVlcnRvIFJpY28xJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNOOjRE
# MkYtRTNERC1CRUVGMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2
# aWNlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAlvqLj8BZWleNACW5
# 2AA0cBFIXLMSOW2rtR2zDmxJmjrw3yhaQv5ArPzjZGoiKCBOW2bp0dgVyYHVhFGo
# x1fpjuAlP1KnwVUjXQXEYXkjp3oG1AKMMFzb+zWKHQTXXVIA2X33kPwWBjx5rm7W
# eoSiaUIFuN2ipjLcA8RPaEAGkgzqFzAhrEK9366CYmcdI/4/Ej/xHEmHyNP8YVHO
# QvXDL+QPaIyXvXULODcMv/IAde6ypLD3mFmZbaa0vsc29LPTiuJ+NnDdCdg/AiLj
# oJKLfgqv2n10HVVXv75mj1KaB2Oa8Z4WMfYm2HfETE+ShQtpau8hupyk6z0TuwBQ
# lMGwHQIDAQABo4IBGzCCARcwHQYDVR0OBBYEFCLvaHS4UgO5dJZhY/PQd5KIwJMF
# MB8GA1UdIwQYMBaAFNVjOlyKMZDzQ3t8RhvFM2hahW1VMFYGA1UdHwRPME0wS6BJ
# oEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01p
# Y1RpbVN0YVBDQV8yMDEwLTA3LTAxLmNybDBaBggrBgEFBQcBAQROMEwwSgYIKwYB
# BQUHMAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9wa2kvY2VydHMvTWljVGlt
# U3RhUENBXzIwMTAtMDctMDEuY3J0MAwGA1UdEwEB/wQCMAAwEwYDVR0lBAwwCgYI
# KwYBBQUHAwgwDQYJKoZIhvcNAQELBQADggEBAGc/+dilpj5ulWziMmUftKwSVXhw
# 692mcKeD5ejG1mc2FVuhBCWkuvs5D+bg5zvzvTtEXyifJdNJYky8cNWEEPvioa5j
# coWapYbDgwaoYuoQJSdQf//G1+Fk8x2LG4wMGZjtK2qRRS5flNFFWHvM11WpLuYT
# 4bMRR53Mjad1NUYm0FQjvdxTvBR7yV58gSdfMp/GzJxPFSizSdQjZigoafz1lY8p
# L9jibflYTdiKuZMyMrnsHkDooQZIGT2+rKsY2K8Qaiok36Yw3xlQskko60UvODFW
# DubPlz8mCwxE+8XBlT3qFZwuCs1XkPd80CdaaIIsIyOIjw3whCzNm8ASnMgwggZx
# MIIEWaADAgECAgphCYEqAAAAAAACMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQg
# Um9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkgMjAxMDAeFw0xMDA3MDEyMTM2NTVa
# Fw0yNTA3MDEyMTQ2NTVaMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5n
# dG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9y
# YXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMIIB
# IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqR0NvHcRijog7PwTl/X6f2mU
# a3RUENWlCgCChfvtfGhLLF/Fw+Vhwna3PmYrW/AVUycEMR9BGxqVHc4JE458YTBZ
# sTBED/FgiIRUQwzXTbg4CLNC3ZOs1nMwVyaCo0UN0Or1R4HNvyRgMlhgRvJYR4Yy
# hB50YWeRX4FUsc+TTJLBxKZd0WETbijGGvmGgLvfYfxGwScdJGcSchohiq9LZIlQ
# YrFd/XcfPfBXday9ikJNQFHRD5wGPmd/9WbAA5ZEfu/QS/1u5ZrKsajyeioKMfDa
# TgaRtogINeh4HLDpmc085y9Euqf03GS9pAHBIAmTeM38vMDJRF1eFpwBBU8iTQID
# AQABo4IB5jCCAeIwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFNVjOlyKMZDz
# Q3t8RhvFM2hahW1VMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsGA1UdDwQE
# AwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFNX2VsuP6KJcYmjRPZSQ
# W9fOmhjEMFYGA1UdHwRPME0wS6BJoEeGRWh0dHA6Ly9jcmwubWljcm9zb2Z0LmNv
# bS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNybDBa
# BggrBgEFBQcBAQROMEwwSgYIKwYBBQUHMAKGPmh0dHA6Ly93d3cubWljcm9zb2Z0
# LmNvbS9wa2kvY2VydHMvTWljUm9vQ2VyQXV0XzIwMTAtMDYtMjMuY3J0MIGgBgNV
# HSABAf8EgZUwgZIwgY8GCSsGAQQBgjcuAzCBgTA9BggrBgEFBQcCARYxaHR0cDov
# L3d3dy5taWNyb3NvZnQuY29tL1BLSS9kb2NzL0NQUy9kZWZhdWx0Lmh0bTBABggr
# BgEFBQcCAjA0HjIgHQBMAGUAZwBhAGwAXwBQAG8AbABpAGMAeQBfAFMAdABhAHQA
# ZQBtAGUAbgB0AC4gHTANBgkqhkiG9w0BAQsFAAOCAgEAB+aIUQ3ixuCYP4FxAz2d
# o6Ehb7Prpsz1Mb7PBeKp/vpXbRkws8LFZslq3/Xn8Hi9x6ieJeP5vO1rVFcIK1GC
# RBL7uVOMzPRgEop2zEBAQZvcXBf/XPleFzWYJFZLdO9CEMivv3/Gf/I3fVo/HPKZ
# eUqRUgCvOA8X9S95gWXZqbVr5MfO9sp6AG9LMEQkIjzP7QOllo9ZKby2/QThcJ8y
# Sif9Va8v/rbljjO7Yl+a21dA6fHOmWaQjP9qYn/dxUoLkSbiOewZSnFjnXshbcOc
# o6I8+n99lmqQeKZt0uGc+R38ONiU9MalCpaGpL2eGq4EQoO4tYCbIjggtSXlZOz3
# 9L9+Y1klD3ouOVd2onGqBooPiRa6YacRy5rYDkeagMXQzafQ732D8OE7cQnfXXSY
# Ighh2rBQHm+98eEA3+cxB6STOvdlR3jo+KhIq/fecn5ha293qYHLpwmsObvsxsvY
# grRyzR30uIUBHoD7G4kqVDmyW9rIDVWZeodzOwjmmC3qjeAzLhIp9cAvVCch98is
# TtoouLGp25ayp0Kiyc8ZQU3ghvkqmqMRZjDTu3QyS99je/WZii8bxyGvWbWu3EQ8
# l1Bx16HSxVXjad5XwdHeMMD9zOZN+w2/XU/pnR4ZOC+8z1gFLu8NoFA12u8JJxzV
# s341Hgi62jbb01+P3nSISRKhggLSMIICOwIBATCB/KGB1KSB0TCBzjELMAkGA1UE
# BhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAc
# BgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEpMCcGA1UECxMgTWljcm9zb2Z0
# IE9wZXJhdGlvbnMgUHVlcnRvIFJpY28xJjAkBgNVBAsTHVRoYWxlcyBUU1MgRVNO
# OjREMkYtRTNERC1CRUVGMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNloiMKAQEwBwYFKw4DAhoDFQBEDDaSD+f/SfrQPt4bL3pZh0NPpqCBgzCB
# gKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQH
# EwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xJjAkBgNV
# BAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwMA0GCSqGSIb3DQEBBQUA
# AgUA46pYMjAiGA8yMDIxMDExNDA5NDIxMFoYDzIwMjEwMTE1MDk0MjEwWjB3MD0G
# CisGAQQBhFkKBAExLzAtMAoCBQDjqlgyAgEAMAoCAQACAikSAgH/MAcCAQACAhKg
# MAoCBQDjq6myAgEAMDYGCisGAQQBhFkKBAIxKDAmMAwGCisGAQQBhFkKAwKgCjAI
# AgEAAgMHoSChCjAIAgEAAgMBhqAwDQYJKoZIhvcNAQEFBQADgYEAi8NmLDCNx9H7
# zDShpjPcNApStYcOv9jpzvWSyOVinZqODx6q/LQPlFah+f1Nb16nLM33k6MfDyo7
# eQLQM5at2GmxBwquouNqC7uS3W2TezpiUqjgdoDpm7rj7tRPg/zjLlt2oqy5CfXg
# 3S8u0g/M90QFgUEPuzoltjAELgllwrAxggMNMIIDCQIBATCBkzB8MQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQg
# VGltZS1TdGFtcCBQQ0EgMjAxMAITMwAAASuT0O2OCvfwRwAAAAABKzANBglghkgB
# ZQMEAgEFAKCCAUowGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJEAEEMC8GCSqGSIb3
# DQEJBDEiBCBdVGwqSSAchkxuWPkFokrzJDD2XS2tfwXCiwQfBJzyZjCB+gYLKoZI
# hvcNAQkQAi8xgeowgecwgeQwgb0EIGQnOeZKhcJTLFzce9iM4ipYx0bovq1MCDcq
# wtpdG89fMIGYMIGApH4wfDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRpbWUtU3RhbXAgUENBIDIwMTACEzMA
# AAErk9Dtjgr38EcAAAAAASswIgQg+0nFtjCWGh5dU1PmQrSXtX6ffIO5v9zkKxAG
# Vc4Q5A0wDQYJKoZIhvcNAQELBQAEggEAKUTMban2WqAYs1FeP/pCdeelxXTh4Y4i
# 7nJGHo/3aSIGTlC7CCcnSX8QX/woZ5MnvMcj85t7Wep2y/FfZ3a7EJujYPHNfsaM
# PrI/mUi3J2JA750gKv7Yyd22toVuKd9uNe9N9I7fooN4eoEJxFsDynqRSV5c7QCn
# JMPuoyFDsRmyMvsGC/E+pnFH5pgynPK9JYB7W4nu782OHtZV7i4bPthWlNymRRd3
# C8peNXeElyExCyXbpWxQWiled8JXWMFQHvF1TdYM3HxTxei1BvOAWc1fpJP2yTUN
# P//SdFL4AfxYzYNiItYlz8Oy1KylVLKSIMYKR4cu7Rqcpj0SMFAE1Q==
# SIG # End signature block
