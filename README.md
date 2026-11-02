# LMCP for Hermes

Connect Hermes to [LMCP](https://local-mcp.com), an app that turns the apps you
already use into MCP tools (200+ tools): Apple Mail, Microsoft 365 mail,
Calendar, Teams, Slack, OneDrive, Office files, a browser you log into once, and
the terminal. This plugin currently starts the macOS version of LMCP. LMCP also runs on
Windows, but this plugin does not support it yet.

This is an Agent Plugins v1 package: a root `plugin.json`, an `mcp.json` server
definition and a Hermes skill. It starts the LMCP server you installed
separately. It does not download, install or update LMCP, and it holds no
credentials.

Disclosure: this plugin is published by Colibird, the company that makes LMCP.

## Prerequisites

- macOS.
- LMCP installed from [local-mcp.com](https://local-mcp.com/download?ref=hermes-plugin).
- For Apple Mail tools, Full Disk Access granted to LMCP.
- Optional: a Microsoft 365 account connected in LMCP for `m365_*` tools and
  for sending in Teams.

## Install in Hermes

```
hermes plugins install local-mcp
```

Restart Hermes so the MCP server and its tools load. Try a read-only request
first:

> What's on my calendar today?

The tools are named `mcp__local-mcp__<tool>`. If you already added LMCP by
hand (`hermes mcp add local-mcp ...`), keep one registration: Hermes gives the
manual configuration precedence over a plugin server with the same name.

The launcher (`scripts/start-lmcp.sh`) looks for the LMCP app in
`~/Applications` and `/Applications` and starts the server bundled inside it.
It downloads nothing. If LMCP was installed only through npm, without the app,
install the app from local-mcp.com.

## Scoping tools for unattended jobs

LMCP can read and send mail, post in chats and run terminal commands. For
cron jobs and other unattended runs, expose only the tools the job needs.
Tools that send something off the computer or can't be undone (mail and
messages, terminal commands, permanent deletes) show a preview and require
`confirm: true`; other writes run on the first call. An agent running on its
own can confirm its own call, so filtering is what keeps a morning
summary job from sending anything. The included skill explains this to the
agent. You can also turn on LMCP's read-only mode, which applies to every
client.

## What LMCP does on your Mac

- Reads local app data: the Apple Mail index, the new Teams app's local cache,
  calendars through EventKit, files you point it at.
- Runs terminal commands and drives its own browser window when the agent
  calls those tools.
- WhatsApp access uses an unofficial linked-device client; WhatsApp may
  restrict accounts that use unofficial clients.
- Web AIs (claude.ai, ChatGPT) reach LMCP through an optional cloud connector,
  off by default. Hermes runs locally and does not need it.
- Whatever the agent reads is sent to the model provider Hermes is configured
  to use.
- The LMCP app updates itself, outside Hermes and this plugin.
- **Telemetry.** `LMCP_DISABLE_TELEMETRY=1` turns off usage telemetry in the
  server process this plugin starts. The plugin's launcher also starts the
  LMCP app, which sends its own telemetry, plus a minimal liveness heartbeat
  (computer id, version, licence) that is not disabled.

## License

MIT for this plugin. LMCP itself is a separate, closed-source app.

