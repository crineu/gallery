package main

import (
	"log"
	"net/http"
	"os"
	"strings"

	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api"
)

func main() {
	token := os.Getenv("TOKEN")
	bot, err := tgbotapi.NewBotAPI(token)
	if err != nil {
		log.Fatal("Token não encontrado")
	}

	// bot.Debug = true

	updateConfig := tgbotapi.NewUpdate(0)
	updateConfig.Timeout = 600

	updates, err := bot.GetUpdatesChan(updateConfig)
	if err != nil {
		log.Fatal(err)
	}

	for update := range updates {
		if update.Message == nil {
			continue
		}

		if update.Message.Text != "" {
			handleMessage(bot, update.Message.Text, update.Message.Chat.ID)
		}

		if update.Message.Caption != "" {
			handleMessage(bot, update.Message.Caption, update.Message.Chat.ID)
		}
	}
}

func handleMessage(bot *tgbotapi.BotAPI, text string, chatID int64) {
	if strings.Contains(text, "https://") || strings.Contains(text, "http://") {
		link := extractLink(text)
		location, err := getURLLocation(link)
		returnMsg := "Retorno do BOT"
		if err != nil {
			log.Println("Error getting URL location:", err)
			returnMsg = err.Error()
		} else {
			returnMsg = strings.Replace(location, "?", " ", 1)
		}

		msg := tgbotapi.NewMessage(chatID, returnMsg)
		bot.Send(msg)
	}
}

func extractLink(text string) string {
	start := strings.Index(text, "https://")
	if start == -1 {
		start = strings.Index(text, "http://")
	}
	end := strings.IndexAny(text[start:], " \n\t")
	if end == -1 {
		end = len(text)
	} else {
		end += start
	}
	return text[start:end]
}

func getURLLocation(url string) (string, error) {
	resp, err := http.Get(url)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	return resp.Request.URL.String(), nil
}
