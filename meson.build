# Project name and programming language
project('com.github.arviantodwi.fulo', 'vala', 'c')

# Import required modules
i18n = import('i18n')   # Translations
gnome = import('gnome') # UI library

# Get our additional resources
asresources = gnome.compile_resources (
    'as-resources', join_paths ('data', 'fulo.gresource.xml'),
    source_dir: 'data',
    c_name: 'as'
)

# Set our translation domain
add_global_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language:'c'
)

# Create a new executable, list the files we want to compile,
# list the dependencies we need, and install
executable(
    meson.project_name(),
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/Enums/PresetColor.vala',
    'src/Views/SwatchesBox.vala',
    'src/Widgets/ColorSwatch.vala',
    asresources,
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('glib-2.0'),
        dependency('granite', version: '>=5.5')
    ],
    install: true
)

subdir('po')
subdir('data')
