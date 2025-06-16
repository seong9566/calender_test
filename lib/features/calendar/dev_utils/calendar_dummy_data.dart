import 'package:calender_test/features/calendar/data/models/todo_model.dart';

final List<TodoModel> dummyTodos = [
  // 1. 사업장 할 일 (관리자가 작성한 일정)
  TodoModel(
    title: '화장실 청소',
    isChecked: false,
    shareUserName: '천수', // 공유대상
    createUserName: '영희', // 관리자
    todoDetailModel: [
      TodoDetailModel(detailTitle: '변기 청소', isChecked: false),
      TodoDetailModel(detailTitle: '화장실 벽 청소', isChecked: false),
      TodoDetailModel(detailTitle: '거울 청소', isChecked: false),
    ],
  ),
  // 2. 개인 할 일
  TodoModel(
    title: '1층 로비 청소',
    isChecked: false,
    shareUserName: '민수', // 자기 자신에게만 공유
    createUserName: '민수',
    todoDetailModel: [
      TodoDetailModel(detailTitle: '로비 벽 청소', isChecked: false),
      TodoDetailModel(detailTitle: '로비 바닥 청소', isChecked: false),
    ],
  ),
  // 3. 개인 할 일
  TodoModel(
    title: '주차장 청소',
    isChecked: false,
    shareUserName: '지현',
    createUserName: '지현',
    todoDetailModel: [
      TodoDetailModel(detailTitle: '주차장 벽 청소', isChecked: false),
      TodoDetailModel(detailTitle: '주차장 바닥 청소', isChecked: false),
    ],
  ),
  // 4. 개인 할 일
  TodoModel(
    title: '2층 라운지 청소',
    isChecked: false,
    shareUserName: '민지',
    createUserName: '민지',
    todoDetailModel: [
      TodoDetailModel(detailTitle: '라운지 벽 청소', isChecked: false),
      TodoDetailModel(detailTitle: '라운지 바닥 청소', isChecked: false),
    ],
  ),
  // 5. 사업장 할 일 (관리자가 작성한 일정)
  TodoModel(
    title: '회의실 준비',
    isChecked: true,
    shareUserName: '전체',
    createUserName: '영희', // 관리자
    todoDetailModel: [
      TodoDetailModel(detailTitle: '회의실 청소', isChecked: true),
      TodoDetailModel(detailTitle: '프로젝터 점검', isChecked: true),
      TodoDetailModel(detailTitle: '음료 준비', isChecked: false),
    ],
  ),
  // 6. 사업장 할 일 (관리자가 작성한 일정)
  TodoModel(
    title: '월간 보고서 작성',
    isChecked: false,
    shareUserName: '팀장단',
    createUserName: '영희', // 관리자
    todoDetailModel: [
      TodoDetailModel(detailTitle: '재무 보고서', isChecked: false),
      TodoDetailModel(detailTitle: '인사 보고서', isChecked: false),
      TodoDetailModel(detailTitle: '사업 계획서', isChecked: false),
    ],
  ),
  // 7. 개인 할 일
  TodoModel(
    title: '점심 식단 관리',
    isChecked: false,
    shareUserName: '',
    createUserName: '민수',
    todoDetailModel: [
      TodoDetailModel(detailTitle: '점심 메뉴 계획', isChecked: false),
      TodoDetailModel(detailTitle: '식재료 구매', isChecked: false),
    ],
  ),
  // 8. 개인 할 일
  TodoModel(
    title: '월간 일정 계획',
    isChecked: false,
    shareUserName: '',
    createUserName: '지현',
    todoDetailModel: [
      TodoDetailModel(detailTitle: '휴가 일정 계획', isChecked: false),
      TodoDetailModel(detailTitle: '프로젝트 일정 계획', isChecked: false),
    ],
  ),
  // 9. 사업장 할 일 (관리자가 작성한 일정)
  TodoModel(
    title: '신입사원 교육',
    isChecked: false,
    shareUserName: '교육팀',
    createUserName: '영희', // 관리자
    todoDetailModel: [
      TodoDetailModel(detailTitle: '회사 소개 교육', isChecked: false),
      TodoDetailModel(detailTitle: '시스템 교육', isChecked: false),
      TodoDetailModel(detailTitle: '안전 교육', isChecked: false),
    ],
  ),
  // 10. 개인 할 일
  TodoModel(
    title: '사이드 프로젝트 계획',
    isChecked: false,
    shareUserName: '민지',
    createUserName: '민지',
    todoDetailModel: [
      TodoDetailModel(detailTitle: '기획안 작성', isChecked: false),
      TodoDetailModel(detailTitle: '기술 스택 결정', isChecked: false),
      TodoDetailModel(detailTitle: '일정 계획', isChecked: false),
    ],
  ),
];
