<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Symfony\Component\Process\Process;

class WebhookController extends Controller
{
    public function handle(Request $request)
    {
        // Validate the webhook request (optional)

        // // Process the incoming webhook payload
        // $payload = $request->all();

        // // Check the event type
        // $eventType = $request->header('X-GitHub-Event');

        // // Only proceed if it's a push event
        if ($eventType === 'push') {
            // Execute the script
            $process = Process::fromShellCommandline('/home/josephemmanuel/webhooks/redeploy.sh');
            $process->run();

            // Check if the process was successful
            if (!$process->isSuccessful()) {
                // Handle the error
                return response()->json(['error' => 'Failed to execute the script'], 500);
            }

            // Script execution successful
            return response()->json(['message' => 'Script executed successfully'], 200);
        }

        // Respond to other event types (optional)

        // Respond to unrecognized events
        return response()->json(['message' => 'Webhook received, but no action taken'], 200);
    }
}

