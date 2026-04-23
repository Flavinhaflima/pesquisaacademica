-- Fix Q4.1 to be a proper subtopic with likert scale like Q4.2 and Q4.3
UPDATE survey_questions 
SET 
  question_type = 'likert',
  options = '[{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo Parcialmente"},{"value":"3","label":"Neutro"},{"value":"4","label":"Concordo Parcialmente"},{"value":"5","label":"Concordo"}]'
WHERE question_key = 'q41';

-- Update Q1 text
UPDATE survey_questions 
SET question_text = 'Durante o scroll no Instagram ou TikTok, eu costumo ignorar automaticamente qualquer forma de anúncio.'
WHERE question_key = 'q1';
