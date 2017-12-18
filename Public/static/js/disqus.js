var disqus_config = function () {
this.page.identifier = $("#blog-post-data").data("postIdentifier");
};

(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
var disqusName = $("#blog-post-data").data("disqusName");
s.src = 'https://' + disqusName + '.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
