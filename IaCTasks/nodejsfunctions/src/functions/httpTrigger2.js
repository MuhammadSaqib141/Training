// const { app } = require('@azure/functions');
// const { ServiceBusClient } = require('@azure/service-bus');
// const { DefaultAzureCredential } = require('@azure/identity');

// const fullyQualifiedNamespace = process.env.ServiceBusConnection;
// const topicName = "mytopic";
// const credential = new DefaultAzureCredential();

// app.http('send-messages-to-topic-using-httptigger', {
//     methods: ['GET', 'POST'],
//     authLevel: 'anonymous',
//     handler: async (request, context) => {
//         context.log("HTTP-triggered function started to send messages to Service Bus topic.");

//         const messages = [
//             { body: "Albert Einstein" },
//             { body: "Werner Heisenberg" },
//             { body: "Marie Curie" },
//             { body: "Steven Hawking" },
//             { body: "Isaac Newton" },
//             { body: "Niels Bohr" },
//             { body: "Michael Faraday" },
//             { body: "Galileo Galilei" },
//             { body: "Johannes Kepler" },
//             { body: "Nikolaus Kopernikus" }
//         ];

//         try {
//             // Create the Service Bus client
//             const sbClient = new ServiceBusClient(fullyQualifiedNamespace, credential);
//             const sender = sbClient.createSender(topicName); // Use topicName instead of queueName

//             // Create a batch and send messages
//             let batch = await sender.createMessageBatch();
//             for (const message of messages) {
//                 if (!batch.tryAddMessage(message)) {
//                     // Send the current batch if full
//                     await sender.sendMessages(batch);
//                     batch = await sender.createMessageBatch();

//                     if (!batch.tryAddMessage(message)) {
//                         throw new Error("Message too large to fit in a batch.");
//                     }
//                 }
//             }

//             // Send the last batch
//             await sender.sendMessages(batch);

//             context.log(`Messages sent successfully to topic: ${topicName}`);
//             return { status: 200, body: "Messages sent successfully to the topic!" };
//         } catch (err) {
//             context.log.error("Error occurred while sending messages:", err);
//             return { status: 500, body: `Error sending messages: ${err.message}` };
//         }
//     }
// });