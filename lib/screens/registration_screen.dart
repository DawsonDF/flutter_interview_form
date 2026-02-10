import 'package:flutter/material.dart';

/// Main registration screen with stepper
///
/// TODO: Implement the following:
/// 1. Connect to your state management provider
/// 2. Implement step navigation logic
/// 3. Add validation before allowing step progression
/// 4. Handle form submission
/// 5. Load saved draft on initialization
/// 6. Auto-save draft after changes
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
    _loadDraft();
  }

  Future<void> _loadDraft() async {
    // TODO: Implement draft loading using PersistenceService
    //
    // Example implementation pattern:
    // 1. final persistenceService = PersistenceService();
    // 2. await persistenceService.initialize();
    // 3. Check if persistenceService.hasSavedDraft()
    // 4. If true, load: await persistenceService.loadFormData()
    // 5. Load step: await persistenceService.loadCurrentStep()
    // 6. Restore form fields with loaded data
    // 7. Call setState() to update UI
    //
    // Optional: Show a dialog asking if user wants to resume
  }

  void _onStepContinue() {
    // TODO: Implement step validation and auto-save
    // 1. Validate current step form fields
    // 2. If valid, increment step
    // 3. Save form data to SharedPreferences using PersistenceService:
    //    final persistenceService = PersistenceService();
    //    await persistenceService.initialize();
    //    await persistenceService.saveFormData({...formData...});
    //    await persistenceService.saveCurrentStep(_currentStep);

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
    // TODO: Implement smart navigation
    // Only allow jumping to completed steps
    // Prevent jumping ahead to incomplete steps

    setState(() {
      _currentStep = step;
    });
  }

  Future<void> _submitForm() async {
    // TODO: Implement form submission with persistence cleanup
    // 1. Final validation of all steps
    // 2. Send data to backend/database
    // 3. Clear saved draft from SharedPreferences:
    //    await _persistenceService.clearFormData();
    // 4. Show success message
    // 5. Reset form state and navigation

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Registration completed successfully!'),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              // TODO: Clear saved draft after successful submission
              // await _persistenceService.clearFormData();
              // TODO: Reset form state
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
    // TODO: Implement proper step state logic
    // Return StepState.complete for completed steps
    // Return StepState.error for steps with validation errors
    // Return StepState.indexed for other steps

    if (step < _currentStep) {
      return StepState.complete;
    }
    return StepState.indexed;
  }

  Widget _buildPersonalInfoStep() {
    // TODO: Build Step 1 form fields
    // Required fields:
    // - Full Name
    // - Email (with async validation)
    // - Phone Number
    // - Date of Birth (with age validation)
    //
    // Stretch goal:
    // - Business registration checkbox
    // - Business name (conditional)

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

          // TODO: Add form fields here
          // Example structure:
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Full Name',
              hintText: 'Enter your full name',
            ),
            // TODO: Connect to your state management
            // TODO: Add validation
          ),
          const SizedBox(height: 16),

          // TODO: Add more fields...
        ],
      ),
    );
  }

  Widget _buildAddressStep() {
    // TODO: Build Step 2 form fields
    // Required fields:
    // - Street Address
    // - City (auto-populated from ZIP)
    // - State (dropdown, auto-populated from ZIP)
    // - ZIP Code (with async validation)
    // - Country (read-only: "United States")

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

          // TODO: Add form fields here
        ],
      ),
    );
  }

  Widget _buildReviewStep() {
    // TODO: Build Step 3 review screen
    // Display all collected information
    // Add "Edit" buttons to go back to specific steps
    // Show submit button (handled in controlsBuilder)

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

          // TODO: Display form data in read-only format
          // Example:
          _buildReviewSection(
            title: 'Personal Information',
            items: [
              // TODO: Pull from your state management
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
