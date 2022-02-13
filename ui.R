
# install.packages("ggmap")
# install.packages("lubridate")

library(readr)
library(shiny)
library(lubridate)
#library(ggmap)

band_name <- "The Schmidt Brothers"
current_year <- as.character(year(Sys.Date()))

# USER INTERFACE----------------------------------------------------------------------------------------------------------------------------
# Input Options-------------------------------------------------------------------------------------------
event_type_options <- c("Free Public Performance", "Ticketed Public Performance", "Free Band Hosted Performance", "Ticketed Band Hosted Performance", "Music Festival", "City Festival", "Private Party",  "Wedding", "Corporate Event", "Other")
venue_type_options <- c("Bar", "Music Venue", "City Event", "Theater", "Event Center", "Residential", "Hotel", "Local Live Music", "Specialized Event", "Other")

sound_options <- c("Tim Fry", "Phil Tschechaniuk", "Shane Lunsford", "Matt Greiner", "James Greenhill", "Cory McBride", "Mike McMeins", "Jeff Pieler", "Doug Berry", "Venue Provided", "Other", "N/A")
light_options <- c("Doug Berry", "Harry Backer", "Daren Barker", "Mike Zhorne", "Venue Provided", "Other", "N/A")
roadie_options <- c("Harry Backer", "Connor Music", "Keenan Daly", "Other", "N/A")

commission_options <- c("Cory Talbot", "Stephen Schmidt", "Sam Schmidt", "Gabe Schmidt", "Other", "N/A")


# Event Information Input --------------------------------------------------------------------------------
# date_input <- textInput("event_date", label = "Event Date", value = "")
# venue_input <- textInput("venue", label = "Event Venue", value = "")
# location_input <- textInput("location", label = "Event Location", value = "")
# s_time_input <- textInput("s_time", label = "Start Time", value = "")
# e_time_input <- textInput("e_time", label = "End Time", value = "")
# event_type_input <- sidebarPanel("event_type", label = "Event Type", choices = event_type_options)
# venue_type_input <- sidebarPanel("venue_type", label = "Venue Type", choices = venue_type_options)
# 
# # Contact Information Input-------------------------------------------------------------------------------
# contact_name_input <- textInput("contact_name", label = "Contact Name", value = "")
# phone_input <- textInput("phone_number", label = "Phone", value = "")
# email_input <- textInput("email", label = "Email", value = "")
# 
# # Variable Input------------------------------------------------------------------------------------------
# commision_input <- sidebarPanel("commision", label = "Commission", choices = commission_options)
# distance_input <- textInput("distance", label = "Driving Distance", value = "")
# lodging <- textInput("lodging", label = "Lodging Cost", value = "")
# # band_fund <- sidebarPanel("band_fund", label = "Band Fund Rate", choices = c("5%", "10%", "15%", "20%"), value = "20%")
# 
# 
# sound_input <- sidebarPanel("sound", label = "Sound Production", choices = sound_options)
# light_input <- sidebarPanel("lighs", label = "Light Production", choices = light_options)
# roadie_input <- sidebarPanel("roadie", label = "Roadie", choices = roadie_options)
# 
# sound_total_input <- textInput("sound_total", label = "Sound Production Cost", value = "")
# light_total_input <- textInput("light_total", label = "Light Production Cost", value = "")
# roadie_total_input <- textInput("roadie_total", label = "Roadie Cost", value = "")

# Constants
# mileage_rate <- textInput("mileage_rate", label = "Mileage Rate", value = ".50")
#band_cut <- textInput("band_cut", label = "Band Cut", value = "300")
# band_fund <- sidebarPanel("band_fund", label = "Band Fund Rate", choices = c("5%", "10%", "15%", "20%"), value = "20%")


# contact_panel <- sidebarPanel(date_input,venue_input, location_input, s_time_input, e_time_input, event_type_input, venue_type_input)
# production_panel <- 
# 
# df_panel <- plotOutput("df")
# 
# final_panel <- sidebarLayout(contact_panel, df_panel)
# 

event_details <- sidebarPanel(
  textInput("event_date", label = "Event Date", value = ""),
  textInput("venue", label = "Event Venue", value = ""),
  location_input <- textInput("location", label = "Event Location", value = ""),
  textInput("s_time", label = "Start Time", value = ""),
  textInput("e_time", label = "End Time", value = ""),
  selectInput("event_type", label = "Event Type", choices = event_type_options),
  selectInput("venue_type", label = "Venue Type", choices = venue_type_options)
)
  
production_details <- sidebarPanel(
  selectInput("sound", label = "Sound Production", choices = sound_options),
  selectInput("lighs", label = "Light Production", choices = light_options),
  selectInput("roadie", label = "Roadie", choices = roadie_options)
)
    
variables <- sidebarPanel(
  selectInput("commision", label = "Commission", choices = commission_options),
  numericInput("distance", label = "Driving Distance", value = ""),
  numericInput("lodging", label = "Lodging Cost", value = ""),
  #selectInput("band_fund", label = "Band Fund Rate", choices = c)
  width = 5
)

constants <- sidebarPanel(
  numericInput("band_members", label = "Band Members", value = "3"),
  numericInput("mileage_rate", label = "Mileage Rate", value = ".50"),
  numericInput("band_cut", label = "Band Cut", value = "300"),
  numericInput("band_fund", label = "Band Fund Rate", value = ".2")
) 

production_cost <- sidebarPanel(
  numericInput("sound_total", label = "Sound Production Cost", value = ""),
  numericInput("light_total", label = "Light Production Cost", value = ""),
  numericInput("roadie_total", label = "Roadie Cost", value = "")
)

# ui <- fluidPage(
#   titlePanel(paste(band_name, "Performance Fee Calculator")),
#   sidebarLayout(event_details),
#   mainPanel(
#     tabsetPanel(
#       tabPanel("Variables", variables)
#     )
#   )
# )

# ui <- fluidPage(
#   titlePanel(paste(band_name, "Performance Fee Calculator")),
#   event_details3
# )


ui <- navbarPage(paste(band_name, "Performance Fee Calculator"), 
    tabPanel("Event Details",
        fluidPage(
          # titlePanel(paste(band_name, "Performance Fee Calculator")),
          tags$div(textInput("event_date", label = "Event Date (mm/dd/yyyy)", value = ""),  style="display:inline-block"),
          tags$div(textInput("venue", label = "Event Venue", value = ""),  style="display:inline-block"),
          tags$div(location_input <- textInput("location", label = "Event Location (City, State)", value = ""),  style="display:inline-block"),
          tags$div(textInput("event_host", label = "Event Host", value = ""),  style="display:inline-block"),
          tags$div(textInput("s_time", label = "Start Time", value = ""),  style="display:inline-block"),
          tags$div(textInput("e_time", label = "End Time", value = ""),  style="display:inline-block"),
          
          tags$div(selectInput("time_of_day", label = "Time of Day", choices = c("Morning", "Afternoon", "Evening")),  style="display:inline-block"),
          tags$div(selectInput("public_private", label = "Public/Private Event", choices = c("Public", "Private")),  style="display:inline-block"),
          tags$div(selectInput("event_type", label = "Event Type", choices = event_type_options),  style="display:inline-block"),
          tags$div(selectInput("venue_type", label = "Venue Type", choices = venue_type_options),  style="display:inline-block"),
          tags$div(selectInput("environment_type", label = "Environment", choices = c("Indoor", "Outdoor")),  style="display:inline-block"),
          tags$div(selectInput("stage", label = "Stage (Yes/No)", choices = c("Yes", "No")),  style="display:inline-block"),
          
          tags$div(textInput("contact_name", label = "Contact Name", value = ""),  style="display:inline-block"),
          tags$div(textInput("phone_number", label = "Phone", value = ""),  style="display:inline-block"),
          tags$div(textInput("email", label = "Email", value = ""),  style="display:inline-block"),
          hr(),
          
          # tags$div(selectInput("sound", label = "Sound Production", choices = sound_options),  style="display:inline-block"),
          # tags$div(selectInput("lights", label = "Light Production", choices = light_options),  style="display:inline-block"),
          # tags$div(selectInput("roadie", label = "Roadie", choices = roadie_options),  style="display:inline-block")
      ) #close fluid page 
    ), #close event details panel
    tabPanel("Variables",
      sidebarPanel(
        numericInput("band_members", label = "Band Members", value = "3"),
        numericInput("mileage_rate", label = "Mileage Rate", value = ".50"),
        numericInput("band_cut", label = "Band Cut", value = "300"),
        numericInput("band_fund", label = "Band Fund Rate", value = ".2") 
      ) #close variable sidebar panel 
    ) #close variables panel 
) #close naviigation bar function




