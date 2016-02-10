# How to PGP

## SYMMETRIC ENCRYPTION
### Encrypt
* optionally encrypt *and* sign an encrypted file with a passphrase
* encrypt on the command line: `gpg -c --cipher-algo aes foo.txt`
  This uses AES as the encryption algorithm and will return a `.gpg`
  file.
* armor option: this creates a file that is ASCII-encoded and safe to
  transmit via email. File type: `.asc`

### Decrypt a symmetrically encrypted file
* `gpg -d foo.txt.gpg` - will override existing files!
* direct output: `gpg -d foo.txt.gpg/asc > myfile.txt`

### SUMMARY
Symmetric is kinda easy since you provide the passphrase to encrypt and
decrypt on the fly.

## PUBLIC KEY ENCRYPTION

### CREATE A KEY PAIR
`gpg --gen-key- will generate a new pair of keys. Choose 4096-bit.

* list your keys and show fingerprint:
`gpg -K --keyid-format long --with-colons --with-fingerprint`

* exporting your public key:
via xclip: `gpg --export -a [fingerprint] | xclip -sel
clip`

* exporting your private key: (!!)
via xclip(!!): gpg --export-secret-keys -a
[fingerprint] | xclip -sel clip

### EDIT EXISTING KEYS
If you want to add an email address, there is no need to revoke the
keys. Do this:
```
gpg --edit-key [key id]
gpg> adduid
[add information]
gpg> save
```

Optionally, include this to indicate trust:
```
gpg> adduid
gpg> uid [user id]
gpg> trust
gpg> 5
gpg> y
gpg> save
```

### Generate a public key file
`gpg --armor --export email@address/ UID > file.name.asc`

### Export private key(!!)
tbc

### Add email address to key file
```
gpg --edit-key [key_id]
gpg> adduid
[enter information]

#optional: add trust level to email
gpg> uid [uid]
gpg> trust

gpg> save
```

### Import a public key
`gpg --import file.name.asc`

### Send an encrypted message to a receiver
* Get the recipient's public key - usually as an .asc file.

* to list all locally available files: `gpg --list-keys`. This will show
  all keys, their encryption algorithm and a UID (`2048R/UID123`)

* to encrypt: `gpg --recipient UID123 / foo@bar.net -e file.txt`, or
  short: `gpg -aer foo@bar.net file.txt'

### Decrypt a received message or file
* if you have a file (`.gpg`/`.asc`), hit `gpg --decrypt foo.txt` on the
  command line. (Or `gpg --decrypt foo.asc > foo.txt`)

## DIGITAL SIGNATURE
* This deals more with the integrity of the document and not its
  confidentiality:
  `gpg --clearsign foo.bar`

* To check: `gpg --verify foo.bar.asc` - requires imported public key!

## ENCRYPT AND SIGN
### How it's done
`gpg --armor --recipient email@address.com --encrypt --sign file.name`
