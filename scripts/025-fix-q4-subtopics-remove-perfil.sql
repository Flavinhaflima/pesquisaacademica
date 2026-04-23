-- Fix Q4 subtopics to be Q4.2 and Q4.3, and remove Perfil title

-- Update Q4.1 to Q4.2
UPDATE survey_questions 
SET question_number = 'Q4.2', question_key = 'q42'
WHERE question_key = 'q41';

-- Update Q4.2 to Q4.3
UPDATE survey_questions 
SET question_number = 'Q4.3', question_key = 'q43'
WHERE question_key = 'q42' AND question_number = 'Q4.2';

-- Remove block title from demographic questions (set to empty or null)
UPDATE survey_questions 
SET block_title = ''
WHERE block_number = 0;

-- Ensure Q4 header and subtopics come right after Q3
UPDATE survey_questions SET sort_order = 5 WHERE question_key = 'q4';
UPDATE survey_questions SET sort_order = 6 WHERE question_number = 'Q4.2';
UPDATE survey_questions SET sort_order = 7 WHERE question_number = 'Q4.3';

-- Reorder remaining questions
UPDATE survey_questions SET sort_order = 8 WHERE question_key = 'q5';
UPDATE survey_questions SET sort_order = 9 WHERE question_key = 'q6';
UPDATE survey_questions SET sort_order = 10 WHERE question_key = 'q7';
UPDATE survey_questions SET sort_order = 11 WHERE question_key = 'q8';
UPDATE survey_questions SET sort_order = 12 WHERE question_key = 'q9';
UPDATE survey_questions SET sort_order = 13 WHERE question_key = 'q10';
UPDATE survey_questions SET sort_order = 14 WHERE question_key = 'q11';
UPDATE survey_questions SET sort_order = 15 WHERE question_key = 'q12';
UPDATE survey_questions SET sort_order = 16 WHERE question_key = 'q13';
