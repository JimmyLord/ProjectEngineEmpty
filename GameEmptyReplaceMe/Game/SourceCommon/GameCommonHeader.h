//
// Copyright (c) 2012-2016 Jimmy Lord http://www.flatheadgames.com
//
// This software is provided 'as-is', without any express or implied warranty.  In no event will the authors be held liable for any damages arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.

#ifndef __GameCommonHeader_H__
#define __GameCommonHeader_H__

#include "../../../Framework/MyFramework/SourceCommon/CommonHeader.h"
#include "../../../Engine/MyEngine/SourceCommon/EngineCommonHeader.h"

#include "GameComponents/ComponentInputTrackMousePos.h"
#include "GameComponents/ComponentAIChasePlayer.h"

#include "Core/GameComponentTypeManager.h"
#include "Core/GameEmptyReplaceMe.h"

#if MYFW_USING_WX
#include "Core/GameMainFrame.h"
#endif

#endif //__GameCommonHeader_H__
