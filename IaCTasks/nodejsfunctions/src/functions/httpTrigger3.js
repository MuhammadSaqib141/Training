// const { app } = require('@azure/functions');
// const { BlobServiceClient } = require('@azure/storage-blob');
// const { DefaultAzureCredential } = require('@azure/identity'); // Managed Identity for authentication

// const credential = new DefaultAzureCredential(); // Uses Managed Identity

// app.http('upload-static-text-to-container', {
//     methods: ['GET', 'POST'],  // Handle both GET and POST requests
//     authLevel: 'anonymous', // This can be changed to 'function' or 'admin' if needed
//     handler: async (request, context) => {
//         const containerName = "mycontainer";  // Set your container name here
//         const blobServiceEndpoint = process.env.AZURE_STORAGE_ENDPOINT;  // The Blob Storage endpoint

//         // Check for POST request and read the JSON body
//         if (request.method === 'POST') {
//             try {
//                 // Parse the JSON body sent by the client (Postman)
//                 const body = await request.json();  // Request body is parsed as JSON
//                 console.log("Request body received:", body); // Log the parsed body

//                 // You can now use the body in your logic, for example:
//                 // Assuming the JSON contains a "content" field to upload
//                 const staticContent = body.content || "Default static content.";  // Use "content" from the body or default

//                 // Static content to upload
//                 console.log("Uploading content:", staticContent);

//                 // Initialize the BlobServiceClient using managed identity
//                 const blobServiceClient = new BlobServiceClient(blobServiceEndpoint, credential);
//                 const containerClient = blobServiceClient.getContainerClient(containerName);

//                 // Check if the container exists, and create it if not
//                 const exists = await containerClient.exists();
//                 if (!exists) {
//                     // Create the container if it doesn't exist
//                     context.log(`Container ${containerName} does not exist. Creating it now...`);
//                     await blobServiceClient.createContainer(containerName);
//                     context.log(`Container ${containerName} created successfully.`);
//                 }

//                 // Convert the static content to a buffer for uploading
//                 const contentBuffer = Buffer.from(staticContent, 'utf-8');

//                 // Generate a unique blob name
//                 const blobName = `static-text-upload-${Date.now()}.txt`;  // Unique name for the blob

//                 // Get a blob client to upload the content
//                 const blobClient = containerClient.getBlockBlobClient(blobName);

//                 // Upload the static content to Blob Storage
//                 await blobClient.upload(contentBuffer, contentBuffer.length);

//                 // Return success response
//                 return { status: 200, body: `Successfully uploaded content as ${blobName}` };

//             } catch (error) {
//                 // Handle JSON parsing errors or any other issues
//                 return { status: 400, body: `Invalid JSON or error processing request: ${error.message}` };
//             }
//         }

//         // Handle other HTTP methods like GET if needed (optional)
//         return { status: 405, body: "Method Not Allowed. Please use POST." };
//     }
// });
