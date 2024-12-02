// const { app } = require('@azure/functions');

// app.serviceBusTopic('serviceBusQueueTrigger1', {
//     connection: 'MyServiceBusConnection',  
//     topicName: 'mytopic',                
//     subscriptionName: 'mysubscription',    // Ensure this is the correct subscription name
//     handler: (message, context) => {
//         context.log('Service Bus Message Received:', message);
//         context.log('EnqueuedTimeUtc:', context.triggerMetadata.enqueuedTimeUtc);
//         context.log('DeliveryCount:', context.triggerMetadata.deliveryCount);
//         context.log('MessageId:', context.triggerMetadata.messageId);
//     },
// });



// const { app } = require('@azure/functions');
// const { DefaultAzureCredential } = require('@azure/identity');
// const { ServiceBusClient } = require("@azure/service-bus");

// const fullyQualifiedNamespace = process.env.FULLY_QUALIFIED_NAMESPACE;
// const credential = new DefaultAzureCredential();
// const sbClient = new ServiceBusClient(fullyQualifiedNamespace, credential);

// app.serviceBusTopic('mySbMsg', {
//     topicName: 'mytopic',
//     subscriptionName: 'mysubscription',
//     handler: async (message, context) => {
//         context.log(`Message received from topic: ${message.body}`);
//         // Add your message processing logic here
//     }
// });
