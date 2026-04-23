-- Delete all existing questions
DELETE FROM survey_questions;

-- Reset the sequence
ALTER SEQUENCE survey_questions_id_seq RESTART WITH 1;

-- Insert demographic questions (before Block 1)
INSERT INTO survey_questions (block_title, question_number, question_text, check_note, block_number, question_type, sort_order, options)
VALUES 
('Dados Demográficos', 'Q0a', 'Gênero', NULL, 0, 'radio', 1, '[{"value":"a","label":"Feminino"},{"value":"b","label":"Masculino"},{"value":"c","label":"Prefiro não informar"}]'),
('Dados Demográficos', 'Q0b', 'Idade', NULL, 0, 'radio', 2, '[{"value":"a","label":"Menor de 18 anos"},{"value":"b","label":"Entre 19-24 anos"},{"value":"c","label":"Entre 25-34 anos"},{"value":"d","label":"Entre 35-44 anos"},{"value":"e","label":"Entre 45-54 anos"},{"value":"f","label":"Mais de 55 anos"}]');

-- Likert scale options (same for all Likert questions)
-- Insert Block 1 - Reação Automática
INSERT INTO survey_questions (block_title, question_number, question_text, check_note, block_number, question_type, sort_order, options)
VALUES 
('Bloco 1 - Reação Automática', 'Q1', 'Durante o scroll no Instagram ou TikTok, eu costumo ignorar anúncios automaticamente.', NULL, 1, 'likert', 3, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]');

-- Insert Block 2 - Formato, Interrupção & Conteúdo
INSERT INTO survey_questions (block_title, question_number, question_text, check_note, block_number, question_type, sort_order, options)
VALUES 
('Bloco 2 - Formato, Interrupção e Conteúdo', 'Q2', 'Anúncios pagos inseridos entre conteúdos (como entre stories ou no feed) me fazem pular ou ignorar mais rapidamente.', NULL, 2, 'likert', 4, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]'),
('Bloco 2 - Formato, Interrupção e Conteúdo', 'Q3', 'O formato do anúncio (como reels, estático ou story) influencia se eu paro para prestar atenção.', NULL, 2, 'likert', 5, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]'),
('Bloco 2 - Formato, Interrupção e Conteúdo', 'Q4', 'A qualidade do conteúdo do anúncio (relevância, criatividade e estética) influencia se eu paro para prestar atenção.', NULL, 2, 'likert', 6, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]');

-- Insert Block 3 - Comportamento
INSERT INTO survey_questions (block_title, question_number, question_text, check_note, block_number, question_type, sort_order, options)
VALUES 
('Bloco 3 - Comportamento', 'Q5', 'Nas últimas duas semanas, eu interagi (curti, salvei ou compartilhei) anúncios que vi no Instagram ou TikTok.', NULL, 3, 'likert', 7, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]');

-- Insert Block 4 - Interesse vs Formato
INSERT INTO survey_questions (block_title, question_number, question_text, check_note, block_number, question_type, sort_order, options)
VALUES 
('Bloco 4 - Interesse vs Formato', 'Q6', 'Quando um anúncio parece alinhado com meus interesses, mesmo sendo claramente uma propaganda, eu tendo a prestar atenção ou interagir com ele.', NULL, 4, 'likert', 8, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]'),
('Bloco 4 - Interesse vs Formato', 'Q7', 'Eu só presto atenção ou interajo com anúncios quando o formato ou estilo do conteúdo me prende, independentemente do produto ser do meu interesse.', NULL, 4, 'likert', 9, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]');

-- Insert Block 5 - Influência Indireta
INSERT INTO survey_questions (block_title, question_number, question_text, check_note, block_number, question_type, sort_order, options)
VALUES 
('Bloco 5 - Influência Indireta', 'Q8', 'Mesmo quando ignoro um anúncio, às vezes acabo pesquisando o produto depois.', NULL, 5, 'likert', 10, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]');

-- Insert Block 6 - Personalização & Percepção
INSERT INTO survey_questions (block_title, question_number, question_text, check_note, block_number, question_type, sort_order, options)
VALUES 
('Bloco 6 - Personalização e Percepção', 'Q9', 'Sinto que a maioria dos anúncios que vejo está relacionada a algo que pesquisei ou demonstrei interesse anteriormente, e isso me causa desconforto.', NULL, 6, 'likert', 11, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]'),
('Bloco 6 - Personalização e Percepção', 'Q10', 'Já deixei de comprar algo por achar que um anúncio era invasivo demais.', NULL, 6, 'likert', 12, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]');

-- Insert Block 7 - Impacto na Compra
INSERT INTO survey_questions (block_title, question_number, question_text, check_note, block_number, question_type, sort_order, options)
VALUES 
('Bloco 7 - Impacto na Compra', 'Q11', 'O TikTok influencia minhas decisões de compra mais do que o Instagram.', NULL, 7, 'likert', 13, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]');

-- Insert Block 8 - Alta Estimulação / Imersão
INSERT INTO survey_questions (block_title, question_number, question_text, check_note, block_number, question_type, sort_order, options)
VALUES 
('Bloco 8 - Alta Estimulação e Imersão', 'Q12', 'Quando estou usando TikTok ou Instagram, muitas vezes continuo rolando sem perceber o tempo passar.', NULL, 8, 'likert', 14, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]'),
('Bloco 8 - Alta Estimulação e Imersão', 'Q13', 'Sinto que entro em um estado automático enquanto consumo conteúdo nessas plataformas.', NULL, 8, 'likert', 15, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]'),
('Bloco 8 - Alta Estimulação e Imersão', 'Q14', 'Quando estou nesse estado de rolagem contínua, presto menos atenção consciente nos anúncios, a menos que eles se integrem de forma natural ao conteúdo do feed.', NULL, 8, 'likert', 16, '[{"value":"0","label":"Discordo totalmente"},{"value":"1","label":"Discordo"},{"value":"2","label":"Discordo parcialmente"},{"value":"3","label":"Concordo parcialmente"},{"value":"4","label":"Concordo"},{"value":"5","label":"Concordo totalmente"}]');

-- Insert Open Question
INSERT INTO survey_questions (block_title, question_number, question_text, check_note, block_number, question_type, sort_order, options)
VALUES 
('Questão Aberta', 'Q15', 'Descreva um anúncio que você lembra de ter visto recentemente nas redes sociais e o que fez você lembrar dele.', NULL, 9, 'textarea', 17, NULL);
