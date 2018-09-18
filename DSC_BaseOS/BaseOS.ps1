Configuration BaseOS{


Import-DscResource -ModuleName 'xDSCDomainjoin'
Import-DscResource -Name 'xRemoteDesktopAdmin'
Import-DSCResource -Name 'xTimeZone'
Import-DscResource –ModuleName xSystemSecurity
 
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
                                                          
            xIEESC SetAdminIEESC {
            UserRole = "Administrators"
            IsEnabled = $True           
                                                     }   
                                           
            xUAC UAC{
            Setting = 'AlwaysNotify'        
                                                     } 


} #end Node Configuration


























} #End Configuration      