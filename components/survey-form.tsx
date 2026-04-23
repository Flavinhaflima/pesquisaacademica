"use client"

import { useState, useEffect } from "react"
import { cn } from "@/lib/utils"

interface Question {
  id: number
  block_number: number
  block_title: string
  question_number: string
  question_text: string
  check_note: string | null
  question_type: string
  options: { value: string; label: string }[] | null
  sort_order: number
}

// Helper to convert "Q1" to "q1", "Q0_a" to "q0a", "Q4.1" to "q41" for form submission
const getQuestionKey = (questionNumber: string) => questionNumber.toLowerCase().replace('.', '').replace('_', '')

interface QuestionCardProps {
  number: string
  question: string
  children: React.ReactNode
  checkNote?: string | null
  isSubQuestion?: boolean
  hasError?: boolean
}

function QuestionCard({ number, question, children, checkNote, isSubQuestion, hasError }: QuestionCardProps) {
  const highlightPlatforms = (text: string) => {
    const parts = text.split(/(Instagram|TikTok|Instagram ou TikTok|TikTok ou Instagram)/g)
    return parts.map((part, index) => {
      if (['Instagram', 'TikTok', 'Instagram ou TikTok', 'TikTok ou Instagram'].includes(part)) {
        return <span key={index} className="font-medium text-primary">{part}</span>
      }
      return part
    })
  }

  return (
    <div className={cn(
      "bg-card border border-border rounded-[14px] p-6 mb-3.5 transition-colors focus-within:border-primary/25",
      isSubQuestion && "ml-6 bg-card/50",
      hasError && "border-red-500/70 bg-red-500/5"
    )}>
      <div className="font-serif text-[11px] font-bold text-muted-foreground tracking-[0.1em] mb-2">
        {number}
      </div>
      <div className="text-[15px] font-normal text-foreground mb-4 leading-[1.55]">
        {highlightPlatforms(question)}
      </div>
      {checkNote && (
        <span className="text-[11px] text-accent bg-accent/10 rounded-md px-2.5 py-1 inline-block mb-3.5">
          {checkNote}
        </span>
      )}
      {children}
      {hasError && (
        <p className="mt-3 text-sm text-red-400">
          Esta pergunta é obrigatória.
        </p>
      )}
    </div>
  )
}

interface RadioOptionProps {
  name: string
  value: string
  label: string
  selected: boolean
  onChange: (value: string) => void
}

function RadioOption({ name, value, label, selected, onChange }: RadioOptionProps) {
  return (
    <label
      className={cn(
        "flex items-start gap-3 cursor-pointer p-3 px-3.5 rounded-[10px] border transition-all text-sm text-[#c0c0cc] leading-[1.45]",
        selected
          ? "border-primary/30 bg-primary/5 text-foreground"
          : "border-transparent bg-secondary hover:border-primary/20 hover:text-foreground"
      )}
    >
      <input
        type="radio"
        name={name}
        value={value}
        checked={selected}
        onChange={() => onChange(value)}
        className="appearance-none w-[17px] h-[17px] rounded-full border-[1.5px] border-muted-foreground bg-transparent flex-shrink-0 mt-0.5 transition-all cursor-pointer checked:bg-primary checked:border-primary checked:shadow-[0_0_0_3px_rgba(200,241,53,0.15)]"
      />
      <span>{label}</span>
    </label>
  )
}

interface LikertScaleProps {
  name: string
  options: { value: string; label: string }[]
  selected: string | undefined
  onChange: (value: string) => void
}

function LikertScale({ name, options, selected, onChange }: LikertScaleProps) {
  return (
    <div className="space-y-2">
      <div className="grid grid-cols-5 gap-2">
        {options.map((option) => (
          <label
            key={option.value}
            className={cn(
              "flex flex-col items-center justify-center cursor-pointer p-3 rounded-[10px] border transition-all text-center min-h-[80px]",
              selected === option.value
                ? "border-primary bg-primary/10 text-foreground"
                : "border-border bg-secondary hover:border-primary/30 text-muted-foreground hover:text-foreground"
            )}
          >
            <input
              type="radio"
              name={name}
              value={option.value}
              checked={selected === option.value}
              onChange={() => onChange(option.value)}
              className="sr-only"
            />
            <span className="text-xl font-bold mb-1">{option.value}</span>
            <span className="text-[10px] leading-tight">{option.label}</span>
          </label>
        ))}
      </div>
    </div>
  )
}

interface SurveyFormProps {
  onSubmit: () => void
}

export default function SurveyForm({ onSubmit }: SurveyFormProps) {
  const [questions, setQuestions] = useState<Question[]>([])
  const [answers, setAnswers] = useState<Record<string, string>>({})
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [isLoading, setIsLoading] = useState(true)
  const [progress, setProgress] = useState(0)
  const [missingQuestions, setMissingQuestions] = useState<string[]>([])

  useEffect(() => {
    fetchQuestions()
  }, [])

  const fetchQuestions = async () => {
    try {
      const response = await fetch('/api/questions')
      const data = await response.json()
      const parsedData = data.map((q: Question & { options: string | null | { value: string; label: string }[] }) => ({
        ...q,
        options: typeof q.options === 'string' ? JSON.parse(q.options) : q.options
      }))
      setQuestions(parsedData)
    } catch (error) {
      console.error('Error fetching questions:', error)
    } finally {
      setIsLoading(false)
    }
  }

  const updateAnswer = (question: string, value: string) => {
    const newAnswers = { ...answers, [question]: value }
    setAnswers(newAnswers)
    setMissingQuestions(prev => prev.filter(q => q !== question))
    
    const requiredQuestions = getRequiredQuestions()
    const answered = requiredQuestions.filter(q => newAnswers[getQuestionKey(q.question_number)]?.trim()).length
    setProgress(requiredQuestions.length > 0 ? (answered / requiredQuestions.length) * 100 : 0)
  }

  const getRequiredQuestions = () => {
    const answerableQuestions = questions.filter(q => q.question_type !== 'header')
    const sortedQuestions = [...answerableQuestions].sort((a, b) => a.sort_order - b.sort_order)

    return sortedQuestions.filter((question, index) => {
      const isLastQuestion = index === sortedQuestions.length - 1
      return !(isLastQuestion && question.question_type === 'textarea')
    })
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()

    const missing = getRequiredQuestions()
      .filter(q => !answers[getQuestionKey(q.question_number)]?.trim())
      .map(q => getQuestionKey(q.question_number))

    if (missing.length > 0) {
      setMissingQuestions(missing)
      document.getElementById(`question-${missing[0]}`)?.scrollIntoView({
        behavior: 'smooth',
        block: 'center'
      })
      return
    }

    setIsSubmitting(true)

    try {
      const response = await fetch('/api/survey', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(answers),
      })

      if (response.ok) {
        onSubmit()
      } else {
        const errorData = await response.json().catch(() => ({}))
        console.error('Survey submission failed:', response.status, errorData)
        alert('Erro ao enviar respostas. Por favor, tente novamente.')
      }
    } catch (error) {
      console.error('Error submitting survey:', error)
      alert('Erro de conexão. Verifique sua internet e tente novamente.')
    } finally {
      setIsSubmitting(false)
    }
  }

  // Group questions by block
  const groupedQuestions = questions.reduce((acc, question) => {
    const blockKey = `${question.block_number}-${question.block_title}`
    if (!acc[blockKey]) {
      acc[blockKey] = {
        blockNumber: question.block_number,
        blockTitle: question.block_title,
        questions: []
      }
    }
    acc[blockKey].questions.push(question)
    return acc
  }, {} as Record<string, { blockNumber: number; blockTitle: string; questions: Question[] }>)

  const sortedBlocks = Object.values(groupedQuestions).sort((a, b) => a.blockNumber - b.blockNumber)

  if (isLoading) {
    return (
      <div className="min-h-screen bg-background flex items-center justify-center">
        <div className="animate-spin rounded-full h-10 w-10 border-b-2 border-primary"></div>
      </div>
    )
  }

  const renderQuestion = (question: Question) => {
    const isSubQuestion = question.question_number.includes('.')
    const key = getQuestionKey(question.question_number)
    const hasError = missingQuestions.includes(key)
    
    // Header type question (like Q4) - just show the text without input
    if (question.question_type === 'header') {
      return (
        <div key={question.id} className="bg-card border border-border rounded-[14px] p-6 mb-3.5">
          <div className="font-serif text-[11px] font-bold text-muted-foreground tracking-[0.1em] mb-2">
            {question.question_number}
          </div>
          <div className="text-[15px] font-normal text-foreground leading-[1.55]">
            {question.question_text}
          </div>
        </div>
      )
    }

    return (
      <div key={question.id} id={`question-${key}`} className="scroll-mt-12">
        <QuestionCard
          number={question.question_number}
          question={question.question_text}
          checkNote={question.check_note}
          isSubQuestion={isSubQuestion}
          hasError={hasError}
        >
          {question.question_type === 'textarea' ? (
            <textarea
              name={key}
              value={answers[key] || ""}
              onChange={(e) => updateAnswer(key, e.target.value)}
              placeholder="Escreva aqui sua resposta..."
              className="w-full bg-secondary border border-border rounded-[10px] text-foreground font-sans text-sm font-light p-3.5 resize-y min-h-[90px] outline-none transition-colors focus:border-primary/30 placeholder:text-muted-foreground"
            />
          ) : question.question_type === 'likert' && question.options ? (
            <LikertScale
              name={key}
              options={question.options}
              selected={answers[key]}
              onChange={(v) => updateAnswer(key, v)}
            />
          ) : (
            <div className="flex flex-col gap-2">
              {question.options?.map((option) => (
                <RadioOption
                  key={option.value}
                  name={key}
                  value={option.value}
                  label={option.label}
                  selected={answers[key] === option.value}
                  onChange={(v) => updateAnswer(key, v)}
                />
              ))}
            </div>
          )}
        </QuestionCard>
      </div>
    )
  }

  return (
    <>
      {/* Progress Bar */}
      <div className="sticky top-0 z-10 h-[3px] bg-secondary">
        <div
          className="h-full bg-primary transition-[width] duration-300 ease-out"
          style={{ width: `${progress}%` }}
        />
      </div>

      {/* Hero */}
      <div className="relative overflow-hidden py-20 px-6 text-center border-b border-border">
        <div className="absolute inset-[-60px] pointer-events-none bg-[radial-gradient(ellipse_70%_50%_at_50%_0%,rgba(200,241,53,0.12)_0%,transparent_70%),radial-gradient(ellipse_50%_40%_at_80%_100%,rgba(123,97,255,0.1)_0%,transparent_60%)]" />
        
        <div className="inline-block font-sans text-[11px] font-medium tracking-[0.12em] uppercase text-primary border border-primary/30 rounded-full py-1.5 px-3.5 mb-7">
          Pesquisa Acadêmica - SKEMA Business School
        </div>
        
        <h1 className="font-serif text-[clamp(2rem,6vw,3.6rem)] font-extrabold leading-[1.1] tracking-[-0.02em] max-w-[700px] mx-auto mb-7 text-balance">
          Você realmente para
          <br />
          pra ver um anúncio
          <br />
          <em className="not-italic text-primary">no meio do scroll?</em>
        </h1>
        
        <div className="max-w-[580px] mx-auto text-muted-foreground text-[15px] leading-[1.75]">
          <p>
            Esta pesquisa faz parte de um projeto acadêmico que investiga como as pessoas respondem a anúncios nas redes sociais - especialmente no Instagram e TikTok, onde o conteúdo é rápido, contínuo e moldado por algoritmos.
          </p>
          <p className="mt-3">
            Não há respostas certas ou erradas. Responda com base nos seus hábitos reais. O survey leva cerca de 3-4 minutos e é completamente anônimo.
          </p>
        </div>
      </div>

      {/* Form */}
      <form onSubmit={handleSubmit} className="max-w-[720px] mx-auto px-6 pb-20">
        {sortedBlocks.map((block) => (
          <div key={block.blockNumber} className="mt-12">
            {block.blockTitle && block.blockTitle.trim() !== '' && (
              <div className="font-serif text-[10px] font-bold tracking-[0.18em] uppercase text-accent mb-5 flex items-center gap-2.5">
                {block.blockTitle}
                <span className="flex-1 h-px bg-border" />
              </div>
            )}

            {block.questions.sort((a, b) => a.sort_order - b.sort_order).map(renderQuestion)}
          </div>
        ))}

        {/* Submit */}
        <div className="mt-10 text-center">
          <button
            type="submit"
            disabled={isSubmitting}
            className="font-serif text-[15px] font-bold tracking-[0.04em] bg-primary text-primary-foreground border-none rounded-full py-4 px-12 cursor-pointer transition-all hover:-translate-y-0.5 hover:shadow-[0_8px_32px_rgba(200,241,53,0.25)] disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {isSubmitting ? "Enviando..." : "Enviar Respostas"}
          </button>
        </div>
      </form>
    </>
  )
}
