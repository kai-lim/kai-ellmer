#install.packages("ellmer")


library(ellmer)
library(shiny)
library(shinychat)

ui <- bslib::page_fluid(
  chat_ui("chat")
)

server <- function(input, output, session) {
  # Initialize a chat object with `ellmer`
  chat <- chat_openai(system_prompt = "You're a helpful assistant who answers questions.")
  
  # Observe user input and generate responses
  observeEvent(input$chat_user_input, {
    # Use async streaming to handle responses without blocking the app
    stream <- chat$stream_async(input$chat_user_input)
    # Append the streaming response to the chat UI
    chat_append("chat", stream)
  })
}

shinyApp(ui, server)



# chat <- chat_openai(
#   model = "gpt-4o-mini",
#   system_prompt = "You are a friendly but terse assistant.",
# )
# 
# 
# live_console(chat)
