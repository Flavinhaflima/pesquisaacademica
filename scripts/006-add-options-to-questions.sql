-- Add options column to survey_questions table
ALTER TABLE survey_questions ADD COLUMN IF NOT EXISTS options JSONB;

-- Update Q1 options
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "Passo direto, quase no automático"},
  {"value": "b", "label": "Dou uma olhada rápida, mas continuo rolando"},
  {"value": "c", "label": "Paro um pouco se algo chamar atenção"},
  {"value": "d", "label": "Paro e assisto/leio se parecer relevante pra mim"},
  {"value": "e", "label": "Depende - às vezes engajo, às vezes não"}
]'::jsonb WHERE question_key = 'q1';

-- Update Q2 options
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "Passo direto, quase no automático"},
  {"value": "b", "label": "Dou uma olhada rápida, mas continuo rolando"},
  {"value": "c", "label": "Paro um pouco se algo chamar atenção"},
  {"value": "d", "label": "Paro e assisto/leio se parecer relevante pra mim"},
  {"value": "e", "label": "Depende - às vezes engajo, às vezes não"}
]'::jsonb WHERE question_key = 'q2';

-- Update Q3 options
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "0 - acho que não interagi com nenhum"},
  {"value": "b", "label": "1-2 vezes"},
  {"value": "c", "label": "3-5 vezes"},
  {"value": "d", "label": "Mais de 5 vezes"}
]'::jsonb WHERE question_key = 'q3';

-- Update Q4 options
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "Paro nos dois - decido pelo visual, não pelo assunto"},
  {"value": "b", "label": "Paro só no relevante"},
  {"value": "c", "label": "Pulo os dois - estou em modo scroll e anúncio quebra o ritmo de qualquer jeito"},
  {"value": "d", "label": "Depende do formato - vídeo, imagem ou story muda minha reação"}
]'::jsonb WHERE question_key = 'q4';

-- Update Q5 options
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "\"Útil - está me mostrando coisas que eu realmente quero.\""},
  {"value": "b", "label": "\"Perturbador - não gosto de ser rastreado(a).\""}
]'::jsonb WHERE question_key = 'q5';

-- Update Q6 options
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "Sim, isso já mudou minha decisão de compra"},
  {"value": "b", "label": "Não - se o produto me interessa, isso não importa"},
  {"value": "c", "label": "Nunca tinha pensado nisso dessa forma"}
]'::jsonb WHERE question_key = 'q6';

-- Update Q7 options
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "Sim, isso já aconteceu mais de uma vez"},
  {"value": "b", "label": "Sim, lembro de uma vez específica"},
  {"value": "c", "label": "Não, se não parei é porque não me interessou"},
  {"value": "d", "label": "Nunca tinha pensado nisso"}
]'::jsonb WHERE question_key = 'q7';

-- Update Q8 options
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "Sim, consigo lembrar de um caso específico"},
  {"value": "b", "label": "Sim, mas não consigo identificar qual anúncio foi"},
  {"value": "c", "label": "Não, se não cliquei não ficou na memória"},
  {"value": "d", "label": "Nunca prestei atenção nisso"}
]'::jsonb WHERE question_key = 'q8';

-- Q9 is textarea, no options needed
UPDATE survey_questions SET options = NULL WHERE question_key = 'q9';

-- Update Q10 options
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "Instagram"},
  {"value": "b", "label": "TikTok"},
  {"value": "c", "label": "Outra plataforma"},
  {"value": "d", "label": "Não consigo lembrar onde vi"}
]'::jsonb WHERE question_key = 'q10';

-- Update Q11 options
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "Sim, o TikTok me influencia mais nas compras"},
  {"value": "b", "label": "Sim, o Instagram me influencia mais nas compras"},
  {"value": "c", "label": "As duas plataformas têm impacto parecido"},
  {"value": "d", "label": "Nenhuma das duas me faz comprar por causa de anúncio"}
]'::jsonb WHERE question_key = 'q11';

-- Update Q12 options
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "Sim, isso acontece com frequência"},
  {"value": "b", "label": "Sim, já aconteceu pelo menos uma vez"},
  {"value": "c", "label": "Não, nunca fiz isso"}
]'::jsonb WHERE question_key = 'q12';

-- Update Q13 options
UPDATE survey_questions SET options = '[
  {"value": "a", "label": "As plataformas controlam - o algoritmo decide por mim"},
  {"value": "b", "label": "Eu controlo - curto e sigo o que quero ver"},
  {"value": "c", "label": "É uma mistura: o algoritmo aprende comigo e eu me adapto a ele"},
  {"value": "d", "label": "Nunca parei para pensar nisso"}
]'::jsonb WHERE question_key = 'q13';
