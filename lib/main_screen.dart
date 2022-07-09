import 'package:flutter/material.dart';
import 'package:metamask_connect/metamask_connect.dart';
import 'package:metamask_connect/wallet_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late WalletModel _walletModel;
  final MetaMaskConnect _metaMaskConnect = MetaMaskConnect();
  bool _isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222743),
      body: SafeArea(
        child: _isConnected ? _connectedWidget() : _notConnectedWidget(),
      ),
    );
  }

  _notConnectedWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://seeklogo.com/images/M/metamask-logo-09EDE53DBD-seeklogo.com.png',
              width: 150,
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          'Add Metamask',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'Connect your\nMetamask wallet',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () async {
            _walletModel = await _metaMaskConnect.walletConnect();
            setState(() => _isConnected = true);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'CONNECT',
              style: TextStyle(
                color: Color(0xFFFB4467),
                fontSize: 14,
              ),
            ),
          ),
        )
      ],
    );
  }

  _connectedWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://seeklogo.com/images/M/metamask-logo-09EDE53DBD-seeklogo.com.png',
              width: 150,
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          _walletModel.address,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () async {
            await _metaMaskConnect.disconnect();
            setState(() => _isConnected = false);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'DISCONNECT',
              style: TextStyle(
                color: Color(0xFFFB4467),
                fontSize: 14,
              ),
            ),
          ),
        )
      ],
    );
  }
}
