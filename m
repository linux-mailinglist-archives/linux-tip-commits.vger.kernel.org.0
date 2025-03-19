Return-Path: <linux-tip-commits+bounces-4347-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390AAA68AB3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8DA4601D7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D682580FD;
	Wed, 19 Mar 2025 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hs2qWuou";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VU8ajGQW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEA25742D;
	Wed, 19 Mar 2025 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382224; cv=none; b=RkdxBTQH9cIAgr4AXINTTrvDsFJ1UJyc2IhYhB3f3qjH2a1yd/ms+V6Zweeqvruj9PlZb5bAWvaFVNXibdinSlnNYmwt2vOD87ik8b79us11PJpmuApy0yyseyr76mMjR6MSD/wr6krkzNcuzCXV24q7XXW+8RYsi8t4giHurI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382224; c=relaxed/simple;
	bh=os8NOVPZ6ASQ5TUg708arXtzu11aArT44L8Hj0n8Dvs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uhsGyXmHdLqNMdNwOVPUhmUfdXBVNxS/WMkOj79aSFhhPYhe5jW9qY88gRZGMsXx+imrUqlfln+Z4YmSkR2Hh6U10PzANGVO7SZ9q5hQb5zcbUDZWpX20eBh517qxIWxr/3lT4AWdD/sDynTj3DGimbG7s65L0hN1DtCS8hyZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hs2qWuou; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VU8ajGQW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAe/HYGZ5ehWszpDu/FJJJkmviayOokg81drPmcDnUI=;
	b=Hs2qWuou1qCd7rU8t616NSsMg/K46hJieXT51LsYQhAPd9iMeErSFeTuTmybdZAS0HPyQ+
	0PnvyWoZm9jj/S0uoOFc7YKRCnNLgzOQiu3KpqfLPmGa9t+xEQ6Mxy9Mw2ufteDKeGwiDr
	vXDdzCOSKWarxuwGSBtIaZzVlxYGvXuCoyEpQjyPr6/vwTMwPWlZhMMUu/unNxF9dtfF2X
	vJwcM9tXYCW+N/GrziK9GFmdtcYlA8f5mvPzZtrbvZQ6s26sI6EWekDwdSlmq5MaIdKo9c
	gld3Wj2Iq2wkXtwYsLALgftoyG85Vt2Q2IV0uvZLhs5dMqLhCGTnV4kmtnKMpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HAe/HYGZ5ehWszpDu/FJJJkmviayOokg81drPmcDnUI=;
	b=VU8ajGQWXkEw+gQScziok3yPfMXcOEQIoVB5CU5mWW+qDyUDRkjeKbq+bOXmln7lE8bSxX
	5flkfqbdSZoxNjCA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/core] x86/cpu/intel: Replace Family 5 model checks with VFM ones
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
Message-ID: <174238222081.14745.8426983772353917875.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     eb1ac3330573e0d6cb0f8dccde34112929fc1344
Gitweb:        https://git.kernel.org/tip/eb1ac3330573e0d6cb0f8dccde34112929fc1344
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:25 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:44 +01:00

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

