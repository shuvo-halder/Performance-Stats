Perfect, Shuvo — this is exactly the kind of project where your methodical, reproducible workflow shines. Let’s break it down step by step so you can set up a remote Linux server, configure SSH with two key pairs, and optionally harden it with **fail2ban**.

---

## 🚀 Step 1: Provision a Remote Linux Server
You can use **DigitalOcean**, **AWS EC2**, or any provider. I’ll outline DigitalOcean since it’s straightforward:

1. Sign up at [DigitalOcean](https://www.digitalocean.com).
2. Create a **Droplet**:
   - Choose **Ubuntu 22.04 LTS** (stable and widely supported).
   - Select a basic plan (e.g., $5/month).
   - Choose a datacenter region close to you.
   - Skip SSH keys for now (we’ll add them manually).
3. Once created, note the **public IP address**.

---

## 🔑 Step 2: Generate Two SSH Key Pairs
On your local machine:

```bash
# First key pair
ssh-keygen -t ed25519 -f ~/.ssh/server_key1 -C "server key 1"

# Second key pair
ssh-keygen -t ed25519 -f ~/.ssh/server_key2 -C "server key 2"
```

- This creates `server_key1` and `server_key1.pub`, plus `server_key2` and `server_key2.pub`.
- Keep private keys safe (`server_key1`, `server_key2`).
- Public keys (`.pub`) will be uploaded to the server.

---

## 🔧 Step 3: Add Keys to the Server
1. Connect to your server using the root password provided by DigitalOcean:

```bash
ssh root@<server-ip>
```

2. Create a user (recommended for security):

```bash
adduser shuvo
usermod -aG sudo shuvo
```

3. Switch to your new user:

```bash
su - shuvo
```

4. Create the `.ssh` directory:

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
```

5. Add both public keys:

```bash
nano ~/.ssh/authorized_keys
```

Paste contents of `server_key1.pub` and `server_key2.pub`.

6. Set permissions:

```bash
chmod 600 ~/.ssh/authorized_keys
```

---

## 🖥️ Step 4: Test SSH Connections
From your local machine:

```bash
ssh -i ~/.ssh/server_key1 shuvo@<server-ip>
ssh -i ~/.ssh/server_key2 shuvo@<server-ip>
```

Both should work.

---

## ⚙️ Step 5: Configure `~/.ssh/config`
Edit your local SSH config:

```bash
nano ~/.ssh/config
```

Add:

```bash
Host myserver-key1
    HostName <server-ip>
    User shuvo
    IdentityFile ~/.ssh/server_key1

Host myserver-key2
    HostName <server-ip>
    User shuvo
    IdentityFile ~/.ssh/server_key2
```

Now you can connect with:

```bash
ssh myserver-key1
ssh myserver-key2
```

---

## 🛡️ Stretch Goal: Install Fail2ban
Fail2ban helps block brute-force attempts.

```bash
sudo apt update && sudo apt install fail2ban -y
```

Configuration file: `/etc/fail2ban/jail.local`

Example:

```ini
[sshd]
enabled = true
port    = ssh
filter  = sshd
logpath = /var/log/auth.log
maxretry = 5
```

Restart service:

```bash
sudo systemctl restart fail2ban
sudo systemctl enable fail2ban
```

Check status:

```bash
sudo fail2ban-client status sshd
```

---

✅ **Outcome:** You can SSH into your server using both keys, either with `ssh -i` or via `ssh <alias>`.  
🔒 **Stretch goal achieved:** Fail2ban is protecting your server.

---

Would you like me to also give you a **step-by-step verification checklist** (with expected outputs for each command) so you can confirm everything is working exactly as intended?
