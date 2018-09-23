# rmit-ios-2018b
iOS Weather App ⛈❄️🦋
</br>***
</br> api: https://api.darksky.net/forecast/b9fc9277797647a38161d0f28d058376/
</br>***
</br>CustomTabController.swift: 
</br>- stores location to be used by other views (ex: "42.3601,-71.0589")
</br>- gets current location: https://stackoverflow.com/questions/25296691/get-users-current-location-coordinates
</br>- to get location from other views: https://stackoverflow.com/questions/29734954/how-do-you-share-data-between-view-controllers-and-other-objects-in-swift
</br>***
</br>SettingsScreen.swift:
</br>- geocodes location input by user 
</br>- updates CustomTabController location
</br>***
</br>Hourly:
</br>*
</br>HourlyScreen.swift: custom viewcontroller class for Hourly Scene in storyboard
</br>viewDidAppear: reinitializes view according to CustomTabController location
</br>URLSession: https://www.lynda.com/iOS-tutorials/Manage-text-JSON-from-server/645028/682880-4.html
</br>*
</br>HourlyCell.swift: custom tableviewcell class for HourlyCell in storyboard 
</br>Custom Cell: https://www.youtube.com/watch?v=FtO5QT2D_H8&t=744s
</br>*
</br>HourlyWeather.swift: object to hold json response for hourly forecast and populate HourlyCell
