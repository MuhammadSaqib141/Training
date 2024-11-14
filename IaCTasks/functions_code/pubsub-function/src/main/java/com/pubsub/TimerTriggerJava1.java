package com.pubsub;

import java.time.LocalDateTime;
import com.microsoft.azure.functions.annotation.*;
import com.microsoft.azure.functions.*;

public class TimerTriggerJava1 {

    @FunctionName("TimerTriggerJava1")
    public void run(
        @TimerTrigger(name = "timerInfo", schedule = "%ScheduleAppSetting%")
        String timerInfo,
        final ExecutionContext context
    ) {
        context.getLogger().info("Java Timer trigger function started execution.");
        context.getLogger().info("Current time: " + LocalDateTime.now());
        
        // Additional processing code
        context.getLogger().info("Function execution logic goes here.");

        context.getLogger().info("Java Timer trigger function completed execution at: " + LocalDateTime.now());
    }
}
