-- Fix Q11 option B text
UPDATE survey_questions
SET options = '[{"value":"a","label":"Sim, o TikTok me influencia mais nas compras"},{"value":"b","label":"Não, o Instagram me influencia mais nas compras"},{"value":"c","label":"As duas plataformas têm impacto parecido"},{"value":"d","label":"Nenhuma das duas me faz comprar por causa de anúncio"}]'
WHERE question_number = 'Q11';
