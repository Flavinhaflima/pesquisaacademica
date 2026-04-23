-- Update age options for Q0B
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "Entre 14-28 anos"},
  {"value": "b", "label": "Entre 29-43 anos"},
  {"value": "c", "label": "Entre 44-59 anos"},
  {"value": "d", "label": "Acima de 60 anos"}
]'::jsonb WHERE question_key = 'q0b';

-- Update Likert scale options for all Likert questions (5 points)
UPDATE survey_questions SET options = '[
  {"value": "1", "label": "Discordo"},
  {"value": "2", "label": "Discordo parcialmente"},
  {"value": "3", "label": "Neutro"},
  {"value": "4", "label": "Concordo parcialmente"},
  {"value": "5", "label": "Concordo"}
]'::jsonb WHERE question_type = 'likert';

-- Delete Q12
DELETE FROM survey_questions WHERE question_key = 'q12';

-- Update Q4 to be the main question with sub-items
UPDATE survey_questions SET 
  question_text = 'Avalie o quanto cada um dos fatores abaixo influencia você a parar para prestar atenção em um anúncio:',
  question_type = 'likert_group'
WHERE question_key = 'q4';

-- Insert Q4 sub-questions
INSERT INTO survey_questions (question_key, block_title, question_number, question_text, question_type, block_number, sort_order, options) VALUES
('q4a', 'Bloco 2 - Atenção e Engajamento', 'Q4a', 'Relevância (quando o conteúdo tem a ver com meus interesses)', 'likert', 2, 7, '[
  {"value": "1", "label": "Discordo"},
  {"value": "2", "label": "Discordo parcialmente"},
  {"value": "3", "label": "Neutro"},
  {"value": "4", "label": "Concordo parcialmente"},
  {"value": "5", "label": "Concordo"}
]'::jsonb),
('q4b', 'Bloco 2 - Atenção e Engajamento', 'Q4b', 'Criatividade (quando a ideia é diferente ou chama atenção)', 'likert', 2, 8, '[
  {"value": "1", "label": "Discordo"},
  {"value": "2", "label": "Discordo parcialmente"},
  {"value": "3", "label": "Neutro"},
  {"value": "4", "label": "Concordo parcialmente"},
  {"value": "5", "label": "Concordo"}
]'::jsonb),
('q4c', 'Bloco 2 - Atenção e Engajamento', 'Q4c', 'Estética (quando o visual, edição ou design são atraentes)', 'likert', 2, 9, '[
  {"value": "1", "label": "Discordo"},
  {"value": "2", "label": "Discordo parcialmente"},
  {"value": "3", "label": "Neutro"},
  {"value": "4", "label": "Concordo parcialmente"},
  {"value": "5", "label": "Concordo"}
]'::jsonb);

-- Delete old Q4 and renumber
DELETE FROM survey_questions WHERE question_key = 'q4' AND question_type = 'likert_group';

-- Update sort_order for questions after Q4
UPDATE survey_questions SET sort_order = sort_order + 2 WHERE sort_order > 9 AND question_key NOT IN ('q4a', 'q4b', 'q4c');

-- Renumber questions after Q12 deletion (Q13, Q14, Q15 become Q12, Q13, Q14)
UPDATE survey_questions SET question_number = 'Q12', question_key = 'q12_new' WHERE question_key = 'q13';
UPDATE survey_questions SET question_number = 'Q13', question_key = 'q13_new' WHERE question_key = 'q14';
UPDATE survey_questions SET question_number = 'Q14', question_key = 'q14_new' WHERE question_key = 'q15';

-- Fix the keys
UPDATE survey_questions SET question_key = 'q12' WHERE question_key = 'q12_new';
UPDATE survey_questions SET question_key = 'q13' WHERE question_key = 'q13_new';
UPDATE survey_questions SET question_key = 'q14' WHERE question_key = 'q14_new';
