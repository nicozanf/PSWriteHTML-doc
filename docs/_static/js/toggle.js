document.addEventListener('DOMContentLoaded', function() {

    function findStylesheet(fileName) {
        return Array.from(document.querySelectorAll('link[rel="stylesheet"]'))
            .find(function(link) {
                return new URL(link.href, document.baseURI).pathname.endsWith("/" + fileName);
            });
    }

    function toggleCssMode(isDay) {
        var mode = (isDay ? "Day" : "Night");
        localStorage.setItem("css-mode", mode);

        var daysheet = findStylesheet("pygments.css");
        if (daysheet) {
            daysheet.disabled = !isDay;
        }

        var nightsheet = findStylesheet("dark.css");
        if (!isDay && !nightsheet) {
            var element = document.createElement("link");
            element.setAttribute("rel", "stylesheet");
            element.setAttribute("type", "text/css");
            element.setAttribute("href", "_static/css/dark.css");
            document.getElementsByTagName("head")[0].appendChild(element);
            return;
        }
        if (nightsheet) {
            nightsheet.sheet.disabled = isDay;
        }
    }

    var initial = localStorage.getItem("css-mode") != "Night";
    var checkbox = document.querySelector('input[name=mode]');

    if (!checkbox) {
        return;
    }

    toggleCssMode(initial);
    checkbox.checked = initial;

    checkbox.addEventListener('change', function() {
        document.documentElement.classList.add('transition');
        window.setTimeout(() => {
            document.documentElement.classList.remove('transition');
        }, 1000)
        toggleCssMode(this.checked);
    })

}); 
