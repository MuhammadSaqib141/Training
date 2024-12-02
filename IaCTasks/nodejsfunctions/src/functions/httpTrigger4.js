// const { app } = require('@azure/functions');
// const { AppConfigurationClient } = require('@azure/app-configuration');
// const { DefaultAzureCredential } = require('@azure/identity'); // Use Managed Identity for authentication

// // Initialize DefaultAzureCredential
// const credential = new DefaultAzureCredential();

// app.http('access-app-configuration', {
//     methods: ['GET'],
//     authLevel: 'anonymous',
//     handler: async (request, context) => {
//         context.log("HTTP-triggered function started to access App Configuration.");

//         // Retrieve App Configuration endpoint from environment variables
//         const endpoint = process.env.APP_CONFIGURATION_ENDPOINT;

//         if (!endpoint) {
//             context.log.error("App Configuration endpoint is missing.");
//             return {
//                 status: 400,
//                 body: "App Configuration endpoint is missing. Please set the APP_CONFIGURATION_ENDPOINT environment variable."
//             };
//         } else {
//             context.log(`Endpoint found: ${endpoint}`);
//         }

//         // Initialize AppConfigurationClient with endpoint and DefaultAzureCredential
//         const client = new AppConfigurationClient(endpoint, credential);

//         try {
//             context.log("Initializing credential with DefaultAzureCredential...");
//             context.log("Fetching configuration values...");

//             // Define the keys to fetch
//             const key1 = 'myKey1';
//             const key2 = 'myKey2';
//             context.log(`Fetching configuration for keys: ${key1}, ${key2}`);

//             // Fetch configuration values
//             const config1 = await client.getConfigurationSetting({ key: key1 });
//             const config2 = await client.getConfigurationSetting({ key: key2 });

//             // Log fetched values for debugging
//             context.log(`Fetched configuration: ${key1} = ${config1.value}, ${key2} = ${config2.value}`);

//             // Construct and return a proper JSON response
//             return {
//                 status: 200,
//                 headers: { 'Content-Type': 'application/json' },
//                 body: JSON.stringify({
//                     [key1]: config1.value,
//                     [key2]: config2.value
//                 })
//             };
//         } catch (err) {
//             // Log and return error details
//             context.log.error("Error fetching App Configuration:", err);

//             return {
//                 status: 500,
//                 headers: { 'Content-Type': 'application/json' },
//                 body: JSON.stringify({
//                     error: "Error fetching App Configuration",
//                     details: err.message
//                 })
//             };
//         }
//     }
// });
