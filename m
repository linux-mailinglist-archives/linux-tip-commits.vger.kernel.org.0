Return-Path: <linux-tip-commits+bounces-6434-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01E6B4235A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884AA7A9447
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655DC305051;
	Wed,  3 Sep 2025 14:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H6cFMZ51";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FoEcBgoY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE832E92C3;
	Wed,  3 Sep 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908785; cv=none; b=Dh3BibmLF8Fod0KKkJlLR/+IlLUTFOl80ifpPEJtZaPvUtQN60Vuvlg5gRMWoF+PZt5Pj2x/jbP22rhaHj66/8oOi23JhqeqAeHZlUCqY+KsFgWZImbWyLidUt2JhB6xLzPYDrx+fe49Unr18rmO8leBuwkMKpcWRECQ8W7d7QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908785; c=relaxed/simple;
	bh=WCs89rxSemEi1SSxuhlOVtKDAs7bC0NQNI1afm2DB5U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XioDnbDtBgpY6AsXmVhuSS6FFtQerkVxKnVAYVxis6dWuUH2aT5uOl+neScECGr0bTPwPlLxLfdisrCG3/bSYxt/QUFeNt3JGCRyz2TyHYnTp6qOlw91KHoj+zloMZSQYCg589r9EHh3pfdklzfTWMjopzIFq+bFnzkBAg1alFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H6cFMZ51; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FoEcBgoY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 14:13:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756908782;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRGZWv/2wP4LUgh1tY8GE2xU+mV9fWLP/4ChjZROVqs=;
	b=H6cFMZ51+02Du9HwKLYhyMLrQSR9fZaUG5u5UxIZnHGNmk0D7nDO0PMrGbn9OLnhsVocsh
	lK5l+eybQds8gPUCpBiU8Uk25x3mFCHaa7ZoWKtkZPtINRxy2/91C0PBfdQdmEXz/2CewL
	19n9Ckj+VVfq+rbto/io+TIy6g5ER8qEGC4UU913tg9QWd8KllDi273L7OxvDhdJwXw2/w
	ZVH8MubcF+rLFkSHP53nkdxPKRNVG8QgVYVyoUPsOjI5TO1fLb8nfJYUaS1oWCB7EVTjhR
	aAoqQVHDaL1mzNYEb785lw/q7m6mrvc/DLxRA/SusCgOxx8BcIuzMdtDBRkE6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756908782;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRGZWv/2wP4LUgh1tY8GE2xU+mV9fWLP/4ChjZROVqs=;
	b=FoEcBgoYbeApWZMwDW2EYNqBgqUWPpZvg7uhuwXCXq+/gftWOpReGgjvSubdV6cjdEEhTA
	4RidkbZShn6TZQCA==
From: "tip-bot2 for Wladislav Wiebe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Add support for warning on long-running
 interrupt handlers
Cc: Wladislav Wiebe <wladislav.wiebe@nokia.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jirislaby@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250804093525.851-1-wladislav.wiebe@nokia.com>
References: <20250804093525.851-1-wladislav.wiebe@nokia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175690878044.1920.10260472737445670133.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     673f1244b3d47c9b41cda3473c062bec586387be
Gitweb:        https://git.kernel.org/tip/673f1244b3d47c9b41cda3473c062bec586=
387be
Author:        Wladislav Wiebe <wladislav.wiebe@nokia.com>
AuthorDate:    Mon, 04 Aug 2025 11:35:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 16:10:40 +02:00

genirq: Add support for warning on long-running interrupt handlers

Introduce a mechanism to detect and warn about prolonged interrupt handlers.
With a new command-line parameter (irqhandler.duration_warn_us=3D), users can
configure the duration threshold in microseconds when a warning in such
format should be emitted:

"[CPU14] long duration of IRQ[159:bad_irq_handler [long_irq]], took: 1330 us"

The implementation uses local_clock() to measure the execution duration of the
generic IRQ per-CPU event handler.

Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/all/20250804093525.851-1-wladislav.wiebe@nokia.=
com

---
 Documentation/admin-guide/kernel-parameters.txt |  5 ++-
 kernel/irq/handle.c                             | 49 +++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 747a55a..bdbc44f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2606,6 +2606,11 @@
 			for it. Intended to get systems with badly broken
 			firmware running.
=20
+	irqhandler.duration_warn_us=3D [KNL]
+			Warn if an IRQ handler exceeds the specified duration
+			threshold in microseconds. Useful for identifying
+			long-running IRQs in the system.
+
 	irqpoll		[HW]
 			When an interrupt is not handled search all handlers
 			for it. Also check all handlers each timer
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 9489f93..e103451 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -136,6 +136,44 @@ void __irq_wake_thread(struct irq_desc *desc, struct irq=
action *action)
 	wake_up_process(action->thread);
 }
=20
+static DEFINE_STATIC_KEY_FALSE(irqhandler_duration_check_enabled);
+static u64 irqhandler_duration_threshold_ns __ro_after_init;
+
+static int __init irqhandler_duration_check_setup(char *arg)
+{
+	unsigned long val;
+	int ret;
+
+	ret =3D kstrtoul(arg, 0, &val);
+	if (ret) {
+		pr_err("Unable to parse irqhandler.duration_warn_us setting: ret=3D%d\n", =
ret);
+		return 0;
+	}
+
+	if (!val) {
+		pr_err("Invalid irqhandler.duration_warn_us setting, must be > 0\n");
+		return 0;
+	}
+
+	irqhandler_duration_threshold_ns =3D val * 1000;
+	static_branch_enable(&irqhandler_duration_check_enabled);
+
+	return 1;
+}
+__setup("irqhandler.duration_warn_us=3D", irqhandler_duration_check_setup);
+
+static inline void irqhandler_duration_check(u64 ts_start, unsigned int irq,
+					     const struct irqaction *action)
+{
+	u64 delta_ns =3D local_clock() - ts_start;
+
+	if (unlikely(delta_ns > irqhandler_duration_threshold_ns)) {
+		pr_warn_ratelimited("[CPU%u] long duration of IRQ[%u:%ps], took: %llu us\n=
",
+				    smp_processor_id(), irq, action->handler,
+				    div_u64(delta_ns, NSEC_PER_USEC));
+	}
+}
+
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 {
 	irqreturn_t retval =3D IRQ_NONE;
@@ -155,7 +193,16 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *d=
esc)
 			lockdep_hardirq_threaded();
=20
 		trace_irq_handler_entry(irq, action);
-		res =3D action->handler(irq, action->dev_id);
+
+		if (static_branch_unlikely(&irqhandler_duration_check_enabled)) {
+			u64 ts_start =3D local_clock();
+
+			res =3D action->handler(irq, action->dev_id);
+			irqhandler_duration_check(ts_start, irq, action);
+		} else {
+			res =3D action->handler(irq, action->dev_id);
+		}
+
 		trace_irq_handler_exit(irq, action, res);
=20
 		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pS enabled interrupts\n",

