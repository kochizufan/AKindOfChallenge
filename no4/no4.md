No.4

WebScocketの経験が少なかったため調査から
事前調査中参照サイト：
http://search.cpan.org/~topaz/Net-WebSocket-Server/lib/Net/WebSocket/Server.pm
http://search.cpan.org/~topaz/Net-WebSocket-Server/lib/Net/WebSocket/Server/Connection.pm
http://search.cpan.org/~vti/Protocol-WebSocket-0.18/lib/Protocol/WebSocket/Request.pm

テストコードからそのまま実装、テストへ

作業開始：14:21
作業完了：16:21
総作業時間（調査、設計、実装、テスト、デバグ）：120分

動作前提：
node.jsのインストール（簡易httpサーバのため）
sudo cpanm Net::WebSocket::Server 

動作方法：
1. node server.js & で簡易httpサーバ起動（8888で動作）
2. perl no4_server.pl & でWebSocketサーバ起動（8889で動作）
3. 複数のブラウザでhttp://localhost:8888/にアクセス。以後、チャット可能

特記：
* ユーザ名相当のものとしてWebSocketのキーを使用
* 新規接続時の過去ログ表示は10行
* Databaseは使わずtxtファイルに追記