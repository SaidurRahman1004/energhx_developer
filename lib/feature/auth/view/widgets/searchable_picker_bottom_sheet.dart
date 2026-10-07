import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class PickerItem<T> {
  final T data;
  final String title;
  final String? subtitle;
  final Widget? leading;
  final bool isSelected;

  const PickerItem({
    required this.data,
    required this.title,
    this.subtitle,
    this.leading,
    this.isSelected = false,
  });
}

class SearchablePickerBottomSheet<T> extends StatefulWidget {
  final String title;
  final String searchHint;
  final List<PickerItem<T>> items;
  final ValueChanged<T> onSelected;
  final bool allowCustomEntry;
  final ValueChanged<String>? onCustomSelected;
  final String emptyMessage;

  const SearchablePickerBottomSheet({
    super.key,
    required this.title,
    required this.searchHint,
    required this.items,
    required this.onSelected,
    this.allowCustomEntry = false,
    this.onCustomSelected,
    this.emptyMessage = 'No results found',
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String searchHint,
    required List<PickerItem<T>> items,
    required ValueChanged<T> onSelected,
    bool allowCustomEntry = false,
    ValueChanged<String>? onCustomSelected,
    String emptyMessage = 'No results found',
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SearchablePickerBottomSheet<T>(
        title: title,
        searchHint: searchHint,
        items: items,
        onSelected: onSelected,
        allowCustomEntry: allowCustomEntry,
        onCustomSelected: onCustomSelected,
        emptyMessage: emptyMessage,
      ),
    );
  }

  @override
  State<SearchablePickerBottomSheet<T>> createState() =>
      _SearchablePickerBottomSheetState<T>();
}

class _SearchablePickerBottomSheetState<T>
    extends State<SearchablePickerBottomSheet<T>> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<PickerItem<T>> get _filteredItems {
    if (_searchQuery.trim().isEmpty) return widget.items;
    final query = _searchQuery.toLowerCase().trim();
    return widget.items.where((item) {
      final matchTitle = item.title.toLowerCase().contains(query);
      final matchSubtitle = item.subtitle?.toLowerCase().contains(query) ?? false;
      return matchTitle || matchSubtitle;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final filtered = _filteredItems;
    final trimmedQuery = _searchQuery.trim();

    return Container(
      height: MediaQuery.of(context).size.height * 0.78,
      margin: EdgeInsets.only(bottom: bottomInset),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          // Drag handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: AppColors.textSecondary,
                    size: 22.sp,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Close',
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),

          // Search Field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.sp,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: widget.searchHint,
                  hintStyle: GoogleFonts.plusJakartaSans(
                    fontSize: 14.sp,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: const Color(0xFF64748B),
                    size: 20.sp,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear_rounded,
                            size: 18.sp,
                            color: const Color(0xFF94A3B8),
                          ),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),

          // Custom entry quick action if allowed and query typed
          if (widget.allowCustomEntry && trimmedQuery.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                  widget.onCustomSelected?.call(trimmedQuery);
                },
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0FDF4),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add_location_alt_rounded,
                          color: Colors.white,
                          size: 16.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'Use "$trimmedQuery"',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14.sp,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Items List
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 48.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            widget.emptyMessage,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          if (widget.allowCustomEntry && trimmedQuery.isNotEmpty) ...[
                            SizedBox(height: 16.h),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).pop();
                                widget.onCustomSelected?.call(trimmedQuery);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                              icon: const Icon(Icons.check, color: Colors.white),
                              label: Text(
                                'Use "$trimmedQuery"',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filtered.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: Color(0xFFF8FAFC)),
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          widget.onSelected(item.data);
                        },
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: item.isSelected
                                ? const Color(0xFFF0FDF4)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              if (item.leading != null) ...[
                                item.leading!,
                                SizedBox(width: 12.w),
                              ],
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14.sp,
                                        fontWeight: item.isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: item.isSelected
                                            ? AppColors.primary
                                            : AppColors.textPrimary,
                                      ),
                                    ),
                                    if (item.subtitle != null &&
                                        item.subtitle!.isNotEmpty) ...[
                                      SizedBox(height: 2.h),
                                      Text(
                                        item.subtitle!,
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12.sp,
                                          color: const Color(0xFF94A3B8),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              if (item.isSelected)
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.primary,
                                  size: 20.sp,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
