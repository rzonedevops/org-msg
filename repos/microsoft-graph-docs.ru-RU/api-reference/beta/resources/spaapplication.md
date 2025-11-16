---
title: тип ресурса spaApplication
description: Указывает параметры для одно-страницного приложения.
localization_priority: Normal
doc_type: resourcePageType
ms.prod: applications
author: sureshja
ms.openlocfilehash: 82848c5ea8427111b2d8b02c1886f3990faba79e
ms.sourcegitcommit: be09568fa07ab793cd1db500f537ca94ca9e5b4a
ms.translationtype: MT
ms.contentlocale: ru-RU
ms.lasthandoff: 04/15/2021
ms.locfileid: "51836953"
---
# <a name="spaapplication-resource-type"></a>тип ресурса spaApplication

Пространство имен: microsoft.graph

[!INCLUDE [beta-disclaimer](../../includes/beta-disclaimer.md)]

Указывает параметры для одно-страницного приложения.

## <a name="properties"></a>Свойства

| Свойство | Тип | Описание |
|:---------|:-----|:------------|
| redirectUris | Коллекция String | Указывает URL-адреса, куда отправляются маркеры пользователей для регистрации, или URL-адреса перенаправления, куда отправляются коды авторизации OAuth 2.0 и маркеры доступа. |

## <a name="json-representation"></a>Представление JSON
Ниже указано представление ресурса в формате JSON.

<!-- {
  "blockType": "resource",
  "optionalProperties": [
  ],
  "@odata.type": "microsoft.graph.spaApplication"
}-->

```json
{
  "redirectUris": ["String"]
}
```
