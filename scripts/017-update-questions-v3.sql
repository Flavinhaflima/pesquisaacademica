-- Update demographic questions to remove Q0 prefix
UPDATE survey_questions SET question_number = 'Gênero' WHERE question_key = 'q0a';
UPDATE survey_questions SET question_number = 'Idade' WHERE question_key = 'q0b';

-- Update Q3 text
UPDATE survey_questions 
SET question_text = 'O formato da propaganda (como reels, estático ou story) influencia se eu paro para prestar atenção.'
WHERE question_key = 'q3';

-- Update Q4 to be a header question
UPDATE survey_questions 
SET 
  question_text = 'Avalie o quanto cada um dos fatores abaixo influencia você a parar para prestar atenção em uma propaganda:',
  question_type = 'header',
  options = NULL
WHERE question_key = 'q4a' AND question_number = 'Q4a';

-- Actually, let's restructure Q4 properly
-- First update Q4a to be a sub-question
UPDATE survey_questions 
SET 
  question_number = 'Q4.1',
  question_text = 'Relevância (quando o conteúdo tem a ver com meus interesses)',
  block_title = 'Atenção'
WHERE question_key = 'q4a';

UPDATE survey_questions 
SET 
  question_number = 'Q4.2',
  question_text = 'Criatividade (quando a ideia é diferente ou chama atenção)',
  block_title = 'Atenção'
WHERE question_key = 'q4b';

UPDATE survey_questions 
SET 
  question_number = 'Q4.3',
  question_text = 'Estética (quando o visual, edição ou design são atraentes)',
  block_title = 'Atenção'
WHERE question_key = 'q4c';

-- Update block titles to single words
UPDATE survey_questions SET block_title = 'Perfil' WHERE question_key IN ('q0a', 'q0b');
UPDATE survey_questions SET block_title = 'Imersão' WHERE question_key IN ('q1', 'q2');
UPDATE survey_questions SET block_title = 'Comportamento' WHERE question_key = 'q3';
UPDATE survey_questions SET block_title = 'Atenção' WHERE question_key IN ('q4a', 'q4b', 'q4c');
UPDATE survey_questions SET block_title = 'Personalização' WHERE question_key IN ('q5', 'q6');
UPDATE survey_questions SET block_title = 'Influência' WHERE question_key IN ('q7', 'q8', 'q9');
UPDATE survey_questions SET block_title = 'Percepção' WHERE question_key IN ('q10', 'q11');
UPDATE survey_questions SET block_title = 'Controle' WHERE question_key IN ('q13', 'q14', 'q15');

-- Update block numbers for proper ordering
UPDATE survey_questions SET block_number = 0 WHERE question_key IN ('q0a', 'q0b');
UPDATE survey_questions SET block_number = 1 WHERE question_key IN ('q1', 'q2');
UPDATE survey_questions SET block_number = 2 WHERE question_key = 'q3';
UPDATE survey_questions SET block_number = 3 WHERE question_key IN ('q4a', 'q4b', 'q4c');
UPDATE survey_questions SET block_number = 4 WHERE question_key IN ('q5', 'q6');
UPDATE survey_questions SET block_number = 5 WHERE question_key IN ('q7', 'q8', 'q9');
UPDATE survey_questions SET block_number = 6 WHERE question_key IN ('q10', 'q11');
UPDATE survey_questions SET block_number = 7 WHERE question_key IN ('q13', 'q14', 'q15');

-- Insert Q4 header question
INSERT INTO survey_questions (question_key, block_number, block_title, question_number, question_text, question_type, options, sort_order)
VALUES ('q4_header', 3, 'Atenção', 'Q4', 'Avalie o quanto cada um dos fatores abaixo influencia você a parar para prestar atenção em uma propaganda:', 'header', NULL, 40);

-- Update sort orders
UPDATE survey_questions SET sort_order = 1 WHERE question_key = 'q0a';
UPDATE survey_questions SET sort_order = 2 WHERE question_key = 'q0b';
UPDATE survey_questions SET sort_order = 10 WHERE question_key = 'q1';
UPDATE survey_questions SET sort_order = 20 WHERE question_key = 'q2';
UPDATE survey_questions SET sort_order = 30 WHERE question_key = 'q3';
UPDATE survey_questions SET sort_order = 40 WHERE question_key = 'q4_header';
UPDATE survey_questions SET sort_order = 41 WHERE question_key = 'q4a';
UPDATE survey_questions SET sort_order = 42 WHERE question_key = 'q4b';
UPDATE survey_questions SET sort_order = 43 WHERE question_key = 'q4c';
UPDATE survey_questions SET sort_order = 50 WHERE question_key = 'q5';
UPDATE survey_questions SET sort_order = 60 WHERE question_key = 'q6';
UPDATE survey_questions SET sort_order = 70 WHERE question_key = 'q7';
UPDATE survey_questions SET sort_order = 80 WHERE question_key = 'q8';
UPDATE survey_questions SET sort_order = 90 WHERE question_key = 'q9';
UPDATE survey_questions SET sort_order = 100 WHERE question_key = 'q10';
UPDATE survey_questions SET sort_order = 110 WHERE question_key = 'q11';
UPDATE survey_questions SET sort_order = 120 WHERE question_key = 'q13';
UPDATE survey_questions SET sort_order = 130 WHERE question_key = 'q14';
UPDATE survey_questions SET sort_order = 140 WHERE question_key = 'q15';
