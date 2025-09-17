Return-Path: <linux-tip-commits+bounces-6667-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C724B7C476
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 13:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC55946369A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 09:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F15E342CBE;
	Wed, 17 Sep 2025 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LMYL9vL3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i8DrnvT+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3598D30BB9F;
	Wed, 17 Sep 2025 09:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101273; cv=none; b=hOOBQjW5sWAgNl5Q8zYvDPVedR7+pASpODRDht4O3hi4ScCeY+046MJkmQmjWS7CVqrfzEH5TZYWRtonlbk8u9/q56+1Bh5uQapBKNwMhzYu1do3zO8///hniPvMA8YFRYlozgdRViWdCfmtarKGIUPDJ48RDYt64Un1zt3X5A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101273; c=relaxed/simple;
	bh=m993Qocz9zrGo4BatPO0WcI1MyD/cp6xH7bT8LdwNUM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ZysU9Hafg8lOXKNLay5iKcVqfKDbbXTteCJJykyDLTm2cJESZX10IiW8mu9L4vjmtBgWD2gkGGcnY4IgRpdk5SAmbwazcqvjPZPGFQf67UdD/j6i1jMga75SxzzE1JuiSMT4XhlfsP5tFKjOdMCKVM0Y9WPU7acdHpRd3MROoS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LMYL9vL3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i8DrnvT+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 09:27:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758101269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tom8KzEXJzxJELzgD2heVLQjvqxQvGvmOShC29QIpYQ=;
	b=LMYL9vL3hNCUcmGVus7Wg1GPL5jDQksNYdgqYFzMq+XBWCFO8wvOl6A5QquOfZR4PeyaPr
	TYnm0XfnexoEd02g1FNrhC5ianjWN+Hi59aJfc7L7oPh71gplD4UXN7sX1jZrixT3XeXMj
	irmj6lkTcC3ZpjI3TbJzhtZF1g2898Ns/xWF5TWm2lhDkFNEzwjte5W65RjbMPi28M9Xi/
	1X3DpIPwkrvOOpdOznfwdMSCYzFs2T5kM5ldV/1C9jPxOM0+pjZoj5pcIp4jxQMfrUhqjv
	5g7h53yG4MJUsseqbtkJLLs0VkGNJfY8DPVyKJpSTM9ltKqs8/OHA+wV9fiHIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758101269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=tom8KzEXJzxJELzgD2heVLQjvqxQvGvmOShC29QIpYQ=;
	b=i8DrnvT+Fo6tHe7/PbG/AsgHD1N3zk6OfUmvX9XuF68abzpfty/JzBgx7ccws371lv90i5
	EtLlNXHAJm1A9rBw==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/cacheinfo: Simplify
 cacheinfo_amd_init_llc_id() using _cpuid4_info
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175810126833.709179.7236959380938455569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     af507c6951180ae5e5edb71f56a227ffdcc54f78
Gitweb:        https://git.kernel.org/tip/af507c6951180ae5e5edb71f56a227ffdcc=
54f78
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Thu, 21 Aug 2025 05:19:09=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Sep 2025 11:22:40 +02:00

x86/cpu/cacheinfo: Simplify cacheinfo_amd_init_llc_id() using _cpuid4_info

struct _cpuid4_info has the same layout as the CPUID leaf 0x8000001d.
Use the encoded definition and amd_fill_cpuid4_info(), get_cache_id()
helpers instead of open coding masks and shifts to calculate the llc_id.

cacheinfo_amd_init_llc_id() is only called on AMD systems that support
X86_FEATURE_TOPOEXT and amd_fill_cpuid4_info() uses the information from
CPUID leaf 0x8000001d on all these systems which is consistent with the
current open coded implementation.

While at it, avoid reading  cpu_data() every time get_cache_id() is
called and instead pass the APIC ID necessary to return the
_cpuid4_info.id from get_cache_id().

No functional changes intended.

  [ bp: do what Ahmed suggests: merge into one patch, make id4 ptr
    const. ]

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://lore.kernel.org/20250821051910.7351-2-kprateek.nayak@amd.com
---
 arch/x86/kernel/cpu/cacheinfo.c | 48 ++++++++++++++------------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index adfa7e8..51a95b0 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -290,6 +290,22 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 }
=20
 /*
+ * The max shared threads number comes from CPUID(0x4) EAX[25-14] with input
+ * ECX as cache index. Then right shift apicid by the number's order to get
+ * cache id for this cache node.
+ */
+static unsigned int get_cache_id(u32 apicid, const struct _cpuid4_info *id4)
+{
+	unsigned long num_threads_sharing;
+	int index_msb;
+
+	num_threads_sharing =3D 1 + id4->eax.split.num_threads_sharing;
+	index_msb =3D get_count_order(num_threads_sharing);
+
+	return apicid >> index_msb;
+}
+
+/*
  * AMD/Hygon CPUs may have multiple LLCs if L3 caches exist.
  */
=20
@@ -312,18 +328,11 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, u=
16 die_id)
 		 * Newer families: LLC ID is calculated from the number
 		 * of threads sharing the L3 cache.
 		 */
-		u32 eax, ebx, ecx, edx, num_sharing_cache =3D 0;
 		u32 llc_index =3D find_num_cache_leaves(c) - 1;
+		struct _cpuid4_info id4 =3D {};
=20
-		cpuid_count(0x8000001d, llc_index, &eax, &ebx, &ecx, &edx);
-		if (eax)
-			num_sharing_cache =3D ((eax >> 14) & 0xfff) + 1;
-
-		if (num_sharing_cache) {
-			int index_msb =3D get_count_order(num_sharing_cache);
-
-			c->topo.llc_id =3D c->topo.apicid >> index_msb;
-		}
+		if (!amd_fill_cpuid4_info(llc_index, &id4))
+			c->topo.llc_id =3D get_cache_id(c->topo.apicid, &id4);
 	}
 }
=20
@@ -598,27 +607,12 @@ int init_cache_level(unsigned int cpu)
 	return 0;
 }
=20
-/*
- * The max shared threads number comes from CPUID(0x4) EAX[25-14] with input
- * ECX as cache index. Then right shift apicid by the number's order to get
- * cache id for this cache node.
- */
-static void get_cache_id(int cpu, struct _cpuid4_info *id4)
-{
-	struct cpuinfo_x86 *c =3D &cpu_data(cpu);
-	unsigned long num_threads_sharing;
-	int index_msb;
-
-	num_threads_sharing =3D 1 + id4->eax.split.num_threads_sharing;
-	index_msb =3D get_count_order(num_threads_sharing);
-	id4->id =3D c->topo.apicid >> index_msb;
-}
-
 int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci =3D this_cpu_ci->info_list;
 	u8 cpu_vendor =3D boot_cpu_data.x86_vendor;
+	u32 apicid =3D cpu_data(cpu).topo.apicid;
 	struct amd_northbridge *nb =3D NULL;
 	struct _cpuid4_info id4 =3D {};
 	int idx, ret;
@@ -628,7 +622,7 @@ int populate_cache_leaves(unsigned int cpu)
 		if (ret)
 			return ret;
=20
-		get_cache_id(cpu, &id4);
+		id4.id =3D get_cache_id(apicid, &id4);
=20
 		if (cpu_vendor =3D=3D X86_VENDOR_AMD || cpu_vendor =3D=3D X86_VENDOR_HYGON)
 			nb =3D amd_init_l3_cache(idx);

