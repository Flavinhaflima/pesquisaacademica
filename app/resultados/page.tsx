import { neon } from '@neondatabase/serverless'
import ResultsClient from './results-client'

export const dynamic = 'force-dynamic'
export const revalidate = 0

interface SurveyResponse {
  id: number
  q0a: string | null
  q0b: string | null
  q1: string | null
  q2: string | null
  q3: string | null
  q41: string | null
  q42: string | null
  q5: string | null
  q6: string | null
  q7: string | null
  q8: string | null
  q9: string | null
  q10: string | null
  q11: string | null
  q12: string | null
  q13: string | null
  created_at: string
}

interface SurveyQuestion {
  question_key: string
  question_number: string
  question_text: string
  question_type: string
  options: { value: string; label: string }[] | null
  sort_order: number
}

async function getResponses(): Promise<SurveyResponse[]> {
  try {
    const sql = neon(process.env.DATABASE_URL!)
    const responses = await sql`
      SELECT 
        id, q0a, q0b, q1, q2, q3, q41, q42, q5, q6, q7, q8, q9, q10, q11, q12, q13,
        to_char(created_at, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') as created_at
      FROM survey_responses 
      ORDER BY created_at DESC
    `
    return responses as SurveyResponse[]
  } catch (error) {
    console.error("Error fetching responses:", error)
    return []
  }
}

async function getQuestions(): Promise<SurveyQuestion[]> {
  try {
    const sql = neon(process.env.DATABASE_URL!)
    const questions = await sql`
      SELECT question_key, question_number, question_text, question_type, options, sort_order
      FROM survey_questions
      ORDER BY sort_order ASC, question_number ASC
    `
    return questions as SurveyQuestion[]
  } catch (error) {
    console.error("Error fetching questions:", error)
    return []
  }
}

export default async function ResultsPage() {
  const [responses, questions] = await Promise.all([getResponses(), getQuestions()])
  
  return <ResultsClient responses={responses as SurveyResponse[]} questions={questions} />
}
