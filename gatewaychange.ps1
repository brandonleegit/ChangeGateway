$index = get-netipaddress | where-object {$_.IPAddress -eq '1.2.3.4'} | select -ExpandProperty InterfaceIndex
$Log = 'c:\windows\options\gateway\gatewaychange.log'
$gateway = get-netroute -DestinationPrefix '0.0.0.0/0' | select -ExpandProperty NextHop
$oldroute = '1.1.1.1'
$newroute = '2.2.2.2'
$destination = '0.0.0.0/0'

Function Swap-Gateway() {

remove-netroute -interfaceindex $index -NextHop $oldroute -confirm:$false
new-netroute -interfaceindex $index -NextHop $newroute -destinationprefix $destination -confirm:$false
sleep 3

}

if ($gateway -eq '1.2.3.4') {
Write-Warning -Message "Gateway is set to $gateway and will be changed to $newroute"
Swap-Gateway | Out-file $Log -Append

}
else {
Write-Warning -Message "Gateway is already set to $newroute and needs no change"

}