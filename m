Return-Path: <linux-tip-commits+bounces-4348-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E2A68AB4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 608EF88392E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF3C258CD9;
	Wed, 19 Mar 2025 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UoUew2dp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ad5lUKr3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822A257AC2;
	Wed, 19 Mar 2025 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382225; cv=none; b=fSfC+iQEPpuHvlfDr6XtnU9DpdZ4sHW7AEiOQwL3LXST2Zap/mP6YUqE0g1Ljk2pXlerT4wuX3lZokT0NOU9f+FXSxn6H+xMLHWqWshB9XB6mcCR/oIOFPyopCDi0NBYEWREFZKklltpuFVtEfHgnrNLCKIHy3HwfDzCwSHZMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382225; c=relaxed/simple;
	bh=5LIUsqcqlEu8aAjOqXe3zjK/BDRxda3PI0QyIr3HOwg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=StoxuqeG8z5pDRtnkwPjEm78I15VYrMZ+MmFd2lIkhJ/nYehsnlnv6pTAvUGFOsHAInKnbxhidlOEUkvDyCcRbGCbDl6/l6mt/b+oVodP0p+5aM6U8QJhOq37XKfXjwm1ELp09rGKvgOugeOMylDS9BKrMzwsQDHpv+r7i/EYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UoUew2dp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ad5lUKr3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c945eZaEeteDp93tq+2UhmXKZCDRc2x5oHfZhbRPsYc=;
	b=UoUew2dpBQzqwXFRaZE7jwYcTnfqkJYJi/7qmwapZMQVjG4vTfzI1/4C3+U5LqkGWnX+EX
	CqxD0W3+zVz5Tj6iAVzlSStuyQMsCR/xzywxyi9/ySzR7t+Unsy8wPSOC3jbzWtllGYw6k
	XLyy2QjZpqbexjlFR8eAHPu+ar7ku34gCaTZ9wAtuptSs7QKA2oi/VkLOApzZ9tP4ACLH9
	cU7RLSP5vmo63wYA/la79wEUhXO89Kal0v2xPMXYCFK6n6IB3bGE1gYSHKfdri17H+NzUX
	TUMQm/9cu4z3RXDcNh/QKIyl12HUlm2oa4J5OCkTXpph27WPPC9P6JIUIEfyQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382222;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c945eZaEeteDp93tq+2UhmXKZCDRc2x5oHfZhbRPsYc=;
	b=ad5lUKr3DqwR764SP48mEFGCgbOnZKaVwnoqWOAxCod9VI8Mz2E2asPEdPec795GhJFCi5
	2BFrqmx04jQmsLAA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu/intel: Replace Family 15 checks with VFM ones
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-7-sohil.mehta@intel.com>
References: <20250219184133.816753-7-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238222136.14745.7241896029857106686.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     fc866f247277894bf887cda01c010e1d98abcb86
Gitweb:        https://git.kernel.org/tip/fc866f247277894bf887cda01c010e1d98abcb86
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:24 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:43 +01:00

x86/cpu/intel: Replace Family 15 checks with VFM ones

Introduce names for some old pentium 4 models and replace the x86_model
checks with VFM ones.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250219184133.816753-7-sohil.mehta@intel.com
---
 arch/x86/include/asm/intel-family.h | 4 ++++
 arch/x86/kernel/cpu/intel.c         | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 58735bc..0108695 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -184,6 +184,10 @@
 /* Family 5 */
 #define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
 
+/* Family 15 - NetBurst */
+#define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
+#define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a49615f..42cebca 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -247,8 +247,8 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 #endif
 
 	/* CPUID workaround for 0F33/0F34 CPU */
-	if (c->x86 == 0xF && c->x86_model == 0x3
-	    && (c->x86_stepping == 0x3 || c->x86_stepping == 0x4))
+	if (c->x86_vfm == INTEL_P4_PRESCOTT &&
+	    (c->x86_stepping == 0x3 || c->x86_stepping == 0x4))
 		c->x86_phys_bits = 36;
 
 	/*
@@ -421,7 +421,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * P4 Xeon erratum 037 workaround.
 	 * Hardware prefetcher may cause stale data to be loaded into the cache.
 	 */
-	if ((c->x86 == 15) && (c->x86_model == 1) && (c->x86_stepping == 1)) {
+	if (c->x86_vfm == INTEL_P4_WILLAMETTE && c->x86_stepping == 1) {
 		if (msr_set_bit(MSR_IA32_MISC_ENABLE,
 				MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE_BIT) > 0) {
 			pr_info("CPU: C0 stepping P4 Xeon detected.\n");

