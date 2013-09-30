Todonize - TODO Framework
============================
Embed TODO feature into your awesome application in 3 minutes!

アプリケーションにTODO機能を追加するフレームワーク

概要
---------
**Todonize** はPerlで書かれたアプリケーションにTODO機能を追加するフレームワークです。  
基本的なセットアップを行うと、TODOの作成・取得・更新・削除などのAPIが提供され、  
そのAPIを使うことでアプリケーションに自由にTODO機能を埋め込むことができます。  
またプラグイン機能を使うとTODOの機能を拡張することができます(※後述)。

セットアップ方法
---------------------
DBのセットアップ

TODO API
----------
- TODOの作成: `create(\%attr, $dbh, $table)`

```perl
my $todo = Todonize->create({
    title => 'メール返信',
    is_done => 0,
}, $dbh, $table);
```

- TODOの取得: `get($dbh, $table, $id)` or `get_all($dbh, $table)`

```perl
my $todo = Todonize->get($dbh, $table, 1);
my $todos = Todonize->get_all($dbh, $table);
```

- TODOの更新: `update($dbh, $table, $id, \%attr)`

```perl
my $todo = Todonize->update($dbh, $table, 1, {
    'is_done' => 1,
});
```

- TODOの削除: `delete($dbh, $table, $id)`
```perl
Todonize->delete($dbh, $table, 1);
```

プラグイン機能
---------------
プラグインを使う・作ることでTODOを機能拡張することができます。


サードパーティプラグインの開発方法
----------------------------------
`ThirdParty` というプラグインを作る場合、`Todonize::Plugin::ThirdParty::API`モジュールを作ります。

```perl
package Todonize::Plugin::ThirdParty::API;
use parent qw/Todonize::Plugin/;

sub export {
    return qw(third_party_method);
}

sub columns {
    return qw(new_col1 new_col2);
}

sub third_party_method {
    my $class = shift; # $class is class object of 'Todonize'
}

1;
```
