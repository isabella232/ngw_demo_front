<%inherit file="_master.mako"/>

<!--  Outer row  -->
<div class="row">
    <div class="section col s12 m9 l10">
        <div id="nav_description" class="row scrollspy">
            <div class="row">
                <p class="caption col s12">Демо-стенд создан для демонстрации возможностей интеграции клиентских
                    компонентов к серверной системе управления пространственными данными <a
                            href="http://nextgis.ru/nextgis-web/">NextGIS Web</a>.</p>
            </div>
            <div class="row">
                <a id="download-source" class="btn waves-effect red"
                   href="https://github.com/nextgis/rosavto">Все примеры одним списком<i
                        class="mdi-action-view-module left"></i></a>
            </div>

            <div class="row">
                <div class="col s12 m6">
                    <p class="promo-caption">GitHub</p>

                    <p>Исходный код стенда доступен на GitHub.</p>
                    <a id="download-source" class="btn waves-effect waves-light"
                       href="https://github.com/nextgis/rosavto" target="_blank">Source<i
                            class="mdi-action-settings-ethernet right"></i></a>

                    <p>
                        <iframe src="https://ghbtns.com/github-btn.html?user=nextgis&repo=rosavto&type=star&count=true&size=large"
                                frameborder="0" scrolling="0" width="160px" height="30px"></iframe>
                    </p>
                    <p>
                        <iframe src="https://ghbtns.com/github-btn.html?user=nextgis&repo=rosavto&type=watch&count=true&size=large&v=2"
                                frameborder="0" scrolling="0" width="160px" height="30px"></iframe>
                    </p>
                </div>
                <div class="col s12 m6">
                    <p class="promo-caption">NextGIS Web</p>

                    <p>Стенд связан с экземпляром NextGIS Web.</p>

                    <a id="download-source" class="btn waves-effect waves-light"
                       href="http://demo.nextgis.ru/ngw_rosavto/resource/0" target="_blank">Открыть NextGIS Web<i
                            class="mdi-action-launch right"></i></a>

                    <p>Также доступна документация к системе</p>

                    <a id="download-source" class="btn waves-effect waves-light"
                       href="https://github.com/nextgis/docs_ngweb" target="_blank">NextGIS Web документация<i
                            class="mdi-action-launch right"></i></a>

                </div>
            </div>
        </div>
        <div id="nav_about" class="row scrollspy">
            <div class="col s12">
                <h3 class="header">О нас</h3>

                <p>ООО «NextGIS» — коммерческая компания, которая строит свой бизнес вокруг
                    открытого программного обеспечения, данных и методологий в области геоинформатики.</p>

                <p>Связать с нами можно любым удобным для вас способом, контакты доступны <a
                        href="http://nextgis.ru/contact/">здесь</a>.</p>
            </div>
        </div>

    </div>

    <!-- Sub-navigation table of contents -->
    <%
        sub_navs = [
            ('nav_description', u'Описание'),
            ('nav_about', u'О нас')
        ]
    %>
    <%include file='_sub_navigation.mako' args='sub_navs=sub_navs'/>
</div>


