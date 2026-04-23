-- Remove all Q4 related questions
DELETE FROM survey_questions WHERE question_number LIKE 'Q4%';

-- Add Q4 as header question (no options, just displays text)
INSERT INTO survey_questions (question_key, block_number, block_title, question_number, question_text, check_note, question_type, options, sort_order)
VALUES ('q4', 2, 'Perguntas', 'Q4', 'Avalie o quanto cada um dos fatores abaixo influencia você a parar para prestar atenção em uma propaganda:', NULL, 'header', NULL, 5);

-- Add Q4.1 Criatividade with likert scale
INSERT INTO survey_questions (question_key, block_number, block_title, question_number, question_text, check_note, question_type, options, sort_order)
VALUES ('q41', 2, 'Perguntas', 'Q4.1', 'Criatividade (quando a ideia é diferente ou chama atenção)', NULL, 'likert', '[{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo Parcialmente"},{"value":"3","label":"Neutro"},{"value":"4","label":"Concordo Parcialmente"},{"value":"5","label":"Concordo"}]', 6);

-- Add Q4.2 Estética with likert scale
INSERT INTO survey_questions (question_key, block_number, block_title, question_number, question_text, check_note, question_type, options, sort_order)
VALUES ('q42', 2, 'Perguntas', 'Q4.2', 'Estética (quando o visual, edição ou design são atraentes)', NULL, 'likert', '[{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo Parcialmente"},{"value":"3","label":"Neutro"},{"value":"4","label":"Concordo Parcialmente"},{"value":"5","label":"Concordo"}]', 7);

-- Update sort_order for questions after Q4
UPDATE survey_questions SET sort_order = 8 WHERE question_number = 'Q5';
UPDATE survey_questions SET sort_order = 9 WHERE question_number = 'Q6';
UPDATE survey_questions SET sort_order = 10 WHERE question_number = 'Q7';
UPDATE survey_questions SET sort_order = 11 WHERE question_number = 'Q8';
UPDATE survey_questions SET sort_order = 12 WHERE question_number = 'Q9';
UPDATE survey_questions SET sort_order = 13 WHERE question_number = 'Q10';
UPDATE survey_questions SET sort_order = 14 WHERE question_number = 'Q11';
UPDATE survey_questions SET sort_order = 15 WHERE question_number = 'Q12';
UPDATE survey_questions SET sort_order = 16 WHERE question_number = 'Q13';
