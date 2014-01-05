# Qchan Web
HTML-based client application of Qchan.

Qchan is a project of a Job-Queue Worker System.
It consists of a cluster of many processes and Qchan Web provides User Interface to web browsers.
Qchan Web is one of client applicaitons of Qchan's REST API, implemented with client-side JavaScript.

![](https://raw.github.com/r7kamura/qchan-web/master/doc/png/overview.png)

## Usage
Run server by `rake`, then open http://localhost:4000 in your web browser.

```sh
rake
```

## Architecture
* View Tree
* View Communication

### View Tree
アプリケーションは木構造の関係を持つ複数のView Objectで構成される。
HTML上での表現と近似して、上位のView Objectが下位のView Objectを包含する形になる。
(自身の描画されるべき要素を知るため)子は親への参照を持つが、親は子への参照を持たない。
Viewの分割単位となるものは以下の通り。

* 画面の部品の単位 (例: headerとfooter, mainとsidebar)
* 動的にHTML要素が変更される単位 (例: Sign inのリンク)
* 子に発生するイベントの管理単位 (例: タブ一覧)
* 最上位の要素 (全体を包括するViewが必ず1つ存在する)

### View Communication
全てのView Object間の会話はEventを介して行われる。
グローバルに参照可能なMediator Objectが存在し、
各View ObjectはMediator Objectのイベントを購読・発火することで他のView Objectとの会話を行う。
