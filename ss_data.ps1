$qtype = $args[0]

if ($args.Count -lt 3) {
    Write-Output "There is no arguments!"
    exit
}

switch ($qtype) {
    "pool" {
        $qparam = $args[1]
        $qid = $args[2]
        
        $sp = Get-StoragePool -UniqueId "{$qid}"
        if (-not $sp) {
            $sp = Get-StoragePool -UniqueId "$qid"
        }
        if (-not $sp) {
            Write-Output "Object not found!"
            exit
        }

        switch ($qparam) {
            "size" { Write-Output ($sp.Size / 1 ) }
            "allocated" { Write-Output ($sp.AllocatedSize / 1) }
            "opstatus" { Write-Output $sp.OperationalStatus }
            "healthstatus" { Write-Output $sp.HealthStatus }
        }

    }
    "vdisks" {
        $qparam = $args[1]
        $qid = $args[2]

        $vd = Get-VirtualDisk -UniqueId "$qid"

        if (-not $vd) {
            Write-Output "Object not found!"
            exit
        }

        switch ($qparam) {
            "storagepool" { 
                $sp = Get-StoragePool -VirtualDisk $vd
                Write-Output $sp.FriendlyName
            }
            "size" { Write-Output ($vd.Size / 1) }
            "writecachesize" { Write-Output ($vd.WriteCacheSize / 1) }
            "istiered" { if ($vd.IsTiered) { Write-Output 1 } else {Write-Output 0 } }
            "ssdtiersize" { 
                if ($vd.IsTiered) { 
                    $StorageTiers = $vd  | Get-StorageTier
                    Write-Output (($StorageTiers | Where-Object {$_.MediaType -eq 'SSD'}).Size / 1)

                } else {
                    Write-Output 0
                }
             }

             "hddtiersize" {
                if ($vd.IsTiered) {
                    $StorageTiers = $vd  | Get-StorageTier
                    Write-Output (($StorageTiers | Where-Object {$_.MediaType -eq 'HDD'}).Size / 1)
                } else {
                    Write-Output 0
                }
             }

             "opstatus" { Write-Output $vd.OperationalStatus }
             "healthstatus" { Write-Output $vd.HealthStatus }
             "resiliency" { Write-Output $vd.ResiliencySettingName }
             "datacopyes" { Write-Output $vd.NumberOfDataCopies }
             "columns" { Write-Output $vd.NumberofColumns }

        }

    }
}