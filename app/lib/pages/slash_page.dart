import 'package:app/services/prefs_service.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();
       
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1590),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _positionAnimation = Tween<double>(begin: -200.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuart,
      ),
    );
    Future.wait([
      PrefsService.isAuth(),
      Future.delayed(Duration(milliseconds: 2500)),
        _animationController.forward(),
      ]).then((value) => value[0] ? Navigator.of(context).pushReplacementNamed('/home') : Navigator.of(context).pushReplacementNamed('/login'));

  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 167, 191, 139),
      child: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (BuildContext context, Widget? child) {
            return Transform.translate(
              offset: Offset(0.0, _positionAnimation.value),
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: Image.asset("assets/imagens/labmaker-splash.png"),
              ),
            );
          },
        ),
      ),
    );
  }
}
