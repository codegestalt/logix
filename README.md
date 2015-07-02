**ATTENTION:** This gem is work in progress and not usable at the moment.

# Logix
Ruby wrapper for the Crealogix E-Banking web "offline-tool" (API).

# Quick start
Install via Rubygems

`gem install logix`

... or add to your Gemfile

`gem "logix"`

## Usage
**Certificate & Private key:** To be able to connect to your bank you need a valid Certificate and Private Key (usually issued by your Bank / Crealogix).
You can either provide the path using the constructor or set the predefined environment variables `LOGIX_CERTIFICATE` and `LOGIX_PRIVATE_KEY`.

**Example:**
`client = Logix::Client.new(password: 'y0l0', certificate: "./path/to/certificate.crt.pem", private_key: "./path/to/private.key.pem")`

**Login:**
`client.login!`

### First time login and Certificate activation
If this is your first time using the certificate to login in you need to activate it first. After the activation you need to change the password on your first login.
This can be done with following two steps.

`client.activate!(code_a: "aaa", code_b: "bbb")`

after the certificate has been verified you need to login for the first while also setting a new password:

`client.login!(password: "initialpassword", new_password: "new_password")`

**NOTE:** If the `new_password` option is defined it will ALWAYS overrite the current password. This is handy should you want to change your password in the future.

### Environment Variables
Instead of providing all attributes to the constructor you can also set following environment variables instead:

- `LOGIX_FQDN` the fully qualified domain name of your bank. Example: `"something.bankname.ch"`
- `LOGIX_PASSWORD` your login password.
- `LOGIX_CERTIFICATE` path to the certificate file.
- `LOGIX_PRIVATE_KEY` path to the private key file.

## Bank specific settings
Various endpoints to the API can differ from Bank to Bank. These are what I think are "defaults" used by Crealogix.
You can always change them using the constructor.

- `soft_cert_authentication_endpoint` the endpoint where the login happens. Default value: `/softCertLogin`
- `soft_cert_activation_endpoint` the endpoint that is used for the initial certificate verification (only happens once). Default value: `/softCertActivation`
