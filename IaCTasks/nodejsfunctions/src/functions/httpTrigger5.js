// const { app } = require('@azure/functions');
// const { SecretClient } = require('@azure/keyvault-secrets');
// const { DefaultAzureCredential } = require('@azure/identity');

// const credential = new DefaultAzureCredential();

// app.http('access-key-vault', {
//     methods: ['GET'],
//     authLevel: 'anonymous',
//     handler: async (request, context) => {
//         context.log("HTTP-triggered function started to access Key Vault.");

//         const keyVaultUrl = process.env.KEY_VAULT_URL;
//         if (!keyVaultUrl) {
//             context.log.error("Key Vault URL is missing.");
//             return { status: 400, body: "Key Vault URL is missing." };
//         }

//         const client = new SecretClient(keyVaultUrl, credential);

//         try {
//             // Retrieve the secret from Key Vault
//             const secretName = 'mySecret1';
//             const secret = await client.getSecret(secretName);

//             context.log(`Fetched secret: ${secretName} = ${secret.value}`);

//             return {
//                 status: 200,
//                 body: {
//                     [secretName]: secret.value
//                 }
//             };
//         } catch (err) {
//             context.log.error("Error fetching secret from Key Vault:", err);
//             return { status: 500, body: `Error fetching secret from Key Vault: ${err.message}` };
//         }
//     }
// });
