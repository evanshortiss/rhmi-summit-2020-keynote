# FTP Setup

This folder contains a data generator written in Node.js, and instructions to
easily setup an FTP server on a VPS such as DigitalOcean.

## VPS FTP Server Setup

Create a Fedora 31 VPS, then issue the following commands:

```bash
ssh root@<server-ip>

git clone https://github.com/evanshortiss/rhmi-summit-2020-keynote

cd rhmi-summit-2020-keynote

./ftp-setup/ftp.setup.sh
```

Note that an FTP username and password will be provided by the script. Take
note of these since you'll need them!

## Verify FTP from macOS via Finder

1. Open Finder
1. Select *Go > Connect to Server* from the top menu bar
1. Enter `ftp://<SERVER_IP>` in the dialog box and click *Connect*
1. Select *Registered User* when prompted:
    1. Enter `ftp-user` as the username
    1. Enter the FTP user password
1. You should be successfully connected and be able to browse files in `/home/ftp-user` on the remote server