-- Rename q4a, q4b, q4c to q41, q42, q43 to match the new question numbering
ALTER TABLE survey_responses RENAME COLUMN q4a TO q41;
ALTER TABLE survey_responses RENAME COLUMN q4b TO q42;
ALTER TABLE survey_responses RENAME COLUMN q4c TO q43;
