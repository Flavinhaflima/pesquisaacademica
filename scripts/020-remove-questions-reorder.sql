-- Remove Q4.1 and Q7, reorder questions
DELETE FROM survey_questions WHERE question_number = 'Q4.1';
DELETE FROM survey_questions WHERE question_number = 'Q7';

-- Add Q12 back (was deleted earlier)
INSERT INTO survey_questions (question_key, block_title, question_number, question_text, question_type, block_number, sort_order, options)
VALUES ('q12', 'Percepção', 'Q12', 'Prefiro anúncios em formato de vídeo curto', 'likert', 7, 120, '[{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo Parcialmente"},{"value":"3","label":"Neutro"},{"value":"4","label":"Concordo Parcialmente"},{"value":"5","label":"Concordo"}]');

-- Update sort_order to put Q12 before Q13 and Q14 last
UPDATE survey_questions SET sort_order = 10 WHERE question_number = 'Gênero';
UPDATE survey_questions SET sort_order = 20 WHERE question_number = 'Idade';
UPDATE survey_questions SET sort_order = 30 WHERE question_number = 'Q1';
UPDATE survey_questions SET sort_order = 40 WHERE question_number = 'Q2';
UPDATE survey_questions SET sort_order = 50 WHERE question_number = 'Q3';
UPDATE survey_questions SET sort_order = 60 WHERE question_number = 'Q4';
UPDATE survey_questions SET sort_order = 70 WHERE question_number = 'Q4.2';
UPDATE survey_questions SET sort_order = 80 WHERE question_number = 'Q4.3';
UPDATE survey_questions SET sort_order = 90 WHERE question_number = 'Q5';
UPDATE survey_questions SET sort_order = 100 WHERE question_number = 'Q6';
UPDATE survey_questions SET sort_order = 110 WHERE question_number = 'Q8';
UPDATE survey_questions SET sort_order = 120 WHERE question_number = 'Q9';
UPDATE survey_questions SET sort_order = 130 WHERE question_number = 'Q10';
UPDATE survey_questions SET sort_order = 140 WHERE question_number = 'Q11';
UPDATE survey_questions SET sort_order = 150 WHERE question_number = 'Q12';
UPDATE survey_questions SET sort_order = 160 WHERE question_number = 'Q13';
UPDATE survey_questions SET sort_order = 170 WHERE question_number = 'Q15';
UPDATE survey_questions SET sort_order = 180 WHERE question_number = 'Q14';
