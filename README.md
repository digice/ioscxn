# iOSCxn #

_API Client and Server for iOS in Swift and PHP_

### Getting Started ###

1. After cloning the repository, run `./bin/setup.sh` to clone the dependencies and create the MySQL database.

2. Link the `./www` directory to your web server, or move the contents into an accessible path (and upate the `require` statement in `request.php`. The `./www/index.html` file can help you test to make sure the API is working.

3. Create your Xcode project and copy the files within the `./Swift` directory into the project navigator.

4. Modify the URL String in `./Swift/Connection/Connection.swift` to reflect the url to `request.php`. If your web server does not support the HTTPS protocol, you'll need to edit the Info.plist file and add the following tags:

```XML
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
```

5. In the Xcode Project settings, under General->Deployment Info, set the Main Interface to "Test" to test the connection.
