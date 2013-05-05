/**
 * Copyright (c) 2012 Pal Dorogi <pal.dorogi@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 **/

namespace Daf.Validation {
    public class ValidationFailure : Object, IValidationFailure {
        public string property_name { get; set; }
        public string message { get; set; }
        public Severity severity { get; set; }

        public ValidationFailure (string property_name,
                                    string message = "Validation failed.",
                                    Severity severity = Severity.ERROR) {
            this.property_name = property_name;
            this.message = message;
            this.severity = severity;
        }
    }
}
