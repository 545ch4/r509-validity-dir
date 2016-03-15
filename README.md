# r509-validity-dir

This project is related to [r509](http://github.com/r509/r509), [r509-ca-http](http://github.com/r509/r509-ca-http), and [r509-ocsp-responder](http://github.com/r509/r509-ocsp-responder), allowing certificate validity and revocation information to be read using an OpenSSL maintained directory of certificate files and the CRL.

To check the validity we are trying to fetch the given serial at OpenSSLs ```new_certs_dir``` directory and checking the CRL for revocation of that certificate.

Necessary OpenSSL directories given in ```openssl.conf```:

    new_certs_dir = $dir/newcerts
    crl_dir       = $dir/ca.crl

Example init:
   R509::Validity::CRL::Checker.new
      :ca => {
         :new_certs_dir => '<PATH_TO_NEW_CERTS>',
         :crl => '<PATH_TO_CRL_FILE>'
      }
   )

The "status" field can be one of:

    R509::Validity::VALID
    R509::Validity::REVOKED

The "revocation\_reason" field can be one of:

    null
    0  (unspecified)
    1  (keyCompromise)
    2  (cACompromise)
    3  (affiliationChanged)
    4  (superseded)
    5  (cessationOfOperation)
    6  (certificateHold)
    8  (removeFromCRL)
    9  (privilegeWithdrawn)
    10 (aACompromise)
