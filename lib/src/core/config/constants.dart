import 'package:flutter_dotenv/flutter_dotenv.dart';

// API URLs
final String DEV_API_URL = dotenv.env['DEV_API_URL']!;
final String API_URL = dotenv.env['API_URL']!;
final String API_PREFIX = dotenv.env['API_PREFIX']!;

// OAuth
final String NAVER_OAUTH = dotenv.env['NAVER_OAUTH']!;
final String KAKAO_OAUTH = dotenv.env['KAKAO_OAUTH']!;
final String GOOGLE_OAUTH = dotenv.env['GOOGLE_OAUTH']!;

// Geocoding
final String GEOCODING_API_URL = dotenv.env['GEOCODING_API_URL']!;
final String REVERSE_GEOCODING_API_URL =
    dotenv.env['REVERSE_GEOCODING_API_URL']!;

// Naver Cloud Platform
final String X_NCP_APIGW_API_KEY_ID = dotenv.env['X_NCP_APIGW_API_KEY_ID']!;
final String X_NCP_APIGW_API_KEY = dotenv.env['X_NCP_APIGW_API_KEY']!;

final String NAVER_CLIENT_ID = dotenv.env['NAVER_CLIENT_ID']!;
final String NAVER_CONSUMER_ID = dotenv.env['NAVER_CONSUMER_ID']!;
final String NAVER_CONSUMER_SECRET = dotenv.env['NAVER_CONSUMER_SECRET']!;
final String NAVER_APP_NAME = dotenv.env['NAVER_APP_NAME']!;
final String SERVICE_URL_SCHEME = dotenv.env['SERVICE_URL_SCHEME']!;

// Portone
final String PORTONE_STORE_ID = dotenv.env['PORTONE_STORE_ID']!;
final String PORTONE_TEST_CHANNEL_KEY = dotenv.env['PORTONE_TEST_CHANNEL_KEY']!;
final String PORTONE_CHANNEL_KEY = dotenv.env['PORTONE_CHANNEL_KEY']!;
final String PORTONE_IMP_CODE = dotenv.env['PORTONE_IMP_CODE']!;
// MID (Merchant ID) - 각 채널의 가맹점 ID
final String PORTONE_TEST_MID = dotenv.env['PORTONE_TEST_MID']!;
final String PORTONE_MID = dotenv.env['PORTONE_MID']!;

// kakao
final String KAKAO_NATIVE_PROD_APP_KEY = dotenv.env['KAKAO_NATIVE_PROD_APP_KEY']!;
final String KAKAO_NATIVE_DEV_APP_KEY = dotenv.env['KAKAO_NATIVE_DEV_APP_KEY']!;
final String KAKAO_JAVASCRIPT_KEY = dotenv.env['KAKAO_JAVASCRIPT_KEY']!;
final String KAKAO_REST_API_KEY = dotenv.env['KAKAO_REST_API_KEY']!;

// Firebase (Android용 - iOS는 GoogleService-Info.plist 사용)
// Dev
final String FIREBASE_APP_ID_ANDROID_DEV = dotenv.env['FIREBASE_APP_ID_ANDROID_DEV']!;
final String FIREBASE_API_KEY_ANDROID_DEV = dotenv.env['FIREBASE_API_KEY_ANDROID_DEV']!;
final String FIREBASE_MESSAGING_SENDER_ID_ANDROID_DEV = dotenv.env['FIREBASE_MESSAGING_SENDER_ID_ANDROID_DEV']!;
final String FIREBASE_PROJECT_ID_ANDROID_DEV = dotenv.env['FIREBASE_PROJECT_ID_ANDROID_DEV']!;

// Prod
final String FIREBASE_APP_ID_ANDROID_PROD = dotenv.env['FIREBASE_APP_ID_ANDROID_PROD']!;
final String FIREBASE_API_KEY_ANDROID_PROD = dotenv.env['FIREBASE_API_KEY_ANDROID_PROD']!;
final String FIREBASE_MESSAGING_SENDER_ID_ANDROID_PROD = dotenv.env['FIREBASE_MESSAGING_SENDER_ID_ANDROID_PROD']!;
final String FIREBASE_PROJECT_ID_ANDROID_PROD = dotenv.env['FIREBASE_PROJECT_ID_ANDROID_PROD']!;

final int KAKAO_SHARE_TEMPLATE_ID_PROD = int.parse(dotenv.env['KAKAO_SHARE_TEMPLATE_ID_PROD']!);
final int KAKAO_SHARE_TEMPLATE_ID_DEV = int.parse(dotenv.env['KAKAO_SHARE_TEMPLATE_ID_DEV']!);
