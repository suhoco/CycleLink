# CycleLink

# 🚲 CycleLink Study Branch

CycleLink는 **중고 자전거 거래 앱**을 학습 목적으로 구현하는 프로젝트입니다.  
이 저장소의 `study` 브랜치는 초기 `init commit` 기준에서 직접 기능을 하나씩 개발해 나가며,  
**Supabase + Flutter 기반의 풀스택 앱 개발 학습 기록**을 정리합니다.

---

## 📑 학습 기록
주차별 상세 진행 내용은 `docs/` 폴더에 정리되어 있습니다.

- [1주차: Supabase 인증 & 프로필 관리](./docs/week1.md)
- [2주차: 상품 기능 + 이미지 처리](./docs/week2.md)
- [3주차: 사용자 상호작용 기능](./docs/week3.md)
- [4주차: 실시간 채팅 & 배포](./docs/week4.md)

👉 전체 개요는 [SUMMARY.md](./docs/SUMMARY.md) 에서 확인할 수 있습니다.

---

## 📌 브랜치 구조
- **main**: 팀원이 실제 개발한 버전
- **study**: 학습용 브랜치 (init commit부터 직접 구현 진행)

---

## 🛠 기술 스택
- **Frontend**: Flutter (Material 3, supabase_flutter)
- **Backend**: Supabase (Postgres, Auth, Storage, Realtime)
- **Auth**: Google OAuth (PKCE)
- **Infra**: GitHub (버전 관리 & 기록)

---

## 🎯 학습 목표
1. Supabase 인증과 RLS 기반 보안 이해
2. Flutter 앱 구조화 및 환경 세팅
3. DB 연동을 통한 CRUD 패턴 습득
4. 실시간 데이터 & 채팅 기능 학습
5. 배포 가능한 MVP 수준의 앱 설계
