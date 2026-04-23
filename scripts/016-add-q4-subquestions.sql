-- Add columns for Q4 sub-questions
ALTER TABLE survey_responses ADD COLUMN IF NOT EXISTS q4a VARCHAR(10);
ALTER TABLE survey_responses ADD COLUMN IF NOT EXISTS q4b VARCHAR(10);
ALTER TABLE survey_responses ADD COLUMN IF NOT EXISTS q4c VARCHAR(10);

-- Remove Q12 column (question was deleted)
ALTER TABLE survey_responses DROP COLUMN IF EXISTS q12;
