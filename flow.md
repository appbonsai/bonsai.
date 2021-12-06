# Flow

## Git flow

- default branch is **develop**
   - Consists of commits where each commit represents fully completed and reviewed task
   - Contains tags for releases
   - History should never be rewritten
- 1 task = 1 branch = 1 pull request - 1 commit to **develop**
   - mark bug tasks as bugfix/
   - mark normal tasks as feature/
- Merge requires 2 approval in pull request
- Pull request consists of
   - Task tag
   - Description
   - Affected parts of the project

> **Commit** in **develop** example:
> [BS-01] Improve SomeService background fetch

> **Branch** example:
> feature/BS-01-some-service-bg-fetch

> **Pull request** example:
> [BS-01]
Improve SomeService background fetch
Service app layer affected

## Trello flow

- 1 feature = 1 epic
- Task consists of:
   - Task tag
   - Title
   - Description
   - Tag (bugfix/feature)
   - Epic link

#### Epic examples:

- Ассеты/фонт/локализация
- Бизнес логика подсчета денег
- Главный экран
- Экран с графиками
- Экран с бюджетом
- Экран ввода транзакции
- Deployment (билды, заливка, сертификаты)
- 3rd part libraries
