Return-Path: <linux-tip-commits+bounces-3575-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CE2A3F804
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 16:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8BBB16C531
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF8C208962;
	Fri, 21 Feb 2025 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aPWYnMyu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r8Y39V+2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1F474BED;
	Fri, 21 Feb 2025 15:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150489; cv=none; b=emY/zE8L3csYhFNcYs9Z56GV0xlB60Bx3nUOgFMUcgjktxNwEy98jEXUVRUc3jwToYiaAfS2RgRRogUUtGMSW9yzlmVulXgP7xv0PAjDCnoNE/FmSgd9lE3qCjzdzsJd6p1nSGW4t0dphKTEKcXcpA10JuiJROYOIIxSouIj/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150489; c=relaxed/simple;
	bh=UoJLtFhgBEmILKuPV5PmWow2I7yrilaHeQwiz1VkK3Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S4/3XVOIL7vANOrrdc3RkUOIcpuNc/ESTxd1fDkw4A1fiyFbVq03tvaVhdjnG02wb1dZ6d37VKDMDfGuP6I1OA0EX8ZT+St3//tkS+Y4wGaSAfIydGRuObBL0T9/+V/XLTR3DuflIDOcUT6vb47vSxzwhW6gm2xQa1bIThDj+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aPWYnMyu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r8Y39V+2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 15:08:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740150486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xs+Lj91zAobjC8WIHkTSOdAdAbewkgnh8/JUyYEOlC0=;
	b=aPWYnMyuRf/fXxgBEOFXuNOTMVDrCGHOoJi4axgyRMDgCbyI77OBWIa4+j6vz5moOcSQJ6
	m/d9sAWN8ERZkW0iEsaEyx/vsDgG3LGvFrUwixW+yq6Hg9awNirvTYiasTmWynWFuBbLGa
	/YShY4O4D+2+zy+6ZMNZhCnjtadkbcxPgXRvrdR6bh3nXMKOEZJFJgklrifSPJSYLvRx5S
	g+t/sG+taJOhfCQPhu+s5h0NBAQbg4KgPr6PozwywBueAYJR4/EIQ9v3LVihFxQZSTaXIp
	oOdFiyqoe1gEAM8p/UlmoU8VBfpgHP8H0RnQn2xilVb+Dy9U9CFTcYE/v3+Pmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740150486;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xs+Lj91zAobjC8WIHkTSOdAdAbewkgnh8/JUyYEOlC0=;
	b=r8Y39V+2Ohc9nx/qihPobEnosm2t5iyi0PnjZkCCNaZsIa3z0fDZQyBxyVsArmxYC1MU0C
	O9/sCSxNDnUMKsDw==
From: "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/kcfi: Require FRED for FineIBT
Cc: Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250214192210.work.253-kees@kernel.org>
References: <20250214192210.work.253-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174015048551.10177.4353365227122906077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     f12315780faf1cbfe00991077a1e8c8e4c201f3b
Gitweb:        https://git.kernel.org/tip/f12315780faf1cbfe00991077a1e8c8e4c201f3b
Author:        Kees Cook <kees@kernel.org>
AuthorDate:    Fri, 14 Feb 2025 11:22:21 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 15:38:11 +01:00

x86/kcfi: Require FRED for FineIBT

With what appears to be an unavoidable pivot gadget always present in
the kernel (the entry code), FineIBT's lack of caller-side CFI hash
validation leaves it critically flawed:

  https://lore.kernel.org/linux-hardening/Z60NwR4w%2F28Z7XUa@ubun/ [1]

Require FRED for FineIBT:

  https://lore.kernel.org/linux-hardening/c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com/

(and probably should also require eXecute-Only memory too), and default
to kCFI when CFI is built in.

Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250214192210.work.253-kees@kernel.org
---
 arch/x86/Kconfig              |  9 +++++----
 arch/x86/include/asm/cfi.h    |  2 +-
 arch/x86/kernel/alternative.c |  4 +++-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 87198d9..754bcd6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2427,12 +2427,13 @@ config STRICT_SIGALTSTACK_SIZE
 
 config CFI_AUTO_DEFAULT
 	bool "Attempt to use FineIBT by default at boot time"
-	depends on FINEIBT
+	depends on FINEIBT && X86_FRED
 	default y
 	help
-	  Attempt to use FineIBT by default at boot time. If enabled,
-	  this is the same as booting with "cfi=auto". If disabled,
-	  this is the same as booting with "cfi=kcfi".
+	  Attempt to use FineIBT by default at boot time if supported
+	  and sensible for the hardware. If enabled, this is the same
+	  as booting with "cfi=auto". If disabled, this is the same as
+	  booting with "cfi=kcfi".
 
 source "kernel/livepatch/Kconfig"
 
diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 31d19c8..547377e 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -93,7 +93,7 @@
  *
  */
 enum cfi_mode {
-	CFI_AUTO,	/* FineIBT if hardware has IBT, otherwise kCFI */
+	CFI_AUTO,	/* FineIBT if hardware has IBT, FRED, and XOM */
 	CFI_OFF,	/* Taditional / IBT depending on .config */
 	CFI_KCFI,	/* Optionally CALL_PADDING, IBT, RETPOLINE */
 	CFI_FINEIBT,	/* see arch/x86/kernel/alternative.c */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c71b575..42f8184 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1302,7 +1302,9 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 
 	if (cfi_mode == CFI_AUTO) {
 		cfi_mode = CFI_KCFI;
-		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
+		/* FineIBT requires IBT and will only be safe with FRED */
+		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT) &&
+		    cpu_feature_enabled(X86_FEATURE_FRED))
 			cfi_mode = CFI_FINEIBT;
 	}
 

