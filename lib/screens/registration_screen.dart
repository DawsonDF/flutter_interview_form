import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onStepContinue() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  void _onStepTapped(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  Future<void> _submitForm() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Registration completed successfully!'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              setState(() {
                _currentStep = 0;
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Registration'),
        elevation: 2,
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: _onStepContinue,
          onStepCancel: _onStepCancel,
          onStepTapped: _onStepTapped,
          controlsBuilder: (context, details) {
            final isLastStep = _currentStep == 2;

            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  if (isLastStep)
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Submit'),
                    )
                  else
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      child: const Text('Continue'),
                    ),
                  const SizedBox(width: 8),
                  if (_currentStep > 0)
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Back'),
                    ),
                ],
              ),
            );
          },
          steps: [
            Step(
              title: const Text('Personal Information'),
              subtitle: const Text('Basic details'),
              content: _buildPersonalInfoStep(),
              isActive: _currentStep >= 0,
              state: _getStepState(0),
            ),
            Step(
              title: const Text('Address'),
              subtitle: const Text('Location details'),
              content: _buildAddressStep(),
              isActive: _currentStep >= 1,
              state: _getStepState(1),
            ),
            Step(
              title: const Text('Review'),
              subtitle: const Text('Confirm details'),
              content: _buildReviewStep(),
              isActive: _currentStep >= 2,
              state: _getStepState(2),
            ),
          ],
        ),
      ),
    );
  }

  StepState _getStepState(int step) {
    if (step < _currentStep) {
      return StepState.complete;
    }
    return StepState.indexed;
  }

  Widget _buildPersonalInfoStep() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Please provide your personal information',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildAddressStep() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Please provide your address',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildReviewStep() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Please review your information',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildReviewSection(
            title: 'Personal Information',
            items: [
              {'label': 'Full Name', 'value': '[Your Name]'},
              {'label': 'Email', 'value': '[Your Email]'},
              {'label': 'Phone', 'value': '[Your Phone]'},
              {'label': 'Date of Birth', 'value': '[Your DOB]'},
            ],
            onEdit: () => setState(() => _currentStep = 0),
          ),
          const SizedBox(height: 16),
          _buildReviewSection(
            title: 'Address',
            items: [
              {'label': 'Street', 'value': '[Your Street]'},
              {'label': 'City', 'value': '[Your City]'},
              {'label': 'State', 'value': '[Your State]'},
              {'label': 'ZIP', 'value': '[Your ZIP]'},
            ],
            onEdit: () => setState(() => _currentStep = 1),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewSection({
    required String title,
    required List<Map<String, String>> items,
    required VoidCallback onEdit,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit'),
                ),
              ],
            ),
            const Divider(),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Text(
                          '${item['label']}:',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(item['value'] ?? ''),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
