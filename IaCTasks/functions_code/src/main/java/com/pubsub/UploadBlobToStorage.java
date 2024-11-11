import com.azure.identity.DefaultAzureCredential;
import com.azure.identity.DefaultAzureCredentialBuilder;
import com.azure.storage.blob.BlobClient;
import com.azure.storage.blob.BlobContainerClient;
import com.azure.storage.blob.BlobServiceClient;
import com.azure.storage.blob.BlobServiceClientBuilder;
import com.microsoft.azure.functions.annotation.*;
import com.microsoft.azure.functions.*;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Optional;

public class UploadBlobToStorage {

    @FunctionName("UploadBlob")
    public HttpResponseMessage run(
            @HttpTrigger(name = "req", methods = {HttpMethod.GET, HttpMethod.POST}, authLevel = AuthorizationLevel.ANONYMOUS) HttpRequestMessage<Optional<String>> request,
            final ExecutionContext context) {

        // Set container name and file details
        String containerName = "your-container-name"; // Set this to your container name
        String fileName = "dummy-file-" + System.currentTimeMillis() + ".txt"; // Generate a unique file name
        String fileContent = "This is a dummy file created by Azure Function!";
        
        // Retrieve the connection string from environment variable or Azure Function's default storage setting
        String endpoint = System.getenv("AzureWebJobsStorage");

        if (endpoint == null || endpoint.isEmpty()) {
            context.getLogger().severe("AzureWebJobsStorage environment variable is not set.");
            return request.createResponseBuilder(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("AzureWebJobsStorage environment variable is not set.")
                    .build();
        }

        try {
            // Attempt to initialize DefaultAzureCredential and log the step
            context.getLogger().info("Initializing DefaultAzureCredential for managed identity.");
            DefaultAzureCredential credential = new DefaultAzureCredentialBuilder().build();
            context.getLogger().info("DefaultAzureCredential initialized.");

            // Build BlobServiceClient using the DefaultAzureCredential
            BlobServiceClient blobServiceClient = new BlobServiceClientBuilder()
                    .credential(credential)
                    .endpoint(endpoint)
                    .buildClient();
            context.getLogger().info("BlobServiceClient created with endpoint: " + endpoint);

            // Get BlobContainerClient and create the container if it doesn't exist
            BlobContainerClient containerClient = blobServiceClient.getBlobContainerClient(containerName);
            if (!containerClient.exists()) {
                context.getLogger().info("Container not found. Creating container: " + containerName);
                containerClient.create();
            }

            // Get BlobClient and upload content
            BlobClient blobClient = containerClient.getBlobClient(fileName);
            InputStream dataStream = new ByteArrayInputStream(fileContent.getBytes(StandardCharsets.UTF_8));
            blobClient.upload(dataStream, fileContent.length(), true);
            dataStream.close();
            context.getLogger().info("File " + fileName + " uploaded successfully!");

            // Return response to the client
            return request.createResponseBuilder(HttpStatus.OK)
                    .body("File uploaded successfully!")
                    .build();

        } catch (Exception e) {
            context.getLogger().severe("Error during Blob upload: " + e.getMessage());
            e.printStackTrace();
            return request.createResponseBuilder(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Error uploading blob")
                    .build();
        }
    }
}
