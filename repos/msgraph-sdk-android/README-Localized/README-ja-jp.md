# Microsoft Graph SDK for Android の使用を開始する

[ ![ダウンロード](https://api.bintray.com/packages/microsoftgraph/Maven/msgraph-sdk-android/images/download.svg) ](https://bintray.com/microsoftgraph/Maven/msgraph-sdk-android/_latestVersion)

[Microsoft Graph Beta API](https://graph.microsoft.io/en-us/getting-started) を Android アプリケーションに統合します。

## 1.インストール
### 1.1 Gradle 経由で AAR をインストールする
JCenter リポジトリと `msgraph-sdk-android` のコンパイル依存関係をプロジェクトの `build.gradle` に追加します

```gradle
repository {
    jcenter()
}

dependency {
    // Include the sdk as a dependency
    compile('com.microsoft.graph:msgraph-sdk-android:1.2.+')

    // Include the gson dependency
    compile('com.google.code.gson:gson:2.3.1')
}
```

### 1.2 ProGuard を有効にする
Graph API の性質により、SDK はその機能を記述するために非常に多くのクラスのセットを必要とします。プロジェクトで [ProGuard](https://developer.android.com/studio/build/shrink-code.html) が有効になっていることを確認する必要があります。そうでない場合、特定のアプリケーションに関連する必要のない機能のビルド時間が長くなります。それでも 64k メソッドの制限に達している場合は、[Multidexing](https://developer.android.com/studio/build/multidex.html) を有効にすることもできます。

## 2.はじめに

### 2.1 アプリケーションを登録する

[これらの](https://graph.microsoft.io/en-us/app-registration)手順に従ってアプリケーションを登録します。

### 2.2 IAuthenticationProvider オブジェクトを作成する

**GraphServiceClient** クラスのインスタンスは、要求を作成し、Microsoft Graph API にそれらを送信し、応答を処理します。
このクラスの新しいインスタンスを作成するには、
Microsoft Graph への要求を認証できる、
`IAuthenticationProvider` のインスタンスを提供する必要があります。

クライアント アプリケーションの認証例については、「[MSGraph SDK Android MSA Auth for Android Adapter](https://github.com/microsoftgraph/msgraph-sdk-android-msa-auth-for-android-adapter)」を参照してください。

### 2.3 GraphServiceClient オブジェクトを取得する

正しいアプリケーションID および URL を設定した後、サービスに対する要求を作成するために**GraphServiceClient** オブジェクトを取得する必要があります。SDK はアカウント情報を保存しますが、ユーザーが初めてログオンすると、UI を呼び出してユーザーのアカウント情報を取得します。

```java
final IClientConfig mClientConfig = DefaultClientConfig
                                        .createWithAuthenticationProvider(mAuthenticationProvider);

final IGraphServiceClient mClient = new GraphServiceClient
                                            .Builder()
                                            .fromConfig(mClientConfig)
                                            .buildClient();
```

## 3.サービスに対する要求を作成する

認証された GraphServiceClient を取得したら、サービスに対する呼び出しを開始できます。サービスに対する要求は [REST API](https://graph.microsoft.io/en-us/docs) に類似しています。

### ドライブを取得する

ユーザーのドライブを取得するには:

```java
graphClient
    .getMe()
    .getDrive()
    .buildRequest()
    .get(new ICallback<Drive>() {
  @Override
  public void success(final Drive result) {
    final String msg = "Found Drive " + result.id;
    Toast.makeText(getActivity(), msg, Toast.LENGTH_SHORT)
        .show();
  }
  ...
  // Handle failure case
});
```

SDK の設計方法に関する一般的な概要については、「[概要](docs/overview.md)」を参照してください。

## 4.ドキュメント

詳細なドキュメントについては、次を参照してください。

* [概要](docs/overview.md)
* [機能拡張](docs/extensibility.md)
* [`Null` 値を含むオープン型 PATCH サポートの処理](docs/opentypes.md)
* [コレクション](docs/collections.md)
* [エラー](docs/errors.md)
* [カスタム要求の作成](docs/custom-queries.md)
* [既知の問題](docs/known-issues.md)
* [投稿](docs/contributions.md)

## 5.問題

既知の問題については、「[問題](https://github.com/MicrosoftGraph/sdk-android/issues)」を参照してください。

## 6.投稿

Microsoft Graph SDK では、投稿を受け付けています。このプロジェクトに投稿する方法については、[ここを](docs/contributions.md)参照してください。

このプロジェクトでは、[Microsoft Open Source Code of Conduct (Microsoft オープン ソース倫理規定)](https://opensource.microsoft.com/codeofconduct/) が採用されています。詳細については、「[Code of Conduct の FAQ (倫理規定の FAQ)](https://opensource.microsoft.com/codeofconduct/faq/)」を参照してください。また、その他の質問やコメントがあれば、[opencode@microsoft.com](mailto:opencode@microsoft.com) までお問い合わせください。

## 7.サポートされる Android のバージョン
Microsoft Graph SDK for Android ライブラリは、[Android API リビジョン 15](http://source.android.com/source/build-numbers.html) 以降のランタイムでサポートされます。SDK をビルドするには、Android API リビジョン 23 以降をインストールする必要があります。

## 8.ライセンス

Copyright (c) Microsoft Corporation.All Rights Reserved.Licensed under the [MIT license](LICENSE).

## 9.サードパーティについての通知

[サードパーティについての通知](THIRD%20PARTY%20NOTICES)
