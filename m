Return-Path: <linux-tip-commits+bounces-6339-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EABB33C84
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0FDA1895A92
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FE52DA758;
	Mon, 25 Aug 2025 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vbqZNZUJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b765i0nq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600692D7395;
	Mon, 25 Aug 2025 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117470; cv=none; b=RYSwOrBRXT8FxQBE1hh0arbqRhjm5fsJHb1Dfi7Abr8+XsjFgJY5wrRuTXkXtG77FLGlf10UvZczkAaF6A6OMixIYSTSnIF3rH6Q3yYoIWwuUTVRyEcKz7lbW41NSBre39wJ7psxDjgVR2F/c26keZihMDQ1VA6nhBctXBOHqBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117470; c=relaxed/simple;
	bh=Gy9RWe2I3O4vuxP7cSLY4C0WbOZsMEjxgVxwf0iTEKo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LgYgci1Egh3yKoDe2PuluN/FcBBF3OrsG3V09C9Mj5+9j5yzqZy+o7pvQCjvdvODDhlehzjelhA94OXArqFQ4Z4JXz8QboMyRmaee7kGLjQNJFaG2uZkAmSIFjeNEkswrHhGX08JdjOsynkvAe1spiFdo0ULjDbrsEknFZkUoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vbqZNZUJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b765i0nq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzeYs5klCNuWtqWNE9WKaCYnMAUwwhChJ19pwd+gWOU=;
	b=vbqZNZUJEjp3VMzu2fd/qfkJARDZcF7Dz8CQ3IV4wNQUEahEPUqyXfBamS+ipWqdjHV6U9
	QkUzUlWA5nVJbBT+y4IWu7u8b2otPdLGVwXtkiB3dz0nICH/So5xDcoaBGDyAtqJtrsK2J
	NhHoVxSA+Msw8gxAtW2wbErOXsID1rYJRbbtE5GHP8eW/mqEF1zTmLw+E8WBWadkIht5iM
	fGzi+qxL6FMh6bCi5waCV004WuT0Zgrc/9WfiPRN62KTm63hqu6jEwExWnFOf/0iyqJJJ5
	g0sj1RyGv5S1rz4vW9zrJyqLcHbPu9fUPbyba37IKjMnK0BPdk9GjjjJIru93Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZzeYs5klCNuWtqWNE9WKaCYnMAUwwhChJ19pwd+gWOU=;
	b=b765i0nqQAB6pKMst3OMQpMFDoj0ySnnNbJASn9td/1PTnAyv8C6LwkwBUJxBBraOe1Bxu
	zhQlxEr+FMgkStCw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into
 INTEL_FIXED_BITS_MASK
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Yi Lai <yi1.lai@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250820023032.17128-7-dapeng1.mi@linux.intel.com>
References: <20250820023032.17128-7-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611746491.1420.3927180463060441981.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2676dbf9f4fb7f6739d1207c0f1deaf63124642a
Gitweb:        https://git.kernel.org/tip/2676dbf9f4fb7f6739d1207c0f1deaf6312=
4642a
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 20 Aug 2025 10:30:31 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:27 +02:00

perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into INTEL_FIXED_BITS_MASK

ICL_FIXED_0_ADAPTIVE is missed to be added into INTEL_FIXED_BITS_MASK,
add it.

With help of this new INTEL_FIXED_BITS_MASK, intel_pmu_enable_fixed() can
be optimized. The old fixed counter control bits can be unconditionally
cleared with INTEL_FIXED_BITS_MASK and then set new control bits base on
new configuration.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
Link: https://lore.kernel.org/r/20250820023032.17128-7-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c      | 10 +++-------
 arch/x86/include/asm/perf_event.h |  6 +++++-
 arch/x86/kvm/pmu.h                |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f88a99d..28f5468 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2845,8 +2845,8 @@ static void intel_pmu_enable_fixed(struct perf_event *e=
vent)
 {
 	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc =3D &event->hw;
-	u64 mask, bits =3D 0;
 	int idx =3D hwc->idx;
+	u64 bits =3D 0;
=20
 	if (is_topdown_idx(idx)) {
 		struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
@@ -2885,14 +2885,10 @@ static void intel_pmu_enable_fixed(struct perf_event =
*event)
=20
 	idx -=3D INTEL_PMC_IDX_FIXED;
 	bits =3D intel_fixed_bits_by_idx(idx, bits);
-	mask =3D intel_fixed_bits_by_idx(idx, INTEL_FIXED_BITS_MASK);
-
-	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip) {
+	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip)
 		bits |=3D intel_fixed_bits_by_idx(idx, ICL_FIXED_0_ADAPTIVE);
-		mask |=3D intel_fixed_bits_by_idx(idx, ICL_FIXED_0_ADAPTIVE);
-	}
=20
-	cpuc->fixed_ctrl_val &=3D ~mask;
+	cpuc->fixed_ctrl_val &=3D ~intel_fixed_bits_by_idx(idx, INTEL_FIXED_BITS_MA=
SK);
 	cpuc->fixed_ctrl_val |=3D bits;
 }
=20
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_ev=
ent.h
index f8247ac..49a4d44 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -35,7 +35,6 @@
 #define ARCH_PERFMON_EVENTSEL_EQ			(1ULL << 36)
 #define ARCH_PERFMON_EVENTSEL_UMASK2			(0xFFULL << 40)
=20
-#define INTEL_FIXED_BITS_MASK				0xFULL
 #define INTEL_FIXED_BITS_STRIDE			4
 #define INTEL_FIXED_0_KERNEL				(1ULL << 0)
 #define INTEL_FIXED_0_USER				(1ULL << 1)
@@ -48,6 +47,11 @@
 #define ICL_EVENTSEL_ADAPTIVE				(1ULL << 34)
 #define ICL_FIXED_0_ADAPTIVE				(1ULL << 32)
=20
+#define INTEL_FIXED_BITS_MASK					\
+	(INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |		\
+	 INTEL_FIXED_0_ANYTHREAD | INTEL_FIXED_0_ENABLE_PMI |	\
+	 ICL_FIXED_0_ADAPTIVE)
+
 #define intel_fixed_bits_by_idx(_idx, _bits)			\
 	((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
=20
diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
index ad89d0b..103604c 100644
--- a/arch/x86/kvm/pmu.h
+++ b/arch/x86/kvm/pmu.h
@@ -13,7 +13,7 @@
 #define MSR_IA32_MISC_ENABLE_PMU_RO_MASK (MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL =
|	\
 					  MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
=20
-/* retrieve the 4 bits for EN and PMI out of IA32_FIXED_CTR_CTRL */
+/* retrieve a fixed counter bits out of IA32_FIXED_CTR_CTRL */
 #define fixed_ctrl_field(ctrl_reg, idx) \
 	(((ctrl_reg) >> ((idx) * INTEL_FIXED_BITS_STRIDE)) & INTEL_FIXED_BITS_MASK)
=20

