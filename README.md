# SAML Metadata updater

A simple script that `wget` SAML metadata to a temporary file. 
If a certificate is supplied it will verify the signature of the metadata. If the metadata was signed by the cert it will move the metdata to its final destination.

# Usage

    md-update.sh [-c CERT_FILE] [-q] -o OUT_FILE URL

The `-q` option is for a quiet run with no output.

# Dependencies

If you want to verify the metadata signatrue, you will need to install `xmlsec1`.

    sudo apt-get install xmlsec1
