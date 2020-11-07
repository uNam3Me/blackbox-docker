What is this?
---------------------
Dockerfile to install blackbox in docker
----------------------------------------

Blackbox
-------

Full instructions can be found at: https://github.com/StackExchange/blackbox#overview

Why Is This Important?
------------------------

OBVIOUSLY we don't want secret things like SSL private keys and passwords to be leaked.

NOT SO OBVIOUSLY when we store "secrets" in a VCS repo like Git or Mercurial, suddenly we are less able to share our code with other people. Communication between subteams of an organization is hurt. You can't collaborate as well. Either you find yourself emailing individual files around (yuck!), making a special repo with just the files needed by your collaborators (yuck!!), or just deciding that collaboration isn't worth all that effort (yuck!!!).

The ability to be open and transparent about our code, with the exception of a few specific files, is key to the kind of collaboration that DevOps and modern IT practitioniers need to do.

One-Time Setup
---------------
Follow the numbered steps.

(1) The user must then install the GPG software package and generate a key pair with `gpg --gen-key`:

Open Terminal.

```
Generate a GPG key pair. Since there are multiple versions of GPG, you may need to consult the relevant man page to find the appropriate key generation command. Your key must use RSA.

If you are on version 2.1.17 or greater, paste the text below to generate a GPG key pair.

$ gpg --full-generate-key

If you are not on version 2.1.17 or greater, the gpg --full-generate-key command doesn't work. Paste the text below and skip to step 6.

$ gpg --default-new-key-algo rsa4096 --gen-key


At the prompt, specify the kind of key you want, or press Enter to accept the default RSA and DSA.

Please select what kind of key you want
Your selection? 1

Enter the desired key size. Your key must be at least 4096 bits.
What keysize do you want? (2048) 4096 
Requested keysize is 4096 bits

Enter the length of time the key should be valid. Press Enter to specify the default selection, indicating that the key doesn't expire.
Please specify how long the key should be valid.
Key is valid for? (0) 1y
Key expires at Sat 08 July 2021 03:58:21 PM PDT

Verify that your selections are correct.
Is this correct? (y/N) y

Enter your user ID information.
Is this correct? (y/N) y
Real name: Firstname Lastname
Email address: firstname.lastname@identv.com
Comment: Software Engineer
You selected this USER-ID:    "Firstname Lastname (Software Engineer) <firstname.lastname@identv.com>"
Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit? O

Note: When asked to enter your email address, ensure that you enter the verified email address for your GitHub account. To keep your email address private, use your GitHub-provided no-reply email address. For more information, see "Verifying your email address" and "Setting your commit email address."

Type a secure passphrase.

Use the gpg --list-secret-keys --keyid-format LONG command to list GPG keys for which you have both a public and private key. A private key is required for signing commits or tags.

$ gpg --list-secret-keys --keyid-format LONG

Note: Some GPG installations on Linux may require you to use gpg2 --list-keys --keyid-format LONG to view a list of your existing keys instead. In this case you will also need to configure Git to use gpg2 by running git config --global gpg.program gpg2.

From the list of GPG keys, copy the GPG key ID you'd like to use. In this example, the GPG key ID is 3AA5C34371567BD2:

$ gpg --list-secret-keys --keyid-format LONG
/Users/hubot/.gnupg/secring.gpg
------------------------------------
sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
uid                          Hubot 
ssb   4096R/42B317FD4BA89E7A 2016-03-10

Paste the text below, substituting in the GPG key ID you'd like to use. In this example, the GPG key ID is 3AA5C34371567BD2:

$ gpg --armor --export 3AA5C34371567BD2
# Prints the GPG key ID, in ASCII armor format

Copy your GPG key, beginning with -----BEGIN PGP PUBLIC KEY BLOCK----- and ending with -----END PGP PUBLIC KEY BLOCK-----.

After the key generation is complete, upload it to a keyserver 
with, for example, $ gpg --keyserver pgp.mit.edu --send-key 3AA5C34371567BD2.
```

It is highly recommended that a passphrase is used with the key. 
Key generation may take a long time, this is normal.

Make a note of the key fingerprint (40 characters long) that will be displayed, you will
be need it in a moment.

(2) Install 'Blackbox' from https://github.com/StackExchange/blackbox

Deleting a Key
---------------

If a user leaves the organization, or is otherwise de-authorized, their key needs to be removed from the server, and the credentials and filestore need to be re-encrypted.

Or, to manually delete the key from the repo:
```
git pull
blackbox_removeadmin <email assoc. with key>
Delete this key from the keyring? (y/N) y

blackbox_update_all_files
git commit -a
```

Remember that this person did have access to all the secrets at one time. They could have made a copy. Therefore, to be completely secure, you should change all passwords, generate new SSL keys, and so on just like when anyone that had privileged access leaves an organization.
