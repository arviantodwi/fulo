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
    # Fulo
    'src/Helpers.vala',
    'src/MainWindow.vala',
    'src/Application.vala',
    # Fulo.Enums
    'src/Enums/Format.vala',
    # Fulo.Views
    'src/Views/ColorPickerView.vala',
    # Fulo.Widgets
    'src/Widgets/Format.vala',
    'src/Widgets/HexEntry.vala',
    'src/Widgets/ColorName.vala',
    'src/Widgets/PickerButton.vala',
    # Fulo.Widgets.Editor
    'src/Widgets/Editor/Chooser.vala',
    'src/Widgets/Editor/Contrast.vala',
    'src/Widgets/Editor/HueSlider.vala',
    'src/Widgets/Editor/AlphaSlider.vala',
    'src/Widgets/Editor/ColorEditor.vala',
    # Fulo.Widgets.Swatch
    'src/Widgets/Swatch/SwatchItem.vala',
    'src/Widgets/Swatch/SwatchGroup.vala',
    asresources,
    dependencies: [
        dependency('gee-0.8'),
        dependency('gtk+-3.0'),
        dependency('glib-2.0'),
        dependency('cairo', version: '>=1.15'),
        dependency('granite', version: '>=5.5'),
        math_dep
    ],
    install: true
)

subdir('po')
subdir('data')
