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

using Gee;

namespace Daf.Validation {

    public abstract class AbstractValidator<T> : Object, IValidators {

        protected Gee.MultiMap<string, ValidationRule> rules = new Gee.HashMultiMap<string, ValidationRule> ();

          public void add_rule (string property_name,
                                  owned DelegateRule rule,
                                  string message = "",
                                  Severity severity = Severity.ERROR) {
            rules.set (property_name, new ValidationRule ((owned) rule,
            new ValidationFailure (property_name, message, severity)));
        }

        public ValidationResult validate (T instance) {

            var failures = new HashMap<string, IValidationFailure> ();
            var highest_severity = Severity.OK;

            foreach (var rule in rules.get_values ()) {
                  if (!rule.rule ((Object) instance, rule)) {

                    if (rule.severity > highest_severity) {
                        highest_severity = rule.severity;
                        failures[rule.property_name] = rule.failure;
                    }
                }
            }
            //.changed ("Failures size %d", failures.size);
            return new ValidationResult (highest_severity, failures.read_only_view);
        }

    }
}
