// package com.pubsub;

// import com.azure.identity.DefaultAzureCredential;
// import com.azure.identity.DefaultAzureCredentialBuilder;
// import com.azure.messaging.servicebus.ServiceBusClientBuilder;
// import com.azure.messaging.servicebus.ServiceBusMessage;
// import com.azure.messaging.servicebus.ServiceBusSenderClient;
// import com.microsoft.azure.functions.ExecutionContext;
// import com.microsoft.azure.functions.HttpMethod;
// import com.microsoft.azure.functions.HttpRequestMessage;
// import com.microsoft.azure.functions.HttpResponseMessage;
// import com.microsoft.azure.functions.HttpStatus;
// import com.microsoft.azure.functions.annotation.AuthorizationLevel;
// import com.microsoft.azure.functions.annotation.FunctionName;
// import com.microsoft.azure.functions.annotation.HttpTrigger;

// import java.util.Optional;

// public class SendMessageToTopic {

//     public static String topicName = "mytopic";

//     @FunctionName("SendMessageToTopic")
//     public HttpResponseMessage run(
//             @HttpTrigger(
//                 name = "req",
//                 methods = {HttpMethod.GET, HttpMethod.POST},
//                 authLevel = AuthorizationLevel.ANONYMOUS)
//                 HttpRequestMessage<Optional<String>> request,
//             final ExecutionContext context) {

//         context.getLogger().info("-----------------------------Java HTTP trigger processed a request------------------------------------------");

//         context.getLogger().info("Request Body: " + request.getBody().orElse("No body provided"));
//         context.getLogger().info("Query Parameters: " + request.getQueryParameters().toString());

//         final String messageContent = request.getBody().orElse(request.getQueryParameters().get("message"));

//         if (messageContent == null) {
//             return request.createResponseBuilder(HttpStatus.BAD_REQUEST)
//                           .body("Please provide a message in the body or as a query parameter")
//                           .build();
//         }

//         try {
//             sendMessageToServiceBus(messageContent, context);
//             return request.createResponseBuilder(HttpStatus.OK)
//                           .body("Message sent to topic: " + topicName + " with content: " + messageContent)
//                           .build();
//         } catch (Exception e) {
//             context.getLogger().severe("Failed to send message: " + e.getMessage());
//             return request.createResponseBuilder(HttpStatus.INTERNAL_SERVER_ERROR)
//                           .body("Failed to send message to Service Bus. " + e.getMessage())
//                           .build();
//         }
//     }

//     private static void sendMessageToServiceBus(String messageContent, ExecutionContext context) throws Exception {
//         String clientId = System.getenv("AZURE_SERVICEBUS_CLIENTID");
//         String fullyQualifiedNamespace = System.getenv("AZURE_SERVICEBUS_FULLYQUALIFIEDNAMESPACE");

//         context.getLogger().info("Client ID: " + clientId);
//         context.getLogger().info("Namespace: " + fullyQualifiedNamespace);

//         if (clientId == null || fullyQualifiedNamespace == null) {
//             throw new IllegalStateException("Environment variables for Service Bus configuration are not set.");
//         }

//         DefaultAzureCredential credential = new DefaultAzureCredentialBuilder()
//                 // .managedIdentityClientId(clientId)
//                 .build();

//         try (ServiceBusSenderClient senderClient = new ServiceBusClientBuilder()
//                 .fullyQualifiedNamespace(fullyQualifiedNamespace)
//                 .credential(credential)
//                 .sender()
//                 .topicName(topicName)
//                 .buildClient()) {

//             senderClient.sendMessage(new ServiceBusMessage(messageContent));
//             context.getLogger().info("Sent message to Service Bus: " + messageContent);

//         } catch (Exception e) {
//             context.getLogger().severe("Error sending message to Service Bus: " + e.getMessage());
//             throw e;  
//         }
//     }
// }
