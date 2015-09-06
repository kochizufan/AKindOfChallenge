#!perl

use strict;
use warnings;
use feature qw(switch say);
use Net::WebSocket::Server;
use POSIX qw(strftime);
use utf8;
use Encode qw(decode_utf8);
 
my %clients;
my $logfile = "logfile.txt";

# Connectionのキーを得る
sub get_client_key {
    my $conn = shift;
    foreach my $key (keys %clients) {
        return $key if ($conn eq $clients{$key});                
    }    
}

# 表示文字列を生成
sub create_line {
    my ($key, $time, $message) = @_;
    return "[${key}:" . strftime("%Y-%m-%d %H:%M:%S", localtime($time)) . "]: " . $message;
}

Net::WebSocket::Server->new(
    listen => 8889,
    on_connect => sub {
        my ($serv, $conn) = @_;
        $conn->on(
            handshake => sub {
                # Handshake開始
                my ($conn, $handshake) = @_;
                my $key = $handshake->req->key;
                # 他のクライアントにログインを告げる
                foreach my $to_conn (values %clients) {
                    $to_conn->send_utf8($key . " logged in");
                }                
                $clients{$key} = $conn;
            },
            ready => sub {
                # 過去ログを表示
                my ($conn) = @_;
                my $messages = decode_utf8(`tail -10 $logfile`);
                chomp($messages);
                $conn->send_utf8($messages);
            },
            utf8 => sub {
                # メッセージ受付
                my ($conn, $message) = @_;
                my $key = get_client_key($conn);
                my $message_line = create_line($key, time(), $message);
                # 過去ログに記録
                `echo '$message_line' >> $logfile`;              
                # 全クライアントに送信
                foreach my $to_conn (values %clients) {
                    $to_conn->send_utf8($message_line);
                }
            },
            disconnect => sub {
                my ($conn, $code, $reason) = @_;
                my $key = get_client_key($conn);
                # クライアント削除
                delete $clients{$key};
                # 残りのクライアントにログアウトを告げる
                foreach my $to_conn (values %clients) {
                    $to_conn->send_utf8($key . " logged out");
                }
            }
        );
    },
)->start;