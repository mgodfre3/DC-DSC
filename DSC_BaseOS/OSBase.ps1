Configuration OSBase {
       
param(


    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [Boolean] $xIEEsc_IsEnabled,

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String] $xIEEsc_UserRole,

    [PSCredential] $RenameAndDomainJoin_Credential,

    [String] $RenameAndDomainJoin_DomainName,

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String] $RenameAndDomainJoin_Name,

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String] $RemoteDesktopSettings_Ensure,

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String] $RemoteDesktopSettings_UserAuthentication,

    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [String] $PSExecutionPolicy_PSExecutionPolicy
)
    # resource import
    Import-DscResource –ModuleName xSystemSecurity
Import-DscResource –ModuleName StateConfigCompositeResources

    Node local {
    	xIEEsc xIEEsc {        
	    IsEnabled = $xIEEsc_IsEnabled

	    UserRole = $xIEEsc_UserRole


          }
	RenameAndDomainJoin RenameAndDomainJoin {        
	    Credential = $RenameAndDomainJoin_Credential

	    DomainName = $RenameAndDomainJoin_DomainName

	    Name = $RenameAndDomainJoin_Name


          }
	RemoteDesktopSettings RemoteDesktopSettings {        
	    Ensure = $RemoteDesktopSettings_Ensure

	    UserAuthentication = $RemoteDesktopSettings_UserAuthentication


          }
	PSExecutionPolicy PSExecutionPolicy {        
	    PSExecutionPolicy = $PSExecutionPolicy_PSExecutionPolicy


          }

    }
}