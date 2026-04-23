import { neon } from '@neondatabase/serverless'
import { NextResponse } from 'next/server'

export const dynamic = 'force-dynamic'
export const revalidate = 0

const sql = neon(process.env.DATABASE_URL!)

const getQuestionKey = (questionNumber: string) => questionNumber.toLowerCase().replace('.', '').replace('_', '')

async function getRequiredQuestionKeys() {
  const questions = await sql`
    SELECT question_number, question_type
    FROM survey_questions
    WHERE question_type != 'header'
    ORDER BY sort_order ASC, question_number ASC
  `

  return questions
    .filter((question, index) => {
      const isLastQuestion = index === questions.length - 1
      return !(isLastQuestion && question.question_type === 'textarea')
    })
    .map(question => getQuestionKey(question.question_number as string))
}

export async function POST(request: Request) {
  try {
    const data = await request.json()
    const requiredQuestionKeys = await getRequiredQuestionKeys()
    const missingQuestions = requiredQuestionKeys.filter(key => !String(data[key] ?? '').trim())

    if (missingQuestions.length > 0) {
      return NextResponse.json(
        { error: 'Missing required answers', missingQuestions },
        { status: 400 }
      )
    }
    
    await sql`
      INSERT INTO survey_responses (
        q0a, q0b, q1, q2, q3, q41, q42, q5, q6, q7, q8, q9, q10, q11, q12, q13
      ) VALUES (
        ${data.q0a || null},
        ${data.q0b || null},
        ${data.q1 || null},
        ${data.q2 || null},
        ${data.q3 || null},
        ${data.q41 || null},
        ${data.q42 || null},
        ${data.q5 || null},
        ${data.q6 || null},
        ${data.q7 || null},
        ${data.q8 || null},
        ${data.q9 || null},
        ${data.q10 || null},
        ${data.q11 || null},
        ${data.q12 || null},
        ${data.q13 || null}
      )
    `
    
    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Error saving survey response:', error)
    return NextResponse.json(
      { error: 'Failed to save response', details: String(error) },
      { status: 500 }
    )
  }
}

export async function GET() {
  try {
    const responses = await sql`
      SELECT 
        id, q0a, q0b, q1, q2, q3, q41, q42, q5, q6, q7, q8, q9, q10, q11, q12, q13,
        to_char(created_at, 'YYYY-MM-DD"T"HH24:MI:SS"Z"') as created_at
      FROM survey_responses 
      ORDER BY created_at DESC
    `
    
    return NextResponse.json(responses, {
      headers: {
        'Cache-Control': 'no-store, no-cache, must-revalidate, proxy-revalidate',
      },
    })
  } catch (error) {
    console.error('Error fetching survey responses:', error)
    return NextResponse.json(
      { error: 'Failed to fetch responses' },
      { status: 500 }
    )
  }
}

export async function DELETE(request: Request) {
  try {
    const { searchParams } = new URL(request.url)
    const id = searchParams.get('id')
    
    if (!id) {
      return NextResponse.json(
        { error: 'ID is required' },
        { status: 400 }
      )
    }
    
    await sql`DELETE FROM survey_responses WHERE id = ${parseInt(id)}`
    
    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Error deleting survey response:', error)
    return NextResponse.json(
      { error: 'Failed to delete response' },
      { status: 500 }
    )
  }
}

export async function PUT(request: Request) {
  try {
    const data = await request.json()
    const { id, ...fields } = data
    
    if (!id) {
      return NextResponse.json(
        { error: 'ID is required' },
        { status: 400 }
      )
    }
    
    await sql`
      UPDATE survey_responses SET
        q0a = ${fields.q0a || null},
        q0b = ${fields.q0b || null},
        q1 = ${fields.q1 || null},
        q2 = ${fields.q2 || null},
        q3 = ${fields.q3 || null},
        q41 = ${fields.q41 || null},
        q42 = ${fields.q42 || null},
        q5 = ${fields.q5 || null},
        q6 = ${fields.q6 || null},
        q7 = ${fields.q7 || null},
        q8 = ${fields.q8 || null},
        q9 = ${fields.q9 || null},
        q10 = ${fields.q10 || null},
        q11 = ${fields.q11 || null},
        q12 = ${fields.q12 || null},
        q13 = ${fields.q13 || null}
      WHERE id = ${parseInt(id)}
    `
    
    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Error updating survey response:', error)
    return NextResponse.json(
      { error: 'Failed to update response' },
      { status: 500 }
    )
  }
}
