// package com.pubsub;

// import com.microsoft.azure.functions.annotation.*;
// import com.microsoft.azure.functions.*;
// import com.microsoft.azure.functions.annotation.ServiceBusTopicTrigger;


// /**
//  * Azure Functions with Service Bus Topic Trigger using Managed Identity.
//  */
// public class ServiceBusTopicTriggerr {
//     /**
//      * This function will be invoked when a new message is received at the Service Bus Topic.
//      */
//     @FunctionName("ServiceBusTopicTrigger")
//     public void run(
//         @ServiceBusTopicTrigger(
//             name = "message",
//             topicName = "mytopic",
//             subscriptionName = "mysubscription",
//             connection = "ServiceBusConnection"
//         )
//         String message,
//         final ExecutionContext context
//     ) {
//         context.getLogger().info("Java Service Bus Topic trigger function executed.");
//         if (message != null) {
//             context.getLogger().info("Received message: " + message);
//         } else {
//             context.getLogger().severe("Message is null, check the Service Bus connection and message content.");
//         }
//     }
// }
