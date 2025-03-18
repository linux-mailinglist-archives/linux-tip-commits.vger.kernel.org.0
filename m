Return-Path: <linux-tip-commits+bounces-4309-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5655A67C53
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 19:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D020C16CEA7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 18:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6540D2135C5;
	Tue, 18 Mar 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nlu+b1cN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QFo7lu7q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7BA213232;
	Tue, 18 Mar 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324075; cv=none; b=Py75v3tnT5nrbORtbUeJ8Zj4ABnw4qZY/+TkyyOkNoRZjwRADkLFJkHWibOrqi1JsiJXPxeaLm1sltFIbadoPFV4xgrSHYajAMD5SGJNpjiB824QNLyAjbkrJyCsZ5C+IIcBrhosbEeMmx8S9mj8jw5ehecG+UjtgUlRvo8LlSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324075; c=relaxed/simple;
	bh=VUspO3yKYwD8NPxWbnYFz/zjvpvRGUw3f1HHLfDzjkw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Hqd4FrrVSUH7dTxZWcMiS4wEQT+y8GXa+MuBmitNCxIT9dDHetV/4n867kSzdZ5MDqglDUQfkR1ToMUayQW1+pssHiE0EfSQS2cFhK8CAo4VwrIvzL0Dv7VaEx+bBSiEK1bv7Vh8GUzsUkkyei4G7LIQGQ/8JBfuPz6YMjj0LY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nlu+b1cN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QFo7lu7q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 18:54:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742324071;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YnsToolJeEPblejyKvbztWKrWAD+IHTK79ghr9P+UM=;
	b=nlu+b1cNPleLWaSWgmHPBD/00sW+xLNMRjioalyXOKurkrJceEsCBG4M7DOu2BwZA7tRGL
	diwjBJpgccWS2gcKryobTvEUrsIQqpGfgkm2/EkPpndfZKMaOR6fCKP8vaUgkF26no2rOQ
	NO9DK+0Y8lJKEuHFd1dgRqNwUk125meGDPWtBKRwTItcVCzc4ujQWwCFuvoIGDjoIMe/p6
	Tqc43YGVT72RSuqTHXFdo5D60lneF2D5zk5hSo2kYSW8E0C3RbH/c0WZkiz77aSnf4zkDY
	muCpXbujmNGBBt0iJhVENkFBimm9TQlDbwNgtO8EMswSQ02UINA9AXM+7yrsWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742324071;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+YnsToolJeEPblejyKvbztWKrWAD+IHTK79ghr9P+UM=;
	b=QFo7lu7qzJuRwZx3B5LraM+39ueiFIRmAMRnEzDmFWB/cv8GXbXOfPMly4p9HZ9I21yL1y
	Xf8fyE0eCoJiGFBA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu/intel: Replace Family 5 model checks with VFM ones
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-8-sohil.mehta@intel.com>
References: <20250219184133.816753-8-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174232407072.14745.13324218248508971177.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     8aba98edb8701dad1f748205eb7a093d268f0d40
Gitweb:        https://git.kernel.org/tip/8aba98edb8701dad1f748205eb7a093d268f0d40
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:25 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 19:33:45 +01:00

x86/cpu/intel: Replace Family 5 model checks with VFM ones

Introduce names for some Family 5 models and convert some of the checks
to be VFM based.

Also, to keep the file sorted by family, move Family 5 to the top of the
header file.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250219184133.816753-8-sohil.mehta@intel.com
---
 arch/x86/include/asm/intel-family.h |  9 ++++++---
 arch/x86/kernel/cpu/intel.c         | 11 +++++------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 0108695..4296c8e 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -45,6 +45,12 @@
 /* Wildcard match so X86_MATCH_VFM(ANY) works */
 #define INTEL_ANY			IFM(X86_FAMILY_ANY, X86_MODEL_ANY)
 
+/* Family 5 */
+#define INTEL_FAM5_START		IFM(5, 0x00) /* Notational marker, also P5 A-step */
+#define INTEL_PENTIUM_75		IFM(5, 0x02) /* P54C */
+#define INTEL_PENTIUM_MMX		IFM(5, 0x04) /* P55C */
+#define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
+
 /* Family 6 */
 #define INTEL_PENTIUM_PRO		IFM(6, 0x01)
 #define INTEL_PENTIUM_II_KLAMATH	IFM(6, 0x03)
@@ -181,9 +187,6 @@
 #define INTEL_XEON_PHI_KNL		IFM(6, 0x57) /* Knights Landing */
 #define INTEL_XEON_PHI_KNM		IFM(6, 0x85) /* Knights Mill */
 
-/* Family 5 */
-#define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
-
 /* Family 15 - NetBurst */
 #define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
 #define INTEL_P4_PRESCOTT		IFM(15, 0x03)
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 42cebca..ae20f45 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -358,9 +358,8 @@ static void intel_smp_check(struct cpuinfo_x86 *c)
 	/*
 	 * Mask B, Pentium, but not Pentium MMX
 	 */
-	if (c->x86 == 5 &&
-	    c->x86_stepping >= 1 && c->x86_stepping <= 4 &&
-	    c->x86_model <= 3) {
+	if (c->x86_vfm >= INTEL_FAM5_START && c->x86_vfm < INTEL_PENTIUM_MMX &&
+	    c->x86_stepping >= 1 && c->x86_stepping <= 4) {
 		/*
 		 * Remember we have B step Pentia with bugs
 		 */
@@ -387,7 +386,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * The Quark is also family 5, but does not have the same bug.
 	 */
 	clear_cpu_bug(c, X86_BUG_F00F);
-	if (c->x86 == 5 && c->x86_model < 9) {
+	if (c->x86_vfm >= INTEL_FAM5_START && c->x86_vfm < INTEL_QUARK_X1000) {
 		static int f00f_workaround_enabled;
 
 		set_cpu_bug(c, X86_BUG_F00F);
@@ -435,7 +434,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * integrated APIC (see 11AP erratum in "Pentium Processor
 	 * Specification Update").
 	 */
-	if (boot_cpu_has(X86_FEATURE_APIC) && (c->x86<<8 | c->x86_model<<4) == 0x520 &&
+	if (boot_cpu_has(X86_FEATURE_APIC) && c->x86_vfm == INTEL_PENTIUM_75 &&
 	    (c->x86_stepping < 0x6 || c->x86_stepping == 0xb))
 		set_cpu_bug(c, X86_BUG_11AP);
 
@@ -612,7 +611,7 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
 	 * Intel Quark SoC X1000 contains a 4-way set associative
 	 * 16K cache with a 16 byte cache line and 256 lines per tag
 	 */
-	if ((c->x86 == 5) && (c->x86_model == 9))
+	if (c->x86_vfm == INTEL_QUARK_X1000)
 		size = 16;
 	return size;
 }

