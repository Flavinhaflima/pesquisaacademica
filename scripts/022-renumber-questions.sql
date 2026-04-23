-- Renumber questions and create two blocks (Perfil and Perguntas)

-- First, update demographic questions to have Q0_a and Q0_b numbering
UPDATE survey_questions SET question_number = 'Q0_a', block_title = 'Perfil', block_number = 0 WHERE question_key = 'q0a';
UPDATE survey_questions SET question_number = 'Q0_b', block_title = 'Perfil', block_number = 0 WHERE question_key = 'q0b';

-- Update all other questions to block "Perguntas"
UPDATE survey_questions SET block_title = 'Perguntas', block_number = 1 WHERE block_number != 0 OR block_number IS NULL;

-- Renumber Q4.2 to Q4.1
UPDATE survey_questions SET question_number = 'Q4.1', question_key = 'q41_new' WHERE question_key = 'q42';

-- Renumber Q4.3 to Q4.2
UPDATE survey_questions SET question_number = 'Q4.2', question_key = 'q42_new' WHERE question_key = 'q43';

-- Now fix the question_keys
UPDATE survey_questions SET question_key = 'q41' WHERE question_key = 'q41_new';
UPDATE survey_questions SET question_key = 'q42' WHERE question_key = 'q42_new';

-- Renumber Q8 to Q7
UPDATE survey_questions SET question_number = 'Q7', question_key = 'q7' WHERE question_key = 'q8';

-- Renumber Q9 to Q8
UPDATE survey_questions SET question_number = 'Q8', question_key = 'q8' WHERE question_key = 'q9';

-- Renumber Q10 to Q9
UPDATE survey_questions SET question_number = 'Q9', question_key = 'q9' WHERE question_key = 'q10';

-- Renumber Q11 to Q10
UPDATE survey_questions SET question_number = 'Q10', question_key = 'q10' WHERE question_key = 'q11';

-- Renumber Q12 to Q11
UPDATE survey_questions SET question_number = 'Q11', question_key = 'q11' WHERE question_key = 'q12';

-- Renumber Q13 to Q12
UPDATE survey_questions SET question_number = 'Q12', question_key = 'q12' WHERE question_key = 'q13';

-- Renumber Q14 to Q13
UPDATE survey_questions SET question_number = 'Q13', question_key = 'q13' WHERE question_key = 'q14';

-- Update sort_order to reflect new ordering
UPDATE survey_questions SET sort_order = 1 WHERE question_key = 'q0a';
UPDATE survey_questions SET sort_order = 2 WHERE question_key = 'q0b';
UPDATE survey_questions SET sort_order = 3 WHERE question_key = 'q1';
UPDATE survey_questions SET sort_order = 4 WHERE question_key = 'q2';
UPDATE survey_questions SET sort_order = 5 WHERE question_key = 'q3';
UPDATE survey_questions SET sort_order = 6 WHERE question_key = 'q4';
UPDATE survey_questions SET sort_order = 7 WHERE question_key = 'q41';
UPDATE survey_questions SET sort_order = 8 WHERE question_key = 'q42';
UPDATE survey_questions SET sort_order = 9 WHERE question_key = 'q5';
UPDATE survey_questions SET sort_order = 10 WHERE question_key = 'q6';
UPDATE survey_questions SET sort_order = 11 WHERE question_key = 'q7';
UPDATE survey_questions SET sort_order = 12 WHERE question_key = 'q8';
UPDATE survey_questions SET sort_order = 13 WHERE question_key = 'q9';
UPDATE survey_questions SET sort_order = 14 WHERE question_key = 'q10';
UPDATE survey_questions SET sort_order = 15 WHERE question_key = 'q11';
UPDATE survey_questions SET sort_order = 16 WHERE question_key = 'q12';
UPDATE survey_questions SET sort_order = 17 WHERE question_key = 'q13';
