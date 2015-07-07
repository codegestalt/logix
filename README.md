**ATTENTION:** This gem is work in progress and not feature complete (yet)

# Logix
Ruby wrapper for the Crealogix E-Banking web "offline-tool" (API).

## Installation
`gem install logix`

## Usage
**Certificate & Private key:** To be able to connect to your bank you need a valid Certificate and Private Key (usually issued by your Bank / Crealogix).

First you create a new `Logix::Client` instance like follow:

**Example:**

`client = Logix::Client.new(password: 'y0l0', certificate: "./path/to/certificate.crt.pem", private_key: "./path/to/private.key.pem", endpoint: "my.bank.ch")`

*TODO: Show example for additional options like `soft_cert_authentication_endpoint` here.*

After creating the client you can log-in like this.

**Login:**

`client.login!`

If the login is successfull it will return true. Otherwise the method will return false.
To see the specific error codes you can use the `client.last_response` method.


**Getting the last response**

This will return the last HTTP response as a Faraday Hash object.

`client.last_response`

**MT940 Download**

`client.mt940_download(data_type: newMT940)`

Returns the latest unprocessesd MT940 Files.

`client.mt940_download(data_type: oldMT940)`

Returns all MT940 Files that have already been processed.


##Still in work

Following API methods are complete:

- `client.login!`
- `client.mt940_download` (needs tests)

Following API methods are not yet implemented:

- `client.sys_info`
- `client.authenticate!`
- `client.logout`
- `client.session_status`
- `client.login_time`
- `client.esr_download`
- `client.ipi_download`
- `client.lsv_download`
- `client.mt471_download`
- `client.mt536_download`
- `client.mt5xx_download`
- `client.dta_upload`
- `client.dta_status_request`
- `client.download_bank_document_categories`
- `client.download_bank_documents`
