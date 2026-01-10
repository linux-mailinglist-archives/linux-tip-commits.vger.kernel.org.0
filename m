Return-Path: <linux-tip-commits+bounces-7856-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F402D0DC58
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6060302653E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF41C2D8DB0;
	Sat, 10 Jan 2026 19:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bjMOMRXe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ZgXkNi7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E72E719E;
	Sat, 10 Jan 2026 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074382; cv=none; b=aUYJiJI1SvZdlJGlY4SX7SHk2q9NC1TR8Egzj+MBs9N5H5nnVNgK2vvYG69Mdg/y+15c+1rbW/Pm2dgiQ17dKvUZ9FlFwAaVeVa2p3BYw0YWw0SYTIIHFZkTKB/BtiSlBe/roazinl0i9EtA9nK6LnkaZc2/LIbmQbM1+rQfiSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074382; c=relaxed/simple;
	bh=Vph+iZ9DJHzTx5OgAruXQsEC+CJRqwK7W2pb2DV9Fhw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=UAsYr7ug051DHZz50DYT4HLkkPoKFsyVKZQVXUbx23cZyv73zp15M5bszAkliTy43QT2laICAWYCqbZSWyQl7+je0XXMWjs1rjxanvCCxUeeTtbuFg1Xk6ysntM80F9yeTLGq2V4n2ZKs+EQSl+e5u8Yrxb+9F1u7DpT9pGrgvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bjMOMRXe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ZgXkNi7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:46:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074371;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YN7eOTTKdUH6qCmk5uq/Q3gGPWPDvXYRuJiUV/Fyv4c=;
	b=bjMOMRXeWyipXDR48CNFKr/mLZ6jQ89Cvn+IpH3xU9MuqHehcZXWk1bT5hRG1NAOkYj8Mu
	q8aL//jtboC4bfFnRiQNErYEWYKKlGquDaCbaPlM74jzIEocCozAdLrqEgGSr8uyjMKUwC
	+oWhdNHLuGZXFNBqsXFf/OkXvguqx+ME0rOY4kF+ed01a62hFFVQkZuvONBPcEFm9Becyf
	ARL2xZCQPrR/WmPS5CWDhyBsGg6KNRrXl2xQvIX6sk2ZeobX66QsRTdJNqVG/9tW7PndJB
	toAohBLUv3cfvKZ53kn2sXmWQfEVHEO21hbUG+yWYT5FG+QFXSXJbfymNQFh3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074371;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YN7eOTTKdUH6qCmk5uq/Q3gGPWPDvXYRuJiUV/Fyv4c=;
	b=2ZgXkNi7GpTRHXkt7RYb36UHkXSxoJlZktuzp4Z6aC6QjxEy3gd8opnN9acDnoz5PJlDDB
	Zs023R6K8v5Fn4Bw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86,fs/resctrl: Handle events that can be read from any CPU
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807437057.510.1186287662088486077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     ab0308aee3819a3eccde42f9eb5bb01d6733be38
Gitweb:        https://git.kernel.org/tip/ab0308aee3819a3eccde42f9eb5bb01d673=
3be38
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:20:58 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 05 Jan 2026 15:38:07 +01:00

x86,fs/resctrl: Handle events that can be read from any CPU

resctrl assumes that monitor events can only be read from a CPU in the
cpumask_t set of each domain.  This is true for x86 events accessed with an
MSR interface, but may not be true for other access methods such as MMIO.

Introduce and use flag mon_evt::any_cpu, settable by architecture, that
indicates there are no restrictions on which CPU can read that event.  This
flag is not supported by the L3 event reading that requires to be run on a CPU
that belongs to the L3 domain of the event being read.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c | 6 +++---
 fs/resctrl/ctrlmondata.c           | 6 ++++++
 fs/resctrl/internal.h              | 2 ++
 fs/resctrl/monitor.c               | 4 +++-
 include/linux/resctrl.h            | 2 +-
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index b3a2dc5..bd4a981 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -902,15 +902,15 @@ static __init bool get_rdt_mon_resources(void)
 	bool ret =3D false;
=20
 	if (rdt_cpu_has(X86_FEATURE_CQM_OCCUP_LLC)) {
-		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID);
+		resctrl_enable_mon_event(QOS_L3_OCCUP_EVENT_ID, false);
 		ret =3D true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
-		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID);
+		resctrl_enable_mon_event(QOS_L3_MBM_TOTAL_EVENT_ID, false);
 		ret =3D true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
-		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID);
+		resctrl_enable_mon_event(QOS_L3_MBM_LOCAL_EVENT_ID, false);
 		ret =3D true;
 	}
 	if (rdt_cpu_has(X86_FEATURE_ABMC))
diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index 7f9b2fe..2c69fcd 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -578,6 +578,11 @@ void mon_event_read(struct rmid_read *rr, struct rdt_res=
ource *r,
 		}
 	}
=20
+	if (evt->any_cpu) {
+		mon_event_count(rr);
+		goto out_ctx_free;
+	}
+
 	cpu =3D cpumask_any_housekeeping(cpumask, RESCTRL_PICK_ANY_CPU);
=20
 	/*
@@ -591,6 +596,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_reso=
urce *r,
 	else
 		smp_call_on_cpu(cpu, smp_mon_event_count, rr, false);
=20
+out_ctx_free:
 	if (rr->arch_mon_ctx)
 		resctrl_arch_mon_ctx_free(r, evt->evtid, rr->arch_mon_ctx);
 }
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index 86cf38a..fb0b6e4 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -61,6 +61,7 @@ static inline struct rdt_fs_context *rdt_fc2context(struct =
fs_context *fc)
  *			READS_TO_REMOTE_MEM) being tracked by @evtid.
  *			Only valid if @evtid is an MBM event.
  * @configurable:	true if the event is configurable
+ * @any_cpu:		true if the event can be read from any CPU
  * @enabled:		true if the event is enabled
  */
 struct mon_evt {
@@ -69,6 +70,7 @@ struct mon_evt {
 	char			*name;
 	u32			evt_cfg;
 	bool			configurable;
+	bool			any_cpu;
 	bool			enabled;
 };
=20
diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index 340b847..8c76ac1 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -518,6 +518,7 @@ static int __mon_event_count(struct rdtgroup *rdtgrp, str=
uct rmid_read *rr)
 {
 	switch (rr->r->rid) {
 	case RDT_RESOURCE_L3:
+		WARN_ON_ONCE(rr->evt->any_cpu);
 		if (rr->hdr)
 			return __l3_mon_event_count(rdtgrp, rr);
 		else
@@ -987,7 +988,7 @@ struct mon_evt mon_event_all[QOS_NUM_EVENTS] =3D {
 	},
 };
=20
-void resctrl_enable_mon_event(enum resctrl_event_id eventid)
+void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu)
 {
 	if (WARN_ON_ONCE(eventid < QOS_FIRST_EVENT || eventid >=3D QOS_NUM_EVENTS))
 		return;
@@ -996,6 +997,7 @@ void resctrl_enable_mon_event(enum resctrl_event_id event=
id)
 		return;
 	}
=20
+	mon_event_all[eventid].any_cpu =3D any_cpu;
 	mon_event_all[eventid].enabled =3D true;
 }
=20
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 79aaaab..22c5d07 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -412,7 +412,7 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
 u32 resctrl_arch_system_num_rmid_idx(void);
 int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
=20
-void resctrl_enable_mon_event(enum resctrl_event_id eventid);
+void resctrl_enable_mon_event(enum resctrl_event_id eventid, bool any_cpu);
=20
 bool resctrl_is_mon_event_enabled(enum resctrl_event_id eventid);
=20

