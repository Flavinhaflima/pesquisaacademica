-- Reorganizar todas as perguntas na ordem correta

-- Bloco 1 - Perfil
UPDATE survey_questions SET block_number = 1, block_title = 'Perfil', sort_order = 1 WHERE question_number = 'Q0_a';
UPDATE survey_questions SET block_number = 1, block_title = 'Perfil', sort_order = 2 WHERE question_number = 'Q0_b';

-- Bloco 2 - Perguntas
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 3 WHERE question_number = 'Q1';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 4 WHERE question_number = 'Q2';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 5 WHERE question_number = 'Q3';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 6 WHERE question_number = 'Q4';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 7 WHERE question_number = 'Q4.1';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 8 WHERE question_number = 'Q4.2';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 9 WHERE question_number = 'Q5';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 10 WHERE question_number = 'Q6';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 11 WHERE question_number = 'Q7';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 12 WHERE question_number = 'Q8';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 13 WHERE question_number = 'Q9';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 14 WHERE question_number = 'Q10';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 15 WHERE question_number = 'Q11';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 16 WHERE question_number = 'Q12';
UPDATE survey_questions SET block_number = 2, block_title = 'Perguntas', sort_order = 17 WHERE question_number = 'Q13';
