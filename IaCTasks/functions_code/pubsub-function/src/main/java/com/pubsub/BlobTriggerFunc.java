// package com.pubsub;

// import com.microsoft.azure.functions.annotation.*;
// import com.microsoft.azure.functions.*;

// public class BlobTriggerFunc {

//     @FunctionName("BlobTriggerFunction")
//     @StorageAccount("STA_MI_CONN") 
//     public void run(
//         @BlobTrigger(name = "content", path = "container1/{name}", dataType = "binary") byte[] content,
//         @BindingName("name") String name,
//         final ExecutionContext context
//     ) {
//         context.getLogger().info("Connected! Java Blob trigger function processed a blob. Name: " + name + "\n  Size: " + content.length + " Bytes");
//     }
// }

