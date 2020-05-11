# FTP Setup

This folder contains a data generator written in Node.js, and instructions to
easily setup an FTP server on a VPS.

_NOTE: This setup script is not intended for use as a production ready configuration. Also, it has only been tested and verified on a Fedora 31 VPS from DigitalOcean for demo purposes._

## VPS FTP Server Setup

Create a Fedora 31 VPS, then issue the following commands:

```bash
ssh root@<server-ip>

git clone https://github.com/evanshortiss/rhmi-summit-2020-keynote

cd rhmi-summit-2020-keynote

./ftp/ftp.setup.sh
```

Note that an FTP connection details are written to stdout by the script once it
is finished. Take note of these since you'll need them!

## Connect to the FTP Service

You can connect to the FTP service using your preferred client.

### Using macOS via Finder

1. Open Finder
1. Select *Go > Connect to Server* from the top menu bar
1. Enter `ftp://<SERVER_IP>` in the dialog box and click *Connect*
1. Select *Registered User* when prompted:
    1. Enter `ftp-user` as the username
    1. Enter the FTP user password
1. You should be connected and able to browse files in the `/home/ftp-user` directory on the VPS