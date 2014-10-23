root = @

document = root.document
navigator = root.navigator
location = root.location

class Lastfm
  constructor: (options) ->
    @apiProtocol = "http"
    @apiUrl = "ws.audioscrobbler.com"
    @apiVersion = "2.0"

    @apiBaseUrl = @_constructApiBaseUrl @apiProtocol, @apiUrl, @apiVersion

    {@key, @format} = options
    @format = @format or "json"

  artistGetInfo: (artist, callback) ->
    @_apiRequest "artist.getinfo", artist: artist, callback


  _apiRequest: (method, params, callback) ->
    requestString = ""
    requestString += "&#{param}=#{encodeURIComponent request}" for own param, request of params

    url = "#{@apiBaseUrl}?method=#{method}#{requestString}&api_key=#{@key}&format=#{@format}"

    @_xhrRequest url, callback

  _constructApiBaseUrl: (protocol, url, version) ->
    @apiBaseUrl = "#{protocol}://#{url}/#{version}/"

  _xhrRequest: (url, callback) ->
    xhr = new XMLHttpRequest()

    xhr.onreadystatechange = () ->
      if xhr.readyState == 4 && xhr.status == 200
        response = JSON.parse xhr.responseText
        callback response

    xhr.open("GET", url, true)
    xhr.send()

if define?.amd?
  define [], () ->
    Lastfm
else
  root.Lastfm = Lastfm
