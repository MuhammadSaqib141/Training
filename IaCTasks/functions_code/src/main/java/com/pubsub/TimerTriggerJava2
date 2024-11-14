package com.pubsub;

import java.time.*;
import com.microsoft.azure.functions.annotation.*;
import com.microsoft.azure.functions.*;

/**
 * Azure Functions with Timer trigger.
 */
public class TimerTriggerJava2 {
    /**
     * This function will be invoked periodically according to the specified schedule.
     */
    @FunctionName("TimerTriggerJava2")
    public void run(
        @TimerTrigger(name = "timerInfo", schedule = "%ScheduleAppSetting%") String timerInfo,
        final ExecutionContext context
    ) {
        context.getLogger().info("Java Timer222222222 trigger function executed at: " + LocalDateTime.now());
    }
}
