# PSDokuWiki ![alt text](https://ci.appveyor.com/api/projects/status/github/AndyDLP/PSDokuWiki?branch=master&svg=true "")
PSDokuWiki is a (WIP) PowerShell wrapper for DokuWiki's XML RPC API

Use *New-DokuSession* first, and use the resulting object for authentication to the API e.g.

```powershell
# Create the session object
$DS = New-DokuSession -Server wiki.example.com -Credential (Get-Credential) -Unencrypted -SessionMethod Cookie

# Use it to add text to a page
Add-DokuPageData -DokuSession $DS -FullName 'ns:page' -RawWikiText 'Hello World'
````

## Fault codes

Fault codes generated by the DokuWiki API

  * //100 -> Page errors//
    * //110 -> Page access errors//
      * 111 -> User is not allowed to read the requested page
      * 112 -> User is not allowed to edit the page
      * 113 -> manager permission is required
      * 114 -> superuser permission is required
    * //120 -> Page existence errors//
      * 121 -> The requested page does not exist
    * //130 -> Page edit errors//
      * 131 -> Empty page id
      * 132 -> Empty page content
      * 133 -> Page is locked
      * 134 -> Positive wordblock check
  * //200 -> Media errors//
    * //210 -> Media access errors//
      * 211 -> User is not allowed to read the requested media
      * 212 -> User is not allowed to delete media
      * 215 -> User is not allowed to list media
    * //220 -> Media existence errors//
      * 221 -> The requested media does not exist
    * //230 -> Media edit errors//
      * 231 -> Filename not given
      * 232 -> File is still referenced
      * 233 -> Could not delete file
  * //300 -> Search errors//
    * //310 -> Argument errors//
      * 311 -> The provided value is not a valid timestamp
    * //320 -> Search result errors//
      * 321 -> No changes in specified timeframe

Additionally there are some server error codes that indicate some kind of server or XML-RPC failure. The codes are the following:

  * -32600 -> Invalid XML-RPC request. Not conforming to specification.
  * -32601 -> Requested method does not exist.
  * -32602 -> Wrong number of parameters or invalid method parameters.
  * -32603 -> Not authorized to call the requested method (No login or invalid login data was given).
  * -32604 -> Forbidden to call the requested method (but a valid login was given).
  * -32605 -> The XML-RPC API has not been enabled in the configuration
  * -32700 -> Parse Error. Request not well formed.
  * -32800 -> Recursive calls to system.multicall are forbidden.
  * -99999 -> Unknown server error.
