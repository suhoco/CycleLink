# CycleLink 학습 기록
## 목표 : Supabase + Google oAuth 감 잡기
## 2025-09-09 : Supabase + Google OAuth 연동 성공

### 1. 환경 세팅
- Flutter SDK 설치 → PATH 등록
- 프로젝트 루트: `~/bike_market`
- `.env` 파일 생성
  ```env
  SUPABASE_URL=https://uphossytnvkrjawaulsm.supabase.co
  SUPABASE_ANON_KEY=... (anon public key)

.gitignore에 .env 추가

### 2. Supabase 설정

프로젝트 생성 후 URL/anon key 확인

Authentication → Providers → Google → Enable

Google Cloud Console에서 OAuth 클라이언트 발급

Authorized JavaScript origins:
```
http://localhost:3000
```

Authorized redirect URIs:
```
http://localhost:3000
http://localhost:3000/
```

발급받은 Client ID/Secret을 Supabase에 입력

### 3. 시행착오 & 문제 해결

flutter run 했을 때 .env 없다고 에러
→ 해결: .env 생성

Google 로그인 시 Unsupported provider 에러
→ 해결: Provider 토글 ON

Redirect URI 등록할 때 경로 포함 불가 오류
→ 해결: Origins에는 도메인만, Redirect URIs에는 /auth/v1/callback까지

로그인 후 connection refused
→ 원인: Flutter dev server 포트 불일치
→ 해결:
```
flutter run -d chrome --web-port=3000
```
### 4. 결과

로그인 화면 → Google 계정 선택 → Supabase 세션 정상 생성 확인

### 5. 다음 목표

study 브랜치에서 init commit 상태부터 만들어보기
