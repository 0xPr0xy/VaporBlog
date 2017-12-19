var disqus_config = function () {
this.page.identifier = $("#article-data").data("articleIdentifier");
};

(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
var disqusName = $("#article-data").data("disqusName");
s.src = 'https://' + disqusName + '.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
