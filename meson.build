project('helloworld',
        ['vala', 'c'],
        version: '0.1.0',
        meson_version: '>=0.40.0',
        license: 'GPL3')

raven_plugin_helloworld_sources = ['helloworld.vala']

AppletNameSources = [
    'helloworld.vala',
]


AppletNameDependencies = [
dependency('gtk+-3.0', version: '>=3.18'), 
dependency('budgie-1.0', version: '>=2'),
dependency('gdk-3.0'),
dependency('libpeas-gtk-1.0'),
dependency('budgie-raven-plugin-1.0'),
meson.get_compiler('c').find_library('m', required: false)
]

shared_library('com.github.samlane-ma.raven.widget.helloworld', AppletNameSources, dependencies: AppletNameDependencies)

