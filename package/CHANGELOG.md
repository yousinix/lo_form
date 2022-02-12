## 0.4.0

- Add `all` (like AND operator) and `any` (like OR operator) named constructors to validators.
- **BREAKING:** Replace `name` with a **generic** `loKey`.

## 0.3.0

- **BREAKING:** Change **form** validation API from a single function called `validate` to a `validators` list of type `LoFormBaseValidator`.
- **BREAKING:** Rename `LoValidator` to `LoFieldBaseValidator`.
- **BREAKING:** Rename `LoCustomValidator` to `LoFieldValidator`.

## 0.2.0

- Add `debounceTime` property for debouncing field's changes.
- Add `LoConfig` to configure the package defaults.
- **BREAKING:** Change **field** validation API from a single function called `validate` to a `validators` list of type `LoValidator`.

## 0.1.2

- Change `onSubmit` return type to `FutureOr<bool>`; to eliminate the need for writing `async` in synchronous functions.
- Add `initialValue` to all pre-built fields.

## 0.1.1

- Update dependencies.
- Fix email regex.

## 0.1.0

Initial release.

## 0.0.1-dev.2

- Add some unit tests.
- Add some API reference.
- Change directory structure.
- Fix README.

## 0.0.1-dev.1

- Add `LoCheckBox` field.
- Add `props` field to pre-built fields, to allow styling and modifying them as regular Flutter fields.
- Add `submittableWhen` to choose when to make the submit button enabled.
- Add `email` & `regExp` validators.
- Cleanup code.

## 0.0.1-dev.0

- Add `LoFrom` widget to manage the form callbacks and state.
- Add a simple `LoTextField` as a pre-built `LoField`.
- Add `LoValidation` to facilitate building validation functions and reuse them.
- Add errors, touches, statuses, values maps, to track fields' state.
- Add form-level and field-level validation.
