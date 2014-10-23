root = @

document = root.document
navigator = root.navigator
location = root.location

class Nravasada
  constructor: (options) ->
    {@url, @imageNode, @lastfm} = options

    @_overloadPutMetadata()
    @_injectScript()

    setInterval () =>
      console.log "Update"
      @_injectScript()
    , 5000

  _overloadPutMetadata: () ->
    proxiedPutMetadata = window.PutMetadata
    if !window.PutListeners
      window.PutListeners = () ->
    window.PutMetadata = (radioname, djnick, djid, djchat, song) =>
      @radioname = radioname
      @djnick = djnick
      @djid = djid
      @djchat = djchat
      artist = song.split("-")[0]
      if @artist != artist
        @artist = artist
        @_getCover @artist

      if proxiedPutMetadata
        proxiedPutMetadata.apply @, arguments

  _injectScript: () ->
    document.head.appendChild @_composeScriptNode()


  _composeScriptNode: () ->
    @script = document.createElement "script"
    @script.src = @url
    @script

  _getCover: (artist) ->
    @lastfm.artistGetInfo artist, (response)=>
      if response?.artist?
        @imageSrc = response.artist.image[4]["#text"]
        @_updateImage()

  _updateImage: ()->
    @imageNode.style.backgroundImage = "url(#{@imageSrc})"

if define?.amd?
  define [], () ->
    Nravasada
else
  root.Nravasada = Nravasada