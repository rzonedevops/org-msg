---
title: тип ресурса configurationManagerAction
description: Параметр для триггера действийConfigurationManagerAction
author: dougeby
localization_priority: Normal
ms.prod: intune
doc_type: resourcePageType
ms.openlocfilehash: 07cf57cf159b9a30dc653a0cbe26451b97b903fe
ms.sourcegitcommit: 00ac72f7b1cdde4f71ff332c2e7953908ef9de52
ms.translationtype: MT
ms.contentlocale: ru-RU
ms.lasthandoff: 01/04/2022
ms.locfileid: "61711916"
---
# <a name="configurationmanageraction-resource-type"></a>тип ресурса configurationManagerAction

Пространство имен: microsoft.graph

> **Важно:** Microsoft Graph API в /бета-версии могут изменяться; использование продукции не поддерживается.

> **Примечание.** API Microsoft Graph для Intune требует наличия [активной лицензии Intune](https://go.microsoft.com/fwlink/?linkid=839381) для клиента.

Параметр для триггера действийConfigurationManagerAction

## <a name="properties"></a>Свойства
|Свойство|Тип|Описание|
|:---|:---|:---|
|action|[configurationManagerActionType](../resources/intune-devices-configurationmanageractiontype.md)|Тип действия для запуска клиента Configuration Manager. Возможные значения: `refreshMachinePolicy`, `refreshUserPolicy`, `wakeUpClient`, `appEvaluation`, `quickScan`, `fullScan`, `windowsDefenderUpdateSignatures`.|

## <a name="relationships"></a>Связи
Нет

## <a name="json-representation"></a>Представление JSON
Ниже представлено описание ресурса в формате JSON.
<!-- {
  "blockType": "resource",
  "@odata.type": "microsoft.graph.configurationManagerAction"
}
-->
``` json
{
  "@odata.type": "#microsoft.graph.configurationManagerAction",
  "action": "String"
}
```




