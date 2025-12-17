Return-Path: <linux-tip-commits+bounces-7747-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A3741CC7AD3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58B603006726
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD5B348894;
	Wed, 17 Dec 2025 12:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ahaApgHL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NHYSNHse"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EED347FD8;
	Wed, 17 Dec 2025 12:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975096; cv=none; b=ZKB5CTsq7uCUZGPOLthoCLfSUBwjqjchpbWSoc2WLL0gJ2bpaQYuJ37h8Cj9fg0COZC2sNBiHra4klkednRHJdBv6mVcWgsuLnWIjv6KvHa6zbZTmADGOQbLN6QRZDIL2KHLNvxNZ8I3+5O8KgCEBVD9GaGzRDwraX2ehLCJDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975096; c=relaxed/simple;
	bh=Y6a0XzticXi/rks23NQAiILxXBzNjUMIfc64+9q17XM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SHbKUYxTGVe/fpbLz12GA0mvjPAZKaloXtADXbMZw4qkzpYeu35/bvv8AewqlweLxxvd1CmVXUDnTx3MOoiVSw8tLbShC5BSRJG9YyJckUSqvwu6NbF3Vqf4p/cgN9WfPgQlUgtKDHxmkVTB7H8bR5eB9apyW2TOLb8JWHLGd5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ahaApgHL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NHYSNHse; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV66hOXbjhyOjuXb40u7vQggXagrO0DPzbYkK2e6Rno=;
	b=ahaApgHL0fJkSKpADV1+kNaBXpvcWf1hXtGVYiQK0le0lbbzwIx0AxoM2J2UR+8+UefwLi
	ZFgXaQ6ln3G+qDeqa51eMRZwjUf1ABl1RwE1Wi1EFZYZt0FWtX1Vv4BRgjljde2E3PpbIP
	emrLseGwc2uRzXMqiJyZOQZ2BW5A7QlqOdDkm9I2vV6U5X5Mzlh3vgowsIjLzL5e6RJMd1
	AdZ8Sio1RPkoC1k4KXryirV9gnFKUW/qk8L3ybc9FGmFyjH+01B6Bd3KceXm5DiUenV8Ix
	gxIsmk1zGw8RakHpa3GMZU+R2fsBPzy2S+5FWDb2bUusB013JLd9+GYoY5HC5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV66hOXbjhyOjuXb40u7vQggXagrO0DPzbYkK2e6Rno=;
	b=NHYSNHse0i0EUqTMt4NEMRuZz27AAIVVPlhP/W1myszfOOCDuNvREEO4naVjL+Yc51SmbX
	XqZ1uXIYCF5yGdBQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf: Add APIs to load/put guest mediated PMU context
Cc: Sean Christopherson <seanjc@google.com>,
 Kan Liang <kan.liang@linux.intel.com>, Mingwei Zhang <mizhang@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Xudong Hao <xudong.hao@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251206001720.468579-8-seanjc@google.com>
References: <20251206001720.468579-8-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597509246.510.17927277797275133035.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     42457a7fb6cacca83be4deaf202ac3e45830daf2
Gitweb:        https://git.kernel.org/tip/42457a7fb6cacca83be4deaf202ac3e4583=
0daf2
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 05 Dec 2025 16:16:43 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:05 +01:00

perf: Add APIs to load/put guest mediated PMU context

Add exported APIs to load/put a guest mediated PMU context.  KVM will
load the guest PMU shortly before VM-Enter, and put the guest PMU shortly
after VM-Exit.

On the perf side of things, schedule out all exclude_guest events when the
guest context is loaded, and schedule them back in when the guest context
is put.  I.e. yield the hardware PMU resources to the guest, by way of KVM.

Note, perf is only responsible for managing host context.  KVM is
responsible for loading/storing guest state to/from hardware.

[sean: shuffle patches around, write changelog]
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Link: https://patch.msgid.link/20251206001720.468579-8-seanjc@google.com
---
 include/linux/perf_event.h |  2 +-
 kernel/events/core.c       | 61 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d9988e3..322cfa9 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1925,6 +1925,8 @@ extern u64 perf_event_pause(struct perf_event *event, b=
ool reset);
 #ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
 int perf_create_mediated_pmu(void);
 void perf_release_mediated_pmu(void);
+void perf_load_guest_context(void);
+void perf_put_guest_context(void);
 #endif
=20
 #else /* !CONFIG_PERF_EVENTS: */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6781d39..bbb81a4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -470,10 +470,19 @@ static cpumask_var_t perf_online_pkg_mask;
 static cpumask_var_t perf_online_sys_mask;
 static struct kmem_cache *perf_event_cache;
=20
+#ifdef CONFIG_PERF_GUEST_MEDIATED_PMU
+static DEFINE_PER_CPU(bool, guest_ctx_loaded);
+
+static __always_inline bool is_guest_mediated_pmu_loaded(void)
+{
+	return __this_cpu_read(guest_ctx_loaded);
+}
+#else
 static __always_inline bool is_guest_mediated_pmu_loaded(void)
 {
 	return false;
 }
+#endif
=20
 /*
  * perf event paranoia level:
@@ -6384,6 +6393,58 @@ void perf_release_mediated_pmu(void)
 	atomic_dec(&nr_mediated_pmu_vms);
 }
 EXPORT_SYMBOL_GPL(perf_release_mediated_pmu);
+
+/* When loading a guest's mediated PMU, schedule out all exclude_guest event=
s. */
+void perf_load_guest_context(void)
+{
+	struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_context);
+
+	lockdep_assert_irqs_disabled();
+
+	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);
+
+	if (WARN_ON_ONCE(__this_cpu_read(guest_ctx_loaded)))
+		return;
+
+	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
+	ctx_sched_out(&cpuctx->ctx, NULL, EVENT_GUEST);
+	if (cpuctx->task_ctx) {
+		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
+		task_ctx_sched_out(cpuctx->task_ctx, NULL, EVENT_GUEST);
+	}
+
+	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
+	if (cpuctx->task_ctx)
+		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
+
+	__this_cpu_write(guest_ctx_loaded, true);
+}
+EXPORT_SYMBOL_GPL(perf_load_guest_context);
+
+void perf_put_guest_context(void)
+{
+	struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_context);
+
+	lockdep_assert_irqs_disabled();
+
+	guard(perf_ctx_lock)(cpuctx, cpuctx->task_ctx);
+
+	if (WARN_ON_ONCE(!__this_cpu_read(guest_ctx_loaded)))
+		return;
+
+	perf_ctx_disable(&cpuctx->ctx, EVENT_GUEST);
+	if (cpuctx->task_ctx)
+		perf_ctx_disable(cpuctx->task_ctx, EVENT_GUEST);
+
+	perf_event_sched_in(cpuctx, cpuctx->task_ctx, NULL, EVENT_GUEST);
+
+	if (cpuctx->task_ctx)
+		perf_ctx_enable(cpuctx->task_ctx, EVENT_GUEST);
+	perf_ctx_enable(&cpuctx->ctx, EVENT_GUEST);
+
+	__this_cpu_write(guest_ctx_loaded, false);
+}
+EXPORT_SYMBOL_GPL(perf_put_guest_context);
 #else
 static int mediated_pmu_account_event(struct perf_event *event) { return 0; }
 static void mediated_pmu_unaccount_event(struct perf_event *event) {}

