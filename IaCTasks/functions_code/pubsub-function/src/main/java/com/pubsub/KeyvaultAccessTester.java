// package com.pubsub;

// import com.azure.identity.DefaultAzureCredential;
// import com.azure.identity.DefaultAzureCredentialBuilder;
// import com.azure.security.keyvault.secrets.SecretClient;
// import com.azure.security.keyvault.secrets.SecretClientBuilder;
// import com.microsoft.azure.functions.annotation.*;
// import com.microsoft.azure.functions.*;

// import java.util.Optional;

// public class KeyvaultAccessTester {

//     @FunctionName("KeyvaultAccessTester")
//     public HttpResponseMessage run(
//             @HttpTrigger(name = "req", methods = {HttpMethod.GET, HttpMethod.POST}, authLevel = AuthorizationLevel.ANONYMOUS) HttpRequestMessage<Optional<String>> request,
//             final ExecutionContext context) {
//         context.getLogger().info("Java HTTP trigger processed a request.");

//         String secretUri = System.getenv("secretUri");

//         if (secretUri == null || secretUri.isEmpty()) {
//             return request.createResponseBuilder(HttpStatus.BAD_REQUEST)
//                     .body("Secret URI is not provided in environment variables.")
//                     .build();
//         }

//         try {
//             String secretValue = getSecretFromKeyVault(secretUri, context);
//             return request.createResponseBuilder(HttpStatus.OK)
//                     .body("Retrieved secret value: " + secretValue)
//                     .build();
//         } catch (Exception e) {
//             context.getLogger().severe("Error retrieving secret: " + e.getMessage());
//             return request.createResponseBuilder(HttpStatus.INTERNAL_SERVER_ERROR)
//                     .body("Error retrieving secret.")
//                     .build();
//         }
//     }

//     private String getSecretFromKeyVault(String secretUri, ExecutionContext context) {
//         try {
//             // Initialize DefaultAzureCredential for Managed Identity authentication
//             DefaultAzureCredential credential = new DefaultAzureCredentialBuilder().build();
//             // Create the SecretClient to access the Key Vault
//             SecretClient secretClient = new SecretClientBuilder()
//                     .vaultUrl(secretUri)
//                     .credential(credential)
//                     .buildClient();

//             // Extract the secret name from the URI
//             String secretName = "MySecret" ;

//             context.getLogger().info("Connected to Key Vault with secret name: " + secretName);

//             // Retrieve the secret value from Key Vault
//             String secretValue = secretClient.getSecret(secretName).getValue();
//             context.getLogger().info("Successfully retrieved secret.");
//             return secretValue;
//         } catch (Exception e) {
//             context.getLogger().severe("Failed to retrieve secret: " + e.getMessage());
//             throw new RuntimeException("Error accessing Key Vault", e);
//         }
//     }
<<<<<<< HEAD:IaCTasks/functions_code/src/main/java/com/pubsub/KeyvaultAccessTester.java
// }
=======
// }
>>>>>>> c6c04f6 (adding TimeTrigger Functions):IaCTasks/functions_code/pubsub-function/src/main/java/com/pubsub/KeyvaultAccessTester.java
