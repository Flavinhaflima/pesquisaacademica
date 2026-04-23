-- Drop and recreate survey_responses table with simplified column names
DROP TABLE IF EXISTS survey_responses;

CREATE TABLE survey_responses (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  q1 VARCHAR(1),
  q2 VARCHAR(1),
  q3 VARCHAR(1),
  q4 VARCHAR(1),
  q5 VARCHAR(1),
  q6 VARCHAR(1),
  q7 VARCHAR(1),
  q8 VARCHAR(1),
  q9 VARCHAR(1),
  q10 VARCHAR(1),
  q11 TEXT,
  q12 VARCHAR(1),
  q13 VARCHAR(1),
  q14 VARCHAR(1),
  q15 VARCHAR(1)
);

-- Create index for faster queries
CREATE INDEX idx_survey_created_at ON survey_responses(created_at DESC);
