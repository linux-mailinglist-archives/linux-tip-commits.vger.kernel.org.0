Return-Path: <linux-tip-commits+bounces-7745-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E19C3CC7D68
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 14:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E429C30842B1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2BB347FEC;
	Wed, 17 Dec 2025 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RmdEvxls";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u9u7kloG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4742A346ADE;
	Wed, 17 Dec 2025 12:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975095; cv=none; b=ppseFawsgbAP7BsNaJ+kuHkagWmSrK8bEtrUSKZFUZjYGPKfcxLjOJ8n+9Dh2wgQgx6zhYm+RyZVp7MSmwUVMHiLu/8OtlylmsC+HS6SUfqP+n0uByzI9vxF3Jei13bZGXw9VCO3dtOJ7nGwTmQdXhgu/7rpY/jcshXZqbaNMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975095; c=relaxed/simple;
	bh=sFxUVTsEtAY+sVf3s+yAiNy6PMb4DKdriYzNVqCt5+I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=toC3Gcj9BpPRZgJr+BnQwAa+Xwy83q0MtOlSO7i//BCwIlp157HvHw9hL4AT40U5XF4m1Pj77TrWuvqX8TWCrgFVn8m/hJT+OU3ZCSDdNdiseJVjf4Bc4xI3fgm2zMfWBtZk/gkUoe9pODBkIb8ykV1OJgRZVdUPtlyfT2HQ13Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RmdEvxls; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u9u7kloG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1Q1iW7Hlm2ePFtWIatSHTPNI3TvjkA/cJhDB1zxdsg=;
	b=RmdEvxls9VTdwlqezC00TU+6LkAuQJVEjiSMydQwEo5it9h2YUKmXWzjf/hdNEvtzAL50h
	NRchT4E9jlHhssuVD0ksd9QmS6E3oDKpLd83Nlf6FClEb0yJ8rNwQ+VQC9t9EEWgsRItlV
	+duSYeKTCmuiUWbtXNEGmab/of4l4FWYlS3XJxQg00oDNoqNXq4d4Bz11IWqZr0lgQfadl
	TIJjbxcn5LCLnPyJ8meV08XTuo2iQhtO57M04gA1gL4UQKX/s4VrkH7QDYBNdr/K91t/SG
	FVMWt0b1xbwBuENJ66b8lR6nbjR+WlWHNQ0ELO8dlk9LOUh2Qe3j7LoDfUD1rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v1Q1iW7Hlm2ePFtWIatSHTPNI3TvjkA/cJhDB1zxdsg=;
	b=u9u7kloGtKE7KWGEI7ZUSy8p61XIed6UicIAo1/jsIobku0z9BMLLO5SMu0sQpXvgCZmcD
	/VyiZlu+l8LzzRBQ==
From: "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/core: Add APIs to switch to/from mediated
 PMI vector (for KVM)
Cc: Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251206001720.468579-10-seanjc@google.com>
References: <20251206001720.468579-10-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597509052.510.14093474392552645208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     560ac136f25da2da44a8b68d581adfdc8230b7e2
Gitweb:        https://git.kernel.org/tip/560ac136f25da2da44a8b68d581adfdc823=
0b7e2
Author:        Sean Christopherson <seanjc@google.com>
AuthorDate:    Fri, 05 Dec 2025 16:16:45 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:06 +01:00

perf/x86/core: Add APIs to switch to/from mediated PMI vector (for KVM)

Add APIs (exported only for KVM) to switch PMIs to the dedicated mediated
PMU IRQ vector when loading guest context, and back to perf's standard NMI
when the guest context is put.  I.e. route PMIs to
PERF_GUEST_MEDIATED_PMI_VECTOR when the guest context is active, and to
NMIs while the host context is active.

While running with guest context loaded, ignore all NMIs (in perf).  Any
NMI that arrives while the LVTPC points at the mediated PMU IRQ vector
can't possibly be due to a host perf event.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251206001720.468579-10-seanjc@google.com
---
 arch/x86/events/core.c            | 32 ++++++++++++++++++++++++++++++-
 arch/x86/include/asm/perf_event.h |  5 +++++-
 2 files changed, 37 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0c38a31..3ad5c65 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -56,6 +56,8 @@ DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) =3D {
 	.pmu =3D &pmu,
 };
=20
+static DEFINE_PER_CPU(bool, guest_lvtpc_loaded);
+
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DEFINE_STATIC_KEY_FALSE(rdpmc_always_available_key);
 DEFINE_STATIC_KEY_FALSE(perf_is_hybrid);
@@ -1760,6 +1762,25 @@ void perf_events_lapic_init(void)
 	apic_write(APIC_LVTPC, APIC_DM_NMI);
 }
=20
+#ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
+void perf_load_guest_lvtpc(u32 guest_lvtpc)
+{
+	u32 masked =3D guest_lvtpc & APIC_LVT_MASKED;
+
+	apic_write(APIC_LVTPC,
+		   APIC_DM_FIXED | PERF_GUEST_MEDIATED_PMI_VECTOR | masked);
+	this_cpu_write(guest_lvtpc_loaded, true);
+}
+EXPORT_SYMBOL_FOR_MODULES(perf_load_guest_lvtpc, "kvm");
+
+void perf_put_guest_lvtpc(void)
+{
+	this_cpu_write(guest_lvtpc_loaded, false);
+	apic_write(APIC_LVTPC, APIC_DM_NMI);
+}
+EXPORT_SYMBOL_FOR_MODULES(perf_put_guest_lvtpc, "kvm");
+#endif /* CONFIG_PERF_GUEST_MEDIATED_PMU */
+
 static int
 perf_event_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 {
@@ -1768,6 +1789,17 @@ perf_event_nmi_handler(unsigned int cmd, struct pt_reg=
s *regs)
 	int ret;
=20
 	/*
+	 * Ignore all NMIs when the CPU's LVTPC is configured to route PMIs to
+	 * PERF_GUEST_MEDIATED_PMI_VECTOR, i.e. when an NMI time can't be due
+	 * to a PMI.  Attempting to handle a PMI while the guest's context is
+	 * loaded will generate false positives and clobber guest state.  Note,
+	 * the LVTPC is switched to/from the dedicated mediated PMI IRQ vector
+	 * while host events are quiesced.
+	 */
+	if (this_cpu_read(guest_lvtpc_loaded))
+		return NMI_DONE;
+
+	/*
 	 * All PMUs/events that share this PMI handler should make sure to
 	 * increment active_events for their events.
 	 */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_ev=
ent.h
index 7276ba7..fb7b261 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -759,6 +759,11 @@ static inline void perf_events_lapic_init(void)	{ }
 static inline void perf_check_microcode(void) { }
 #endif
=20
+#ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
+extern void perf_load_guest_lvtpc(u32 guest_lvtpc);
+extern void perf_put_guest_lvtpc(void);
+#endif
+
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr, void *data=
);
 extern void x86_perf_get_lbr(struct x86_pmu_lbr *lbr);

