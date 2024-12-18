Return-Path: <linux-tip-commits+bounces-3087-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782089F67D7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74DC16B3B5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC491B043B;
	Wed, 18 Dec 2024 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EwZh5WIQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XbEmbleJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99EF19F41D;
	Wed, 18 Dec 2024 14:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530601; cv=none; b=gxy9gs74Uar/z2Z24XtxvzH2QjayWenGQgubZjfHwBJXm9HOef/x4oR6g54HUzERVwaOu7XP2VUwGT6oa1Mus5n7sm5+Y1RyW3rh0akZEDtGbmT0p0gs6T7NBe3rVfvnMccqTwGSt7trl3JgLwkRqbVKtAlnAAT+SyM1SJct8nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530601; c=relaxed/simple;
	bh=T7/F+9ptC2ZPX+yzK/ezsQwmdtHXHQbd0YvDGPb8HzU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=d69JbxrUeC75X+Y2Qg/CUojKCWGFP7JhAVCggU5q54/tXk8u+5bPxADdIEsWsNRiXh/bInDd8mzlumcFArHnZxez4uy7KcigoiYRi/SGu9loEPF58BXe1w7FVgaY/wr3rjw7UwcU0fnKUW6sU9Q6rWBuzHmVBMn25YTMWvyIk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EwZh5WIQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XbEmbleJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:03:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734530596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WxqrjWBdO+ksfvd9q5CF1Lifn/ZRbrmwIHC5EBZg5Tg=;
	b=EwZh5WIQyK2dsHMJR5XaPJ5NXIdKR2iGOOFnfMK/rNmoqq2GNurweshYoTmV9jBjTOkWyi
	hUZB073GyN2+BLpxOoO3QxRdj+tJKrZH+LuK4H2sAT47Fk6Roy5xrLqh50hbCFgzAa4yCO
	YFNxpY+N+1zh0m21lhz0u6ws91bVWV2sPvOfAq51nKe8s1n2y6j8bvk/VUTvI3nNE2QjC6
	0ES2soOeg1r6yF1ykXOvai9tNVrKFU4TuB+DSWir+q9NcUSQZErXSA7vc71dTg04Yh14Fj
	LWVsBXt5LbFzDghwaMbPPiw6DjatcaOLStOXFAmr7hfv93IyGGKs59URPEClpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734530596;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WxqrjWBdO+ksfvd9q5CF1Lifn/ZRbrmwIHC5EBZg5Tg=;
	b=XbEmbleJWIZNv/D87XXxQD7EOvwdPYYxcAT0xA/jAn6Px7KPOhi1jOFGl1p0bHHnkrZH7x
	2Q+9eXnzpHpW4MAQ==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/fpu: Remove unnecessary CPUID level check
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453059585.7135.6447480558100818200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     74ccf55c81c96e0674d7b66bae98dabbce589d57
Gitweb:        https://git.kernel.org/tip/74ccf55c81c96e0674d7b66bae98dabbce589d57
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:38 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 05:24:43 -08:00

x86/fpu: Remove unnecessary CPUID level check

The CPUID level dependency table will entirely zap X86_FEATURE_XSAVE
if the CPUID level is too low.  This code is unreachable.  Kill it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/all/20241213205038.6E71F9A4%40davehans-spike.ostc.intel.com
---
 arch/x86/kernel/fpu/xstate.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index bf38b3e..edacd34 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -764,11 +764,6 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
 		return;
 	}
 
-	if (boot_cpu_data.cpuid_level < XSTATE_CPUID) {
-		WARN_ON_FPU(1);
-		return;
-	}
-
 	/*
 	 * Find user xstates supported by the processor.
 	 */

