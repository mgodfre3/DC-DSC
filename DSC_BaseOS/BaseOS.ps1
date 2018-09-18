Configuration BaseOS{


Import-DscResource -Name 'xDSCDomainjoin'
Import-DscResource -Name 'xRemoteDesktopAdmin'
Import-DscResource -Name 'xTimeZone'
Import-DscResource -ModuleName "xNetworking"
             

 #Variables 
 $domainname='mycloudacademy.org'
 $djoin=(Get-AutomationPSCredential -Name 'Djoiner')

    Node WindowServer{
            xRemoteDesktopAdmin RemoteDesktopSettings{
            Ensure = 'Present'
            UserAuthentication = 'Secure'
                                                     }
                                       
            xTimeZone ServerTime{
            TimeZone = "Eastern Standard Time"
            IsSingleInstance = 'Yes'
                                                     }  
           
            xDSCDomainjoin JoinDomain{
            Domain = $DomainName
            Credential = $djoin # Credential to join to domain
                                                     } 

            xUAC UAC{
            Setting = 'AlwaysNotify'        
                                                     } 
            PSExecutionPolicy PSExecutionPolicy {        
            PSExecutionPolicy ='RemoteSigned'
            }
           <#                                         
            xFirewall AllowRDP{
            Name = 'DSC - Remote Desktop Admin Connections'
            DisplayGroup = "Remote Desktop"
            Ensure = 'Present'
            State = 'Enabled'
            Access = 'Allow'
            Profile = 'Domain'
                                                     }
#>
} #end Node Configuration

} #End Configuration      