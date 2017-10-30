import Kitura
import Foundation
import HeliumLogger

// Define the listening port
let port: Int
let defaultPort = 8080

// Create a new router
let router = Router()

//// Handle HTTP GET requests to /
//router.get("/") {
//    request, response, next in
//    response.send("Hello, World!")
//    next()
//}

router.get("/hello") {
	request, response, next in
	response.headers["Content-Type"] = "text/plain; charset=utf-8"
	do {
		try response.status(.OK).send("Hello world, again!").end()
	}
	catch {
		print("ERROR: Failed to send response to client: \(error)")
	}
}

router.get("/wow") {
	request, response, next in
	response.headers["Content-Type"] = "text/plain; charset=utf-8"
	do {
		try response.status(.OK).send("Wow, Wow, Wow!!!").end()
	}
	catch {
		print("ERROR: Failed to send response to client: \(error)")
	}
}

if let requestedPort = ProcessInfo.processInfo.environment["PORT"] {
	port = Int(requestedPort) ?? defaultPort
}
else {
	port = defaultPort
}
// Add an HTTP server and connect it to the router
Kitura.addHTTPServer(onPort: port, with: router)

// Start the Kitura runloop (this call never returns)
print("Starting server on port \(port)")
Kitura.run()