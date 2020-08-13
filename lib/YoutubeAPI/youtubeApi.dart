import 'dart:io';

import 'package:coach_app/YoutubeAPI/secureStorage.dart';
import 'package:googleapis/youtube/v3.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class YoutubeUpload {
  final storage = SecureStorage();

  getHTTPClient() async {
    var credentials = await storage.getCredentials();
    var scopes = [YoutubeApi.YoutubeScope];
    if (credentials == null) {
      var clientID = ClientId(
          '367080368956-nt26f3rhss4kovv6ks2v9kl5ibs5l65j.apps.googleusercontent.com',
          'y4d4F7XkkcgwvNpu-OWgmn6f');
      var autoRefreshingAuthClient =
          await clientViaUserConsent(clientID, scopes, (url) {
        launch(url);
      });

      storage.saveCredentials(
        autoRefreshingAuthClient.credentials.accessToken,
        autoRefreshingAuthClient.credentials.refreshToken,
      );

      return autoRefreshingAuthClient;
    } else {
      return authenticatedClient(
        http.Client(),
        AccessCredentials(
          AccessToken(credentials['type'], credentials['data'],
              DateTime.parse(credentials['expiry'])),
          credentials['refreshToken'],
          scopes,
        ),
      );
    }
  }

  Future<String> uploadVideo(
      File file, String title, String description) async {
    var client = await getHTTPClient();
    YoutubeApi youtubeApi = YoutubeApi(client);

    Video video = Video()
      ..snippet =
          VideoSnippet.fromJson({'title': title, 'description': description})
      ..status = VideoStatus.fromJson({'privacyStatus': 'unlisted'});

    Video videon = await youtubeApi.videos.insert(video, 'snippet,status',
        uploadMedia: Media(file.openRead(), file.lengthSync()));
    return "https://www.youtube.com/watch?v=" + videon.id;
  }
}
