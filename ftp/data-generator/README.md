# Transaction Data Generator

Generates XML transaction files in the format shown below, and writes them
to the directory `/home/ftp-user/transactions`:

```xml
<?xml version="1.0"?>
<transaction>
  <uuid>9f2cac60-6aaa-4fe8-b83d-fbc69619cdbd</uuid>
  <firstname>Lia</firstname>
  <lastname>Huels</lastname>
  <zipcode>49491</zipcode>
  <price>105.00</price>
  <datetime>2020-03-06T01:41:51.587Z</datetime>
</transaction>
```

## Prerequisites

* Node.js v12 (install with [nvm](https://github.com/nvm-sh/nvm) to easily manage versions)

## Check Generator Status

Use `forever list` to see the running generator process status. The list will
also provide a log file location you can use to check for errors.

## Deployment

The FTP setup script should have performed this, but if necessary you can
deploy manually using the following commands:

```bash
# install forever CLI
npm i forever -g

# fetch resources
git clone git@github.com:evanshortiss/rhmi-summit-keynote.git

# start the generator
cd /root/rhmi-summit-keynote/ftp/data-generator/
forever start -c "npm run start" ./
```
