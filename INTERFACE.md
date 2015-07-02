# Raiffeisen URI Variables

## Production
`<fqdn> tb.raiffeisendirect.ch`
`<authenticationpath> non existend`
`<authenticationpath> (for CLX.Sentinel)  /certLogin`
`<softcertaktivierungpath>  /softCertActivation`
`<softcertauthenticationpath> /softCertLogin`
`<clientpath> non existend`

## Staging System (Needs contracted access)
`<fqdn> at.raiffeisendirect.ch`
`<authenticationpath> non existend`
`<authenticationpath> (for CLX.Sentinel)  /certLogin`
`<softcertaktivierungpath>  /softCertActivation`
`<softcertauthenticationpath> /softCertLogin`
`<clientpath> non existend`

## Testing System (Needs contracted access)
`<fqdn> it.raiffeisendirect.ch`
`<authenticationpath> non existend`
`<authenticationpath> (for CLX.Sentinel)  /certLogin`
`<softcertaktivierungpath>  /softCertActivation`
`<softcertauthenticationpath> /softCertLogin`
`<clientpath> non existend`


# General Endpoints

## Authentication with soft certificate
### Certificate Activation
#### Request
URL: `https://<fqdn><softcertaktivierungspath>/offlinetool/`
Method: `POST`

**Parameters**
`lang` values: `de, fr, it, en`
`codeA` The first code that you will get with the activation letter.
`codeB` The second code that you will get with the activation letter.
`bank` is optional.

####Response
```
<?xml version="1.0" encoding="ISO-8859-1" ?>
<ACTIVATION_SOFT_CERT_RESPONSE>
  <ErrorCode>num</ErrorCode>
  <StatusMsg>Msg</StatusMsg>
  <LastLogin> Msg</LastLogin>
</ACTIVATION_SOFT_CERT_RESPONSE>
```

**`ErrorCode`**
`0` Certificate correct and valid
`1` Certificate and/or conctract unknown
`2` Contract locked
`3` One or multiple activation codes are wrong.
`4` Certificate is locked
`6` Certificate rejected
`7` Certificate expired
`-1` System currently not available

**`StatusMsg`**
Text with error message

**`LastLogin`**
This field only exists if ErrorCode=0. Date and time of the last successfull login in the format dd.mm.yyyy hh:mm

### Login
#### Request

URL: `https://<fqdn><softcertauthenticationpath>/offlinetool/`
Method: `POST`

**Parameters**
`lang` values: `de, fr, it, en`
`password`
`new_password` Mandatory if the password has to be changed (first login), later optional. If present, current password gets overwritten with new password.
`bank` is optional.

####Response
```
<?xml version="1.0" encoding="ISO-8859-1" ?>
<LOGIN_SOFT_CERT_RESPONSE>
  <ErrorCode>num</ErrorCode>
  <StatusMsg>Msg</StatusMsg>
  <LastLogin> Msg</LastLogin>
</LOGIN_SOFT_CERT_RESPONSE>
```

**`ErrorCode`**
`0` Certificate correct and valid
`1` Certificate and/or conctract unknown
`2` Contract locked
`4` User needs to log in on the website to accept disclaimers.
`6` Certificate rejected.
`7` Certificate expired
`8` Password wrong or empty. Please enter new password.
`9` New password is too short or empty. Please enter correct password.
`10` New password is the same as the initial password. Please enter a personal password.
`-1` System currently not available.

**`StatusMsg`**
Text with error message

**`LastLogin`**
This field only exists if ErrorCode=0. Date and time of the last successfull login in the format dd.mm.yyyy hh:mm


> **IMPORTANT:** If the login is successfull the response will include a *RDI_SESS* Cookie in the header. This cookie has to be sent with further requests.

### Logout
#### Request
URL: `https://<fqdn><clientpath>/root/extras/logout`
Method: `POST`

**Parameters**
`output` **xml** If this parameter is omitted, the response is in HTML format.

####Response
```
<?xml version="1.0" encoding="ISO-8859-1" ?>
<LOGOUT_RESPONSE>
  <ErrorCode>num</ErrorCode>
</LOGOUT_RESPONSE>
```

**`ErrorCode`**
`0` Logout successful
`-1` System currently not available

### Session Status
By querying thesession status it can be checked if a HTTP-session is still valid. Atthe same time this function can be used to keep the session alive. This means that the session can be kept active for a longer time and reused for later transactions.

#### Request
URL: `https://<fqdn><clientpath>/root/extras/sessionstatus`
Method: `GET`

####Response
```
<?xml version="1.0" encoding="ISO-8859-1" ?>
<SESSIONSTATUS_RESPONSE>
  <ErrorCode>num</ErrorCode>
  <LoginTime>datetime</LoginTime>
</SESSIONSTATUS_RESPONSE >
```

**`ErrorCode`**
`0` Session is valid
`-1` Session is invalid or system is currently unavailable

**`LoginTime`**
Login time of the current session in the format YYYY-MM-DD HH:MM:SS.mmm. In case of an invalid session this field stays empty.

### Go-Online
#### Request
URL: `https://<fqdn><clientpath>/root/extras/go-online?Page=main`
Method: `GET`

**Parameters**
`page`  values: `main` (default) With the parameter value "main" the main entry page is returned as if the user logged in online. `dtaoverview` The parameter value "dtaoverview" returns the page "Overview of datatransfers". If parameter is omitted, "main" is taken as the default.
