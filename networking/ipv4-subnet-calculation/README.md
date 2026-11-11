# IPv4 subnet calculation

Calculating IPv4 subnet information (Cisco Networking Academy lab 11.6.6, Calculate IPv4 Subnets). For each host IP address, an original subnet mask and a new subnet mask, the network address, the first and last usable host address, the broadcast address and the numbers of subnets, subnet bits, host bits and hosts are determined.

## Objectives

- Part 1: Determine IPv4 address subnetting
- Part 2: Calculate IPv4 address subnetting

## How to read the tables

The four count rows show two values: the first is for the **original** subnet mask and the second for the **new** subnet mask. For example, `0, 3` subnet bits means that the original network has no subnet bits and the new mask adds 3.

## Results

### 1. 192.168.200.139

| Given | |
|---|---|
| Host IP address | 192.168.200.139 |
| Original subnet mask | 255.255.255.0 |
| New subnet mask | 255.255.255.224 (/27) |

| Find | Answer |
|---|---|
| Number of subnet bits | 0, 3 |
| Number of subnets created | 1, 8 |
| Number of host bits per subnet | 8, 5 |
| Number of hosts per subnet | 254, 30 |
| Network address of this subnet | 192.168.200.128 |
| IPv4 address of first host on this subnet | 192.168.200.129 |
| IPv4 address of last host on this subnet | 192.168.200.158 |
| IPv4 broadcast address on this subnet | 192.168.200.159 |

### 2. 10.101.99.228

| Given | |
|---|---|
| Host IP address | 10.101.99.228 |
| Original subnet mask | 255.0.0.0 |
| New subnet mask | 255.255.128.0 (/17) |

| Find | Answer |
|---|---|
| Number of subnet bits | 0, 9 |
| Number of subnets created | 1, 512 |
| Number of host bits per subnet | 24, 15 |
| Number of hosts per subnet | 16 777 214, 32 766 |
| Network address of this subnet | 10.101.0.0 |
| IPv4 address of first host on this subnet | 10.101.0.1 |
| IPv4 address of last host on this subnet | 10.101.127.254 |
| IPv4 broadcast address on this subnet | 10.101.127.255 |

### 3. 172.22.32.12

| Given | |
|---|---|
| Host IP address | 172.22.32.12 |
| Original subnet mask | 255.255.0.0 |
| New subnet mask | 255.255.224.0 (/19) |

| Find | Answer |
|---|---|
| Number of subnet bits | 0, 3 |
| Number of subnets created | 1, 8 |
| Number of host bits per subnet | 16, 13 |
| Number of hosts per subnet | 65 534, 8 190 |
| Network address of this subnet | 172.22.32.0 |
| IPv4 address of first host on this subnet | 172.22.32.1 |
| IPv4 address of last host on this subnet | 172.22.63.254 |
| IPv4 broadcast address on this subnet | 172.22.63.255 |

### 4. 192.168.1.245

| Given | |
|---|---|
| Host IP address | 192.168.1.245 |
| Original subnet mask | 255.255.255.0 |
| New subnet mask | 255.255.255.252 (/30) |

| Find | Answer |
|---|---|
| Number of subnet bits | 0, 6 |
| Number of subnets created | 1, 64 |
| Number of host bits per subnet | 8, 2 |
| Number of hosts per subnet | 254, 2 |
| Network address of this subnet | 192.168.1.244 |
| IPv4 address of first host on this subnet | 192.168.1.245 |
| IPv4 address of last host on this subnet | 192.168.1.246 |
| IPv4 broadcast address on this subnet | 192.168.1.247 |

### 5. 128.107.0.55

| Given | |
|---|---|
| Host IP address | 128.107.0.55 |
| Original subnet mask | 255.255.0.0 |
| New subnet mask | 255.255.255.0 (/24) |

| Find | Answer |
|---|---|
| Number of subnet bits | 0, 8 |
| Number of subnets created | 1, 256 |
| Number of host bits per subnet | 16, 8 |
| Number of hosts per subnet | 65 534, 254 |
| Network address of this subnet | 128.107.0.0 |
| IPv4 address of first host on this subnet | 128.107.0.1 |
| IPv4 address of last host on this subnet | 128.107.0.254 |
| IPv4 broadcast address on this subnet | 128.107.0.255 |

### 6. 192.135.250.180

| Given | |
|---|---|
| Host IP address | 192.135.250.180 |
| Original subnet mask | 255.255.255.0 |
| New subnet mask | 255.255.255.248 (/29) |

| Find | Answer |
|---|---|
| Number of subnet bits | 0, 5 |
| Number of subnets created | 1, 32 |
| Number of host bits per subnet | 8, 3 |
| Number of hosts per subnet | 254, 6 |
| Network address of this subnet | 192.135.250.176 |
| IPv4 address of first host on this subnet | 192.135.250.177 |
| IPv4 address of last host on this subnet | 192.135.250.182 |
| IPv4 broadcast address on this subnet | 192.135.250.183 |

## Reflection question

**Why is the subnet mask so important when analyzing an IPv4 address?**

The subnet mask determines which part of an IPv4 address belongs to the network and which part to an individual device (host). It allows a network to be divided into smaller subnets, so that several separate network areas are formed inside the same network, which can then be managed better.
