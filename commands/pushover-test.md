---
description: Test Pushover notification delivery to verify credentials are configured correctly
argument-hint: No arguments required
allowed-tools: [Bash, AskUserQuestion]
---

# Pushover Test Command

Test that Pushover notifications are working correctly by sending a test notification.

## What You Need

Before running this command, ensure you have set up your Pushover credentials:

1. **Get a Pushover account**: Sign up at https://pushover.net
2. **Create an application**: Register an app at https://pushover.net/apps/build
3. **Set environment variables**:
   ```bash
   export PUSHOVER_USER_KEY="your_user_key_from_pushover"
   export PUSHOVER_API_KEY="your_api_token_from_app"
   ```

## What This Command Does

This command will:
1. Verify that `PUSHOVER_USER_KEY` and `PUSHOVER_API_KEY` environment variables are set
2. Send a test notification via the Pushover API
3. Report success or failure

## Testing Steps

Run this command to test your Pushover setup:

1. Check if environment variables are configured
2. Send a test message: "Pushover test from interview-plugin"
3. Verify the notification appears on your device

## Troubleshooting

**No notification received?**
- Verify environment variables are set: `echo $PUSHOVER_USER_KEY $PUSHOVER_API_KEY`
- Check your user key and API token at https://pushover.net
- Ensure you have the Pushover app installed on your device
- Check Pushover's status page for service issues

**Environment variables not persisting?**
- Add to your shell profile (`~/.zshrc`, `~/.bashrc`, etc.):
  ```bash
  export PUSHOVER_USER_KEY="your_key"
  export PUSHOVER_API_KEY="your_token"
  ```
- Or set in your project's `.env` file and load it

## Example Output

On success:
```
✓ Environment variables configured
✓ Test notification sent successfully
```

On failure:
```
✗ Missing environment variables
  Please set PUSHOVER_USER_KEY and PUSHOVER_API_KEY
```
