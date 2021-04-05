# N26iOSEngineerChallenge

This is an iOS challenge made for an iOS Junior Engineer job offer. The challenge consists in an iPhone app which lists the value of bitcoin in some currencies.

## Deployment Info

This app can be executed in any iPhone device with iOS 11.0 or higher


## App Architecture & design patterns

The app follows the MVC pattern recommended by Apple. 

### Model 

The Model part is divided in two parts. One represents the response given by the API and the other is used for make this response more suitable for the view components.

### View

Thew view component consists in one storyboard with the design of the screens of the app

### View Controller

The app has 3 view controllers:
- BitcoinHistoricValuesListTableViewController: Controller which makes a network request to different API endpoints and fill the tableview with data.
- BitcoinValueDetailViewController: Show the data related to the selected list element
- BaseViewController: This controller is used to avoid code repition and reuse some methods which are necessary in the two previous controllers. 

## Network Resources

The network part is divided in three elements:
- Router: An enum used to handle api endpoints easily.
- ServiceLayer: A class in which the url is build and the network request is made and parsed into an object
- NetworkRequest: Used to return the correct data which the view controller needs to know. Acts as an extra layer to avoid massive view controller problem.

## SOLID

This app follows the SOLID principle and it's code is designed to avoid repetition and to be easily reusable.

## App Screenshots

### Bitcoin Historic values

Screen with a list of the value of bitcoin in EUR the last two weeks including today.

![Captura de pantalla 2021-04-05 a las 14 54 22](https://user-images.githubusercontent.com/43856037/113575869-d7e18b00-961e-11eb-9980-e920bed68d26.png)


### Bitcoin Day Details

We come to this screen clicking in any cell of the previous list.

Screen with the value of Bitcoin in EUR, USD and GBP in that day.

![Captura de pantalla 2021-04-05 a las 14 54 49](https://user-images.githubusercontent.com/43856037/113575906-e7f96a80-961e-11eb-9ce8-c7d64e235162.png)




