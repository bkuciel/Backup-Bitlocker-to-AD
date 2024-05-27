# Backup Bitlocker to AD

Script allows you to backup **existing** system drive bitlocker key's to Active Directory.

You can easily use it in GPO to automate backing up computers that already have encrypted system drive.

## What script do?

1. Script checks if there is network connection.
2. Gets system drive bitlocker data
3. Backs up bitlocker data to AD
4. Save's information in Registry, that is backed up, to prevent running backing up every time when script is executed.

## Howto

In the line 4:

```
set IPAddress="10.150.13.11"
```

Replace IP Address with one from your internal network. This IP will be used to check if computer has access to the internal network.

## What script does not do?

Script will not turn on Bitlocker on unencrypted computers. It will not backup other drives than system drive.