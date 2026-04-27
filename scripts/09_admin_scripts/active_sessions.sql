-- Admin script (may require DBA privileges)

PROMPT Active sessions (requires access to V$SESSION)
SELECT
  sid,
  serial#,
  username,
  status,
  osuser,
  machine,
  program
FROM v$session
WHERE type = 'USER'
ORDER BY status, username;
