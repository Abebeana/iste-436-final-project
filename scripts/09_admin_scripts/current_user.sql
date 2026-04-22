-- Context:
-- Admin script

SELECT
  USER AS session_user,
  SYS_CONTEXT('USERENV','CURRENT_SCHEMA') AS current_schema,
  SYS_CONTEXT('USERENV','SESSION_USER') AS session_user_ctx
FROM dual;
