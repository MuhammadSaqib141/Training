// package com.pubsub;

// import com.azure.identity.DefaultAzureCredential;
// import com.azure.identity.DefaultAzureCredentialBuilder;
// import com.azure.storage.blob.BlobClient;
// import com.azure.storage.blob.BlobContainerClient;
// import com.azure.storage.blob.BlobServiceClient;
// import com.azure.storage.blob.BlobServiceClientBuilder;
// import com.microsoft.azure.functions.annotation.*;
// import com.microsoft.azure.functions.*;

// import java.io.ByteArrayInputStream;
// import java.io.InputStream;
// import java.nio.charset.StandardCharsets;
// import java.util.Optional;

// public class UploadBlobToStorage {

//     @FunctionName("UploadBlob")
//     public HttpResponseMessage run(
//             @HttpTrigger(name = "req", methods = {HttpMethod.GET, HttpMethod.POST}, authLevel = AuthorizationLevel.ANONYMOUS) HttpRequestMessage<Optional<String>> request,
//             final ExecutionContext context) {

//         String containerName = "container1";
//         String fileName = "dummy-file-" + System.currentTimeMillis() + ".txt"; 
//         String fileContent = "This is a dummy file created by Azure Function!";
        
//         String storageAccountUrl = System.getenv("AzureWebJobsStorage_account1");

//         try {
//             DefaultAzureCredential credential = new DefaultAzureCredentialBuilder().build();
//             BlobServiceClient blobServiceClient = new BlobServiceClientBuilder()
//                     .credential(credential)
//                     .endpoint(storageAccountUrl)
//                     .buildClient();

//             BlobContainerClient containerClient = blobServiceClient.getBlobContainerClient(containerName);
//             if (!containerClient.exists()) {
//                 containerClient.create();
//             }

//             BlobClient blobClient = containerClient.getBlobClient(fileName);
//             InputStream dataStream = new ByteArrayInputStream(fileContent.getBytes(StandardCharsets.UTF_8));
//             blobClient.upload(dataStream, fileContent.length(), true);
//             dataStream.close();

//             return request.createResponseBuilder(HttpStatus.OK)
//                     .body("File uploaded successfully!")
//                     .build();

//         } catch (Exception e) {
//             context.getLogger().severe("Error during Blob upload: " + e.getMessage());
//             e.printStackTrace();
//             return request.createResponseBuilder(HttpStatus.INTERNAL_SERVER_ERROR)
//                     .body("Error uploading blob")
//                     .build();
//         }
//     }
// }
