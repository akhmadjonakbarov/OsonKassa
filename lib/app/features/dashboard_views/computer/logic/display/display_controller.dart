import 'package:get/get.dart';
class DisplayController extends GetxController {
  var refreshRates = <int>[60, 90, 120, 144, 240].obs;
  var resolutions = <String>["1920x1080", "2560x1440", "3840x2160"].obs;
  var dSizes = <double>[13, 14, 15.6, 16, 17.2].obs;

  var selectedRefreshRate = <int>[].obs;
  var selectedResolution = <String>[].obs;
  var selectedDSize = <double>[].obs;

  // Function to handle selecting/unselecting a refresh rate
  void selectRefreshRate(int refreshRate) {
    if (selectedRefreshRate.contains(refreshRate)) {
      selectedRefreshRate.remove(refreshRate); // Unselect if already selected
    } else {
      selectedRefreshRate.add(refreshRate); // Add to selected list
    }
  }

  // Function to handle selecting/unselecting a resolution
  void selectResolution(String resolution) {
    if (selectedResolution.contains(resolution)) {
      selectedResolution.remove(resolution); // Unselect if already selected
    } else {
      selectedResolution.add(resolution); // Add to selected list
    }
  }

  // Function to handle selecting/unselecting a display size
  void selectDSize(double size) {
    if (selectedDSize.contains(size)) {
      selectedDSize.remove(size); // Unselect if already selected
    } else {
      selectedDSize.add(size); // Add to selected list
    }
  }

  // Function to clear all selected values
  void clearSelections() {
    selectedRefreshRate.clear();
    selectedResolution.clear();
    selectedDSize.clear();
  }

  // Function to check if a refresh rate is selected
  bool isRefreshRateSelected(int refreshRate) {
    return selectedRefreshRate.contains(refreshRate);
  }

  // Function to check if a resolution is selected
  bool isResolutionSelected(String resolution) {
    return selectedResolution.contains(resolution);
  }

  // Function to check if a display size is selected
  bool isDSizeSelected(double size) {
    return selectedDSize.contains(size);
  }

  // Function to add a new refresh rate (with validation)
  void addRefreshRate(int refreshRate) {
    if (!refreshRates.contains(refreshRate)) {
      refreshRates.add(refreshRate);
      refreshRates.sort(); // Keep list sorted
    }
    selectedRefreshRate.add(refreshRate); // Automatically select the new value
  }

  // Function to add a new resolution (with validation)
  void addResolution(String resolution) {
    if (!resolutions.contains(resolution)) {
      resolutions.add(resolution);
      resolutions.sort(); // Keep list sorted
    }
    selectedResolution.add(resolution); // Automatically select the new value
  }

  // Function to add a new display size (with validation)
  void addDSize(double dSize) {
    if (!dSizes.contains(dSize)) {
      dSizes.add(dSize);
      dSizes.sort(); // Keep list sorted
    }
    selectedDSize.add(dSize); // Automatically select the new value
  }
}
