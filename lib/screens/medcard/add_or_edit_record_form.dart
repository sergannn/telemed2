import 'package:doctorq/screens/medcard/create_record_page_lib.dart';
import 'package:flutter/material.dart';

class AddOrEditRecordForm extends StatefulWidget {
  final void Function(CalendarRecordData)? onRecordAdd;
  final CalendarRecordData? event;

  const AddOrEditRecordForm({
    super.key,
    this.onRecordAdd,
    this.event,
  });

  @override
  _AddOrEditRecordFormState createState() => _AddOrEditRecordFormState();
}

class _AddOrEditRecordFormState extends State<AddOrEditRecordForm> {
  late DateTime _startDate = DateTime.now().withoutTime;
  late DateTime _endDate = DateTime.now().withoutTime;
  late TimeOfDay _selectedTime = TimeOfDay.now();
  String? _selectedCategory = 'Cat1';
  final _form = GlobalKey<FormState>();
  late final _descriptionController = TextEditingController();
  late final _titleController = TextEditingController();
  late final _titleNode = FocusNode();
  late final _descriptionNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _setDefaults();
  }

  @override
  void dispose() {
    _titleNode.dispose();
    _descriptionNode.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15),
          TextFormField(
            controller: _titleController,
            decoration: AppConstants.inputDecoration.copyWith(
              labelText: "Заголовок записи",
            ),
            style: TextStyle(
              color: AppColors.black,
              fontSize: 17.0, 
            ),
            validator: (value) {
              final title = value?.trim();
              if (title == null || title == "") {
                return "Пожалуйста, введите заголовок записи.";
              }
              return null;
            },
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: DateTimeSelectorFormField(
                  decoration: AppConstants.inputDecoration.copyWith(
                    labelText: "Дата записи",
                  ),
                  initialDateTime: _startDate,
                  onSelect: (date) {
                    if (date.withoutTime.withoutTime
                        .isAfter(_endDate.withoutTime)) {
                      _endDate = date.withoutTime;
                    }
                    _startDate = date.withoutTime;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Пожалуйста, выберите дату записи.";
                    }
                    return null;
                  },
                  textStyle: TextStyle(
                    color: AppColors.black,
                    fontSize: 17.0,
                  ),
                  onSave: (date) => _startDate = date ?? _startDate,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: _selectedTime,
                    );
                    if (time != null && mounted) {
                      setState(() => _selectedTime = time);
                    }
                  },
                  child: InputDecorator(
                    decoration: AppConstants.inputDecoration.copyWith(
                      labelText: "Время записи",
                    ),
                    child: Text(
                      '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          TextFormField(
            controller: _descriptionController,
            focusNode: _descriptionNode,
            style: TextStyle(
              color: AppColors.black,
              fontSize: 17.0,
            ),
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            selectionControls: MaterialTextSelectionControls(),
            minLines: 1,
            maxLines: 10,
            maxLength: 1000,
            validator: (value) {
              if (value == null || value.trim() == "") {
                return "Пожалуйста, введите текст записи.";
              }
              return null;
            },
            decoration: AppConstants.inputDecoration.copyWith(
              hintText: "Текст записи",
            ),
          ),
          SizedBox(height: 15),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Категория записи',
              style: TextStyle(
                color: const Color.fromARGB(255, 0, 0, 0),
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
          ),
          Row(
            children: [
              Radio(
                value: 'Cat1',
                groupValue: _selectedCategory,
                onChanged: (value) {
                  setState(() => _selectedCategory = value);
                },
              ),
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: getCategoryColorLib('Cat1'),
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                getCategoryName('Cat1'),
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 'Cat2',
                groupValue: _selectedCategory,
                onChanged: (value) {
                  setState(() => _selectedCategory = value);
                },
              ),
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: getCategoryColorLib('Cat2'),
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                getCategoryName('Cat2'),
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                ),
              )
            ],
          ),
          Row(
            children: [
              Radio(
                value: 'Cat3',
                groupValue: _selectedCategory,
                onChanged: (value) {
                  setState(() => _selectedCategory = value);
                },
              ),
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: getCategoryColorLib('Cat3'),
                  shape: BoxShape.circle,
                ),
              ),
              Text(
                getCategoryName('Cat3'),
                style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          ElevatedButton(
  onPressed: widget.event == null ? _createEvent : _updateEvent,
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 96, 159, 222),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
    minimumSize: const Size(260, 56),
  ),
  child: Text(
    widget.event == null ? "Добавить запись" : "Обновить запись",
    style: const TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
  ),
)
        ],
      ),
    );
  }

  void _createEvent() {
    if (!(_form.currentState?.validate() ?? true)) return;
    _form.currentState?.save();

    final dateWithTime = DateTime(
      _startDate.year,
      _startDate.month,
      _startDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    final event = CalendarRecordData(
      date: dateWithTime,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
    );
    widget.onRecordAdd?.call(event);
    _resetForm();
  }

  void _updateEvent() {
    if (widget.event == null) return;
    if (!(_form.currentState?.validate() ?? true)) return;
    _form.currentState?.save();

    final dateWithTime = DateTime(
      _startDate.year,
      _startDate.month,
      _startDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    final event = widget.event!.copyWith(
      date: dateWithTime,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _selectedCategory,
    );
    widget.onRecordAdd?.call(event);
  }

  void _setDefaults() {
    if (widget.event == null) {
      return;
    }
    final event = widget.event!;
    _startDate = event.date.withoutTime;
    _selectedTime = TimeOfDay(hour: event.date.hour, minute: event.date.minute);
    _titleController.text = event.title;
    _selectedCategory = event.category ?? 'Cat1';
    _descriptionController.text = event.description ?? '';
  }

  void _resetForm() {
    _form.currentState?.reset();
    _startDate = DateTime.now().withoutTime;
    _endDate = DateTime.now().withoutTime;
    _selectedTime = TimeOfDay.now();
    _selectedCategory = 'Cat1';
    if (mounted) {
      setState(() {});
    }
  }
}

typedef Validator = String? Function(String? value);

class DateTimeSelectorFormField extends StatefulWidget {
  final Function(DateTime)? onSelect;
  final FocusNode? focusNode;
  final DateTime? minimumDateTime;
  final Validator? validator;

  final TextStyle? textStyle;
  final void Function(DateTime? date)? onSave;
  final InputDecoration? decoration;
  final TextEditingController? controller;
  final DateTime? initialDateTime;

  const DateTimeSelectorFormField({
    this.onSelect,
    this.onSave,
    this.decoration,
    this.focusNode,
    this.minimumDateTime,
    this.validator,
    this.textStyle,
    this.controller,
    this.initialDateTime,
  });

  @override
  _DateTimeSelectorFormFieldState createState() =>
      _DateTimeSelectorFormFieldState();
}

class _DateTimeSelectorFormFieldState extends State<DateTimeSelectorFormField> {
  late var _minimumDate = CalendarConstants.minDate.withoutTime;

  late var _textEditingController =
      widget.controller ?? TextEditingController();
  late var _focusNode = _getFocusNode();

  late DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _setDates();
  }

  @override
  void didUpdateWidget(covariant DateTimeSelectorFormField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.dispose();
      _focusNode = _getFocusNode();
    }

    if (widget.controller != oldWidget.controller) {
      _textEditingController.dispose();
      _textEditingController = widget.controller ?? TextEditingController();
    }

    if (_selectedDate != oldWidget.initialDateTime ||
        widget.minimumDateTime != oldWidget.minimumDateTime) {
      _setDates();
    }
  }

  FocusNode _getFocusNode() {
    final node = widget.focusNode ?? FocusNode();
    return node;
  }

  @override
  void dispose() {
    if (widget.controller == null) _textEditingController.dispose();
    if (widget.focusNode == null) _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showSelector,
      child: TextFormField(
        focusNode: _focusNode,
        style: widget.textStyle,
        controller: _textEditingController,
        validator: widget.validator,
        minLines: 1,
        onSaved: (value) => widget.onSave?.call(_selectedDate),
        enabled: false,
        decoration: widget.decoration,
      ),
    );
  }

  Future<void> _showSelector() async {
    DateTime? date;

    date = await _showDateSelector();

    _textEditingController.text =
        (date ?? _selectedDate)?.dateToStringWithFormat(format: "dd/MM/yyyy") ??
            '';

    _selectedDate = date ?? _selectedDate;

    if (mounted) {
      setState(() {});
    }

    if (date != null) {
      widget.onSelect?.call(date);
    }
  }

  Future<DateTime?> _showDateSelector() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: widget.minimumDateTime ?? CalendarConstants.minDate,
      lastDate: CalendarConstants.maxDate,
    );

    return date;
  }

  void _setDates() {
    _minimumDate = widget.minimumDateTime ?? CalendarConstants.minDate;
    _selectedDate = widget.initialDateTime;

    if (_selectedDate?.withoutTime.isBefore(_minimumDate.withoutTime) ??
        false) {
      throw 'InitialDate is smaller than Minimum date';
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _textEditingController.text =
          _selectedDate?.dateToStringWithFormat(format: "dd/MM/yyyy") ?? '';
    });
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CustomButton({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 40,
        ),
        decoration: BoxDecoration(
          color: AppColors.navyBlue,
          borderRadius: BorderRadius.circular(7.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.black,
              offset: Offset(0, 4),
              blurRadius: 10,
              spreadRadius: -3,
            )
          ],
        ),
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

String getCategoryName(String category) {
  switch (category) {
    case 'Cat1':
      return 'Приемы';
    case 'Cat2':
      return 'Лекарства';
    case 'Cat3':
      return 'Упражнения';
    default:
      return 'Попробуйте воспользоваться дневником';
  }
}
