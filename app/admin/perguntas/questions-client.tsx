"use client"

import { useState, useEffect, useCallback } from "react"
import Link from "next/link"
import { useRouter } from "next/navigation"
import { AdminLogin } from "@/components/admin-login"

interface Question {
  id: number
  block_title: string | null
  question_number: string
  question_text: string
  check_note: string | null
  updated_at: string
}

interface QuestionsClientProps {
  questions: Question[]
}

export default function QuestionsClient({ questions: initialQuestions }: QuestionsClientProps) {
  const router = useRouter()
  const [questions, setQuestions] = useState(initialQuestions)
  const [editingQuestion, setEditingQuestion] = useState<Question | null>(null)
  const [editFormData, setEditFormData] = useState<Record<string, string>>({})
  const [isSaving, setIsSaving] = useState(false)
  const [isAuthenticated, setIsAuthenticated] = useState<boolean | null>(null)

  useEffect(() => {
    checkAuth()
  }, [])

  const refreshQuestions = useCallback(async () => {
    try {
      const res = await fetch("/api/questions", { cache: "no-store" })
      if (res.ok) {
        const data = await res.json()
        setQuestions(data as Question[])
      }
    } catch (error) {
      console.error("Error refreshing questions:", error)
    }
  }, [])

  useEffect(() => {
    if (isAuthenticated) {
      refreshQuestions()
    }
  }, [isAuthenticated, refreshQuestions])

  const checkAuth = async () => {
    try {
      const res = await fetch("/api/auth")
      const data = await res.json()
      setIsAuthenticated(data.authenticated)
    } catch {
      setIsAuthenticated(false)
    }
  }

  const handleLogout = async () => {
    await fetch("/api/auth", { method: "DELETE" })
    setIsAuthenticated(false)
  }

  const startEditing = (question: Question) => {
    setEditingQuestion(question)
    setEditFormData({
      block_title: question.block_title || "",
      question_number: question.question_number,
      question_text: question.question_text,
      check_note: question.check_note || ""
    })
  }

  const cancelEditing = () => {
    setEditingQuestion(null)
    setEditFormData({})
  }

  const saveQuestion = async () => {
    if (!editingQuestion) return
    
    setIsSaving(true)
    try {
      const res = await fetch("/api/questions", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          id: editingQuestion.id,
          ...editFormData
        })
      })
      
      if (res.ok) {
        await refreshQuestions()
        setEditingQuestion(null)
        setEditFormData({})
        router.refresh()
      }
    } catch (error) {
      console.error("Error saving question:", error)
    } finally {
      setIsSaving(false)
    }
  }

  // Show loading while checking auth
  if (isAuthenticated === null) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-primary"></div>
      </div>
    )
  }

  // Show login if not authenticated
  if (!isAuthenticated) {
    return <AdminLogin onSuccess={() => setIsAuthenticated(true)} />
  }

  // Group questions by block
  const questionsByBlock: Record<string, Question[]> = {}
  questions.forEach(q => {
    const block = q.block_title || "Sem Bloco"
    if (!questionsByBlock[block]) {
      questionsByBlock[block] = []
    }
    questionsByBlock[block].push(q)
  })

  return (
    <div className="min-h-screen bg-background text-foreground">
      {/* Header */}
      <header className="border-b border-border">
        <div className="max-w-6xl mx-auto px-6 py-6 flex items-center justify-between">
          <div>
            <h1 className="font-serif text-2xl font-bold">Editor de Perguntas</h1>
            <p className="text-muted-foreground text-sm mt-1">
              Edite o título dos blocos, numeração e texto das perguntas
            </p>
          </div>
          <div className="flex items-center gap-4">
            <Link href="/" className="text-muted-foreground text-sm hover:text-primary transition-colors">
              Ver Survey
            </Link>
            <Link href="/resultados" className="text-muted-foreground text-sm hover:text-primary transition-colors">
              Resultados
            </Link>
            <button
              onClick={handleLogout}
              className="text-muted-foreground text-sm hover:text-red-500 transition-colors"
            >
              Sair
            </button>
          </div>
        </div>
      </header>

      {/* Content */}
      <main className="max-w-6xl mx-auto px-6 py-8">
        {Object.entries(questionsByBlock).map(([blockTitle, blockQuestions]) => (
          <div key={blockTitle} className="mb-10">
            <div className="font-serif text-xs font-bold tracking-[0.18em] uppercase text-accent mb-4 flex items-center gap-2.5">
              {blockTitle}
              <span className="flex-1 h-px bg-border" />
            </div>
            
            <div className="space-y-4">
              {blockQuestions.map(question => (
                <div 
                  key={question.id} 
                  className="bg-card border border-border rounded-xl p-5"
                >
                  {editingQuestion?.id === question.id ? (
                    // Edit Mode
                    <div className="space-y-4">
                      <div className="grid grid-cols-2 gap-4">
                        <div>
                          <label className="block text-xs text-muted-foreground mb-1.5">
                            Título do Bloco
                          </label>
                          <input
                            type="text"
                            value={editFormData.block_title || ""}
                            onChange={(e) => setEditFormData(prev => ({ ...prev, block_title: e.target.value }))}
                            className="w-full bg-secondary border border-border rounded-lg text-foreground text-sm p-2.5 outline-none focus:border-primary/50"
                            placeholder="Ex: Bloco 1 - Reação aos Anúncios"
                          />
                        </div>
                        <div>
                          <label className="block text-xs text-muted-foreground mb-1.5">
                            Número da Pergunta
                          </label>
                          <input
                            type="text"
                            value={editFormData.question_number || ""}
                            onChange={(e) => setEditFormData(prev => ({ ...prev, question_number: e.target.value }))}
                            className="w-full bg-secondary border border-border rounded-lg text-foreground text-sm p-2.5 outline-none focus:border-primary/50"
                            placeholder="Ex: Q1"
                          />
                        </div>
                      </div>
                      
                      <div>
                        <label className="block text-xs text-muted-foreground mb-1.5">
                          Texto da Pergunta
                        </label>
                        <textarea
                          value={editFormData.question_text || ""}
                          onChange={(e) => setEditFormData(prev => ({ ...prev, question_text: e.target.value }))}
                          rows={3}
                          className="w-full bg-secondary border border-border rounded-lg text-foreground text-sm p-2.5 outline-none focus:border-primary/50 resize-y"
                          placeholder="Digite o texto da pergunta..."
                        />
                      </div>
                      
                      <div>
                        <label className="block text-xs text-muted-foreground mb-1.5">
                          Nota de Verificação (opcional)
                        </label>
                        <input
                          type="text"
                          value={editFormData.check_note || ""}
                          onChange={(e) => setEditFormData(prev => ({ ...prev, check_note: e.target.value }))}
                          className="w-full bg-secondary border border-border rounded-lg text-foreground text-sm p-2.5 outline-none focus:border-primary/50"
                          placeholder="Ex: par de verificação com Q1"
                        />
                      </div>
                      
                      <div className="flex gap-2 pt-2">
                        <button
                          onClick={saveQuestion}
                          disabled={isSaving}
                          className="bg-primary text-primary-foreground px-4 py-2 rounded-lg text-sm font-medium hover:opacity-90 transition-opacity disabled:opacity-50"
                        >
                          {isSaving ? "Salvando..." : "Salvar"}
                        </button>
                        <button
                          onClick={cancelEditing}
                          className="bg-secondary text-secondary-foreground px-4 py-2 rounded-lg text-sm hover:bg-secondary/80 transition-colors"
                        >
                          Cancelar
                        </button>
                      </div>
                    </div>
                  ) : (
                    // View Mode
                    <div className="flex items-start justify-between gap-4">
                      <div className="flex-1">
                        <div className="flex items-center gap-2 mb-2">
                          <span className="text-primary font-serif font-bold text-sm">
                            {question.question_number}
                          </span>
                          {question.check_note && (
                            <span className="text-xs text-muted-foreground bg-secondary px-2 py-0.5 rounded">
                              {question.check_note}
                            </span>
                          )}
                        </div>
                        <p className="text-foreground text-sm leading-relaxed">
                          {question.question_text}
                        </p>
                      </div>
                      <button
                        onClick={() => startEditing(question)}
                        className="text-muted-foreground hover:text-primary transition-colors p-2"
                        title="Editar pergunta"
                      >
                        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                          <path d="M17 3a2.85 2.83 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5Z"/>
                          <path d="m15 5 4 4"/>
                        </svg>
                      </button>
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        ))}
        
        {questions.length === 0 && (
          <div className="text-center py-16 text-muted-foreground">
            Nenhuma pergunta encontrada no banco de dados.
          </div>
        )}
      </main>
    </div>
  )
}
