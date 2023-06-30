require 'telegram/bot'

token = ENV.fetch('TOKEN')

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text

    when '/start'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: "Olá, #{message.from.first_name}"
      )

    when '/h', '/help'
      bot.api.send_message(
        chat_id: message.chat.id,
        text: %w(/parabenizar /reprimir /briga /cutucada).join("\n")
      )

    when '/parabenizar'
      tecladao = Telegram::Bot::Types::ReplyKeyboardMarkup.new(
        keyboard: [
          "PARABÉNS Murilo Teixeira Fernandes\nBEM VINDA Camila Nunes Vieira Zotti",
          "...com todo respeito que devo aos outros colegas, e sem querer lavar roupa suja no canal, DEIXA DE SER BUNDÃO!"
        ],
        one_time_keyboard: true,
        selective: true
      )
      bot.api.send_message(
        chat_id: message.chat.id,
        text: 'Ouçamos um parabenizamento:',
        reply_markup: tecladao
      )

    when '/reprimir'
      frase = ['Não sei se tens algum problema com o @Xáxa, ',
          'mas não é a primeira vez que vejo você tendo uma postura anti-profissional ',
          'em relação a ela. Aqui somos todos colegas de profissão e não é legal ',
          'praticar assédio moral contra nossos pares.'].join
      bot.api.send_message(
        chat_id: message.chat.id,
        text: frase
      )

    when '/briga'
      frase = "Não fujo de briga!\nNão fujo mesmo!"
      bot.api.send_message(
        chat_id: message.chat.id,
        text: frase
      )

    when '/cutucada'
      frase = ['Na reunião do dia 17/09 eu tive instabilidade na minha conexão e não ',
        'consegui acompanhar todas as falas e encaminhamentos. Você poderia enviar por e-mail ',
        'qual a orientação que cada servidor/equipe deve seguir?'].join
      bot.api.send_message(
        chat_id: message.chat.id,
        text: frase
      )

    when '/bot'
      bot.api.send_message(
        chat_id: message.chat.id,
        parse_mode: :MarkdownV2,
        text: "[#{message.from.first_name}](tg://user?id=#{message.from.id}) Link pra citação do cidadão @#{message.from.username}",
        reply_to_message_id: message.message_id
      )

    # else
    #   bot.api.send_message(
    #     chat_id: message.chat.id,
    #     text: "Debug, id #{message.from.id}, first_name #{message.from.first_name}, last_name #{message.from.last_name}, username #{message.from.username}, entities #{message.entities}"
    #   )
    end

  end
end
