Return-Path: <linux-tip-commits+bounces-3092-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA569F67E2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FD277A277B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAEB1DF27F;
	Wed, 18 Dec 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FiWnOfgu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dx5nIrtZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592961C3039;
	Wed, 18 Dec 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530604; cv=none; b=BiyTWBZ1OXt/TFRf/8Wt9F8+BagYqL5Lo6PjdEZh/gT7ODYPJGi6IqtyLd8ImT8UQM2+GPiP0KcgRGtiZVoSWwxsUNeWoeM84f2liMRt9I5sG0wuvcOniB6K/4t/eTWM1j9yU5yojrgmRGlQjLGJT9W7u88tv0Ek5Me5MnBh5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530604; c=relaxed/simple;
	bh=ei0elGZJBWBges7mCo30Yz7SwCZBuBbqPly+tjSdZtc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=TwxSCUd4pS5pWyGTi67oQCW3v5s8kozqaRBATQKbyUkRQ9jcgzgJllqwiNqtN0VRfvLAlKAzD/YdXauJp2uzU06kDpg1NYTG3/QnwFGJyNlq0qT2R+mCaIhHF5MGM0BgjoyOEVSKiedfbqp6GXQERUQCYzELe2zCrJ17nFm/VGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FiWnOfgu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dx5nIrtZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:03:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734530601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=klHvyv6suChEfJgfMFrKvAKHvhNJwgXvZuziD9+0GZA=;
	b=FiWnOfguQ+Sqf0Nbab4uFmVSqywT0NUZ2vX7I/XIiUQT8Ggu+U43s/j/mQWpSwkPymMGEk
	TC+mn8H1BZYuZXHAo/77XMYSY8wyCo88fx9hojr4SnhyRvOIkv+FrWC0eiOmEcRNpsfhbk
	LktQkRPSR1MvxYvDHiRUNQRcFOr3fe6EKQXIfkss0/4dbhpz/yUHX0zvdy1j7a0eClsk5l
	jwh9a1GOd87TyAaedwKxa4y6rTiuEdvyq1aF1dpwHyjbMoi5JPT9pS11VNMundVL/wpVlF
	c+i0Q4kS+ez/IuaK8k46bBDeiW5v0nbbbCXvT//4623+BDZcTF3nj4jq2s7YgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734530601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=klHvyv6suChEfJgfMFrKvAKHvhNJwgXvZuziD9+0GZA=;
	b=Dx5nIrtZFBaEXfonf+01guSop53hlbjUMbz/xTshenFb8iylN0l5gw8StWJsuB8yc82AO0
	5kH3ojmDEm9FwSAw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Refresh DCA leaf reading code
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453060085.7135.2826196679721506391.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     72bc3b77dda1d189fd468d684065c83b23872d33
Gitweb:        https://git.kernel.org/tip/72bc3b77dda1d189fd468d684065c83b23872d33
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:32 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 05:24:43 -08:00

x86/cpu: Refresh DCA leaf reading code

The DCA leaf number is also hard-coded in the CPUID level dependency
table. Move its definition to common code and use it.

While at it, fix up the naming and types in the probe code.  All
CPUID data is provided in 32-bit registers, not 'unsigned long'.
Also stop referring to "level_9".  Move away from test_bit()
because the type is no longer an 'unsigned long'.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/all/20241213205032.476A30FE%40davehans-spike.ostc.intel.com
---
 arch/x86/include/asm/cpuid.h | 3 ++-
 arch/x86/kernel/cpu/common.c | 2 +-
 drivers/dma/ioat/dca.c       | 8 +++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 13ecab9..8ba4d9f 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -21,7 +21,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
-#define CPUID_MWAIT_LEAF		5
+#define CPUID_MWAIT_LEAF	0x5
+#define CPUID_DCA_LEAF		0x9
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 853e373..5ffa1f4 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -638,7 +638,7 @@ struct cpuid_dependent_feature {
 static const struct cpuid_dependent_feature
 cpuid_dependent_features[] = {
 	{ X86_FEATURE_MWAIT,		CPUID_MWAIT_LEAF },
-	{ X86_FEATURE_DCA,		0x00000009 },
+	{ X86_FEATURE_DCA,		CPUID_DCA_LEAF },
 	{ X86_FEATURE_XSAVE,		0x0000000d },
 	{ 0, 0 }
 };
diff --git a/drivers/dma/ioat/dca.c b/drivers/dma/ioat/dca.c
index 17f6b63..658ea2e 100644
--- a/drivers/dma/ioat/dca.c
+++ b/drivers/dma/ioat/dca.c
@@ -10,6 +10,8 @@
 #include <linux/interrupt.h>
 #include <linux/dca.h>
 
+#include <asm/cpuid.h>
+
 /* either a kernel change is needed, or we need something like this in kernel */
 #ifndef CONFIG_SMP
 #include <asm/smp.h>
@@ -58,11 +60,11 @@ static int dca_enabled_in_bios(struct pci_dev *pdev)
 {
 	/* CPUID level 9 returns DCA configuration */
 	/* Bit 0 indicates DCA enabled by the BIOS */
-	unsigned long cpuid_level_9;
+	u32 eax;
 	int res;
 
-	cpuid_level_9 = cpuid_eax(9);
-	res = test_bit(0, &cpuid_level_9);
+	eax = cpuid_eax(CPUID_DCA_LEAF);
+	res = eax & BIT(0);
 	if (!res)
 		dev_dbg(&pdev->dev, "DCA is disabled in BIOS\n");
 

