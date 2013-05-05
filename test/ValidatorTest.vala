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

using Daf.Validation;
using Daf.UnitTest;
using Daf.Validation.Test.Model;

namespace Daf.Validation.Test {

    public class ValidatorTest : AbstractTestCase {

        Person person;
        MockPersonValidator validator;

        ValidationResult result;

        public ValidatorTest () {
            base ("ValidatorTest");
            add_test ("test_person_name", test_person_name);
            add_test ("test_person_email", test_person_email);
            add_test ("test_person_email_by_age", test_person_email_by_age);
        }

        public override void set_up () {
            person = new Person ();
            person.first_name = "Felix";
            person.last_name = "Van der Gullen";
            person.age = 42;
            person.sex = Gender.MALE;
            person.email = "felix.van.der.gullen@gmail.com";

            validator = new MockPersonValidator ();
            result = validator.validate (person);
        }

        public override void tear_down () {
            person = null;
            validator = null;
        }

        public void test_person_name () {

            var severity = result.is_valid ("first_name");
            severity |= result.is_valid ("last_name");
            assert (severity == Severity.OK);
        }

        public void test_person_email () {
            var severity = result.is_valid ("email");
            assert (severity == Severity.OK);
        }

        public void test_person_email_by_age () {

            person.age = 15;
            result = validator.validate (person);
            var severity = result.is_valid ("email");
            assert (severity == Severity.ERROR);
        }
    }


    /*
     *
     */
    public class MockPersonValidator : AbstractValidator<Person> {

        public MockPersonValidator () {

            add_rule ("first_name", (o) => { return ((Person) o).first_name != null; }, "Cannot Be null", Severity.WARNING);
            add_rule ("first_name", (o) => { return ((Person) o).first_name !=""; }, "Cannot Be empty", Severity.WARNING);
            add_rule ("last_name" , (o) => { return ((Person) o).last_name  != null;}, "Cannot Be null", Severity.WARNING);
            add_rule ("age", (o) => { return (18 <= ((Person) o).age <= 99);}, "Age should be between 18-99", Severity.HINT);
            //add_rule ("email", (o) => {return (((Person) o).age < 16);}, "Under age 16 you cannot have email", Severity.INFO);
            //add_rule ("email", (o) => {return EmailIsValid (((Person) o).email);}, "The emails is not Valid", Severity.INFO);
          //
            add_rule ("email",  if_older_than);
           // //(o) => {
            //    var result =  ((Person) o).last_name != null;
            //    debug ("Person's last name (%s): %s", result.to_string (), ((Person) o).last_name);
            //   return result;
            //}, "Cannot Be null", Severity.WARNING);
        }

        private bool if_older_than (Object object, ValidationRule rule) {

            var person = (Person) object;

            bool result = true;
            if (person.age < 16) {
                rule.message = "Under age 16 you cannot have email.";
                rule.severity = Severity.ERROR;
                result = false;
            } else {
                rule.message = "Email is not valid";
                rule.severity = Severity.ERROR;
                result = is_email_valid (person.email);
            }
            return result;
        }
    }
}