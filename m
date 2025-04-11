Return-Path: <linux-tip-commits+bounces-4887-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CBBA8592B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 396977B9A8D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B585E278E4D;
	Fri, 11 Apr 2025 10:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NSxzTn3i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yB7YTYjG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49DC24DC6E;
	Fri, 11 Apr 2025 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365750; cv=none; b=Xa8wGop9ZV7Gkm1DrPbwboO4btiBDDHihoV7UXuG+124b+/v6Q3lfhIdEhV6bryVjHXuqoI7S9ttZnnDpggaSa5fzTJIJUROZgZGk+V/FNgLQTp26OwR1Sq77NmDdheBzRF5D0NlbCXhk8KFLLblWDuR0zN++UJBCwfp45QPv0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365750; c=relaxed/simple;
	bh=Y8dQt3OCyRKxQuzmRGIfaxgsURqYdMpUOav3QHrkh9g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QrZQPTq23LKhyZHEx4lObYD+B+cpKCD7Rk8ARttZQ4z4w77pzC8D4CNDKZJaNQcLWXnUaGogEqBXvEws4VxLgQT6I/iuCMhK889UQ2GP5QSQC72Undz0Ox8npjd2/FuRC2ujSS9UapqLWpwIoGYwuXkUTpYwdVjnVYmetnRMP2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NSxzTn3i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yB7YTYjG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0n7Y12cDwK/6TAocM/ciS8sBxtsNHNlt4HFUI0tP29k=;
	b=NSxzTn3iVrN63ms6qtMmvAmDDHaop66TxTaNYumBLSVS90JyH3+KaHRU/8sb9BXbXEW+VS
	8NBm/SVKxVXLptzlj9+K1I1VrGDUP/O/dD6KWBGEvw/0z8PbysSSg/exSgjS00P/nsR0xb
	cxD+ZgnHsgKPNNwC2cyeNuj/J4QpEwp/Y/w6BQ7Q8p/QVBI4E3H/LEnG+cD22ogL7n6n+p
	J6b9JJJB2PTtjt8Oq7D7ApjyVTmbMOao7pZ+LbIHbbuTesMRs2pm/9uZE/9b2kRyyN29WF
	Pun290RS5I7xZShYlMV76Pig+qoOOZmHZEaxpsKFNjvMPTLS6BWUUeda0VTSVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0n7Y12cDwK/6TAocM/ciS8sBxtsNHNlt4HFUI0tP29k=;
	b=yB7YTYjG7e2Wt8z8OihAc7toW761apQCmEhkMxaT5reXnjpoGzw4JTUrFrXbP/I4MO4MaW
	U+CcptlFwa/Z+hAw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cacheinfo: Standardize header files and CPUID references
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411070401.1358760-3-darwi@linutronix.de>
References: <20250411070401.1358760-3-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436574679.31282.15063931995307319462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     62e565273993ee47c82ca2975e65ce4bec3c3697
Gitweb:        https://git.kernel.org/tip/62e565273993ee47c82ca2975e65ce4bec3c3697
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Apr 2025 09:04:01 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:14:55 +02:00

x86/cacheinfo: Standardize header files and CPUID references

Reference header files using their canonical form <linux/cacheinfo.h>.

Standardize on CPUID(0xN), instead of CPUID(N), for all standard leaves.
This removes ambiguity and aligns them with their extended counterparts
like CPUID(0x8000001d).

References: 0dd09e215a39 ("x86/cacheinfo: Apply maintainer-tip coding style fixes")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/20250411070401.1358760-3-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 52727f8..cc7ae2b 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -3,9 +3,9 @@
  * x86 CPU caches detection and configuration
  *
  * Previous changes
- * - Venkatesh Pallipadi:		Cache identification through CPUID(4)
+ * - Venkatesh Pallipadi:		Cache identification through CPUID(0x4)
  * - Ashok Raj <ashok.raj@intel.com>:	Work with CPU hotplug infrastructure
- * - Andi Kleen / Andreas Herrmann:	CPUID(4) emulation on AMD
+ * - Andi Kleen / Andreas Herrmann:	CPUID(0x4) emulation on AMD
  */
 
 #include <linux/cacheinfo.h>
@@ -78,7 +78,7 @@ struct _cpuid4_info {
 	unsigned long size;
 };
 
-/* Map CPUID(4) EAX.cache_type to linux/cacheinfo.h types */
+/* Map CPUID(0x4) EAX.cache_type to <linux/cacheinfo.h> types */
 static const enum cache_type cache_type_map[] = {
 	[CTYPE_NULL]	= CACHE_TYPE_NOCACHE,
 	[CTYPE_DATA]	= CACHE_TYPE_DATA,
@@ -87,7 +87,7 @@ static const enum cache_type cache_type_map[] = {
 };
 
 /*
- * Fallback AMD CPUID(4) emulation
+ * Fallback AMD CPUID(0x4) emulation
  * AMD CPUs with TOPOEXT can just use CPUID(0x8000001d)
  *
  * @AMD_L2_L3_INVALID_ASSOC: cache info for the respective L2/L3 cache should
@@ -361,7 +361,7 @@ static void intel_cacheinfo_done(struct cpuinfo_x86 *c, unsigned int l3,
 {
 	/*
 	 * If llc_id is still unset, then cpuid_level < 4, which implies
-	 * that the only possibility left is SMT.  Since CPUID(2) doesn't
+	 * that the only possibility left is SMT.  Since CPUID(0x2) doesn't
 	 * specify any shared caches and SMT shares all caches, we can
 	 * unconditionally set LLC ID to the package ID so that all
 	 * threads share it.
@@ -376,7 +376,7 @@ static void intel_cacheinfo_done(struct cpuinfo_x86 *c, unsigned int l3,
 }
 
 /*
- * Legacy Intel CPUID(2) path if CPUID(4) is not available.
+ * Legacy Intel CPUID(0x2) path if CPUID(0x4) is not available.
  */
 static void intel_cacheinfo_0x2(struct cpuinfo_x86 *c)
 {
@@ -466,7 +466,7 @@ static bool intel_cacheinfo_0x4(struct cpuinfo_x86 *c)
 
 void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 {
-	/* Don't use CPUID(2) if CPUID(4) is supported. */
+	/* Don't use CPUID(0x2) if CPUID(0x4) is supported. */
 	if (intel_cacheinfo_0x4(c))
 		return;
 
@@ -474,7 +474,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 }
 
 /*
- * linux/cacheinfo.h shared_cpu_map setup, AMD/Hygon
+ * <linux/cacheinfo.h> shared_cpu_map setup, AMD/Hygon
  */
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 				    const struct _cpuid4_info *id4)
@@ -533,7 +533,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 }
 
 /*
- * linux/cacheinfo.h shared_cpu_map setup, Intel + fallback AMD/Hygon
+ * <linux/cacheinfo.h> shared_cpu_map setup, Intel + fallback AMD/Hygon
  */
 static void __cache_cpumap_setup(unsigned int cpu, int index,
 				 const struct _cpuid4_info *id4)
@@ -599,7 +599,7 @@ int init_cache_level(unsigned int cpu)
 }
 
 /*
- * The max shared threads number comes from CPUID(4) EAX[25-14] with input
+ * The max shared threads number comes from CPUID(0x4) EAX[25-14] with input
  * ECX as cache index. Then right shift apicid by the number's order to get
  * cache id for this cache node.
  */

