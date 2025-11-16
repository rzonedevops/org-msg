---
title: тип ресурса actionResultPart
description: Абстрактный тип для моделирования ответов массовых операций.
author: AkJo
ms.localizationpriority: medium
ms.prod: microsoft-teams
doc_type: resourcePageType
ms.openlocfilehash: 63a4f05e9096c0abd2bb2f207af2702fed3b47e3
ms.sourcegitcommit: 30fca91ed203a9ab7b0562833ce0c20c7fb7b7b1
ms.translationtype: MT
ms.contentlocale: ru-RU
ms.lasthandoff: 09/27/2021
ms.locfileid: "59931964"
---
# <a name="actionresultpart-resource-type"></a>тип ресурса actionResultPart

Пространство имен: microsoft.graph

[!INCLUDE [beta-disclaimer](../../includes/beta-disclaimer.md)]

Абстрактный тип, который служит базой для моделирования ответов массовых операций. Свойство **ошибки** выборочно заполняется в зависимости от того, представляет ли ответ ошибку.

## <a name="properties"></a>Свойства

| Свойство | Тип   | Описание |
|:---------------|:--------|:----------|
|error|[publicError](publicerror.md) |Ошибка, которая произошла, если таково, во время основной операции.|

## <a name="relationships"></a>Отношения
Отсутствуют.

## <a name="json-representation"></a>Представление в формате JSON
Ниже указано представление ресурса в формате JSON.
<!-- {
  "blockType": "resource",
  "@odata.type": "microsoft.graph.actionResultPart"
}
-->
``` json
{
  "@odata.type": "#microsoft.graph.actionResultPart",
  "error": {
    "@odata.type": "microsoft.graph.publicError"
  }
}
```
## <a name="see-also"></a>См. также

- [aadUserConversationMemberResult](aadUserConversationMemberResult.md)
- [Добавление в команду участников оптом](../api/conversationmembers-add.md)

<!-- uuid: 20fd7863-9545-40d4-ae8f-fee2d115a690
2015-10-25 14:57:30 UTC -->
<!--
{
  "type": "#page.annotation",
  "description": "actionResultPart",
  "keywords": "",
  "section": "documentation",
  "tocPath": "",
  "suppressions": []
}
-->


