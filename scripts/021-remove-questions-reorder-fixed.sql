-- Remove Q4.1 and Q7
DELETE FROM survey_questions WHERE question_number IN ('Q4.1', 'Q7');

-- Update Q4.2 and Q4.3 to be just Q4 sub-questions (keep as is, they are the only Q4 sub-items now)

-- Add Q12 back (if it doesn't exist)
INSERT INTO survey_questions (question_key, block_title, question_number, question_text, check_note, block_number, question_type, sort_order, options)
SELECT 'q12', '', 'Q12', 'Prefiro anúncios em formato de vídeo curto', NULL, 0, 'likert', 130, '[{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo Parcialmente"},{"value":"3","label":"Neutro"},{"value":"4","label":"Concordo Parcialmente"},{"value":"5","label":"Concordo"}]'
WHERE NOT EXISTS (SELECT 1 FROM survey_questions WHERE question_number = 'Q12');

-- Remove all block titles (set to empty)
UPDATE survey_questions SET block_title = '', block_number = 0;

-- Reorder questions: Q12 before Q13, Q14 last
-- Demographics first
UPDATE survey_questions SET sort_order = 1 WHERE question_number = 'Gênero';
UPDATE survey_questions SET sort_order = 2 WHERE question_number = 'Idade';

-- Main questions
UPDATE survey_questions SET sort_order = 10 WHERE question_number = 'Q1';
UPDATE survey_questions SET sort_order = 20 WHERE question_number = 'Q2';
UPDATE survey_questions SET sort_order = 30 WHERE question_number = 'Q3';
UPDATE survey_questions SET sort_order = 40 WHERE question_number = 'Q4';
UPDATE survey_questions SET sort_order = 41 WHERE question_number = 'Q4.2';
UPDATE survey_questions SET sort_order = 42 WHERE question_number = 'Q4.3';
UPDATE survey_questions SET sort_order = 50 WHERE question_number = 'Q5';
UPDATE survey_questions SET sort_order = 60 WHERE question_number = 'Q6';
UPDATE survey_questions SET sort_order = 70 WHERE question_number = 'Q8';
UPDATE survey_questions SET sort_order = 80 WHERE question_number = 'Q9';
UPDATE survey_questions SET sort_order = 90 WHERE question_number = 'Q10';
UPDATE survey_questions SET sort_order = 100 WHERE question_number = 'Q11';
UPDATE survey_questions SET sort_order = 110 WHERE question_number = 'Q12';
UPDATE survey_questions SET sort_order = 120 WHERE question_number = 'Q13';
UPDATE survey_questions SET sort_order = 130 WHERE question_number = 'Q15';
UPDATE survey_questions SET sort_order = 140 WHERE question_number = 'Q14';
