<!DOCTYPE html>

{% set html_class = 'theme-next ' + theme.scheme %}
{% if theme.motion.enable %}
  {% set html_class = html_class + ' use-motion' %}
{% endif %}

<html class="{{ html_class | lower }}" lang="{{ config.language }}">
<head>
  <style>
  /*.tags0{font-size: 12px !important;color: #ccc !important;}灰*/

  .tags00{font-size: 12px !important;color: #666 !important;}/*黑*/
  /*.tags01{font-size: 12px !important;color: rgb(255,128,128) !important;}红
  .tags02{font-size: 12px !important;color: rgb(128,255,128) !important;}绿
  .tags03{font-size: 12px !important;color: rgb(128,128,255) !important;}蓝
  .tags04{font-size: 12px !important;color: rgb(255,216,128) !important;}黄*/

  /*.tags10{font-size: 20px !important;color: #666 !important;}*/
  .tags11{font-size: 20px !important;color: rgb(255,128,128) !important;}
  .tags12{font-size: 20px !important;color: rgb(128,255,128) !important;}
  .tags13{font-size: 20px !important;color: rgb(128,128,255) !important;}
  .tags14{font-size: 20px !important;color: rgb(255,216,128) !important;}

  /*.tags20{font-size: 40px !important;color: #666 !important;}*/
  .tags21{font-size: 40px !important;color: rgb(255,128,128) !important;}
  .tags22{font-size: 40px !important;color: rgb(128,255,128) !important;}
  .tags23{font-size: 40px !important;color: rgb(128,128,255) !important;}
  .tags24{font-size: 40px !important;color: rgb(255,216,128) !important;}
  </style>
  {% include '_partials/head.swig' %}
  <title>{% block title %}{% endblock %}</title>
  {% include '_third-party/analytics/index.swig' %}
</head>

<body itemscope itemtype="http://schema.org/WebPage" lang="{{ page.lang || page.language || config.language }}">

  {% set container_class = "container " %}
  {% if theme.sidebar.position %}
    {% set container_class = container_class + 'sidebar-position-' + theme.sidebar.position %}
  {% endif %}
    
  <div class="{{ container_class }} {% block page_class %}{% endblock %}">
    <div class="headband"></div>

    <header id="header" class="header" itemscope itemtype="http://schema.org/WPHeader">
      <div class="header-inner"> {%- include '_partials/header.swig' %} </div>
    </header>

    <main id="main" class="main">
      <div class="main-inner">
        <div class="content-wrap">
          <div id="content" class="content">
            {% block content %}{% endblock %}
          </div>
          {% include '_third-party/duoshuo-hot-articles.swig' %}
          {% include '_partials/comments.swig' %}
        </div>
        {% if theme.sidebar.display !== 'remove' %}
          {% block sidebar %}{% endblock %}
        {% endif %}
      </div>     
    </main>
    
    <footer id="footer" class="footer">
      <div class="footer-inner">
        {% include '_partials/footer.swig' %}
        {% include '_third-party/analytics/analytics-with-widget.swig' %}
        {% block footer %}{% endblock %}
      </div>
    </footer>

    {% if not theme.sidebar.b2t %}
      <div class="back-to-top">
        <i class="fa fa-arrow-up"></i>
        {% if theme.sidebar.scrollpercent %}
          <span id="scrollpercent"><span>0</span>%</span>
        {% endif %}
      </div>
    {% endif %}

    {% if theme.needmoreshare2.enable and theme.needmoreshare2.float.enable %}
      <div id="needsharebutton-float">
        <span class="btn">
          <i class="fa fa-share-alt" aria-hidden="true"></i>
        </span>
      </div>
    {% endif %}

  </div>

  {% include '_scripts/vendors.swig' %}
  {% include '_scripts/commons.swig' %}

  {% set scheme_script = '_scripts/schemes/' + theme.scheme | lower + '.swig' %}
  {% include scheme_script %}

  {% block script_extra %}{% endblock %}

  {% include '_scripts/boostrap.swig' %}

  {% include '_third-party/comments/index.swig' %}
  {% include '_third-party/search/index.swig' %}
  {% include '_third-party/analytics/lean-analytics.swig' %}
  {% include '_third-party/analytics/firestore.swig' %}
  {% include '_third-party/seo/baidu-push.swig' %}
  {% include '_third-party/needsharebutton.swig' %}
  {% include '_third-party/rating.swig' %}
  {% include '_third-party/mathjax.swig' %}
  {% include '_third-party/scroll-cookie.swig' %}
  {% include '_third-party/exturl.swig' %}
</body>
</html>

<script type="text/javascript">
var languages = new Array("C","C++","Java","C#","Python","HTML","CSS","JavaScript","SQL");
var randoms = new Array(4,3,2,1,3,2,1,4,2,1,3,4,1,2,3,4);
$(document).ready(function(){
var tags_all = $(".tag-cloud-tags a");
tags_all.each(function(){
  var x = parseInt(Math.random()*3);
  if(x > 0){
    x = 1;
  }
  for(var i = 0;i<languages.length;i++){
    if($(this).text() == languages[i]){
        x = 2;
      break;
    }
  }
  var y =0;
  if(x != 0){
    y = parseInt(Math.random()*16);
    y = randoms[y];
  }
  $(this).addClass("tags"+x+y);
});
});
</script>