To allow external access to the local network via tailscale: 
1. Create a external DNS record to the local ip address.

e.g. `*.example.com => 192.168.20.3`

2. Add *Write* access to `Devices` - `Routes`

3. Approve the subnet in the machine page.