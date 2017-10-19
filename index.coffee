# TODO-1: Add DarkSky api key below
apiKey: 'YOUR DARKSKY APIKEY'

# TODO-2: Set the units format (si or us) below
units: 'si'

# TODO-3: Set the weather summary language
# like: en, zh...(https://darksky.net/dev/docs)
lang: 'zh'

# Refresh every 60 seconds
refreshFrequency: 600000

command: "echo {}"

city: "echo {}"

render: (o) -> """
  <div class='weather'>
    <div class='icon'></div>
    <div class='temp'></div>
    <div class='summary'></div>
  </div>
"""

# Gets the location
afterRender: (domEl) ->
  geolocation.getCurrentPosition (e) =>
    coords     = e.position.coords
    [lat, lon] = [coords.latitude, coords.longitude]
    @command   = @makeCommand(@apiKey, "#{lat},#{lon}", @units, @lang)
    @city = e.address.city
    @refresh()
    
makeCommand: (apiKey, location, units, lang) ->
  exclude  = "alerts,flags"
  "curl -sS 'https://api.darksky.net/forecast/#{apiKey}/#{location}?units=#{units}&exclude=#{exclude}&lang=#{lang}'"

update: (output, domEl) ->
  data  = JSON.parse(output)
  today = data.daily?.data[0]
  return unless today?
  
  icon = data.currently.icon
  city = @city

  if @units != ''
    if @units == "si"
      $(domEl).find('.temp').html """
        <span class='num'>#{Math.round(data.currently.temperature)}<span>&#xf03c;</span></span>
      """
    else if @units == "us"
      $(domEl).find('.temp').html """
        <span class='num'>#{Math.round(data.currently.temperature)}<span>&#xf045;</span></span>
      """
  else
    $(domEl).find('.temp').html """
      <span class='num'>#{Math.round(data.currently.temperature)}˚</span>
    """

  $(domEl).find('.summary').html """
    <p>#{city} | #{data.currently.summary}, #{Math.round((data.daily.data[0].temperatureMin)*10)/10}-#{Math.round((data.daily.data[0].temperatureMax)*10)/10}˚</p>
    <p>#{data.daily.summary}</p>
  """
  $(domEl).find('.icon')[0].innerHTML = @getIcon(icon)

iconMapping:
  "clear-day"               :"&#xf00d;"
  "clear-night"             :"&#xf02e;"
  "partly-cloudy-day"       :"&#xf002;"
  "partly-cloudy-night"     :"&#xf086;"
  "cloudy"                  :"&#xf013;"
  "rain"                    :"&#xf036;"
  "snow"                    :"&#xf038;"
  "sleet"                   :"&#xf039;"
  "fog"                     :"&#xf030;"
  "wind"                    :"&#xf02f;"
  "unknown"                 :"&#xf03e;"
    
getIcon: (icon) ->
  return @iconMapping["unknown"] unless icon
  @iconMapping["#{icon}"]
      
style: """
  top: 30px
  left: 50px
  color: #fff
  text-shadow: 0 0 1px rgba(#000, 0.3)
  font-family: Helvetica Neue
  text-align: left
  width: 600px

  @font-face
    font-family Weather
    src url(simple-weather-darksky.widget/weathericons.svg) format('svg')

  .weather
    display: inline-block
    text-align: left
    position: relative
    width: 100%

  .icon
    font-family: Weather
    font-size: 60px
    line-height: 60px
    position: absolute
    left: 0
    vertical-align: middle

  .temp
    vertical-align: middle
    padding-left: 80px
    font-weight: 200
    font-size: 60px
    line-height: 60px
    position: relative

    .num
      position: relative

      span
        font-family: Weather
        font-size: 32px
        position: absolute
        top: 0
        right: -25px

  .summary
    display: inline-block
    text-transform: capitalize
    font-size: 12px
    line-height: 1.0
    color: #fff
    position: absolute
    left: 0
    top: 65px

    p
      margin-top: 4px
      margin-bottom: 4px
	  font-family: -apple-system, PingFang SC
"""
