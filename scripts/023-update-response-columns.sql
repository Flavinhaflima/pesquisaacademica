-- Add q12 column back if it doesn't exist
ALTER TABLE survey_responses ADD COLUMN IF NOT EXISTS q12 VARCHAR(10);

-- Rename q41 to q41_new, q42 to q41, q43 to q42
-- First check current state and update accordingly
-- The columns should now be: q0a, q0b, q1, q2, q3, q41, q42, q5, q6, q7, q8, q9, q10, q11, q12, q13
