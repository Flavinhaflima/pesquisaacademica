"use client"

import { useState, useEffect, useCallback } from "react"
import Link from "next/link"
import { useRouter } from "next/navigation"
import { AdminLogin } from "@/components/admin-login"

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

const questionLabels: Record<string, string> = {
  q0a: "Gênero",
  q0b: "Idade",
  q1: "Durante o scroll no Instagram ou TikTok, eu costumo ignorar automaticamente qualquer forma de anúncio",
  q2: "Costumo pular anúncios automaticamente, sem prestar atenção",
  q3: "O formato da propaganda (como reels, estático ou story) influencia se eu paro para prestar atenção",
  q41: "Q4.1 - Criatividade (quando a ideia é diferente ou chama atenção)",
  q42: "Q4.2 - Estética (quando o visual, edição ou design são atraentes)",
  q5: "Me sinto desconfortável quando um anúncio parece saber demais sobre mim",
  q6: "Lembro de marcas que vi em anúncios, mesmo sem ter clicado",
  q7: "Confio mais em anúncios que parecem conteúdo orgânico",
  q8: "Já pesquisei um produto após ver um anúncio, mesmo sem clicar nele",
  q9: "Sinto que o algoritmo entende bem meus interesses",
  q10: "Anúncios interrompem minha experiência nas redes sociais",
  q11: "Prefiro anúncios em formato de vídeo curto",
  q12: "Me sinto no controle do que consumo nas redes sociais",
  q13: "Anúncios criativos me fazem parar de rolar o feed"
}

const demographicOptions: Record<string, { value: string; label: string }[]> = {
  q0a: [
    { value: "a", label: "Feminino" },
    { value: "b", label: "Masculino" },
    { value: "c", label: "Prefiro não informar" }
  ],
  q0b: [
    { value: "a", label: "Menor de 18 anos" },
    { value: "b", label: "Entre 19-24 anos" },
    { value: "c", label: "Entre 25-34 anos" },
    { value: "d", label: "Entre 35-44 anos" },
    { value: "e", label: "Entre 45-54 anos" },
    { value: "f", label: "Mais de 55 anos" }
  ]
}

const likertOptions = [
  { value: "1", label: "Discordo" },
  { value: "2", label: "Discordo Parcialmente" },
  { value: "3", label: "Neutro" },
  { value: "4", label: "Concordo Parcialmente" },
  { value: "5", label: "Concordo" }
]

function getLikertLabel(value: string | null): string {
  if (!value) return "-"
  const option = likertOptions.find(o => o.value === value)
  return option ? `${value} - ${option.label}` : value
}

function getDemographicLabel(question: string, value: string | null): string {
  if (!value) return "-"
  const options = demographicOptions[question]
  const option = options?.find(o => o.value === value)
  return option ? option.label : value
}

function countAnswers(responses: SurveyResponse[], question: string): Record<string, number> {
  const counts: Record<string, number> = {}
  responses.forEach(r => {
    const val = r[question as keyof SurveyResponse] as string | null
    if (val) {
      counts[val] = (counts[val] || 0) + 1
    }
  })
  return counts
}

interface ResultsClientProps {
  responses: SurveyResponse[]
}

export default function ResultsClient({ responses: initialResponses }: ResultsClientProps) {
  const router = useRouter()
  const [responses, setResponses] = useState(initialResponses)
  const [view, setView] = useState<"summary" | "individual">("summary")
  const [expandedResponse, setExpandedResponse] = useState<number | null>(null)
  const [editingResponse, setEditingResponse] = useState<SurveyResponse | null>(null)
  const [editFormData, setEditFormData] = useState<Record<string, string>>({})
  const [isDeleting, setIsDeleting] = useState<number | null>(null)
  const [isSaving, setIsSaving] = useState(false)
  const [isRefreshing, setIsRefreshing] = useState(false)
  const [isAuthenticated, setIsAuthenticated] = useState<boolean | null>(null)

  useEffect(() => {
    checkAuth()
  }, [])

  useEffect(() => {
    setResponses(initialResponses)
  }, [initialResponses])

  const checkAuth = async () => {
    try {
      const res = await fetch("/api/auth")
      const data = await res.json()
      setIsAuthenticated(data.authenticated)
    } catch {
      setIsAuthenticated(false)
    }
  }

  const refreshResponses = useCallback(async () => {
    setIsRefreshing(true)
    try {
      const res = await fetch("/api/survey", { cache: "no-store" })
      if (res.ok) {
        const data = await res.json()
        setResponses(data as SurveyResponse[])
      }
    } catch (error) {
      console.error("Error refreshing responses:", error)
    } finally {
      setIsRefreshing(false)
    }
  }, [])

  useEffect(() => {
    if (isAuthenticated) {
      refreshResponses()
    }
  }, [isAuthenticated, refreshResponses])

  const handleLogout = async () => {
    await fetch("/api/auth", { method: "DELETE" })
    setIsAuthenticated(false)
  }

  if (isAuthenticated === null) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-primary"></div>
      </div>
    )
  }

  if (!isAuthenticated) {
    return <AdminLogin onSuccess={() => setIsAuthenticated(true)} />
  }

  const demographicQuestions = ["q0a", "q0b"]
  const likertQuestions = ["q1", "q2", "q3", "q41", "q42", "q5", "q6", "q7", "q8", "q9", "q10", "q11", "q12", "q13"]
  const allQuestions = [...demographicQuestions, ...likertQuestions]

  const handleDelete = async (id: number) => {
    if (!confirm("Tem certeza que deseja apagar esta resposta?")) return
    
    setIsDeleting(id)
    try {
      const res = await fetch(`/api/survey?id=${id}`, { method: "DELETE" })
      if (res.ok) {
        setResponses(prev => prev.filter(r => r.id !== id))
        if (expandedResponse === id) setExpandedResponse(null)
      } else {
        alert("Erro ao apagar resposta")
      }
    } catch {
      alert("Erro ao apagar resposta")
    } finally {
      setIsDeleting(null)
    }
  }

  const handleEdit = (response: SurveyResponse) => {
    setEditingResponse(response)
    const formData: Record<string, string> = {}
    allQuestions.forEach(q => {
      const value = response[q as keyof SurveyResponse]
      formData[q] = (value as string) || ""
    })
    setEditFormData(formData)
  }

  const handleSaveEdit = async () => {
    if (!editingResponse) return
    
    setIsSaving(true)
    try {
      const res = await fetch("/api/survey", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id: editingResponse.id, ...editFormData })
      })
      
      if (res.ok) {
        setResponses(prev => prev.map(r => 
          r.id === editingResponse.id 
            ? { ...r, ...editFormData } 
            : r
        ))
        setEditingResponse(null)
        router.refresh()
      } else {
        alert("Erro ao salvar alterações")
      }
    } catch {
      alert("Erro ao salvar alterações")
    } finally {
      setIsSaving(false)
    }
  }

  return (
    <main className="min-h-screen bg-background">
      {/* Edit Modal */}
      {editingResponse && (
        <div className="fixed inset-0 bg-black/70 z-50 flex items-center justify-center p-4">
          <div className="bg-card border border-border rounded-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
            <div className="sticky top-0 bg-card border-b border-border px-6 py-4 flex items-center justify-between">
              <h2 className="font-serif font-bold text-xl text-foreground">
                Editar Resposta #{responses.findIndex(r => r.id === editingResponse.id) + 1}
              </h2>
              <button
                onClick={() => setEditingResponse(null)}
                className="text-muted-foreground hover:text-foreground transition-colors"
              >
                <svg className="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>
            
            <div className="p-6 space-y-6">
              {/* Demographic Questions */}
              <div className="border-b border-border pb-6">
                <h3 className="text-sm font-bold text-accent mb-4">DADOS DEMOGRÁFICOS</h3>
                {demographicQuestions.map(q => (
                  <div key={q} className="mb-4">
                    <label className="block text-sm font-medium text-foreground mb-2">
                      {questionLabels[q]}
                    </label>
                    <select
                      value={editFormData[q] || ""}
                      onChange={(e) => setEditFormData(prev => ({ ...prev, [q]: e.target.value }))}
                      className="w-full bg-secondary border border-border rounded-lg px-4 py-3 text-foreground focus:outline-none focus:ring-2 focus:ring-primary"
                    >
                      <option value="">Selecione...</option>
                      {demographicOptions[q]?.map(opt => (
                        <option key={opt.value} value={opt.value}>
                          {opt.label}
                        </option>
                      ))}
                    </select>
                  </div>
                ))}
              </div>

              {/* Likert Questions */}
              <div>
                <h3 className="text-sm font-bold text-accent mb-4">ESCALA LIKERT (1-5)</h3>
                {likertQuestions.map(q => (
                  <div key={q} className="mb-4">
                    <label className="block text-sm font-medium text-foreground mb-2">
                      {q.toUpperCase()}: {questionLabels[q]}
                    </label>
                    <select
                      value={editFormData[q] || ""}
                      onChange={(e) => setEditFormData(prev => ({ ...prev, [q]: e.target.value }))}
                      className="w-full bg-secondary border border-border rounded-lg px-4 py-3 text-foreground focus:outline-none focus:ring-2 focus:ring-primary"
                    >
                      <option value="">Selecione...</option>
                      {likertOptions.map(opt => (
                        <option key={opt.value} value={opt.value}>
                          {opt.value} - {opt.label}
                        </option>
                      ))}
                    </select>
                  </div>
                ))}
              </div>
            </div>
            
            <div className="sticky bottom-0 bg-card border-t border-border px-6 py-4 flex gap-3 justify-end">
              <button
                onClick={() => setEditingResponse(null)}
                className="px-4 py-2 rounded-lg text-sm font-medium bg-secondary text-foreground hover:bg-secondary/80 transition-colors"
              >
                Cancelar
              </button>
              <button
                onClick={handleSaveEdit}
                disabled={isSaving}
                className="px-4 py-2 rounded-lg text-sm font-medium bg-primary text-primary-foreground hover:bg-primary/90 transition-colors disabled:opacity-50"
              >
                {isSaving ? "Salvando..." : "Salvar"}
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Header */}
      <div className="border-b border-border">
        <div className="max-w-6xl mx-auto px-6 py-8">
          <div className="flex items-center justify-between flex-wrap gap-4">
            <div>
              <div className="flex items-center gap-4">
                <Link href="/" className="text-muted-foreground text-sm hover:text-primary transition-colors">
                  Voltar ao survey
                </Link>
                <button
                  onClick={handleLogout}
                  className="text-muted-foreground text-sm hover:text-red-500 transition-colors"
                >
                  Sair
                </button>
              </div>
              <h1 className="font-serif text-3xl font-extrabold mt-2 text-foreground">
                Resultados da Pesquisa
              </h1>
              <p className="text-muted-foreground mt-1">
                {responses.length} {responses.length === 1 ? "resposta" : "respostas"} coletadas
              </p>
            </div>
            
            <div className="flex gap-2">
              <button
                onClick={refreshResponses}
                disabled={isRefreshing}
                className="px-4 py-2 rounded-lg text-sm font-medium bg-secondary text-foreground hover:bg-secondary/80 transition-colors disabled:opacity-50"
              >
                {isRefreshing ? "Atualizando..." : "Atualizar"}
              </button>
              <button
                onClick={() => setView("summary")}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
                  view === "summary" 
                    ? "bg-primary text-primary-foreground" 
                    : "bg-secondary text-foreground hover:bg-secondary/80"
                }`}
              >
                Resumo
              </button>
              <button
                onClick={() => setView("individual")}
                className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${
                  view === "individual" 
                    ? "bg-primary text-primary-foreground" 
                    : "bg-secondary text-foreground hover:bg-secondary/80"
                }`}
              >
                Individual
              </button>
            </div>
          </div>
        </div>
      </div>

      <div className="max-w-6xl mx-auto px-6 py-8">
        {responses.length === 0 ? (
          <div className="text-center py-20">
            <p className="text-muted-foreground text-lg">Nenhuma resposta ainda.</p>
            <Link href="/" className="text-primary hover:underline mt-2 inline-block">
              Compartilhe o survey para começar a coletar respostas
            </Link>
          </div>
        ) : view === "summary" ? (
          <div className="grid gap-6">
            {/* Demographic Summary */}
            <div className="border-b border-border pb-6 mb-6">
              <h2 className="font-serif text-xl font-bold text-foreground mb-6">Dados Demográficos</h2>
              <div className="grid md:grid-cols-2 gap-6">
                {demographicQuestions.map(q => {
                  const counts = countAnswers(responses, q)
                  const total = Object.values(counts).reduce((a, b) => a + b, 0)
                  
                  return (
                    <div key={q} className="bg-card border border-border rounded-xl p-6">
                      <h3 className="font-serif font-bold text-lg mb-4 text-foreground">
                        {questionLabels[q]}
                      </h3>
                      <div className="space-y-3">
                        {demographicOptions[q]?.map(({ value: key, label }) => {
                          const count = counts[key] || 0
                          const percentage = total > 0 ? (count / total) * 100 : 0
                          
                          return (
                            <div key={key} className="flex items-center gap-4">
                              <div className="w-40 text-sm text-muted-foreground flex-shrink-0">
                                {label}
                              </div>
                              <div className="flex-1 bg-secondary rounded-full h-6 overflow-hidden">
                                <div 
                                  className="h-full bg-accent transition-all duration-500"
                                  style={{ width: `${percentage}%` }}
                                />
                              </div>
                              <div className="w-20 text-sm text-foreground text-right">
                                {count} ({percentage.toFixed(0)}%)
                              </div>
                            </div>
                          )
                        })}
                      </div>
                    </div>
                  )
                })}
              </div>
            </div>

            {/* Likert Summary */}
            <h2 className="font-serif text-xl font-bold text-foreground mb-4">Perguntas - Escala Likert</h2>
            {likertQuestions.map(q => {
              const counts = countAnswers(responses, q)
              const total = Object.values(counts).reduce((a, b) => a + b, 0)

              return (
                <div key={q} className="bg-card border border-border rounded-xl p-6">
                  <h3 className="font-serif font-bold text-lg mb-4 text-foreground">
                    {q.toUpperCase()}: {questionLabels[q]}
                  </h3>
                  <div className="space-y-3">
                    {likertOptions.map(({ value: key, label }) => {
                      const count = counts[key] || 0
                      const percentage = total > 0 ? (count / total) * 100 : 0
                      
                      return (
                        <div key={key} className="flex items-center gap-4">
                          <div className="w-48 text-sm text-muted-foreground flex-shrink-0">
                            {key} - {label}
                          </div>
                          <div className="flex-1 bg-secondary rounded-full h-6 overflow-hidden">
                            <div 
                              className="h-full bg-primary transition-all duration-500"
                              style={{ width: `${percentage}%` }}
                            />
                          </div>
                          <div className="w-20 text-sm text-foreground text-right">
                            {count} ({percentage.toFixed(0)}%)
                          </div>
                        </div>
                      )
                    })}
                  </div>
                </div>
              )
            })}
          </div>
        ) : (
          <div className="space-y-4">
            {responses.map((response, index) => (
              <div 
                key={response.id} 
                className="bg-card border border-border rounded-xl overflow-hidden"
              >
                <div className="flex items-center">
                  <button
                    onClick={() => setExpandedResponse(expandedResponse === response.id ? null : response.id)}
                    className="flex-1 px-6 py-4 flex items-center justify-between text-left hover:bg-secondary/50 transition-colors"
                  >
                    <div>
                      <span className="font-serif font-bold text-foreground">
                        Resposta #{responses.length - index}
                      </span>
                      <span className="text-muted-foreground text-sm ml-3">
                        {new Date(response.created_at).toLocaleDateString("pt-BR", {
                          day: "2-digit",
                          month: "short",
                          year: "numeric",
                          hour: "2-digit",
                          minute: "2-digit"
                        })}
                      </span>
                    </div>
                    <svg 
                      className={`w-5 h-5 text-muted-foreground transition-transform ${
                        expandedResponse === response.id ? "rotate-180" : ""
                      }`}
                      fill="none" 
                      stroke="currentColor" 
                      viewBox="0 0 24 24"
                    >
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
                    </svg>
                  </button>
                  
                  <div className="flex items-center gap-2 px-4">
                    <button
                      onClick={() => handleEdit(response)}
                      className="p-2 rounded-lg text-muted-foreground hover:text-accent hover:bg-accent/10 transition-colors"
                      title="Editar"
                    >
                      <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                      </svg>
                    </button>
                    <button
                      onClick={() => handleDelete(response.id)}
                      disabled={isDeleting === response.id}
                      className="p-2 rounded-lg text-muted-foreground hover:text-red-500 hover:bg-red-500/10 transition-colors disabled:opacity-50"
                      title="Apagar"
                    >
                      {isDeleting === response.id ? (
                        <svg className="w-5 h-5 animate-spin" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                          <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
                        </svg>
                      ) : (
                        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                        </svg>
                      )}
                    </button>
                  </div>
                </div>
                
                {expandedResponse === response.id && (
                  <div className="px-6 py-4 border-t border-border bg-secondary/30">
                    {/* Demographics */}
                    <div className="mb-4 pb-4 border-b border-border">
                      <h4 className="text-xs font-bold text-accent mb-2">DADOS DEMOGRÁFICOS</h4>
                      <div className="grid grid-cols-2 gap-4">
                        {demographicQuestions.map(q => (
                          <div key={q}>
                            <span className="text-muted-foreground text-sm">{questionLabels[q]}: </span>
                            <span className="text-foreground text-sm font-medium">
                              {getDemographicLabel(q, response[q as keyof SurveyResponse] as string | null)}
                            </span>
                          </div>
                        ))}
                      </div>
                    </div>

                    {/* Likert Responses */}
                    <div className="grid gap-3">
                      {likertQuestions.map(q => (
                        <div key={q} className="flex items-start gap-2">
                          <span className="text-accent text-sm font-bold w-8 flex-shrink-0">
                            {q.toUpperCase()}:
                          </span>
                          <span className="text-muted-foreground text-sm flex-1">
                            {questionLabels[q]}
                          </span>
                          <span className="text-foreground text-sm font-medium w-48 text-right">
                            {getLikertLabel(response[q as keyof SurveyResponse] as string | null)}
                          </span>
                        </div>
                      ))}
                    </div>
                  </div>
                )}
              </div>
            ))}
          </div>
        )}
      </div>
    </main>
  )
}
