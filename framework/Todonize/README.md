Todonize - TODO Framework
============================
Embed TODO features into your awesome application by simple setup!!

概要
---------
**Todonize** はPerlで書かれたアプリケーションにTODO機能を追加するフレームワークです。  
基本的なセットアップを行うと、TODOの作成・取得・更新・削除などのAPIが提供され、  
そのAPIを使うことでアプリケーションに自由にTODO機能を埋め込むことができます。  
またプラグイン機能を使うとTODOの機能を拡張することができます(※後述)。

セットアップ方法
---------------------
```sh
$ bin/todonize-setup init --database=test --user=addsict
```

TODO API
----------

- TODOの作成: `create(\%attr, $dbh, $table)`

```perl
use Todonize;
my $todo = Todonize->create({
    title => 'メール返信',
    is_done => 0,
}, $dbh, $table);
```

- TODOの取得: `get($dbh, $table, $id)` or `get_all($dbh, $table)`

```perl
use Todonize;
my $todo = Todonize->get($dbh, $table, 1);
my $todos = Todonize->get_all($dbh, $table);
```

- TODOの更新: `update($dbh, $table, $id, \%attr)`

```perl
use Todonize;
my $todo = Todonize->update($dbh, $table, 1, {
    'is_done' => 1,
});
```

- TODOの削除: `delete($dbh, $table, $id)`

```perl
use Todonize;
Todonize->delete($dbh, $table, 1);
```

プラグイン機能 - 概要
-----------------------
初期セットアップではシンプルなTODO機能しか利用できませんが、  
プラグインを使うことでTODOを機能拡張することができます。  
(`Todonize` クラスが拡張されます)

**ビルトインプラグイン**

- Todonize::Plugin::User
    - ユーザ(TODOの作成者creator・割当人assignee)に関する機能拡張
- Todonize::Plugin::Fulltext
    - TODOの全文検索機能を実現する拡張機能

プラグイン機能 - セットアップ・使い方
-----------------------

**プラグインのセットアップ方法**

```sh
$ bin/todonize-plugin add Fulltext --database=test --user=addsict
```

**使い方**

Todonizeモジュールのロード時に、拡張するプラグインを指定します。

```perl
use Todonize (
    'plugins' => [qw/User Fulltext/];
);

Todonize->search($dbh, $table, $query); # Todonizeクラスで全文検索が使えるようになる
```


サードパーティプラグインの開発方法
----------------------------------
`ThirdParty` というプラグインを作る場合

- セットアップ用SQL `init.sql`
- `Todonize::Plugin::ThirdParty::API`モジュール

この2つが必要になります。

**ディレクトリ構成**
```
Todonize/
   |---Plugin/
         |-- ThirdParty/
                 |-- API.pm
                 |-- init.sql

```

**セットアップ用SQL**

```sql
/* init.sql */
ALTER TABLE todo ADD COLUMN new_col1 text;
ALTER TABLE todo ADD COLUMN new_col2 text;
```

**Todonize::Plugin::ThirdParty::API モジュール**

```perl
package Todonize::Plugin::ThirdParty::API;
use parent qw/Todonize::Plugin/;

# Todonizeを拡張するメソッド
sub export {
    return qw(third_party_method);
}

# このモジュールで拡張されるカラム
sub columns {
    return qw(new_col1 new_col2);
}

sub third_party_method {
    my $class = shift; # $class is 'Todonize'
}

1;
```
