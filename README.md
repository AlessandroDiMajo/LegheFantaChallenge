# LegheFantaChallenge
![](https://img.shields.io/badge/iOS-%3E%3D14.0-blue) 
---
## Table of contents
* [General info](#general-info)
* [UI Technologies](#ui-technologies)
* [Architecture](#architecture)
* [Dependencies](#dependencies)
  
## General info
This project is a challenge for Quadronica.srl

## UI Technologies
The project is created with:
* UIKit
    
## Architecture
In Italian:<br />
Per questo progetto, è stata adottata un'architettura MVVM+C (Model-View-ViewModel + Coordinator). La gestione del salvataggio dei dati dei giocatori di calcio è affidata al FavoritesManager. Una volta invocata la sua funzione dedicata, il FavoritesManager assume la responsabilità di monitorare i dati in memoria, sovrascriverli e quindi notificare l'intera applicazione sugli aggiornamenti. Le view controllers sono incaricati di osservare tali notifiche e di aggiornare l'interfaccia utente di conseguenza.

In English:<br />
For this project, an MVVM+C (Model-View-ViewModel + Coordinator) architecture has been adopted. The management of football player data storage is entrusted to the FavoritesManager. Once its dedicated function is called, the FavoritesManager takes on the responsibility of monitoring the in-memory data, overwriting them, and subsequently notifying the entire application about updates. The view controllers are responsible for observing these notifications and updating the user interface accordingly.

## Dependencies
In Italian:<br />
Kingfisher -> utilizzato per la memorizzazione nella cache e il download di immagini.<br />
Anchorage -> impiegato per una gestione più semplice dell'interfaccia utente.<br />
RxSwift & RxCocoa -> utilizzati per la programmazione reattiva.<br />
NotificationBannerSwift -> utilizzato per visualizzare notifiche di errore nell'interfaccia utente.<br />
SwiftLint -> integrato per una migliore qualità del codice.<br />
IQKeyboardManager -> implementato per una gestione semplificata della comparsa e scomparsa della tastiera.<br />

In English:<br />
Kingfisher -> used for image caching and downloading.<br />
Anchorage -> utilized for more straightforward UI management.<br />
RxSwift & RxCocoa -> employed for reactive programming.<br />
NotificationBannerSwift -> employed for displaying error notifications within the UI.<br />
SwiftLint -> integrated for improved code quality.<br />
IQKeyboardManager -> implemented for streamlined keyboard show/hide management.<br />