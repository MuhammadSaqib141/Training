const { app, output } = require('@azure/functions');

const serviceBusTopicOutput = output.serviceBusTopic({
    topicName: 'testtopic',
    connection: 'MyServiceBusConnection'

});

app.timer('timerTriggerToTopic', {
    schedule: '0 */5 * * * *', 
    return: serviceBusTopicOutput, 
    handler: (myTimer, context) => {
        const message = {
            body: `Message created at: ${new Date().toISOString()}`,
            properties: {
                priority: 'high', 
                type: 'notification' 
            },
        };
        context.log('Sending message to topic:', message);
        return message; 
    },
});     