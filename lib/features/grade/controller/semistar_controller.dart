import 'package:gau_app/core/service/datasource/remote/api_client.dart';
import 'package:gau_app/core/service/datasource/remote/api_urls/api_urls.dart';
import 'package:gau_app/features/home/models/dashboard_model.dart';
import 'package:get/get.dart';

class SemistarController extends GetxController {
  // ─── Loading States ──────────────────────────────────────────────────────────

  /// HomeScreen এর GPA widget এর জন্য
  final RxBool isDashboardLoading = false.obs;

  /// GradeScreen এ semester switch করার সময়
  final RxBool isSemesterLoading = false.obs;

  // ─── Data ────────────────────────────────────────────────────────────────────

  final Rxn<SemistarModel> semistarData = Rxn<SemistarModel>();
  final Rxn<Semesters> selectedSemesterData = Rxn<Semesters>();
  final RxnString selectedSemesterName = RxnString();

  // ─── Computed Getters ────────────────────────────────────────────────────────

  List<String> get semesterNames => semistarData.value?.semestersName ?? [];

  List<Courses> get selectedCourses =>
      selectedSemesterData.value?.courses ?? [];

  String get selectedSemesterGPA {
    final gpa = selectedSemesterData.value?.semesterGPA;
    return gpa != null ? gpa.toStringAsFixed(2) : '--';
  }

  String get currentGPA {
    final gpa = semistarData.value?.currentGPA;
    return gpa != null ? gpa.toStringAsFixed(2) : '--';
  }

  String get totalEarnedCredits {
    final credits = semistarData.value?.totalEarnedCredits;
    return credits?.toString() ?? '--';
  }

  // ─── API Calls ───────────────────────────────────────────────────────────────

  /// HomeScreen থেকে call হয়।
  Future<void> fetchDashboardData() async {
    isDashboardLoading.value = true;
    try {
      final response = await ApiClient.getData(ApiUrl.dashboard);
      if (response.statusCode == 200) {
        semistarData.value = SemistarModel.fromJson(response.body['data']);
      } else {
        _showError(response.statusText ?? 'Failed to load grade data');
      }
    } catch (_) {
      _showError('Failed to load grade data');
    } finally {
      isDashboardLoading.value = false;
    }
  }

  /// GradeScreen এ enter করলে call হয়।
  /// Dashboard data তে already semesters আছে — সেখান থেকেই প্রথম semester select করে।
  /// আলাদা API call করে না।
  Future<void> initGradeScreen() async {
    if (semistarData.value == null) {
      // HomeScreen bypass করে সরাসরি GradeScreen এ আসলে fetch করো
      await fetchDashboardData();
    }
    _selectSemesterFromLocalData(semesterNames.isNotEmpty ? semesterNames.first : null);
  }

  /// Dropdown থেকে semester বদলালে call হয়।
  /// Dashboard data তে এই semester এর courses already আছে কিনা check করে।
  /// থাকলে local থেকে নেয়, না থাকলে API call করে।
  Future<void> onSemesterSelected(String semesterName) async {
    if (selectedSemesterName.value == semesterName) return;

    selectedSemesterName.value = semesterName;

    // Dashboard data তে এই semester আছে কিনা দেখো
    final localSemester = semistarData.value?.semesters?.firstWhereOrNull(
          (s) => s.semesterName == semesterName,
    );

    if (localSemester != null) {
      // Local data থেকেই নাও — no API call
      selectedSemesterData.value = localSemester;
      return;
    }

    // Local এ নেই → API call করো
    isSemesterLoading.value = true;
    try {
      final response = await ApiClient.getData(
        ApiUrl.semester(semesterName: semesterName),
      );
      if (response.statusCode == 200) {
        // Response এর data তে full SemistarModel structure আসে,
        // semesters list এর প্রথম item নাও
        final model = SemistarModel.fromJson(response.body['data']);
        selectedSemesterData.value = model.semesters?.firstWhereOrNull(
              (s) => s.semesterName == semesterName,
        );
      } else {
        _showError(response.statusText ?? 'Failed to load semester data');
      }
    } catch (_) {
      _showError('Failed to load semester data');
    } finally {
      isSemesterLoading.value = false;
    }
  }

  // ─── Private Helpers ─────────────────────────────────────────────────────────

  /// Dashboard data তে থাকা semester locally select করে — কোনো API call নেই।
  void _selectSemesterFromLocalData(String? semesterName) {
    if (semesterName == null) return;
    final semester = semistarData.value?.semesters?.firstWhereOrNull(
          (s) => s.semesterName == semesterName,
    );
    if (semester != null) {
      selectedSemesterName.value = semesterName;
      selectedSemesterData.value = semester;
    }
  }

  void _showError(String message) {
    Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
  }
}