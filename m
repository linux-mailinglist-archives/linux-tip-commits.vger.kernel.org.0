Return-Path: <linux-tip-commits+bounces-7435-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCBDC76135
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 20:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E69894E44A1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 19:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788D0368E03;
	Thu, 20 Nov 2025 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gEs8dyyS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UH4q50XT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3159C368E08;
	Thu, 20 Nov 2025 19:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666583; cv=none; b=kjRXR6oHK7HIJAffCGx6loSzgYPY0Kqh8CrULVa8nGPazgV/1GQnc7YnWpWzNcIxDSv0g5+nshNR/WyR53C4Zntl8Nfph4QndRhMGtfmnC+vjbAbKj7PdWfnx3t5ATHIRnIrdMJgu/LImfOqNadIaBTRY0a2pEvH6OzbxkEzUuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666583; c=relaxed/simple;
	bh=zpXqagrE518F6d/h6doVsxiVUQvqWiquIr4/98BN4sg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eItfTSSQAZgaIGgtmH3r+Vfnhr+7vaLdJJunwUWlKan1YNVmRoH1abx46A0AJwLNhxa9Zn6qh2Mh6pFSCW/tgTSnm6OwcSIFvi28uX6BwkMXLGryvdxPyGQ2WA+V4pQlMQVWuGWcxFcinvTvo07A6Nybjlfhj0JtMlP6euDYyqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gEs8dyyS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UH4q50XT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 19:22:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763666578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rhRiiNfpQdZ0o0223YjQcjoU7fhHkF2oE9GbB2lvLU=;
	b=gEs8dyySGCBvJrTFieojDn7RUjzpCt/7I2+pvKs9Cil7q0Pw2NhnvRmksIkZUL6aOuWkiD
	3FJbQObIconedWVQ98LmZnQao094Dii9pc/hMLd/XUsSO3GH7fIsZnT9TPsW2aa+vFWzZU
	MDuXWJQYUqXGt8TXoMxnI4tmmTvkGc/mGrcJPRLJu8eNghiWjaUYqykghZOct3/Ug+6IqW
	0F6eCWO5lgCE2rwq3NBwwECn4B2iHu7ba/SRXwXCWeoprX1bn6l12qE5KPk+kcl41f0/JU
	aXyEOBV4Fs8ERxn4XclJs7MhAH8N3PGTX8ExRUPGCfUPS7Hoj49pXzf10iqsLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763666578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rhRiiNfpQdZ0o0223YjQcjoU7fhHkF2oE9GbB2lvLU=;
	b=UH4q50XTbUsf+WjXFO54vKzFBQr7hkHREfkVKuQD4c9duXBBiRuKt3E60dNMgOEVce//js
	IN8sEYcBLpDG4CDQ==
From: "tip-bot2 for Gabriele Monaco" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] timers/migration: Rename 'online' bit to 'available'
Cc: Gabriele Monaco <gmonaco@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251120145653.296659-2-gmonaco@redhat.com>
References: <20251120145653.296659-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176366657748.498.17541516834970908020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8312cab5ff4702389a86129051eba6ea046a71a1
Gitweb:        https://git.kernel.org/tip/8312cab5ff4702389a86129051eba6ea046=
a71a1
Author:        Gabriele Monaco <gmonaco@redhat.com>
AuthorDate:    Thu, 20 Nov 2025 15:56:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Nov 2025 20:17:31 +01:00

timers/migration: Rename 'online' bit to 'available'

The timer migration hierarchy excludes offline CPUs via the
tmigr_is_not_available function, which is essentially checking the
online bit for the CPU.

Rename the online bit to available and all references in function names
and tracepoint to generalise the concept of available CPUs.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251120145653.296659-2-gmonaco@redhat.com
---
 include/trace/events/timer_migration.h |  4 ++--
 kernel/time/timer_migration.c          | 24 ++++++++++++------------
 kernel/time/timer_migration.h          |  2 +-
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/trace/events/timer_migration.h b/include/trace/events/ti=
mer_migration.h
index 47db5ea..61171b1 100644
--- a/include/trace/events/timer_migration.h
+++ b/include/trace/events/timer_migration.h
@@ -173,14 +173,14 @@ DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_active,
 	TP_ARGS(tmc)
 );
=20
-DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_online,
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_available,
=20
 	TP_PROTO(struct tmigr_cpu *tmc),
=20
 	TP_ARGS(tmc)
 );
=20
-DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_offline,
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_unavailable,
=20
 	TP_PROTO(struct tmigr_cpu *tmc),
=20
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 57e3867..2cfebed 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -429,7 +429,7 @@ static DEFINE_PER_CPU(struct tmigr_cpu, tmigr_cpu);
=20
 static inline bool tmigr_is_not_available(struct tmigr_cpu *tmc)
 {
-	return !(tmc->tmgroup && tmc->online);
+	return !(tmc->tmgroup && tmc->available);
 }
=20
 /*
@@ -926,7 +926,7 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u64=
 now,
 	 * updated the event takes care when hierarchy is completely
 	 * idle. Otherwise the migrator does it as the event is enqueued.
 	 */
-	if (!tmc->online || tmc->remote || tmc->cpuevt.ignore ||
+	if (!tmc->available || tmc->remote || tmc->cpuevt.ignore ||
 	    now < tmc->cpuevt.nextevt.expires) {
 		raw_spin_unlock_irq(&tmc->lock);
 		return;
@@ -973,7 +973,7 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u64=
 now,
 	 * (See also section "Required event and timerqueue update after a
 	 * remote expiry" in the documentation at the top)
 	 */
-	if (!tmc->online || !tmc->idle) {
+	if (!tmc->available || !tmc->idle) {
 		timer_unlock_remote_bases(cpu);
 		goto unlock;
 	}
@@ -1422,19 +1422,19 @@ static long tmigr_trigger_active(void *unused)
 {
 	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
=20
-	WARN_ON_ONCE(!tmc->online || tmc->idle);
+	WARN_ON_ONCE(!tmc->available || tmc->idle);
=20
 	return 0;
 }
=20
-static int tmigr_cpu_offline(unsigned int cpu)
+static int tmigr_clear_cpu_available(unsigned int cpu)
 {
 	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
 	int migrator;
 	u64 firstexp;
=20
 	raw_spin_lock_irq(&tmc->lock);
-	tmc->online =3D false;
+	tmc->available =3D false;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
=20
 	/*
@@ -1442,7 +1442,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	 * offline; Therefore nextevt value is set to KTIME_MAX
 	 */
 	firstexp =3D __tmigr_cpu_deactivate(tmc, KTIME_MAX);
-	trace_tmigr_cpu_offline(tmc);
+	trace_tmigr_cpu_unavailable(tmc);
 	raw_spin_unlock_irq(&tmc->lock);
=20
 	if (firstexp !=3D KTIME_MAX) {
@@ -1453,7 +1453,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	return 0;
 }
=20
-static int tmigr_cpu_online(unsigned int cpu)
+static int tmigr_set_cpu_available(unsigned int cpu)
 {
 	struct tmigr_cpu *tmc =3D this_cpu_ptr(&tmigr_cpu);
=20
@@ -1462,11 +1462,11 @@ static int tmigr_cpu_online(unsigned int cpu)
 		return -EINVAL;
=20
 	raw_spin_lock_irq(&tmc->lock);
-	trace_tmigr_cpu_online(tmc);
+	trace_tmigr_cpu_available(tmc);
 	tmc->idle =3D timer_base_is_idle();
 	if (!tmc->idle)
 		__tmigr_cpu_activate(tmc);
-	tmc->online =3D true;
+	tmc->available =3D true;
 	raw_spin_unlock_irq(&tmc->lock);
 	return 0;
 }
@@ -1758,7 +1758,7 @@ static int tmigr_add_cpu(unsigned int cpu)
 		 * The (likely) current CPU is expected to be online in the hierarchy,
 		 * otherwise the old root may not be active as expected.
 		 */
-		WARN_ON_ONCE(!per_cpu_ptr(&tmigr_cpu, raw_smp_processor_id())->online);
+		WARN_ON_ONCE(!per_cpu_ptr(&tmigr_cpu, raw_smp_processor_id())->available);
 		ret =3D tmigr_setup_groups(-1, old_root->numa_node, old_root, true);
 	}
=20
@@ -1854,7 +1854,7 @@ static int __init tmigr_init(void)
 		goto err;
=20
 	ret =3D cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
-				tmigr_cpu_online, tmigr_cpu_offline);
+				tmigr_set_cpu_available, tmigr_clear_cpu_available);
 	if (ret)
 		goto err;
=20
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index ae19f70..70879cd 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -97,7 +97,7 @@ struct tmigr_group {
  */
 struct tmigr_cpu {
 	raw_spinlock_t		lock;
-	bool			online;
+	bool			available;
 	bool			idle;
 	bool			remote;
 	struct tmigr_group	*tmgroup;

