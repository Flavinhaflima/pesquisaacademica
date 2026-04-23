"use client"

import { useState } from "react"
import SurveyForm from "@/components/survey-form"
import ThankYou from "@/components/thank-you"

export default function SurveyPage() {
  const [submitted, setSubmitted] = useState(false)

  return (
    <main className="min-h-screen bg-background">
      {submitted ? (
        <ThankYou />
      ) : (
        <SurveyForm onSubmit={() => setSubmitted(true)} />
      )}
    </main>
  )
}
