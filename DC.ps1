Configuration DC{

    #Variables 
    $domainname='mycloudacademy.org'
    $djoin=(Get-AutomationPSCredential -Name 'Djoiner')
    $domaincred=(Get-AutomationPSCredential -Name 'Djoiner')
    $safemodecred=(Get-AzurePSCredential -Name 'SafeModeCredential')
    $RetryCount='20'
    $RetryIntervalSec='30'

    
    Import-DscResource -ModuleName 'xActiveDirectory'
    Import-DscResource -ModuleName 'xRemoteDesktopAdmin' 
    Import-DSCResource -ModuleName 'xTimeZone'
    Import-DSCResource -ModuleName 'xDSCDomainjoin'
    

    Node DC{

        #Windows Features
        [array]$Features = 'AD-Domain-Services','RSAT-AD-AdminCenter', 'RSAT-ADDS', 'RSAT-AD-PowerShell', 'RSAT-AD-Tools', 'RSAT-Role-Tools', 'DNS','Telnet-client'
         
        ForEach ($feature in $Features){
        WindowsFeature $Feature {
        Ensure = ‘Present’
        Name = $Feature
        IncludeAllSubfeature = $true
                                                  }
                                        } #End ForEach 

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
        
        xWaitForADDomain DscForestWait{
        DomainName = $DomainName
        DomainUserCredential = $domainCred
        RetryCount = $RetryCount
        RetryIntervalSec = $RetryIntervalSec
        DependsOn = "[WindowsFeature]'AD-Domain-Services'"
                                                  }
        
        xADDomainController SecondDC{
        DomainName = $DomainName
        DomainAdministratorCredential = $domainCred
        SafemodeAdministratorPassword = $safemodeCred
        DependsOn = "[xWaitForADDomain]DscForestWait"
                                                   }


    } #End Node Configuration
                }#End Configuration