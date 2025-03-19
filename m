Return-Path: <linux-tip-commits+bounces-4343-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821CDA68A97
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A1487ACBDE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144825744F;
	Wed, 19 Mar 2025 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZzC6nqN8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQNb4jLn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46BC256C69;
	Wed, 19 Mar 2025 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382223; cv=none; b=pnfInnPETjjGWGP/LKUCfv79zGhymU489a7WF2d2jFNN43q9nlDEHlmvLPgMRlLbMPaXGHfGRDdtQ252x1HBQWk8C+gczuU0jRCTTq7TPzo/7F0jk6LKMgl/5GJFB8k4s3/qC2UKjJnXWUoCCzTYWOpHwwZEAMjLn5emLK17Wqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382223; c=relaxed/simple;
	bh=EbMTnIAN0hQyN0V/hhJN4tsD6XQoKX4WL3DOn6Qwkhg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=njRzVcfvq0zwF9UBjp6Q5nTG36Tl0bqdwEHii3L0Pn7KTH8La36fOeUe7/nqRH00y5Op5LR5mNj9Ji7VaJp0GwaQPjvFULFO6vrvkLDqmrfPUgIgLNn1dM4uUPosB82ktT8xiGUbsVnA1GLX9zvwao5rl5vLB06ry6FabAugv+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZzC6nqN8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQNb4jLn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPLVIlc2UdlGkXvGysS06IABjkXlUERe8y/YYAgJpI0=;
	b=ZzC6nqN8+rhB02MqGPgkqHieR15bMw00f8I5hTxj5gKKCHe3uvAcyndVOOlBU9OItZXHOi
	x7T0wTFtCVO4LYzzUovzTbZAP28cXf7p0naoQcB8q7GA7l0ncjmxHolKMUaq5xEN04JGLD
	9+CyCT2UcLDNuXCeNCLDeXZVpzr0zM+3IZ2LABp+mIuzyfxE7VN8P9Z8dt3Gfl2Y++DvkS
	yX7q+vQMWk2Zds44GcayZTcXQGGIhWrfaWlZtyV+VJfYX5/sHnz60UXFL27rFwoYdkGLSc
	Df6BfjLj+6AhT5cM32pJFFsA8QhwR8gKTGmDbhGf5YM16o5yfK3cdoHreHTIvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPLVIlc2UdlGkXvGysS06IABjkXlUERe8y/YYAgJpI0=;
	b=GQNb4jLn6Oyhl5RUdnNCv/NyjbqChpaNwOwIDjein2f4GcbRB+lkLVzFbWxvCWXolti4Ra
	fuUfKLCdlS+IteDQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/smpboot: Remove confusing quirk usage in INIT delay
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-10-sohil.mehta@intel.com>
References: <20250219184133.816753-10-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238221971.14745.7824621332147536392.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     58d1c1fd0319d00e83f58f2a195847e189e447ce
Gitweb:        https://git.kernel.org/tip/58d1c1fd0319d00e83f58f2a195847e189e447ce
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:27 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:48 +01:00

x86/smpboot: Remove confusing quirk usage in INIT delay

Very old multiprocessor systems required a 10 msec delay between
asserting and de-asserting INIT but modern processors do not require
this delay.

Over time the usage of the "quirk" wording while setting the INIT delay
has become misleading. The code comments suggest that modern processors
need to be quirked, which clears the default init_udelay of 10 msec,
while legacy processors don't need the quirk and continue to use the
default init_udelay.

With a lot more modern processors, the wording should be inverted if at
all needed. Instead, simplify the comments and the code by getting rid
of "quirk" usage altogether and clarifying the following:

  - Old legacy processors -> Set the "legacy" 10 msec delay
  - Modern processors     -> Do not set any delay

No functional change.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250219184133.816753-10-sohil.mehta@intel.com
---
 arch/x86/kernel/smpboot.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 42ca131..5e586f5 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -635,10 +635,9 @@ static void impress_friends(void)
  * But that slows boot and resume on modern processors, which include
  * many cores and don't require that delay.
  *
- * Cmdline "init_cpu_udelay=" is available to over-ride this delay.
- * Modern processor families are quirked to remove the delay entirely.
+ * Cmdline "cpu_init_udelay=" is available to override this delay.
  */
-#define UDELAY_10MS_DEFAULT 10000
+#define UDELAY_10MS_LEGACY 10000
 
 static unsigned int init_udelay = UINT_MAX;
 
@@ -650,7 +649,7 @@ static int __init cpu_init_udelay(char *str)
 }
 early_param("cpu_init_udelay", cpu_init_udelay);
 
-static void __init smp_quirk_init_udelay(void)
+static void __init smp_set_init_udelay(void)
 {
 	/* if cmdline changed it from default, leave it alone */
 	if (init_udelay != UINT_MAX)
@@ -664,7 +663,7 @@ static void __init smp_quirk_init_udelay(void)
 		return;
 	}
 	/* else, use legacy delay */
-	init_udelay = UDELAY_10MS_DEFAULT;
+	init_udelay = UDELAY_10MS_LEGACY;
 }
 
 /*
@@ -1075,7 +1074,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 
 	uv_system_init();
 
-	smp_quirk_init_udelay();
+	smp_set_init_udelay();
 
 	speculative_store_bypass_ht_init();
 

