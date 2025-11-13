class CustomerFeedbackClient
  def self.generate(post:, comments:)
    prompt = <<~TEXT
    投稿内容: #{post.body}
    顧客コメント:
        #{comments.map(&:body).join("\n")}
      TEXT

      client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])

      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          temperature: 0.3,
          messages: [
            { role: "system", content: "あなたは投稿内容に対して顧客の反応を分析し、項目ごとに改行してフィードバックと改善点を返すAIです。"},
            { role: "user", content: prompt }
          ]
        }
      )

      response.dig("choices",0, "message", "content")
  end
end