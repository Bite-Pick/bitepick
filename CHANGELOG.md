# Changelog

바이트픽(bitepick) 앱의 변경 이력. 모든 사용자-영향 변경은 이 파일에 기록한다.

포맷은 [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/),
버저닝은 [Semantic Versioning](https://semver.org/lang/ko/)을 따른다.

> 섹션 종류: **Added** (신규) / **Changed** (변경) / **Deprecated** (지원 중단 예정) /
> **Removed** (제거) / **Fixed** (버그 수정) / **Security** (보안).
>
> 스토어(App Store / Play Store)에 그대로 올라가는 사용자 공지용 문구는
> [`release_notes/{version}.ko.txt`](release_notes/) 에 따로 둔다.
> 이 파일은 개발자/코드 관점, 저 파일은 유저 관점.

---

## [Unreleased]

### Added
-

### Changed
-

### Fixed
-

---

## [1.21.0] - 2026-04-17

### Added

- 사장님 영업 전 재고 확인 알림창 팝업 (ce2a6cf)
- 오픈알림 토스트 트랜지션 효과 추가 (2b0b5ce)
- 오픈 알림 신청자 수 표시 (ad2bf2c)
- 사업자 정보 하단 표시 (35a540b)
- 사장님 상품 관리 페이지에 사진 변경 가능으로 수정 (b6ffda5)


### Fixed

- 재고 업데이트 후 새로고침 (dad849b)
- 픽업시간 단위 10분으로 변경 (1fcf60e)
- 오픈알림 구독자 수 표시 버그 수정 (bbe1927)
- 오픈알림 신청시에는 재고 체크 안하도록 수정 (83bc608)
- 오픈 알림 신청/취소 알림 팝업 디자인 수정 (5f608d8)
- 화면 하단 높이 수정 (47e400b)
- 주문서 디자인 수정 완료 (5971696)
- 영업 토글 중복 클릭 방지 및 낙관적 업데이트 적용 (aa3b402)
- 다음날 픽업시간 선택 시 가장 빠른 시간을 기본값으로 설정 (99375e0)
- 사장님 판매 페이지로 명칭 재수정 (cfe1bb3)
- 다음날 예약 미리 켜면 픽업시간 안 뜨는 오류 수정 (1c8d763)
- 리뷰많은순 버그 수정 (e8a263b)

---
## [1.20.2] - 2026-04-17

_마지막 커밋: `f29891a`_

### Added
- 오픈 알림 신청 해제 기능
- 푸시 알림 클릭 시 관련 페이지로 랜딩 (페이로드 스펙 수정 포함)
- 예약 가능 필터를 칩(chip) UI로 변경

### Changed
- 토스트 메시지 문구 전반 조정
- 업데이트 다이얼로그 텍스트 수정
- 사용자 유형별 FCM 토픽 추가 (푸시 타겟팅 분리)

### Fixed
- 픽업 시간 선택 버그
- 상품명 유효성 검사 추가
- 예약 가능 필터 칩 디테일 수정
- 이미지 URL 및 키 값 수정
- 네트워크 차단 시 에러 화면 노출 방식 개선
- 관리자 페이지에서 승인 대기 매장 사진이 표시되지 않던 오류
- 사장님 판매 페이지 / 관심 목록 새로고침, 주문 내역 지도, 스플래시 노출 시간 조정
- 리뷰 사진 표시 개선
- 페이징 오류 수정 및 무한 스크롤 추가
- 오픈 알림 신청 완료 시 버튼 비활성화 처리
- 사장님 계정 크래시 및 로그아웃 딜레이
- 탭바 색상, 상품 정보 정렬, 지도 리빌드 등 UI 교정
- 바이트백 등록 오류
- 데드락 이슈 해결

### Notes
- 이 버전부터 CHANGELOG 정식 운영 시작. 이전 변경 사항은 git tag(`v*`)와 `build_numbers.json` 이력 참고.
- 스토어 공지 문구: [`release_notes/1.20.2.ko.txt`](release_notes/1.20.2.ko.txt)

---

[Unreleased]: https://github.com/YOUR_ORG/bitepick/compare/v1.21.0...HEAD
[1.21.0]: https://github.com/YOUR_ORG/bitepick/compare/v1.20.2...v1.21.0
[1.20.2]: https://github.com/YOUR_ORG/bitepick/releases/tag/v1.20.2
