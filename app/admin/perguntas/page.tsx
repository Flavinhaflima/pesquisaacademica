import { neon } from '@neondatabase/serverless'
import QuestionsClient from './questions-client'

export const dynamic = 'force-dynamic'
export const revalidate = 0

interface Question {
  id: number
  block_title: string | null
  question_number: string
  question_text: string
  check_note: string | null
  updated_at: string
}

async function getQuestions(): Promise<Question[]> {
  try {
    const sql = neon(process.env.DATABASE_URL!)
    const questions = await sql`
      SELECT 
        id, block_title, question_number, question_text, check_note,
        to_char(updated_at, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') as updated_at
      FROM survey_questions 
      ORDER BY id ASC
    `
    return questions as Question[]
  } catch (error) {
    console.error("[v0] Error fetching questions:", error)
    return []
  }
}

export default async function QuestionsPage() {
  const questions = await getQuestions()
  
  return <QuestionsClient questions={questions} />
}
