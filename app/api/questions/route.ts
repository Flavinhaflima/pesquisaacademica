import { neon } from '@neondatabase/serverless'
import { NextResponse } from 'next/server'
import { cookies } from 'next/headers'

const sql = neon(process.env.DATABASE_URL!)

export async function GET() {
  try {
    const questions = await sql`
      SELECT 
        id, 
        question_key,
        block_title, 
        question_number, 
        question_text, 
        check_note,
        block_number,
        question_type,
        sort_order,
        options
      FROM survey_questions 
      ORDER BY sort_order ASC, question_number ASC
    `
    return NextResponse.json(questions)
  } catch (error) {
    console.error('Error fetching questions:', error)
    return NextResponse.json(
      { error: 'Failed to fetch questions' },
      { status: 500 }
    )
  }
}

export async function PUT(request: Request) {
  try {
    // Check authentication
    const cookieStore = await cookies()
    const sessionToken = cookieStore.get('admin_session')?.value
    
    if (!sessionToken) {
      return NextResponse.json(
        { error: 'Unauthorized' },
        { status: 401 }
      )
    }
    
    const data = await request.json()
    const { id, block_title, question_number, question_text, check_note } = data
    
    if (!id) {
      return NextResponse.json(
        { error: 'ID is required' },
        { status: 400 }
      )
    }
    
    await sql`
      UPDATE survey_questions SET
        block_title = ${block_title || null},
        question_number = ${question_number},
        question_text = ${question_text},
        check_note = ${check_note || null},
        updated_at = NOW()
      WHERE id = ${parseInt(id)}
    `
    
    return NextResponse.json({ success: true })
  } catch (error) {
    console.error('Error updating question:', error)
    return NextResponse.json(
      { error: 'Failed to update question' },
      { status: 500 }
    )
  }
}
