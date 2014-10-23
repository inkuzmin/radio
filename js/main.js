var imageNado = document.getElementById("nrv_cover");


var nrv = new Nravasada({
    url: "http://animeserver.net/wholisten.php?chat=7&mount=4",
    imageNode: imageNado,
    lastfm: new Lastfm({
        "key": "01b1995c7fa2e9cdffb64ca2462484eb"
    })
});