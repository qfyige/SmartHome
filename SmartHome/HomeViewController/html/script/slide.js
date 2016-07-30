!(function() {
    var SupportsTouches = ("createTouch" in document),
    StartEvent = SupportsTouches ? "touchstart": "mousedown",
    //支持触摸式使用相应的事件替代
    MoveEvent = SupportsTouches ? "touchmove": "mousemove",
    EndEvent = SupportsTouches ? "touchend": "mouseup";
    var bw = document.body.offsetWidth;
    var preventDefault = function(ev) {
        if (ev) ev.preventDefault();
        else window.event.returnValue = false;
    }
    function _stopPropagation(e) {
        if (e && e.stopPropagation) e.stopPropagation();
        else window.event.cancelBubble = true;
        return false;
    }
    var curPage = 0;
    var buttons = {};
    $("button").each(function() {
        var num = this.id.substring(4);
        num = num && parseInt(num);
        var that = this;
        if (num >= 1800 && num < 1850) { (function(num) {

                if (pages[num]) {
                    //buttons[pages[num].split("?")[1]] = that;
                    $(that).bind(StartEvent,
                    function(e) {
                        var index = pages[num].split("?")[1];
                        index = parseInt(index);
                        $content.css("marginLeft", -index * bw);
                        curPage = index;
                        _stopPropagation(e);
                    });
                    $(that).bind(EndEvent,
                    function(e) {
                        _stopPropagation(e);
                    });
                }
            })(num);
        }
    });
    var content = document.getElementById('content'),
    $content = $('#content');

    content['on' + StartEvent] = function(e) {
        this.marginLeft = parseInt($content.css("marginLeft"));
        this.startX = e.pageX;
        this.pageX = e.pageX;
        this.dirs = 0;
        this['on' + MoveEvent] = function(e) {
            preventDefault(e);
            this.dirs = e.pageX - this.pageX;
            this.pageX = e.pageX;
            $content.css({
                '-moz-transition': 'none',
                '-webkit-transition': 'none',
                '-ms-transition': 'none',
                '-o-transition': 'none',
                'transition': 'none'
            });
            $content.css("marginLeft", this.marginLeft + e.pageX - this.startX);
            _stopPropagation(e);
        };
    };
    var pagesLength = $('#content > div').size() - 1;
    content['on' + EndEvent] = function(e) {
        content['on' + MoveEvent] = null;
        $content.css({
            '-moz-transition': ' all 0.4s ease-in-out',
            '-webkit-transition': ' all 0.4s ease-in-out',
            '-ms-transition': ' all 0.4s ease-in-out',
            '-o-transition': ' all 0.4s ease-in-out',
            'transition': 'all 0.4s ease-in-out'
        });
        if (Math.abs(this.dirs) < 5) {
            $content.css("marginLeft", -curPage * bw);
            return;
        }

        if (this.dirs < 0) {
            if (curPage != pagesLength) {
                $content.css("marginLeft", -(curPage + 1) * bw);
                curPage = curPage + 1;
            } else {
                $content.css("marginLeft", -curPage * bw);
            }
        } else {
            if (curPage != 0) {
                $content.css("marginLeft", -(curPage - 1) * bw);
                curPage = curPage - 1;
            } else {
                $content.css("marginLeft", -curPage * bw);
            }
        }
    };
    var query = location.search.substring(1);
    if (query) {
        $content.css("marginLeft", -parseInt(query) * bw);
        curPage = parseInt(query);
    }

})();