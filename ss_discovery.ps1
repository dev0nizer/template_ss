$dtype = $args[0]


switch ($dtype) {
    "pool" {
        $StoragePools = Get-StoragePool | Where-Object {$_.FriendlyName -ne 'Primordial'}

        Write-Output "{`n `"data`":[`n"
        foreach ($sp in $StoragePools) {
            $line = "{ `n`"{#POOL}`":`"" + $sp.FriendlyName + "`",`n`"{#PDN}`":`"" + $($sp.UniqueId -replace '[{}]') + "`",`n`"{#PH}`":`"0`"`n}`n,"
            Write-Output $line
        }

        Write-Output "{`n`"{#POOL}`":`"PLACEHOLDER`",`n`"{#PDN}`":`"PLACEHOLDER`",`n`"{#PH}`":`"1`"`n}`n"
        Write-Output " ]`n}"
    }

    "vdisks" {
        $StoragePools = Get-StoragePool
        Write-Output "{`n `"data`":[`n"
        foreach ($sp in $StoragePools)
        {
            $VirtualDisks = Get-VirtualDisk -StoragePool $sp
            foreach ($vd in $VirtualDisks)
            {
           
                $line = "{ `n`"{#VDISK}`":`"" + $vd.FriendlyName + "`",`n`"{#VDN}`":`"" + $vd.UniqueId + "`",`n`"{#PH}`":`"0`"`n}`n,"
                Write-Output $line
            }      

        }  

        Write-Output "{`n`"{#VDISK}`":`"PLACEHOLDER`",`n`"{#VDN}`":`"PLACEHOLDER`",`n`"{#PH}`":`"1`"`n}`n"
        Write-Output " ]`n}"     
    }
}
    

