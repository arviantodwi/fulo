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

# Use math library
cc = meson.get_compiler('c')
math_dep = cc.find_library('m', required: false)

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
    'src/Helpers.vala',
    # 'src/Enums/PresetColor.vala',
    'src/Views/ColorPickerView.vala',
    'src/Widgets/HexEntry.vala',
    'src/Widgets/HueRange.vala',
    'src/Widgets/ColorName.vala',
    'src/Widgets/ColorRegion.vala',
    'src/Widgets/ColorSwatch.vala',
    'src/Widgets/PickerButton.vala',
    'src/Widgets/PresetSwatches.vala',
    'src/Widgets/CustomSwatches.vala',
    asresources,
    dependencies: [
        dependency('cairo'),
        dependency('gtk+-3.0'),
        dependency('glib-2.0'),
        dependency('granite', version: '>=5.5'),
        math_dep
    ],
    install: true
)

subdir('po')
subdir('data')
