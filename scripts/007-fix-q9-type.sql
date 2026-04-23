-- Ensure Q9 is set as textarea type
UPDATE survey_questions 
SET question_type = 'textarea', options = NULL
WHERE question_number = 'Q9';

-- Verify all question types
SELECT question_number, question_type, options IS NOT NULL as has_options
FROM survey_questions
ORDER BY sort_order;
