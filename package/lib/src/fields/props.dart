/// A simple class to extract Flutter's input widgets
/// properties by renaming them; instead of copying the whole
/// widget and modifying to create a pre-built [LoField] wrapper to it.
///
/// Example:
/// ```
/// class TextFieldProps = TextField with Props;
/// ```
mixin Props {}
