$qtype = $args[0]

if ($args.Count -lt 3) {
    echo "There is no arguments!"
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
            echo "Object not found!"
            exit
        }

        switch ($qparam) {
            "size" { echo ($sp.Size / 1 ) }
            "allocated" { echo ($sp.AllocatedSize / 1) }
            "opstatus" { echo $sp.OperationalStatus }
            "healthstatus" { echo $sp.HealthStatus }
        }

    }
    "vdisks" {
        $qparam = $args[1]
        $qid = $args[2]

        $vd = Get-VirtualDisk -UniqueId "$qid"

        if (-not $vd) {
            echo "Object not found!"
            exit
        }

        switch ($qparam) {
            "storagepool" { 
                $sp = Get-StoragePool -VirtualDisk $vd
                echo $sp.FriendlyName
            }
            "size" { echo ($vd.Size / 1) }
            "writecachesize" { echo ($vd.WriteCacheSize / 1) }
            "istiered" { if ($vd.IsTiered) { echo 1 } else {echo 0 } }
            "ssdtiersize" { 
                if ($vd.IsTiered) { 
                    $StorageTiers = $vd  | Get-StorageTier
                    echo (($StorageTiers | Where-Object {$_.MediaType -eq 'SSD'}).Size / 1)

                } else {
                    echo 0
                }
             }

             "hddtiersize" {
                if ($vd.IsTiered) {
                    $StorageTiers = $vd  | Get-StorageTier
                    echo (($StorageTiers | Where-Object {$_.MediaType -eq 'HDD'}).Size / 1)
                } else {
                    echo 0
                }
             }

             "opstatus" { echo $vd.OperationalStatus }
             "healthstatus" { echo $vd.HealthStatus }
             "resiliency" { echo $vd.ResiliencySettingName }
             "datacopyes" { echo $vd.NumberOfDataCopies }
             "columns" { echo $vd.NumberofColumns }

        }

    }
}