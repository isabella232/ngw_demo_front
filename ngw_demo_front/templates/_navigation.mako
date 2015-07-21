## -*- coding: utf-8 -*-

<%
    from rosavto.navigation import pages_config
%>

<header>
    <div class="container">
        <a href="#" data-activates="nav-mobile" class="button-collapse top-nav waves-effect waves-light circle">
            <i class="mdi-navigation-menu"></i>
        </a>
    </div>
    <ul id="nav-mobile" class="side-nav fixed">
        <li class="logo">
            <a id="logo-container" href="/" class="brand-logo" title="На главную">
                <img height="100%" src="${request.static_url('rosavto:static/images/250x250_icon_x_clr_white.png')}"/>
            </a>
        </li>
        % for nav in pages_config:
            % if len(nav) == 5:
            <%
                is_parent_active = False
                current_route_name = request.matched_route.name
                for child in nav[4]:
                    if child[0] == current_route_name:
                        is_parent_active = True
                        break
            %>
                <li class="no-padding">
                    <ul class="collapsible collapsible-accordion">
                        <li class="bold">
                            <a title="${nav[2]}" class="collapsible-header ${'active' if is_parent_active else ''} waves-effect waves-teal">
                                ${nav[1]}
                            </a>
                            <div class="collapsible-body">
                                <ul>
                                    % for child_nav in nav[4]:
                                        <li class="bold ${'active' if request.matched_route.name == child_nav[0] else ''}">
                                            <a href="${request.route_url(child_nav[0])}"
                                               title="${nav[2]}"
                                               class="waves-effect waves-teal">${child_nav[1]}</a>
                                        </li>
                                    % endfor
                                </ul>
                            </div>
                        </li>
                    </ul>
                </li>
            %else:
                <li class="bold ${'active' if request.matched_route.name == nav[0] else ''}">
                    <a href="${request.route_url(nav[0])}" title="${nav[2]}" class="waves-effect waves-teal">${nav[1]}</a>
                </li>
            % endif
        % endfor
    </ul>
</header>