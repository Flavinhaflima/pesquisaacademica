-- Reorder questions so Q4.1 and Q4.2 come right after Q3
-- Current order needs to be: Q0_a, Q0_b, Q1, Q2, Q3, Q4.1, Q4.2, Q5, Q6, Q7, Q8, Q9, Q10, Q11, Q12, Q13

-- Update sort_order for all questions
UPDATE survey_questions SET sort_order = 1 WHERE question_number = 'Q0_a';
UPDATE survey_questions SET sort_order = 2 WHERE question_number = 'Q0_b';
UPDATE survey_questions SET sort_order = 3 WHERE question_number = 'Q1';
UPDATE survey_questions SET sort_order = 4 WHERE question_number = 'Q2';
UPDATE survey_questions SET sort_order = 5 WHERE question_number = 'Q3';
UPDATE survey_questions SET sort_order = 6 WHERE question_number = 'Q4.1';
UPDATE survey_questions SET sort_order = 7 WHERE question_number = 'Q4.2';
UPDATE survey_questions SET sort_order = 8 WHERE question_number = 'Q5';
UPDATE survey_questions SET sort_order = 9 WHERE question_number = 'Q6';
UPDATE survey_questions SET sort_order = 10 WHERE question_number = 'Q7';
UPDATE survey_questions SET sort_order = 11 WHERE question_number = 'Q8';
UPDATE survey_questions SET sort_order = 12 WHERE question_number = 'Q9';
UPDATE survey_questions SET sort_order = 13 WHERE question_number = 'Q10';
UPDATE survey_questions SET sort_order = 14 WHERE question_number = 'Q11';
UPDATE survey_questions SET sort_order = 15 WHERE question_number = 'Q12';
UPDATE survey_questions SET sort_order = 16 WHERE question_number = 'Q13';

-- Ensure block title is "Perguntas" for non-demographic questions
UPDATE survey_questions SET block_title = 'Perguntas' WHERE block_number = 2;
