// package com.pubsub;

// import com.microsoft.azure.functions.annotation.*;
// import com.microsoft.azure.functions.*;
// import java.util.Optional;


// public class ServiceBusTopicTriggerOutput {

//     @FunctionName("sbtopicsend")
//     public HttpResponseMessage run(
//             @HttpTrigger(name = "req", methods = {HttpMethod.GET, HttpMethod.POST}, authLevel = AuthorizationLevel.ANONYMOUS) HttpRequestMessage<Optional<String>> request,
//             @ServiceBusTopicOutput(name = "message", topicName = "mytopic", subscriptionName = "mysubscription", connection = "ServiceBusConnection") OutputBinding<String> message,
//             final ExecutionContext context) {

//             String name = request.getBody().orElse(request.getQueryParameters().get("message"));

//             message.setValue(name);
//             return request.createResponseBuilder(HttpStatus.OK).body("Hello, " + name).build();

//     }
// }


// package com.pubsub;

// import com.microsoft.azure.functions.annotation.*;
// import com.microsoft.azure.functions.*;
// import java.util.Optional;

// public class ServiceBusTopicTriggerOutput {

//     @FunctionName("sbtopicsend")
//     public HttpResponseMessage run(
//             @HttpTrigger(name = "req", methods = {HttpMethod.GET, HttpMethod.POST, HttpMethod.OPTIONS}, authLevel = AuthorizationLevel.ANONYMOUS) HttpRequestMessage<Optional<String>> request,
//             @ServiceBusTopicOutput(name = "message", topicName = "mytopic", subscriptionName = "mysubscription", connection = "ServiceBusConnection") OutputBinding<String> message,
//             final ExecutionContext context) {

//         // Handle preflight request (OPTIONS)
//         if (request.getHttpMethod() == HttpMethod.OPTIONS) {
//             return request.createResponseBuilder(HttpStatus.OK)
//                     .header("Access-Control-Allow-Origin", "*")
//                     .header("Access-Control-Allow-Methods", "GET, POST, OPTIONS")
//                     .header("Access-Control-Allow-Headers", "Content-Type, Authorization")
//                     .build();
//         }

//         // Handle actual GET or POST request
//         String name = request.getBody().orElse(request.getQueryParameters().get("message"));
        
//         // Send message to Service Bus topic
//         message.setValue(name);

//         // Return a response to the frontend
//         return request.createResponseBuilder(HttpStatus.OK)
//                 .header("Access-Control-Allow-Origin", "*")
//                 .body("Message sent successfully: " + name)
//                 .build();
//     }
// }

