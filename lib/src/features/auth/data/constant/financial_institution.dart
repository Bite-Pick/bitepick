class FinancialInstitution {
  final String icon;
  final String name;
  final String shortName;

  const FinancialInstitution({
    required this.icon,
    required this.name,
    required this.shortName,
  });
}

const Map<String, FinancialInstitution> financialInstitutions = {
  'NhBank': FinancialInstitution(
    icon: 'NhBank',
    name: 'NH농협은행',
    shortName: '농협',
  ),
  'ShinhanBank': FinancialInstitution(
    icon: 'ShinhanBank',
    name: '신한은행',
    shortName: '신한',
  ),
  'KakaoBank': FinancialInstitution(
    icon: 'KakaoBank',
    name: '카카오뱅크',
    shortName: '카카오뱅크',
  ),
  'KbBank': FinancialInstitution(
    icon: 'KbBank',
    name: 'KB국민은행',
    shortName: 'KB국민',
  ),
  'KBank': FinancialInstitution(icon: 'KBank', name: '케이뱅크', shortName: '케이뱅크'),
  'IbkBank': FinancialInstitution(
    icon: 'IbkBank',
    name: 'IBK기업은행',
    shortName: 'IBK기업',
  ),
  'WooriBank': FinancialInstitution(
    icon: 'WooriBank',
    name: '우리은행',
    shortName: '우리',
  ),
  'HanaBank': FinancialInstitution(
    icon: 'HanaBank',
    name: '하나은행',
    shortName: '하나',
  ),
  'KdbIndustrialBank': FinancialInstitution(
    icon: 'KdbIndustrialBank',
    name: 'KDB산업은행',
    shortName: 'KDB산업',
  ),
  'BusanBank': FinancialInstitution(
    icon: 'BusanBank',
    name: '부산은행',
    shortName: '부산',
  ),
  'SuhyupBank': FinancialInstitution(
    icon: 'SuhyupBank',
    name: '수협은행',
    shortName: '수협',
  ),
  'JejuBank': FinancialInstitution(
    icon: 'JejuBank',
    name: '제주은행',
    shortName: '제주',
  ),
  'DaeguBank': FinancialInstitution(
    icon: 'DaeguBank',
    name: '대구은행',
    shortName: '대구',
  ),
  'JeonbukBank': FinancialInstitution(
    icon: 'JeonbukBank',
    name: '전북은행',
    shortName: '전북',
  ),
  'ScFirstBank': FinancialInstitution(
    icon: 'ScFirstBank',
    name: 'SC제일은행',
    shortName: 'SC제일',
  ),
  'GwangjuBank': FinancialInstitution(
    icon: 'GwangjuBank',
    name: '광주은행',
    shortName: '광주',
  ),
  'GyeongnamBank': FinancialInstitution(
    icon: 'GyeongnamBank',
    name: '경남은행',
    shortName: '경남',
  ),
  'CitiBank': FinancialInstitution(
    icon: 'CitiBank',
    name: '한국씨티은행',
    shortName: '씨티',
  ),
};
