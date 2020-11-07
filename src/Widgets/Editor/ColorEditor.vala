/**
 * Copyright (c) 2020 Arvianto Dwi Wicaksono (https://github.com/arviantodwi)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this program; if not, write to the
 * Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA
 *
 * Authored by: Arvianto Dwi Wicaksono <arvianto.dwi@gmail.com>
 */

namespace Fulo.Widgets.Editor {

    class ColorEditor : Gtk.Grid {

        //  Properties

        //  Instance
        private Chooser chooser;
        private HueSlider hue_slider;
        private AlphaSlider alpha_slider;
        private Contrast contrast;

        construct {
            this.margin_start = 20;
            this.margin_end = 20;
            this.column_spacing = 10;
            this.row_spacing = 7;

            chooser = new Chooser ();
            hue_slider = new HueSlider ();
            alpha_slider = new AlphaSlider ();
            contrast = new Contrast ();

            this.attach (chooser, 0, 0, 2, 1);
            this.attach_next_to (hue_slider, chooser, Gtk.PositionType.BOTTOM, 1, 1);
            this.attach_next_to (alpha_slider, hue_slider, Gtk.PositionType.BOTTOM, 1, 1);
            this.attach_next_to (contrast, hue_slider, Gtk.PositionType.RIGHT, 1, 2);
        }

        public ColorEditor () {}

    }

}
