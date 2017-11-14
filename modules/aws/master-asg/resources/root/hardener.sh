#!/bin/bash

# This script performs various hardening persuant to the CIS Distribution Independent Linux Benchmark

# 6.2.8 Ensure users' home directories permissions are 750 or more restrictive
chmod -R 750 /home/core

# 5.4.4 Ensure default user umask is 027 or more restrictive
sed -i '/^umask/c\# This line hardened according to the CIS Distribution Independent Linux Benchmark, Section 5.4.4\numask 027' /etc/profile
sed -i '/^UMASK/c\# This line hardened according to the CIS Distribution Independent Linux Benchmark, Section 5.4.4\nUMASK 027' /etc/login.defs

# 5.4.1.4 Ensure inactive password lock is 30 days or less
useradd -D -f 30
sed -i '/^PASS_MAX_DAYS/c\# This line hardened according to the CIS Distribution Independent Linux Benchmark, Section 5.4.1.1\nPASS_MAX_DAYS 90' /etc/login.defs
sed -i '/^PASS_MIN_DAYS/c\# This line hardened according to the CIS Distribution Independent Linux Benchmark, Section 5.4.1.2\nPASS_MIN_DAYS 7' /etc/login.defs
chage --inactive 30 --maxdays 90 --mindays 7 --warndays 7 core

# 5.2 SSH Server Configuration
rm -f /etc/ssh/sshd_config
cp /usr/share/ssh/sshd_config /etc/ssh/sshd_config
# 5.2.1 Ensure permissions on /etc/ssh/sshd_config are configured
chown root:root /etc/ssh/sshd_config
chmod og-rwx /etc/ssh/sshd_config
# 5.2.2 Ensure SSH Protocol is set to 2
# 5.2.3 Ensure SSH LogLevel is set to INFO
# 5.2.4 Ensure SSH MaxAuthTries is set to 4 or less
# 5.2.5 Ensure SSH IgnoreRHosts is enabled
# 5.2.6 Ensure SSH HostbasedAuthentication is disabled
# 5.2.7 Ensure SSH root login is disabled
# 5.2.8 Ensure SSH PermitEmptyPasswords is disabled
# 5.2.9 Ensure SSH PermitUserEnvironment is disabled
# 5.2.10 Ensure only approved ciphers are used
# 5.2.11 Ensure Idle Timeout Interval is configured
# 5.2.13 Ensure SSH LoginGraceTime is set to one minute or less
# 5.2.14 Ensure SSH access is limited
# 5.2.15 Ensure SSH warning banner is configured
cat <<EOF >> /etc/ssh/sshd_config

# The following configurations added in accordance with the CIS Distribution Independent Linux Benchmark, Section 5.2
Banner /etc/issue.net
Protocol 2
LogLevel INFO
X11Forwarding no
MaxAuthTries 4
IgnoreRhosts yes
HostbasedAuthentication no
PermitRootLogin no
PermitEmptyPasswords no
PermitUserEnvironment no
Ciphers aes256-ctr,aes192-ctr,aes128-ctr
MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-512,hmac-sha2-256,umac-128@openssh.com
ClientAliveInterval 300
ClientAliveCountMax 0
LoginGraceTime 60
AllowUsers core
EOF

# 3.6 Firewall configuration
# Flush IPtables rules
iptables -F
# 3.6.2 Ensure default deny firewall policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
# 3.6.3 Ensure loopback traffic is configured
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -s 127.0.0.0/8 -j DROP
# 3.6.4 Ensure outbound and established connections are configured
iptables -A OUTPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p udp -m state --state NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p icmp -m state --state NEW,ESTABLISHED -j ACCEPT
# 3.6.5 Ensure firewall rules exist for all open ports
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT