-- Add missing columns to survey_questions table
ALTER TABLE survey_questions 
ADD COLUMN IF NOT EXISTS block_number INTEGER DEFAULT 1,
ADD COLUMN IF NOT EXISTS question_type VARCHAR(20) DEFAULT 'radio',
ADD COLUMN IF NOT EXISTS sort_order INTEGER DEFAULT 1;

-- Update block_number based on block_title
UPDATE survey_questions SET block_number = 1 WHERE block_title LIKE '%Reação%' OR block_title LIKE '%Reacao%';
UPDATE survey_questions SET block_number = 2 WHERE block_title LIKE '%Comportamento%';
UPDATE survey_questions SET block_number = 3 WHERE block_title LIKE '%Personalização%' OR block_title LIKE '%Personalizacao%';
UPDATE survey_questions SET block_number = 4 WHERE block_title LIKE '%Influência%' OR block_title LIKE '%Influencia%';
UPDATE survey_questions SET block_number = 5 WHERE block_title LIKE '%Memória%' OR block_title LIKE '%Memoria%';
UPDATE survey_questions SET block_number = 6 WHERE block_title LIKE '%Autopercepção%' OR block_title LIKE '%Autopercepcao%';

-- Update question_type for Q9 (textarea)
UPDATE survey_questions SET question_type = 'textarea' WHERE question_key = 'q9';

-- Update sort_order based on question_key
UPDATE survey_questions SET sort_order = 1 WHERE question_key = 'q1';
UPDATE survey_questions SET sort_order = 2 WHERE question_key = 'q2';
UPDATE survey_questions SET sort_order = 3 WHERE question_key = 'q3';
UPDATE survey_questions SET sort_order = 4 WHERE question_key = 'q4';
UPDATE survey_questions SET sort_order = 5 WHERE question_key = 'q5';
UPDATE survey_questions SET sort_order = 6 WHERE question_key = 'q6';
UPDATE survey_questions SET sort_order = 7 WHERE question_key = 'q7';
UPDATE survey_questions SET sort_order = 8 WHERE question_key = 'q8';
UPDATE survey_questions SET sort_order = 9 WHERE question_key = 'q9';
UPDATE survey_questions SET sort_order = 10 WHERE question_key = 'q10';
UPDATE survey_questions SET sort_order = 11 WHERE question_key = 'q11';
UPDATE survey_questions SET sort_order = 12 WHERE question_key = 'q12';
UPDATE survey_questions SET sort_order = 13 WHERE question_key = 'q13';
