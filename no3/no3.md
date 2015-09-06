No.3

前提条件:
sudo cpanm Crypt::CBC Crypt::Blowfish 
で必要モジュールをインストールしてください。

perl no3.pl -s original.txt -d crypted.txt
perl no3.pl -i -s crypted.txt -d decrypted.txt

実装中参照サイト：
http://search.cpan.org/~lds/Crypt-CBC-2.33/CBC.pm

Result:
設計：実装しつつ設計
実装：12:45〜13:01、16分
テスト、デバグ：13:01〜13:07、6分
総時間：22分