import 'package:metamask_connect/wallet_model.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class MetaMaskConnect {
  String _account = "";
  late WalletConnect _connector;
  late SessionStatus? _session;
  final _apiUrl = "https://rinkeby.infura.io/v3/dd4936c57efe4e09beae65c3d0e0a86e";
  final _chainId = 4; //* Ethereum Testnet Rinkeby (RIN)

  Future<WalletModel> walletConnect() async {
    _connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'MetaMask Connect',
        description: 'Demo App',
        url: 'https://walletconnect.org',
        icons: ['https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'],
      ),
    );

    // Subscribe to events
    _connector.on('connect', (session) => {});
    _connector.on('session_update', (payload) => {});
    _connector.on('disconnect', (session) => {});

    // Create a new session
    //await launch uri lets you choose which wallet you want to connect to
    if (!_connector.connected) {
      _session = await _connector.createSession(chainId: _chainId, onDisplayUri: (uri) async => await launchUrlString(uri));
    }

    _account = _session!.accounts[0];

    if (_account != "") {
      return WalletModel(address: _account);
    }
    return WalletModel();
  }

  disconnect() async {
    await _connector.killSession();
  }
}
