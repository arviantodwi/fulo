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

namespace Fulo.Enums {

    public enum Format {
        RGB,
        RGBA,
        HSV;

        public string to_nick () {
            GLib.EnumClass enumc = (GLib.EnumClass) typeof (Format).class_ref ();
            unowned GLib.EnumValue? eval = enumc.get_value (this);
            return_val_if_fail (eval != null, null);
            
            return eval.value_nick;
        }

        public static string get_real_format_name (string name) {
            switch (name) {
                case "FULO_ENUMS_FORMAT_RGB":
                case "FULO_ENUMS_FORMAT_RGBA":
                case "FULO_ENUMS_FORMAT_HSV":
                    string[] name_segments = name.split ("_");
                    return name_segments[name_segments.length - 1];
                default:
                    return "";
            }
        }

        public static Format[] all () {
            return {
                RGB,
                RGBA,
                HSV
            };
        }
    }

}
