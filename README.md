# YoutubeV3apiList
Retrieving from new YoutubeAPI V3 to show a list of videos from a single user or channel

Extra Notes
APIKeyAndConstants.h                                                       |    channel id here    |
- kPlayListID - ID of user's channel - ie. https://www.youtube.com/channel/UCIyJyNFVRJpce6wmYUNtMNw
- kAPIKey - is apikey I generated for one of my apps (iPit Slo) - To generate your own:
            1. Goto Google Developers Console and create a project
            2. After project created and Youtube APIs enabled, goto Credentials on left menu
            3. For this example's method of retrieving the video list, crete new key under Public API Access'
            4. MAKE SURE IT'S A BROWSER KEY (for this example)
            5. Enjoy the key to your user's viewing pleasures

YoutubeTableViewController
- parses json created from api and values in APIKeyAndConstants into an NSMutableArray, videos
- can change size of thumbnail in tableview by replacing @"default" in thumbnailData with desired thumbnail size
- id for video (key to retrieving and playing it) is under resourceId in json

YoutubeDetailController
- using CGFloats x,y,width, and height to control first frame picture bounds. This example bases everything off of a percentage of the device's screen dimensions so edit as you would like