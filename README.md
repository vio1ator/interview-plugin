# interview-plugin

A Claude Code plugin for interactive interviews to gather requirements and refine specifications. Supports spec interviews, PRD interviews, and includes Pushover notifications for session completion alerts.

## Features

### Spec Interviews
- `/interview` - Interactive spec interview for gathering requirements
- `/reinterview` - Interview for changes/additions to an existing spec

### PRD Interviews
- `/interview-prd` - Create a new Product Requirements Document (PRD) through adaptive interview
- `/reinterview-prd` - Refine existing PRD through interview about changes

### Pushover Notifications
- Automatic notifications when Claude Code sessions complete
- Test command to verify Pushover setup

## Installation

1. Clone this repository to your local plugins directory
2. Enable the plugin in Claude Code settings

## Usage

### Spec Interviews

#### /interview

Launch an interactive interview session to gather requirements for a new specification.

```bash
/interview docs/spec.md
```

#### /reinterview

Interview for changes and additions to an existing specification.

```bash
/reinterview docs/spec.md
```

### PRD Interviews

#### /interview-prd

Create a new Product Requirements Document (PRD) through adaptive interview. Covers problem statement, proposed solution, success metrics, and key requirements.

```bash
/interview-prd docs/prd.md
```

The interview uses an adaptive questioning approach - starting broad and drilling deeper based on your responses.

**PRD Structure:**
- Problem Statement: What problem are we solving and for whom?
- Proposed Solution: Product vision, core features, differentiation
- Success Metrics: Primary and secondary metrics, targets
- Key Requirements: Functional, non-functional, and technical constraints

#### /reinterview-prd

Refine an existing PRD through interview about changes, additions, and updates. Focuses only on areas that need changes.

```bash
/reinterview-prd docs/prd.md
```

### Pushover Notifications

#### /pushover-test

Test Pushover notification delivery to verify credentials are configured correctly.

```bash
/pushover-test
```

## Pushover Setup

The Pushover notification feature sends you an alert when a Claude Code session completes, which is useful for long-running tasks.

### Prerequisites

1. **Create a Pushover account**: Sign up at https://pushover.net
2. **Register an application**: Create an app at https://pushover.net/apps/build
3. **Get your credentials**:
   - User Key: Found at https://pushover.net
   - API Token: Found in your app settings

### Configuration

Set the following environment variables:

```bash
export PUSHOVER_USER_KEY="your_user_key"
export PUSHOVER_API_KEY="your_api_token"
```

**For persistent configuration**, add to your shell profile (`~/.zshrc`, `~/.bashrc`, etc.):

```bash
# Pushover notifications for Claude Code
export PUSHOVER_USER_KEY="your_user_key"
export PUSHOVER_API_KEY="your_api_token"
```

### How It Works

- When a Claude Code session ends, a Stop hook triggers
- The hook sends a notification with:
  - Title: "Claude Code finished"
  - Message: "Project: [project-name]"
- The notification is non-blocking and won't affect session behavior

### Troubleshooting

**Not receiving notifications?**

1. Verify environment variables are set:
   ```bash
   echo $PUSHOVER_USER_KEY $PUSHOVER_API_KEY
   ```

2. Test with `/pushover-test` command

3. Check credentials at https://pushover.net

4. Ensure Pushover app is installed on your device

**Still not working?**

The hook is designed to fail silently if credentials are missing. This ensures the plugin doesn't interfere with normal operation.

## Hooks

### Stop Hook

Triggers when a Claude Code session completes. Sends a Pushover notification with the project name.

**Location**: `hooks/hooks.json`
**Script**: `hooks/scripts/stop-pushover.sh`

## Development

### Plugin Structure

```
interview-plugin/
├── .claude-plugin/
│   ├── plugin.json          # Plugin manifest
│   └── marketplace.json     # Marketplace configuration
├── commands/                 # Slash commands
│   ├── interview.md         # /interview
│   ├── reinterview.md       # /reinterview
│   ├── interview-prd.md     # /interview-prd
│   ├── reinterview-prd.md   # /reinterview-prd
│   └── pushover-test.md     # /pushover-test
├── hooks/                    # Event handlers
│   ├── hooks.json
│   └── scripts/
│       └── stop-pushover.sh
├── .gitignore
├── LICENSE
└── README.md
```

### Testing Changes

1. Make changes to the plugin
2. Commit and push to GitHub
3. Pull changes in your Claude Code plugins directory
4. Restart Claude Code to reload plugin configuration

## License

MIT
