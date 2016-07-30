function show($elem, is12Hours, isShowSecond, isShowBlinking) {
    var now, date = new Date();
    now = is12Hours ? date.getHours() % 12 == 0 ? 12 : date.getHours() % 12 : date.getHours();
    now = isShowSecond ? now + ":" + date.getMinutes() + ":" + date.getSeconds() : now + ":" + date.getMinutes();
    $elem.html(now);
    if (isShowBlinking) setTimeout(function() {
        $elem.html("");
    },
    800);

}
function showtime() {
    var $clocks = $("span[id ^= CLOCK]");
    $clocks.each(function() {
        var self = $(this),
        conf = self.attr("data-set");
        is12Hours = conf.indexOf("12") >= 0,
        isShowSecond = conf.indexOf("second") >= 0,
        isShowBlinking = conf.indexOf("blinking") >= 0; (function(self, is12Hours, isShowSecond, isShowBlinking) {
            setInterval(function() {
                show(self, is12Hours, isShowSecond, isShowBlinking)
            },
            1000);
        })(self, is12Hours, isShowSecond, isShowBlinking);

    })
}