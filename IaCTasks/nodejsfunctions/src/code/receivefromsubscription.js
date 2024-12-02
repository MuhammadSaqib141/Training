require('dotenv').config(); // Load environment variables from .env file
const { delay, ServiceBusClient } = require("@azure/service-bus");
const { DefaultAzureCredential } = require("@azure/identity");

// Load the fully qualified namespace from the environment variable
const fullyQualifiedNamespace = "node-service-bus.servicebus.windows.net";
if (!fullyQualifiedNamespace) {
    console.error("Fully qualified namespace is not defined. Check your environment variable.");
    process.exit(1);
}

// Passwordless credential using DefaultAzureCredential (for managed identity or Azure CLI login)
const credential = new DefaultAzureCredential();
const topicName = "mytopic"; // Replace with your topic name
const subscriptionName = "mysubscription"; // Replace with your subscription name

async function main() {
    try {
        // Create the ServiceBus client using the namespace and managed identity credential
        const sbClient = new ServiceBusClient(fullyQualifiedNamespace, credential);

        // Create the receiver for the topic and subscription
        const receiver = sbClient.createReceiver(topicName, subscriptionName);

        // Check if receiver is properly initialized before subscribing
        if (!receiver) {
            console.error("Failed to initialize receiver for subscription:", subscriptionName);
            process.exit(1);
        }

        // Define message handler function
        const myMessageHandler = async (messageReceived) => {
            console.log(`Received message: ${messageReceived.body}`);
        };

        // Define error handler function
        const myErrorHandler = async (error) => {
            console.error("Error occurred in receiver: ", error);
        };

        // Subscribe to messages
        receiver.subscribe({
            processMessage: myMessageHandler,
            processError: myErrorHandler
        });

        // Wait to receive messages
        await delay(5000); // Wait for 5 seconds

        // Close the receiver and client
        await receiver.close();
        await sbClient.close();

    } catch (err) {
        console.error("Error occurred: ", err);
        process.exit(1);
    }
}

// Run the main function
main();
