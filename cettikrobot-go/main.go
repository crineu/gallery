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

	bot.Debug = true

	updateConfig := tgbotapi.NewUpdate(0)
	updateConfig.Timeout = 60

	updates, err := bot.GetUpdatesChan(updateConfig)
	if err != nil {
		log.Fatal(err)
	}

	for update := range updates {
		if update.Message == nil || update.Message.Text == "" {
			continue
		}

		if strings.Contains(update.Message.Text, "https://") || strings.Contains(update.Message.Text, "http://") {
			link := extractLink(update.Message.Text)
			location, err := getURLLocation(link)
			if err != nil {
				log.Println("Error getting URL location:", err)
				continue
			}

			msg := tgbotapi.NewMessage(update.Message.Chat.ID, location)
			bot.Send(msg)
		}
	}
}

func extractLink(text string) string {
	start := strings.Index(text, "https://")
	if start == -1 {
		start = strings.Index(text, "http://")
	}
	end := strings.Index(text[start:], " ")
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
