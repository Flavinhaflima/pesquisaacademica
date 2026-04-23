-- Fix q9 column to accept long text responses
ALTER TABLE survey_responses 
ALTER COLUMN q9 TYPE TEXT;
