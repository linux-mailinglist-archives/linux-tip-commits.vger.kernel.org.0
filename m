Return-Path: <linux-tip-commits+bounces-6160-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A649B0DA01
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 14:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46FFE7AD315
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 12:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD94A2E9EB0;
	Tue, 22 Jul 2025 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+AdK8eI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VBo3J8Ee"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65B1C07C4;
	Tue, 22 Jul 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188358; cv=none; b=lz8AbI2tKEDgQpkiylfOX5Z/nOt8ebjv5MzoDEpdT0uOIgWQ0Yf0RrZobtiOUvxM0BwxN6DZuI9aR3XpnS2i7KpRuR+h55vN73YAApGpo0Vr5XYcMvbkcc3Hd8wCVhYH6cuI2aQ9Knvlo+CuzpE6LYlq+KbVpL3elU6ra4wnxfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188358; c=relaxed/simple;
	bh=WaKMvy2eXDa/0edu830zey+S4GAsXF5i6uXqEONiSaY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QVf7fn98yl5LTIdvoZh3cwXfDWs2Okm5LISREwVv5Acn8m1KgQlkp1zldiGwGpnVldfy+ZjC0T+r3fuR71LYY6uxJoBT8a/uQf3mUMoQIg8MoO/aSW9YG8LjJFWLesoPcvHENLX9AL9eOxJetL37R6N9eIXy8B+iH6if2xMfKsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+AdK8eI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VBo3J8Ee; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Jul 2025 12:45:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753188355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNzB6rI8Tr1A5VvlbgtsD1qkuKbdAcJ7W0BY/+fFswM=;
	b=v+AdK8eISUqGa7GEKcXhra9QcvNzsv4Af3uI1JPjd6nE5T9xAQLMQ7duJlOTmgunX1hNeW
	O7FKEyV75eyo2P9MpppjYimZjq2k+qRxLjtFBUsAEGncu60hsR0XFUDSHEBh++7MGuZGEa
	lilp56URdU3z0BCQ3TN/gk+uU4i+qrd4rTYKSldWpzWCVh9515BNeet+WvQvpYP6BN8mKo
	JCCnbV0NIuwaYWY2xcWhpiHo0AN5j076MfzKJ6WDPJ1MyFXNSOhUn1rQeIC+b4sX11Gc2c
	8kVIJ4mSwaZplHUWktNLyqP3HZJV89aCFePCMLylZ9kotJEKIznUp+OYCqfauQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753188355;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FNzB6rI8Tr1A5VvlbgtsD1qkuKbdAcJ7W0BY/+fFswM=;
	b=VBo3J8EeEQ6ab5wUIM8CKbSlP3+lnnM3lQ9EWmgT/7JmwEPZW79VPu9JnRQ+dbVouly4MG
	AyrJIDWoFSUf/8DQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Move irq_wait_for_poll() to call site
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Liangyan <liangyan.peng@bytedance.com>, Jiri Slaby <jirislaby@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250718185311.948555026@linutronix.de>
References: <20250718185311.948555026@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175318835421.1420.1426076396982442914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4e879dedd571128ed5aa4d5989ec0a1938804d20
Gitweb:        https://git.kernel.org/tip/4e879dedd571128ed5aa4d5989ec0a19388=
04d20
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 18 Jul 2025 20:54:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jul 2025 14:30:42 +02:00

genirq: Move irq_wait_for_poll() to call site

Move it to the call site so that the waiting for the INPROGRESS flag can be
reused by an upcoming mitigation for a potential live lock in the edge type
handler.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Liangyan <liangyan.peng@bytedance.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/all/20250718185311.948555026@linutronix.de

---
 kernel/irq/chip.c      | 33 ++++++++++++++++++++++++---------
 kernel/irq/internals.h |  2 +-
 kernel/irq/spurious.c  | 37 +------------------------------------
 3 files changed, 26 insertions(+), 46 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 5bb26fc..290244c 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -457,11 +457,21 @@ void unmask_threaded_irq(struct irq_desc *desc)
 	unmask_irq(desc);
 }
=20
-static bool irq_check_poll(struct irq_desc *desc)
-{
-	if (!(desc->istate & IRQS_POLL_INPROGRESS))
-		return false;
-	return irq_wait_for_poll(desc);
+/* Busy wait until INPROGRESS is cleared */
+static bool irq_wait_on_inprogress(struct irq_desc *desc)
+{
+	if (IS_ENABLED(CONFIG_SMP)) {
+		do {
+			raw_spin_unlock(&desc->lock);
+			while (irqd_irq_inprogress(&desc->irq_data))
+				cpu_relax();
+			raw_spin_lock(&desc->lock);
+		} while (irqd_irq_inprogress(&desc->irq_data));
+
+		/* Might have been disabled in meantime */
+		return !irqd_irq_disabled(&desc->irq_data) && desc->action;
+	}
+	return false;
 }
=20
 static bool irq_can_handle_pm(struct irq_desc *desc)
@@ -481,10 +491,15 @@ static bool irq_can_handle_pm(struct irq_desc *desc)
 	if (irq_pm_check_wakeup(desc))
 		return false;
=20
-	/*
-	 * Handle a potential concurrent poll on a different core.
-	 */
-	return irq_check_poll(desc);
+	/* Check whether the interrupt is polled on another CPU */
+	if (unlikely(desc->istate & IRQS_POLL_INPROGRESS)) {
+		if (WARN_ONCE(irq_poll_cpu =3D=3D smp_processor_id(),
+			      "irq poll in progress on cpu %d for irq %d\n",
+			      smp_processor_id(), desc->irq_data.irq))
+			return false;
+		return irq_wait_on_inprogress(desc);
+	}
+	return false;
 }
=20
 static inline bool irq_can_handle_actions(struct irq_desc *desc)
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index aebfe22..82b0d67 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -20,6 +20,7 @@
 #define istate core_internal_state__do_not_mess_with_it
=20
 extern bool noirqdebug;
+extern int irq_poll_cpu;
=20
 extern struct irqaction chained_action;
=20
@@ -112,7 +113,6 @@ irqreturn_t handle_irq_event(struct irq_desc *desc);
 int check_irq_resend(struct irq_desc *desc, bool inject);
 void clear_irq_resend(struct irq_desc *desc);
 void irq_resend_init(struct irq_desc *desc);
-bool irq_wait_for_poll(struct irq_desc *desc);
 void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action);
=20
 void wake_threads_waitq(struct irq_desc *desc);
diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 8f26982..73280cc 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -19,45 +19,10 @@ static int irqfixup __read_mostly;
 #define POLL_SPURIOUS_IRQ_INTERVAL (HZ/10)
 static void poll_spurious_irqs(struct timer_list *unused);
 static DEFINE_TIMER(poll_spurious_irq_timer, poll_spurious_irqs);
-static int irq_poll_cpu;
+int irq_poll_cpu;
 static atomic_t irq_poll_active;
=20
 /*
- * We wait here for a poller to finish.
- *
- * If the poll runs on this CPU, then we yell loudly and return
- * false. That will leave the interrupt line disabled in the worst
- * case, but it should never happen.
- *
- * We wait until the poller is done and then recheck disabled and
- * action (about to be disabled). Only if it's still active, we return
- * true and let the handler run.
- */
-bool irq_wait_for_poll(struct irq_desc *desc)
-{
-	lockdep_assert_held(&desc->lock);
-
-	if (WARN_ONCE(irq_poll_cpu =3D=3D smp_processor_id(),
-		      "irq poll in progress on cpu %d for irq %d\n",
-		      smp_processor_id(), desc->irq_data.irq))
-		return false;
-
-#ifdef CONFIG_SMP
-	do {
-		raw_spin_unlock(&desc->lock);
-		while (irqd_irq_inprogress(&desc->irq_data))
-			cpu_relax();
-		raw_spin_lock(&desc->lock);
-	} while (irqd_irq_inprogress(&desc->irq_data));
-	/* Might have been disabled in meantime */
-	return !irqd_irq_disabled(&desc->irq_data) && desc->action;
-#else
-	return false;
-#endif
-}
-
-
-/*
  * Recovery handler for misrouted interrupts.
  */
 static bool try_one_irq(struct irq_desc *desc, bool force)

