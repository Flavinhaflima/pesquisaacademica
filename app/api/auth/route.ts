import { NextResponse } from 'next/server'
import { cookies } from 'next/headers'

const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin123'

export async function POST(request: Request) {
  try {
    const { password } = await request.json()
    
    if (password === ADMIN_PASSWORD) {
      const cookieStore = await cookies()
      
      // Create a simple session token
      const sessionToken = Buffer.from(`authenticated:${Date.now()}`).toString('base64')
      
      cookieStore.set('admin_session', sessionToken, {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'lax',
        maxAge: 60 * 60 * 24, // 24 hours
        path: '/',
      })
      
      return NextResponse.json({ success: true })
    }
    
    return NextResponse.json(
      { error: 'Senha incorreta' },
      { status: 401 }
    )
  } catch (error) {
    console.error('Auth error:', error)
    return NextResponse.json(
      { error: 'Erro de autenticacao' },
      { status: 500 }
    )
  }
}

export async function GET() {
  try {
    const cookieStore = await cookies()
    const session = cookieStore.get('admin_session')
    
    if (session?.value) {
      const decoded = Buffer.from(session.value, 'base64').toString()
      if (decoded.startsWith('authenticated:')) {
        return NextResponse.json({ authenticated: true })
      }
    }
    
    return NextResponse.json({ authenticated: false })
  } catch {
    return NextResponse.json({ authenticated: false })
  }
}

export async function DELETE() {
  try {
    const cookieStore = await cookies()
    cookieStore.delete('admin_session')
    return NextResponse.json({ success: true })
  } catch {
    return NextResponse.json({ success: true })
  }
}
