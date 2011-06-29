Ext.setup({
  // start of onReady --------------------------------------------------------
  onReady: function() {
    //////////////////////////////////////////////////////////////////////////
    // Data Store
    var infos = [
      { date: '2011-06-24', contents: 'えりとれ！ v1.0.0 Released.' },
    ];

    var milestones = [
      { tag: 'v1.0.0', status: '2011-06-27', contents: '- 公式取引掲示板ブラウジング機能 実装' },
    ];

    var apps = [
      { url: 'http://itunes.apple.com/jp/app/mabinogitoolkit/id438883602?mt=8', title: 'MabinogiToolKit', 
        icon: '/ErinnTrader/images/apps/mabinogi_tool_kit.png', description: 'マビノギライフをより便利にするためのユーティリティ集！' }
    ];
  
    //////////////////////////////////////////////////////////////////////////
    // Overview
    var tab_info = new Ext.Component({
      title: 'Overview',
      cls: 'overview',
      scroll: 'vertical',
      tpl: [
        '<ul class="events">',
          '<tpl for=".">',
            '<li class="event">',
              '<span class="contents">{contents}</span>',
              '<span class="date">{date}</span>',
            '</li>',
          '</tpl>',
        '</ul>'
      ]
    });

    //////////////////////////////////////////////////////////////////////////
    // Milestone
    var tab_milestone = new Ext.Component({
      title: 'Milestones',
      cls: 'milestones',
      scroll: 'vertical',
      tpl: [
        '<ul class="events">',
          '<tpl for=".">',
            '<li class="tag-break">',
              '<span class="tag">{tag}</span> <span class="status">({status})</span>',
            '</li>',
            '<li class="event">',
              '<span class="contents">{contents}</span>',
            '</li>',
          '</tpl>',
        '</ul>'
      ]
    });

    //////////////////////////////////////////////////////////////////////////
    // More Apps
    var tab_apps = new Ext.Component({
      title: 'Apps',
      cls: 'apps',
      scroll: 'vertical',
      tpl: [
        '<ul class="events">',
          '<tpl for=".">',
            '<li class="event">',
              '<img class="icon" alt="icon" src="{icon}">',
              '<a href="{url}"><span class="name">{title}</span></a>',
              '<span class="description">{description}</span>',
            '</li>',
          '</tpl>',
        '</ul>'
      ]
    });
    
    //////////////////////////////////////////////////////////////////////////
    // TabBar
    new Ext.TabPanel({
      fullscreen: true,
      tabBar: {
        dock: 'top',
        ui: 'metal',
        layout: {
          pack: 'center'
        }
      },
      animation: 'fade',
      defaults: {
        scroll: 'vertical'
      },
      items: [tab_info, tab_milestone, tab_apps]
    });
    
    tab_info.update(infos);
    tab_milestone.update(milestones);
    tab_apps.update(apps);
  }
  // end of onReady ----------------------------------------------------------
});