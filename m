Return-Path: <linux-tip-commits+bounces-6642-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC874B5935C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 12:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4398A177244
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 10:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA84304BB6;
	Tue, 16 Sep 2025 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3hu8Vzm6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wixQEJax"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C13043A0;
	Tue, 16 Sep 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018102; cv=none; b=Cq3v+krM1fjmlpRcCl4LcfLBe+H4F1fHqljyABFoAJta6UZFb5PdL1FWatXmOZCzgetj5RtcouXbFsCorxzTHnj9++ZPYjAlN3f2qRzG4JU+4eiUbwwPOexeTnj5jXEcgHPQ78lpjjzK4HJwqSaAYuUpRrY6N7SmZarfsuxqEq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018102; c=relaxed/simple;
	bh=FBsV0ucF33I59aGGjd8x+Kfu0n/CeSXIy7c44tyIe8U=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hIsVaFodqAb/sXBjikNPkTXd41gFJxmXE8slL7UVWoA1NH8VyQPPe77ruQ0VNk+UgqFLzofnuQic2wtUf04+i4dMefq8tF6j2hPYwVWNis7xBFCvsETu9/vtfkeDwxbT8zykFzgXdFYRdTd7cYRNjdVEwS7LdiNXgrHVtqebVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3hu8Vzm6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wixQEJax; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 10:21:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758018098;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=NUJGY7rKR/eiZTmIVRRCn+DztTStEzcFTUQs9CvEIAg=;
	b=3hu8Vzm6duB8OHqLB5wxnON3Ty4snYotwHEz0HRPo9lYOFVrDtsZjHLT5Q3Ug5L6vzirVN
	DTixwtp1BvqihiTb5rnPjSS+/DscE4yCm6EBmsfpkpiAYlxmVNRki+8cGvBVNx3SvAUCb4
	3Q7cGLAussiMgybN9sYns7d0sTTzWq3dLyysCHTmhsOFYXgwuDuToHUCvpvJMPTNk7Nmnx
	3iyPvNV+EWDt++am8jBOgODuF6wlttl+HJ0UD0pnGkNhlHPscWFcw4re7wlCkSpRjQX6IL
	gE6DsC+XMj2PgYctboRlwXH2/eQ9aQXOMM3Wv8qDC8tZrT8cXYdWdYhI0gPF/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758018098;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=NUJGY7rKR/eiZTmIVRRCn+DztTStEzcFTUQs9CvEIAg=;
	b=wixQEJaxQ2MGvsxzConmKXL8y4qFr13VedSPtoySCO0al/F10D4EnkoI534EGjtoHs6SRs
	jMVR0U7hbgwYzhBA==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/cacheinfo: Simplify
 cacheinfo_amd_init_llc_id() using _cpuid4_info
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175801809747.709179.2215536198367002321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     66765d17b06f3479ebbb7dd3341701af4594afb2
Gitweb:        https://git.kernel.org/tip/66765d17b06f3479ebbb7dd3341701af459=
4afb2
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Thu, 21 Aug 2025 05:19:09=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 14:23:23 +02:00

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

