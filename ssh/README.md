

```markdown
# Secure SSH Server Setup

This project sets up a remote Linux server with secure SSH access using **two separate SSH key pairs**.  
The outcome: you can connect to your server using either key, with simple aliases configured in `~/.ssh/config`.

---

## 1. Provision a Remote Server
You can use any provider (DigitalOcean, AWS, etc.). Example with DigitalOcean:
- Create a new **Ubuntu 22.04 LTS Droplet**.
- Note the **public IP address**.
- Log in initially with the root password provided.

---

## 2. Generate Two SSH Key Pairs
On your local machine:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/server_key1 -C "server key 1"
ssh-keygen -t ed25519 -f ~/.ssh/server_key2 -C "server key 2"
```

This creates:
- `server_key1` / `server_key1.pub`
- `server_key2` / `server_key2.pub`

---

## 3. Create a Non-Root User
On the server:

```bash
adduser shuvo
usermod -aG sudo shuvo
su - shuvo
```

---

## 4. Configure SSH Keys
Inside the new user’s home:

```bash
mkdir -p ~/.ssh
chmod 700 ~/.ssh
nano ~/.ssh/authorized_keys
```

Paste both public keys (`server_key1.pub` and `server_key2.pub`).

```bash
chmod 600 ~/.ssh/authorized_keys
```

---

## 5. Test SSH Connections
From your local machine:

```bash
ssh -i ~/.ssh/server_key1 shuvo@<server-ip>
ssh -i ~/.ssh/server_key2 shuvo@<server-ip>
```

Both should connect successfully.

---

## 6. Configure SSH Aliases
Edit your local `~/.ssh/config`:

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

Now connect with:

```bash
ssh myserver-key1
ssh myserver-key2
```

---

## 7. (Optional) Harden Security with Fail2ban
Install fail2ban:

```bash
sudo apt update && sudo apt install fail2ban -y
```

Configure `/etc/fail2ban/jail.local`:

```ini
[sshd]
enabled = true
port    = ssh
filter  = sshd
logpath = /var/log/auth.log
maxretry = 5
```

Restart and enable:

```bash
sudo systemctl restart fail2ban
sudo systemctl enable fail2ban
```

Check status:

```bash
sudo fail2ban-client status sshd
```

---

## Outcome
- SSH access works with **two key pairs**.  
- Easy connection via `ssh <alias>`.  
- Fail2ban protects against brute-force attacks.
Project [link](https://roadmap.sh/projects/ssh-remote-server-setup)
