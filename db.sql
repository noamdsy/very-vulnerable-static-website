-- NexaCloud Production DB Backup
-- Generated: 2024-11-03 02:00:01 UTC
-- NUCLEI TRIGGER: exposed database backup file

CREATE TABLE users (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255),
  role VARCHAR(50) DEFAULT 'user',
  created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users VALUES
  ('00000000-0000-0000-0000-000000000001','admin@nexacloud.io','$2b$12$examplehashADMIN','admin','2024-01-01'),
  ('00000000-0000-0000-0000-000000000002','devops@nexacloud-internal.io','$2b$12$examplehashDEV','superadmin','2024-01-01');

CREATE TABLE api_keys (
  id UUID PRIMARY KEY,
  user_id UUID REFERENCES users(id),
  key_hash VARCHAR(255),
  label VARCHAR(100),
  created_at TIMESTAMP DEFAULT NOW()
);

-- prod api keys (rotate after migration)
INSERT INTO api_keys VALUES
  ('aaaaaaaa-0000-0000-0000-000000000001','00000000-0000-0000-0000-000000000001','nxa_prod_aBcDeFgHiJkLmNoPqRsTuVwXyZ123456','production-key','2024-10-01');
