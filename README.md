<h1>Vapor Blog Framework written in Swift</h1>

<h2>Features</h2>
<ul>
    <li> Authentication </li>
    <li> Search </li>
    <li> Pagination </li>
    <li> Page and Article creation </li>
    <li> Uploads </li>
    <li> Markdown support and editor </li>
    <li> Syntax Highlighting </li>
    <li> Google Analytics tracking and Admin dashboard</li>
    <li> Disqus </li>
</ul>

<h2>Setup</h2>
<h3>1. Fixture User</h3>
<p>First create the following folder and file:<pre><code>Config/secrets/fixture_user.json</code></pre> Then, put the following json inside:</p>
<pre><code>
{
	"name": "Admin",
	"email": "name@email.com",
	"password": "password"
}
</code></pre>
<h3>2. Analytics and Disqus (optional)</h3>
<p>Create the following folder and file:<pre><code>Config/secrets/third_party.json</code></pre> And put the following json inside:</p>
<pre><code>
{
	"ga_api_client_id": "$GA_EMBED_API_CLIENT_ID",
	"ga_identifier": "$GA_IDENTIFIER",
	"disqus_name": "$DISQUS_NAME"
}
</code></pre>
<h3>3. Install Dependencies</h3>
<pre><code>vapor fetch</code></pre>
<h3>4. Build</h3>
<pre><code>vapor build</code></pre>
<h3>5. Run</h3>
<pre><code>vapor run</code></pre>

<p align="center">
    <img src="https://cloud.githubusercontent.com/assets/1977704/25426816/a9d40530-2a70-11e7-9758-8a0da6341035.png" width="320" alt="Web Template">
    <br>
    <br>
    <img src="/Screenshots/login.png?raw=true">
    <br>
    <img src="/Screenshots/admin.png?raw=true">
    <br>
    <img src="/Screenshots/admin_pages.png?raw=true">
    <br>
    <img src="/Screenshots/admin_articles.png?raw=true">
    <br>
    <img src="/Screenshots/uploads.png?raw=true">
    <br>
    <img src="/Screenshots/admin_articles_new.png?raw=true">
    <br>
    <img src="/Screenshots/syntax.png?raw=true">
    <br>
    <img src="/Screenshots/search.png?raw=true">
    <br>
    <br>
    <a href="https://docs.vapor.codes/2.0/getting-started/toolbox/#templates">
        <img src="http://img.shields.io/badge/read_the-docs-92A8D1.svg" alt="Documentation">
    </a>
    <a href="http://vapor.team">
        <img src="http://vapor.team/badge.svg" alt="Slack Team">
    </a>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://circleci.com/gh/vapor/web-template">
        <img src="https://circleci.com/gh/vapor/web-template.svg?style=shield" alt="Continuous Integration">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4-brightgreen.svg" alt="Swift 4">
    </a>
</p>
