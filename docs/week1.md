# 🚲 CycleLink Study Branch – 1주차 학습 기록

## 📌 목표 (2025-09-04 ~ 2025-09-10)
1. Supabase 프로젝트 설정
2. Flutter 프로젝트와 연동
3. Google OAuth 로그인 / 로그아웃
4. 앱 실행 시 인증 상태에 따라 자동 라우팅
5. 프로필 관리 (닉네임, 활동 지역 수정 가능)

---

## 1. 환경 세팅
- Flutter SDK 설치 및 PATH 등록
- study 브랜치 생성
  ```bash
  git checkout 576e3b3 -b study
  ```
- pubspec.yaml 환경 정리
```
environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_dotenv: ^5.1.0
  supabase_flutter: ^2.0.0

flutter:
  uses-material-design: true
  assets:
    - .env
```
## 2. Supabase 설정

- Authentication → Providers → Google → Enable

- Google Cloud Console OAuth 클라이언트 생성

- Authorized origins:
```
http://localhost:3000
```
- Authorized redirect URIs:
```
http://localhost:3000
http://localhost:3000/
```
- 발급받은 Client ID/Secret을 Supabase에 등록

## 3. DB 스키마 & 정책

- profiles 테이블

- 신규 유저 자동 생성 트리거

- RLS 정책 (본인만 수정 가능)
```
create table if not exists public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nickname text,
  location text,
  avatar_url text,
  created_at timestamp with time zone default now()
);

create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, nickname, avatar_url)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'name', new.email),
    new.raw_user_meta_data->>'picture'
  )
  on conflict (id) do nothing;
  return new;
end;
$$ language plpgsql security definer;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row execute function public.handle_new_user();

alter table public.profiles enable row level security;

drop policy if exists "profiles read for authenticated" on public.profiles;
create policy "profiles read for authenticated"
on public.profiles for select
to authenticated
using (true);

drop policy if exists "profiles update own row" on public.profiles;
create policy "profiles update own row"
on public.profiles for update
to authenticated
using (auth.uid() = id)
with check (auth.uid() = id);
```
- 기존 가입자 백필
```
insert into public.profiles (id, nickname, avatar_url)
select u.id,
       coalesce(u.raw_user_meta_data->>'name', u.email),
       u.raw_user_meta_data->>'picture'
from auth.users u
left join public.profiles p on p.id = u.id
where p.id is null;
```
## 4. Flutter 연동

-Supabase 초기화
```
await Supabase.initialize(
  url: dotenv.env['SUPABASE_URL']!,
  anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  authOptions: const FlutterAuthClientOptions(
    authFlowType: AuthFlowType.pkce,
  ),
);
```
- AuthGate (StreamBuilder<AuthState>) → 세션 기반 라우팅

- 로그인 (OAuthProvider.google, prompt=select_account)

- 로그아웃 (Supabase.instance.client.auth.signOut())

## 5. 프로필 관리

- ProfileService: getMyProfile(), updateMyProfile() 구현

- ProfileScreen: 닉네임/지역 조회 & 수정 → 저장 시 Supabase 반영

- HomeScreen: AppBar에 마이페이지 이동 + 로그아웃 버튼 추가

## 6. 시행착오 & 해결

- .env 웹 빌드 미포함 → pubspec.yaml에 등록

- Provider.google → OAuthProvider.google (supabase_flutter v2 변경사항)

- 로그아웃 후 새로고침 필요 문제 → AuthGate를 StreamBuilder로 수정

- 다른 계정 전환 안 됨 → queryParams: { prompt: 'select_account' } 추가

## 1주차 결과

- Google OAuth 로그인 / 로그아웃 정상 동작

- profiles 자동 생성 + 수정 가능

- 세션 유지 및 자동 라우팅 정상 작동

- 계정 전환 정상 동작
