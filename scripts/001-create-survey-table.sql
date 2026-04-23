-- Create survey_responses table for storing survey answers
CREATE TABLE IF NOT EXISTS survey_responses (
  id SERIAL PRIMARY KEY,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  -- Bloco 1 - Imersão e Perda de Tempo
  q1_instagram_time VARCHAR(1),
  q2_tiktok_time VARCHAR(1),
  
  -- Bloco 2 - Reação aos Anúncios
  q3_instagram_ad_reaction VARCHAR(1),
  q4_tiktok_ad_reaction VARCHAR(1),
  
  -- Bloco 3 - Comportamento Recente
  q5_ad_interactions VARCHAR(1),
  
  -- Bloco 4 - Personalização
  q6_relevance_reaction VARCHAR(1),
  q7_tracking_feeling VARCHAR(1),
  q8_invasive_purchase VARCHAR(1),
  
  -- Bloco 5 - Influência Inconsciente
  q9_ignored_then_searched VARCHAR(1),
  q10_brand_recall VARCHAR(1),
  
  -- Bloco 6 - Memória e Recall
  q11_memorable_ad TEXT,
  q12_memorable_ad_platform VARCHAR(1),
  
  -- Bloco 7 - Autopercepção
  q13_platform_influence VARCHAR(1),
  q14_search_after_tiktok VARCHAR(1),
  q15_platform_control VARCHAR(1)
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_survey_created_at ON survey_responses(created_at DESC);
