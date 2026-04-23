-- Fix Q4 ordering and rename subtopics to Q4.2 and Q4.3
-- Remove "Perfil" block title

-- Update Q4 header to come right after Q3
UPDATE survey_questions SET sort_order = 6 WHERE question_key = 'q4';

-- Rename Q4.1 to Q4.2 and update sort_order
UPDATE survey_questions 
SET question_number = 'Q4.2', question_key = 'q42_new', sort_order = 7
WHERE question_key = 'q41';

-- Rename Q4.2 to Q4.3 and update sort_order  
UPDATE survey_questions 
SET question_number = 'Q4.3', question_key = 'q43_new', sort_order = 8
WHERE question_key = 'q42';

-- Fix question keys back
UPDATE survey_questions SET question_key = 'q42' WHERE question_key = 'q42_new';
UPDATE survey_questions SET question_key = 'q43' WHERE question_key = 'q43_new';

-- Remove block title for demographic questions (set to empty or same as block 2)
UPDATE survey_questions SET block_title = '' WHERE block_number = 0;

-- Update sort_order for remaining questions
UPDATE survey_questions SET sort_order = 9 WHERE question_key = 'q5';
UPDATE survey_questions SET sort_order = 10 WHERE question_key = 'q6';
UPDATE survey_questions SET sort_order = 11 WHERE question_key = 'q7';
UPDATE survey_questions SET sort_order = 12 WHERE question_key = 'q8';
UPDATE survey_questions SET sort_order = 13 WHERE question_key = 'q9';
UPDATE survey_questions SET sort_order = 14 WHERE question_key = 'q10';
UPDATE survey_questions SET sort_order = 15 WHERE question_key = 'q11';
UPDATE survey_questions SET sort_order = 16 WHERE question_key = 'q12';
UPDATE survey_questions SET sort_order = 17 WHERE question_key = 'q13';
