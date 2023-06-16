class Utils {
  static T convertDynamicToType<T>(dynamic value, {required T defaultValue}) {
    //try to convert dynamic to type T
    try {
      return value as T;
    } catch (e) {
      //if is null add a default value
      if (value == null) {
        return defaultValue;
      }
      //if is not null and can't convert to type T return null
      return defaultValue;
    }
  }
}

extension StringUtils on String? {
  //function to validate isNullOrEmpty
  bool isNullOrEmpty() {
    return this == null || this?.isEmpty == true;
  }

  //function to validate isNotNullOrEmpty
  bool isNotNullOrEmpty() {
    return this != null && this?.isNotEmpty == true;
  }

  bool equalsIgnoreCase(String? other) {
    if (this == null && other == null) return true;
    if (this == null || other == null) return false;
    return this?.toLowerCase() == other.toLowerCase();
  }

  //to int
  int toInt() {
    return int.parse(this!);
  }
}

extension objUtils on Object? {
  bool isNull() {
    return this == null;
  }

  bool isNotNull() {
    return this != null;
  }

  bool isNullOrEmpty() {
    return this == null || this.toString().isEmpty;
  }

  bool isNotNullOrEmpty() {
    return this != null && this.toString().isNotEmpty;
  }

  int toInt() {
    return int.parse(this.toString());
  }
}
