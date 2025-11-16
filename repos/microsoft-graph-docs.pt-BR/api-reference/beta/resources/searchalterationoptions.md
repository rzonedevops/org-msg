---
title: tipo de recurso searchAlterationOptions
description: Fornece as opções de alteração de pesquisa para correção ortográfica.
ms.localizationpriority: medium
author: nmoreau
ms.prod: search
doc_type: resourcePageType
ms.openlocfilehash: 09b2e7f4e5522af709a72b0cfae8f3d836a93e2c
ms.sourcegitcommit: b19b19bf192688f4c513492e8391e4d8dc104633
ms.translationtype: MT
ms.contentlocale: pt-BR
ms.lasthandoff: 02/17/2022
ms.locfileid: "62878432"
---
# <a name="searchalterationoptions-resource-type"></a>tipo de recurso searchAlterationOptions

Namespace: microsoft.graph

[!INCLUDE [beta-disclaimer](../../includes/beta-disclaimer.md)]

Fornece as opções de alteração de pesquisa para correção ortográfica.

## <a name="properties"></a>Propriedades

| Propriedade     | Tipo        | Descrição |
|:-------------|:------------|:------------|
|enableModification|Booliano|Indica se as modificações ortográficas estão habilitadas. Se habilitado, o usuário receberá os resultados da pesquisa para a consulta corrigida  quando não houver resultados para a consulta original com erros de digitação e obterá as informações de modificação ortográfica na propriedade **queryAlterationResponse** da [resposta.](/graph/api/resources/searchresponse?view=graph-rest-beta&preserve-view=true) Opcional.|
|enableSuggestion|Booliano|Indica se as sugestões ortográficas estão habilitadas. Se habilitado, o usuário receberá os resultados da pesquisa para a consulta de pesquisa original e sugestões para correção ortográfica na **propriedade queryAlterationResponse** da [](/graph/api/resources/searchresponse?view=graph-rest-beta&preserve-view=true) resposta para os erros de digitação na consulta. Opcional.|

## <a name="json-representation"></a>Representação JSON

Veja a seguir uma representação JSON do recurso.

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
