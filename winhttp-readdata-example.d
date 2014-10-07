import win32.winbase;
import win32.windef;
import win32.winhttp;
pragma(lib, "winhttp");

int TestWinHttpOpen()
{
    import std.stdio : write, writeln, writefln;
	
    DWORD dwSize = 0;
    DWORD dwDownloaded = 0;
    BOOL  bResults = FALSE;
    HINTERNET  hSession = NULL, 
               hConnect = NULL,
               hRequest = NULL;

    // MSDN recommends a minimum of 8K buffer (could also dynamically allocate this)
    char[8192] OutBuffer;
	
    // Use WinHttpOpen to obtain a session handle.
    hSession = WinHttpOpen( "WinHTTP Example/1.0",  
                            WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
                            WINHTTP_NO_PROXY_NAME, 
                            WINHTTP_NO_PROXY_BYPASS, 0);
    if (!hSession) return -1;
    scope(exit) WinHttpCloseHandle(hSession);

    // Specify an HTTP server.    
    hConnect = WinHttpConnect( hSession, "www.microsoft.com", INTERNET_DEFAULT_HTTPS_PORT, 0);
    if (!hConnect) return -2;
    scope(exit) WinHttpCloseHandle(hConnect);
	
    // Create an HTTP request handle.
    hRequest = WinHttpOpenRequest( hConnect, "GET", cast(LPCWSTR)0,
                                   cast(LPCWSTR)0, WINHTTP_NO_REFERER, 
                                   WINHTTP_DEFAULT_ACCEPT_TYPES, 
                                   WINHTTP_FLAG_SECURE);
    if (!hRequest) return -3;
    scope(exit) WinHttpCloseHandle(hRequest);

    // Send a request.
    bResults = WinHttpSendRequest( hRequest,
                                   WINHTTP_NO_ADDITIONAL_HEADERS,
                                   0, WINHTTP_NO_REQUEST_DATA, 0, 
                                   0, 0);
 
    // End the request.
    if (!bResults) return -4;
        
    bResults = WinHttpReceiveResponse( hRequest, NULL);
    
    // Keep checking for data until there is nothing left.
    if (bResults)
    {
        do 
        {
            // Check for available data.
            dwSize = 0;
            if (!WinHttpQueryDataAvailable( hRequest, &dwSize)) 
            {
                writefln( "Error %s in WinHttpQueryDataAvailable.", GetLastError());
                break;
            }
            
            // No more available data.
            if (!dwSize)
                break;

            // Prepare for new data (MSDN clears buffer each time..)
            OutBuffer[] = 0;
            
            // Read in data, but no more than OutBuffer.length
            if (!WinHttpReadData( hRequest, cast(LPVOID)OutBuffer.ptr,
				dwSize > OutBuffer.length ? OutBuffer.length : dwSize,
				&dwDownloaded))
            {                                  
                writefln( "Error %s in WinHttpReadData.", GetLastError());
            }
            else
            {
                // Write data out (note we don't actually check charset encoding in this example)
                write(OutBuffer[0 .. dwDownloaded]);
            }
        
            // This condition should never be reached since WinHttpQueryDataAvailable
            // reported that there are bits to read.
            if (!dwDownloaded)
                break;
                
        } while (dwSize > 0);
    }
    else
    {
        // Report any errors.
        writefln( "Error %s has occurred (WinHttpReceiveResponse).", GetLastError() );
    }
    
/*
    // Close any open handles.
    // These are handled by scope(exit) above, allowing early returns & exceptions with proper cleanup
    if (hRequest) WinHttpCloseHandle(hRequest);
    if (hConnect) WinHttpCloseHandle(hConnect);
    if (hSession) WinHttpCloseHandle(hSession);
*/
	return 0;
}

int main()
{
	TestWinHttpOpen();
	return 0;
}
