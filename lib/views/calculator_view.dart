import 'package:flutter/material.dart';
import 'converter_view.dart';
import '../models/calculator_model.dart';
import '../controllers/calculator_controller.dart';


class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  late final CalculatorModel _model;
  late final CalculatorController _controller;

  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _model = CalculatorModel();
    _controller = CalculatorController(_model);
  }

  void _onOperationPressed(Operation operation) {
    
    _controller.updateFirstNumber(_firstController.text);
    _controller.updateSecondNumber(_secondController.text);

  
    _controller.calculate(operation);

    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1E3C72),
              Color(0xFF2A5298),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Pealkiri
                        Text(
                          'Lihtne kalkulaator',
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                                               
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ConverterView(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.map),
                          label: const Text('Km → miilid teisendaja'),
                        ),
                        const SizedBox(height: 16),


                        // Esimene arv 

                        
                       
                        const SizedBox(height: 6),
                        TextField(
                          controller: _firstController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.filter_1),
                            hintText: 'Sisesta esimene reaalarv',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Teine arv
                        
                        const SizedBox(height: 6),
                        TextField(
                          controller: _secondController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.filter_2),
                            hintText: 'Sisesta teine reaalarv',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Tehte valik
                        Text(
                          'Vali tehe',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _OperationButton(
                              label: '+',
                              onTap: () => _onOperationPressed(Operation.add),
                            ),
                            _OperationButton(
                              label: '−',
                              onTap: () =>
                                  _onOperationPressed(Operation.subtract),
                            ),
                            _OperationButton(
                              label: '×',
                              onTap: () =>
                                  _onOperationPressed(Operation.multiply),
                            ),
                            _OperationButton(
                              label: '÷',
                              onTap: () => _onOperationPressed(Operation.divide),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Tulemus – SAMA ekraani alumises osas
                        Text(
                          'Tulemus',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _controller.getResultText(),
                            textAlign: TextAlign.right,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),

                                               
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OperationButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _OperationButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 3,
          ),
          child: Text(
            label,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
