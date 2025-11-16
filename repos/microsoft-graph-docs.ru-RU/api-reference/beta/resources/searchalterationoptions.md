---
title: тип ресурса searchAlterationOptions
description: Предоставляет параметры изменения поиска для коррекции правописания.
ms.localizationpriority: medium
author: nmoreau
ms.prod: search
doc_type: resourcePageType
ms.openlocfilehash: 09b2e7f4e5522af709a72b0cfae8f3d836a93e2c
ms.sourcegitcommit: b19b19bf192688f4c513492e8391e4d8dc104633
ms.translationtype: MT
ms.contentlocale: ru-RU
ms.lasthandoff: 02/17/2022
ms.locfileid: "62878437"
---
# <a name="searchalterationoptions-resource-type"></a>тип ресурса searchAlterationOptions

Пространство имен: microsoft.graph

[!INCLUDE [beta-disclaimer](../../includes/beta-disclaimer.md)]

Предоставляет параметры изменения поиска для коррекции правописания.

## <a name="properties"></a>Свойства

| Свойство     | Тип        | Описание |
|:-------------|:------------|:------------|
|enableModification|Логический|Указывает, включены ли изменения орфографии. Если включен, пользователь получит результаты поиска для исправленного запроса,  если нет результатов для исходного запроса с опечатки и получит сведения о внесении изменений орфографии в **свойство queryAlterationResponse** [ответа.](/graph/api/resources/searchresponse?view=graph-rest-beta&preserve-view=true) Необязательное свойство.|
|enableSuggestion|Логический|Указывает, включены ли предложения орфографии. Если включено, пользователь получит результаты поиска для исходного запроса поиска и предложения по исправлению орфографии в свойстве **queryAlterationResponse** ответа на опечатки в запросе.[](/graph/api/resources/searchresponse?view=graph-rest-beta&preserve-view=true) Необязательное свойство.|

## <a name="json-representation"></a>Представление JSON

Ниже указано представление ресурса в формате JSON.

<!-- {
  "blockType": "resource",
  "optionalProperties": [

  ],
  "@odata.type": "microsoft.graph.searchAlterationOptions",
  "baseType": null
}-->

```json
{
  "enableModification": "Boolean",
  "enableSuggestion": "Boolean"
}
```

<!-- uuid: 16cd6b66-4b1a-43a1-adaf-3a886856ed98
2019-02-04 14:57:30 UTC -->
<!-- {
  "type": "#page.annotation",
  "description": "searchAlterationOptions resource",
  "keywords": "",
  "section": "documentation",
  "tocPath": ""
}-->
