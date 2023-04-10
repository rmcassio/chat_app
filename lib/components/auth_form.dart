import 'package:chat_app/components/user_image_picker.dart';
import 'package:chat_app/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();
  bool _isVisible = false;

  void _handleImagePick(Image image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError('Imagem não selecionada!');
    }

    widget.onSubmit(_formData);
  }

  void _showPwd() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: _formData.isSignup,
                child: UserImagePicker(onImagePick: _handleImagePick),
              ),
              Visibility(
                visible: _formData.isSignup,
                child: TextFormField(
                  key: const ValueKey('name'),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (name) {
                    final nameChecked = name ?? '';
                    if (nameChecked.trim().length < 5) {
                      return 'Nome deve ter no mínimo 5 caracteres.';
                    }
                    return null;
                  },
                ),
              ),
              TextFormField(
                key: const ValueKey('email'),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (email) {
                  final emailChecked = email ?? '';
                  if (!emailChecked.contains('@')) {
                    return 'Email informado não é válido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: const ValueKey('pwd'),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password,
                obscureText: !_isVisible,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    color: !_isVisible ? Theme.of(context).primaryColor : Colors.black,
                    onPressed: _showPwd,
                    icon: Icon(!_isVisible ? Icons.remove_red_eye : Icons.linear_scale_sharp),
                  ),
                ),
                validator: (password) {
                  final passwordChecked = password ?? '';
                  if (passwordChecked.length < 6) {
                    return 'Senha deve ter no mínimo 6 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(
                  _formData.isLogin ? 'Criar uma nova conta?' : 'Já possui uma conta?',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
