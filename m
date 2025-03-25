Return-Path: <linux-tip-commits+bounces-4504-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9FA6ECBE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960E53B7CAB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7432B253B64;
	Tue, 25 Mar 2025 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HWFJRkt+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aGYYVyu8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6B0255E20;
	Tue, 25 Mar 2025 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895392; cv=none; b=Uk6CN0TZ2CrcBcbfP1ZupBpdB6fJoM5D6Rxz3y4PkjKGfWyMbdlMUfL9BTlWuv2kmroKAYEolIETJxaUCd7u3Dy9NDCjwrlMec623Sp/TGKB44NBZi+aMK/UuwmHafWLuVe6fn2HRfL3DXJXm1v7W509ZEXMDpaIWocHQFFp8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895392; c=relaxed/simple;
	bh=DgIgqviyRCr0h9S5SdhO6w7uoP3QRasnu/9YmmH8m3o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SecyhNEHDU2NWAmhI7BV/8jl2CvhuQRDpJKCgv7w4Qcb0kSCJwtlymx/tGcYucbwTNSmdGozqUmRI2S5akkY50jEeGlel9o4pWJbPNqfUt801x2ZMPeJdVhxHtH3JL6Mz/tlXB1vzNcHEaTXksFTXjcu4vXzvzX/yWUyDo8ylT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HWFJRkt+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aGYYVyu8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCQD9Cdsbj+RKebz6g5IYNq88KLpgM5v/EkFODZ9V1k=;
	b=HWFJRkt+tSZ0IaqQUza1OWm4nZYSPPv3qUexvYAodxpIfLbz/VsW+UNYxKvIbuivgETU6I
	oJ7YArjasVuWaNPchoUp/ODrYYxY1/60SPuDD7SK7ViyDDoE5DpOeXCZqp8vqRjQvPzfKX
	8uumzYltAcLKhurKdBmR+TTrtaytA1x2vqLsAaeo0pSWbp6qhvB6V5hnI9FhxB6p1She/F
	rd0KBb49An7MX9FgBNK7KvXhaF0ynr3FihhRTX2M+Ot/zc+2Av7aNHEvx8SgaQk8P10x9l
	lfjFhv/wyoE1jtowNajpCKdEerMpcO9GjF5GqVOHZ9sC8iQZEC+WslLPZmMAtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCQD9Cdsbj+RKebz6g5IYNq88KLpgM5v/EkFODZ9V1k=;
	b=aGYYVyu8RmRgDAl8q2RCU1mXtH+0JIrv/LdEY0gNpgLof+dUOd059svbh4AL/IujWKx/gE
	GUFRFCZQUYziDkBA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Rename 'struct _cpuid4_info_regs' to
 'struct _cpuid4_info'
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-17-darwi@linutronix.de>
References: <20250324133324.23458-17-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289538837.14745.7392036326970289330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     eb1c7c08c5a8155d0d2d0a6c7fd741039b7287f1
Gitweb:        https://git.kernel.org/tip/eb1c7c08c5a8155d0d2d0a6c7fd741039b7287f1
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:49 +01:00

x86/cacheinfo: Rename 'struct _cpuid4_info_regs' to 'struct _cpuid4_info'

Parent commits decoupled amd_northbridge from _cpuid4_info_regs, moved
AMD L3 northbridge cache_disable_0/1 sysfs code to its own file, and
splitted AMD vs. Intel leaf 0x4 handling into:

    amd_fill_cpuid4_info()
    intel_fill_cpuid4_info()
    fill_cpuid4_info()

After doing all that, the "_cpuid4_info_regs" name becomes a mouthful.
It is also not totally accurate, as the structure holds cpuid4 derived
information like cache node ID and size -- not just regs.

Rename struct _cpuid4_info_regs to _cpuid4_info.  That new name also
better matches the AMD/Intel leaf 0x4 functions mentioned above.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-17-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 10a79d8..2aaa0f8 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -159,7 +159,7 @@ union _cpuid4_leaf_ecx {
 	u32 full;
 };
 
-struct _cpuid4_info_regs {
+struct _cpuid4_info {
 	union _cpuid4_leaf_eax eax;
 	union _cpuid4_leaf_ebx ebx;
 	union _cpuid4_leaf_ecx ecx;
@@ -295,7 +295,7 @@ static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 		(ebx->split.ways_of_associativity + 1) - 1;
 }
 
-static int cpuid4_info_fill_done(struct _cpuid4_info_regs *id4, union _cpuid4_leaf_eax eax,
+static int cpuid4_info_fill_done(struct _cpuid4_info *id4, union _cpuid4_leaf_eax eax,
 				 union _cpuid4_leaf_ebx ebx, union _cpuid4_leaf_ecx ecx)
 {
 	if (eax.split.type == CTYPE_NULL)
@@ -312,7 +312,7 @@ static int cpuid4_info_fill_done(struct _cpuid4_info_regs *id4, union _cpuid4_le
 	return 0;
 }
 
-static int amd_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+static int amd_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 {
 	union _cpuid4_leaf_eax eax;
 	union _cpuid4_leaf_ebx ebx;
@@ -327,7 +327,7 @@ static int amd_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
 }
 
-static int intel_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+static int intel_fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 {
 	union _cpuid4_leaf_eax eax;
 	union _cpuid4_leaf_ebx ebx;
@@ -339,7 +339,7 @@ static int intel_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
 	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
 }
 
-static int fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+static int fill_cpuid4_info(int index, struct _cpuid4_info *id4)
 {
 	u8 cpu_vendor = boot_cpu_data.x86_vendor;
 
@@ -476,7 +476,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 		 * parameters cpuid leaf to find the cache details
 		 */
 		for (i = 0; i < ci->num_leaves; i++) {
-			struct _cpuid4_info_regs id4 = {};
+			struct _cpuid4_info id4 = {};
 			int retval;
 
 			retval = intel_fill_cpuid4_info(i, &id4);
@@ -563,7 +563,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 }
 
 static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
-				    const struct _cpuid4_info_regs *id4)
+				    const struct _cpuid4_info *id4)
 {
 	struct cpu_cacheinfo *this_cpu_ci;
 	struct cacheinfo *ci;
@@ -620,7 +620,7 @@ static int __cache_amd_cpumap_setup(unsigned int cpu, int index,
 }
 
 static void __cache_cpumap_setup(unsigned int cpu, int index,
-				 const struct _cpuid4_info_regs *id4)
+				 const struct _cpuid4_info *id4)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci, *sibling_ci;
@@ -655,7 +655,7 @@ static void __cache_cpumap_setup(unsigned int cpu, int index,
 		}
 }
 
-static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info_regs *id4,
+static void ci_info_init(struct cacheinfo *ci, const struct _cpuid4_info *id4,
 			 struct amd_northbridge *nb)
 {
 	ci->id				= id4->id;
@@ -686,7 +686,7 @@ int init_cache_level(unsigned int cpu)
  * ECX as cache index. Then right shift apicid by the number's order to get
  * cache id for this cache node.
  */
-static void get_cache_id(int cpu, struct _cpuid4_info_regs *id4)
+static void get_cache_id(int cpu, struct _cpuid4_info *id4)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	unsigned long num_threads_sharing;
@@ -702,8 +702,8 @@ int populate_cache_leaves(unsigned int cpu)
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
 	u8 cpu_vendor = boot_cpu_data.x86_vendor;
-	struct _cpuid4_info_regs id4 = {};
 	struct amd_northbridge *nb = NULL;
+	struct _cpuid4_info id4 = {};
 	int idx, ret;
 
 	for (idx = 0; idx < this_cpu_ci->num_leaves; idx++) {

