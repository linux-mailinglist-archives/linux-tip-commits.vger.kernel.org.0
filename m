Return-Path: <linux-tip-commits+bounces-7964-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D665D1B31B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 21:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04C6630213D6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 20:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8889387379;
	Tue, 13 Jan 2026 20:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bNZQtq3g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qrgg28NO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267F930F95F;
	Tue, 13 Jan 2026 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768335805; cv=none; b=ddcbF7yc7XQBbLKoZYHd5u6ITo4Mk4wdl4XERrwlnEnEUUu8HgwrlbQVh0zfdik4YtJW9OaZuluReLkvkODnGm6v5EifgPXfgnWFq47S8mkN2teApBFCOvFZxYo2Tl1phvxjDAU12LSRrydmb4fwesaiLImSo13RzwJN7r+ggMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768335805; c=relaxed/simple;
	bh=48umE2dAj5vJUqF/QDmNMR67Zmi3AoaiyQqCxHFWJ9k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Gefgcdp3i+EEpMgITMvx0Q/EhVkgCHrXh9NXDPvbkS06x47rkrsN7RR8VBiXYpiI+7AP4BubIP15irj42lQ55fIp/ox+igoFNfv3jlqTwNE6OEdcHvYLkwtlo3TqLoKf2HNySQGwPn0ovCMJaqVqCzykyxoGP00knpks31r67Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bNZQtq3g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qrgg28NO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 20:23:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768335800;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMtATPjk3891+upTv1mBO3x8C5f5Mf8bqQZ0BuG59y0=;
	b=bNZQtq3gLesExmXJnYQqhEX82TzYnWYwX38aFHYMHXriUoOHgmiQQglUDDie9f2hu9/ZpM
	FEH28d8SPvrOaTws8cUbYPFsrnEsDphMB/VOxlHd/IbtjawxGk/k1yCMK0r7LvpP+ht63Z
	glJ1qnRcoNgvnHBesPC6H984ZWoDR7dIjt4w0wYmvEZHp2xtDl283yIGRKEU0LiXD47KUK
	GhgjVFt4DgCJwVQpu5XusAdd7h4pfos8sw8lFQuX8lDHLgFbHpGTbSzzlVJn7yfNKNa3gY
	oyXy+hFXJYsCDoqixBylwz/325UrkKYdKgBH3k6ZKdYep71cyDaLbpwDjXgu+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768335800;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OMtATPjk3891+upTv1mBO3x8C5f5Mf8bqQZ0BuG59y0=;
	b=Qrgg28NOsIt7lJ6MivufDuD+7hOk/4gF7547jC+hy22tqW8avJpIsvh5t/iknrRQwQXd/P
	zNzc7GZ2Y7GFyeDQ==
From: "tip-bot2 for Imran Khan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/cpuhotplug: Notify about affinity changes
 breaking the affinity mask
Cc: Imran Khan <imran.f.khan@oracle.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260113143727.1041265-1-imran.f.khan@oracle.com>
References: <20260113143727.1041265-1-imran.f.khan@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176833579866.510.10170669932125279922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     dd9f6d30c64001ca4dde973ac04d8d155e856743
Gitweb:        https://git.kernel.org/tip/dd9f6d30c64001ca4dde973ac04d8d155e8=
56743
Author:        Imran Khan <imran.f.khan@oracle.com>
AuthorDate:    Tue, 13 Jan 2026 22:37:27 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 21:18:16 +01:00

genirq/cpuhotplug: Notify about affinity changes breaking the affinity mask

During CPU offlining the interrupts affined to that CPU are moved to other
online CPUs, which might break the original affinity mask if the outgoing
CPU was the last online CPU in that mask. This change is not propagated to
irq_desc::affinity_notify(), which leaves users of the affinity notifier
mechanism with stale information.

Avoid this by scheduling affinity change notification work for interrupts
that were affined to the CPU being offlined, if the new target CPU is not
part of the original affinity mask.

Since irq_set_affinity_locked() uses the same logic to schedule affinity
change notification work, split out this logic into a dedicated function
and use that at both places.

[ tglx: Removed the EXPORT(), removed the !SMP stub, moved the prototype,
  	added a lockdep assert instead of a comment, fixed up coding style
  	and name space. Polished and clarified the change log ]

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260113143727.1041265-1-imran.f.khan@oracle.c=
om
---
 kernel/irq/cpuhotplug.c |  6 ++++--
 kernel/irq/internals.h  |  2 +-
 kernel/irq/manage.c     | 26 ++++++++++++++++++--------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 755346e..cd5689e 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -177,9 +177,11 @@ void irq_migrate_all_off_this_cpu(void)
 		bool affinity_broken;
=20
 		desc =3D irq_to_desc(irq);
-		scoped_guard(raw_spinlock, &desc->lock)
+		scoped_guard(raw_spinlock, &desc->lock) {
 			affinity_broken =3D migrate_one_irq(desc);
-
+			if (affinity_broken && desc->affinity_notify)
+				irq_affinity_schedule_notify_work(desc);
+		}
 		if (affinity_broken) {
 			pr_debug_ratelimited("IRQ %u: no longer affine to CPU%u\n",
 					    irq, smp_processor_id());
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 202c50f..9412e57 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -135,6 +135,7 @@ extern bool irq_can_set_affinity_usr(unsigned int irq);
=20
 extern int irq_do_set_affinity(struct irq_data *data,
 			       const struct cpumask *dest, bool force);
+extern void irq_affinity_schedule_notify_work(struct irq_desc *desc);
=20
 #ifdef CONFIG_SMP
 extern int irq_setup_affinity(struct irq_desc *desc);
@@ -142,7 +143,6 @@ extern int irq_setup_affinity(struct irq_desc *desc);
 static inline int irq_setup_affinity(struct irq_desc *desc) { return 0; }
 #endif
=20
-
 #define for_each_action_of_desc(desc, act)			\
 	for (act =3D desc->action; act; act =3D act->next)
=20
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index dde1aa6..9927e08 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -347,6 +347,21 @@ static bool irq_set_affinity_deactivated(struct irq_data=
 *data,
 	return true;
 }
=20
+/**
+ * irq_affinity_schedule_notify_work - Schedule work to notify about affinit=
y change
+ * @desc:  Interrupt descriptor whose affinity changed
+ */
+void irq_affinity_schedule_notify_work(struct irq_desc *desc)
+{
+	lockdep_assert_held(&desc->lock);
+
+	kref_get(&desc->affinity_notify->kref);
+	if (!schedule_work(&desc->affinity_notify->work)) {
+		/* Work was already scheduled, drop our extra ref */
+		kref_put(&desc->affinity_notify->kref, desc->affinity_notify->release);
+	}
+}
+
 int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mas=
k,
 			    bool force)
 {
@@ -367,14 +382,9 @@ int irq_set_affinity_locked(struct irq_data *data, const=
 struct cpumask *mask,
 		irq_copy_pending(desc, mask);
 	}
=20
-	if (desc->affinity_notify) {
-		kref_get(&desc->affinity_notify->kref);
-		if (!schedule_work(&desc->affinity_notify->work)) {
-			/* Work was already scheduled, drop our extra ref */
-			kref_put(&desc->affinity_notify->kref,
-				 desc->affinity_notify->release);
-		}
-	}
+	if (desc->affinity_notify)
+		irq_affinity_schedule_notify_work(desc);
+
 	irqd_set(data, IRQD_AFFINITY_SET);
=20
 	return ret;

