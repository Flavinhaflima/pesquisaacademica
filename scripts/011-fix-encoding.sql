-- Fix encoding issues in survey_questions table

-- Q1
UPDATE survey_questions SET 
  block_title = 'Bloco 1 - Reação aos Anúncios',
  question_text = 'Quando você está no meio de uma sessão de scroll no Instagram e aparece um anúncio, o que geralmente acontece?',
  options = '[{"value":"a","label":"Passo direto, quase no automático"},{"value":"b","label":"Dou uma olhada rápida, mas continuo rolando"},{"value":"c","label":"Paro um pouco se algo chamar atenção"},{"value":"d","label":"Paro e assisto/leio se parecer relevante pra mim"},{"value":"e","label":"Depende - às vezes engajo, às vezes não"}]'::jsonb
WHERE question_number = 'Q1';

-- Q2
UPDATE survey_questions SET 
  block_title = 'Bloco 1 - Reação aos Anúncios',
  question_text = 'E no TikTok, qual das opções melhor descreve sua reação a anúncios?',
  check_note = 'par de verificação com Q1',
  options = '[{"value":"a","label":"Passo direto, quase no automático"},{"value":"b","label":"Dou uma olhada rápida, mas continuo rolando"},{"value":"c","label":"Paro um pouco se algo chamar atenção"},{"value":"d","label":"Paro e assisto/leio se parecer relevante pra mim"},{"value":"e","label":"Depende - às vezes engajo, às vezes não"}]'::jsonb
WHERE question_number = 'Q2';

-- Q3
UPDATE survey_questions SET 
  block_title = 'Bloco 2 - Comportamento Recente',
  question_text = 'Nas últimas duas semanas, quantas vezes você clicou, salvou ou compartilhou um anúncio que viu no Instagram ou TikTok?',
  options = '[{"value":"a","label":"0 - acho que não interagi com nenhum"},{"value":"b","label":"1-2 vezes"},{"value":"c","label":"3-5 vezes"},{"value":"d","label":"Mais de 5 vezes"}]'::jsonb
WHERE question_number = 'Q3';

-- Q4
UPDATE survey_questions SET 
  block_title = 'Bloco 3 - Personalização',
  question_text = 'Imagina que você está rolando o feed e aparecem dois anúncios seguidos. Um é sobre algo que você pesquisou recentemente. O outro não tem nada a ver com você. O que você faz?',
  options = '[{"value":"a","label":"Paro nos dois - decido pelo visual, não pelo assunto"},{"value":"b","label":"Paro só no relevante"},{"value":"c","label":"Pulo os dois - estou em modo scroll e anúncio quebra o ritmo de qualquer jeito"},{"value":"d","label":"Depende do formato - vídeo, imagem ou story muda minha reação"}]'::jsonb
WHERE question_number = 'Q4';

-- Q5
UPDATE survey_questions SET 
  block_title = 'Bloco 3 - Personalização',
  question_text = 'Quando você percebe que um anúncio parece saber o que você estava pesquisando ou comentando, sua primeira reação é mais próxima de...',
  options = '[{"value":"a","label":"\"Útil - está me mostrando coisas que eu realmente quero.\""},{"value":"b","label":"\"Perturbador - não gosto de ser rastreado(a).\""}]'::jsonb
WHERE question_number = 'Q5';

-- Q6
UPDATE survey_questions SET 
  block_title = 'Bloco 3 - Personalização',
  question_text = 'Você já deixou de comprar algo por sentir que o anúncio era "invasivo demais" - como se a plataforma soubesse coisas demais sobre você?',
  check_note = 'verificação de Q5',
  options = '[{"value":"a","label":"Sim, isso já mudou minha decisão de compra"},{"value":"b","label":"Não - se o produto me interessa, isso não importa"},{"value":"c","label":"Nunca tinha pensado nisso dessa forma"}]'::jsonb
WHERE question_number = 'Q6';

-- Q7
UPDATE survey_questions SET 
  block_title = 'Bloco 4 - Influência Inconsciente',
  question_text = 'Você já ignorou um anúncio no Instagram - e mesmo assim foi pesquisar o produto depois?',
  options = '[{"value":"a","label":"Sim, isso já aconteceu mais de uma vez"},{"value":"b","label":"Sim, lembro de uma vez específica"},{"value":"c","label":"Não, se não parei é porque não me interessou"},{"value":"d","label":"Nunca tinha pensado nisso"}]'::jsonb
WHERE question_number = 'Q7';

-- Q8
UPDATE survey_questions SET 
  block_title = 'Bloco 4 - Influência Inconsciente',
  question_text = 'Você consegue lembrar de alguma marca ou produto que ficou na sua cabeça depois de ver um anúncio no TikTok ou Instagram - mesmo sem ter clicado ou parado pra ver?',
  options = '[{"value":"a","label":"Sim, consigo lembrar de um caso específico"},{"value":"b","label":"Sim, mas não consigo identificar qual anúncio foi"},{"value":"c","label":"Não, se não cliquei não ficou na memória"},{"value":"d","label":"Nunca prestei atenção nisso"}]'::jsonb
WHERE question_number = 'Q8';

-- Q9
UPDATE survey_questions SET 
  block_title = 'Bloco 5 - Memória e Recall',
  question_text = 'Pensa em um anúncio que você realmente lembra de ter visto nas redes sociais recentemente - um que ficou na sua cabeça. O que fez você lembrar dele?',
  question_type = 'textarea',
  options = NULL
WHERE question_number = 'Q9';

-- Q10
UPDATE survey_questions SET 
  block_title = 'Bloco 5 - Memória e Recall',
  question_text = 'Esse anúncio que você lembrou estava no Instagram ou no TikTok?',
  check_note = 'verificação de Q9',
  options = '[{"value":"a","label":"Instagram"},{"value":"b","label":"TikTok"},{"value":"c","label":"Outra plataforma"},{"value":"d","label":"Não consigo lembrar onde vi"}]'::jsonb
WHERE question_number = 'Q10';

-- Q11
UPDATE survey_questions SET 
  block_title = 'Bloco 6 - Autopercepção do Comportamento',
  question_text = 'Você diria que o TikTok te faz comprar mais coisas do que o Instagram?',
  options = '[{"value":"a","label":"Sim, o TikTok me influencia mais nas compras"},{"value":"b","label":"Não, o Instagram me influencia mais nas compras"},{"value":"c","label":"As duas plataformas têm impacto parecido"},{"value":"d","label":"Nenhuma das duas me faz comprar por causa de anúncio"}]'::jsonb
WHERE question_number = 'Q11';

-- Q12
UPDATE survey_questions SET 
  block_title = 'Bloco 6 - Autopercepção do Comportamento',
  question_text = 'Você já buscou um produto no Google ou em uma loja depois de ver um vídeo no TikTok - mesmo sem ter clicado no anúncio?',
  check_note = 'verificação de Q11',
  options = '[{"value":"a","label":"Sim, isso acontece com frequência"},{"value":"b","label":"Sim, já aconteceu pelo menos uma vez"},{"value":"c","label":"Não, nunca fiz isso"}]'::jsonb
WHERE question_number = 'Q12';

-- Q13
UPDATE survey_questions SET 
  block_title = 'Bloco 6 - Autopercepção do Comportamento',
  question_text = 'No geral, você sente que as plataformas controlam o que você vê - ou que você controla o que consome?',
  options = '[{"value":"a","label":"As plataformas controlam - o algoritmo decide por mim"},{"value":"b","label":"Eu controlo - curto e sigo o que quero ver"},{"value":"c","label":"É uma mistura: o algoritmo aprende comigo e eu me adapto a ele"},{"value":"d","label":"Nunca parei para pensar nisso"}]'::jsonb
WHERE question_number = 'Q13';
