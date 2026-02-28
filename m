Return-Path: <linux-tip-commits+bounces-8325-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ/0J54No2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8325-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:45:34 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EA81C417D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 955D531DDA10
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F96747F2D4;
	Sat, 28 Feb 2026 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Zv0M3KC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yyl/U8tC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349947DD42;
	Sat, 28 Feb 2026 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293023; cv=none; b=jp9a9kvGDOYqfr7fLXkxgY1Fonc4YHsXsmbUPN+35d4ptJmEKySWZWHVIIzA+3/JS5Un0isqaMNvCAtVJU21Rx9DAvD19RcgforIT/U4jGf3UFMXEYOGcfG7gyydpRpnMquUqaR9XC5HGzCNw9Tqese57I8uBVvHi+2a3HDoHT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293023; c=relaxed/simple;
	bh=mXAwBbCkA2VUwyfCxf05xONsYiTp0z2/KIuiFWmDt28=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=itv5OG9rJyFFHWuxjj1Nx+/RBpWFezQdAjVWFMWNmUk1iVDt048zhxQ4j+R8+z1p0qXFz4U/DyWpFzUTX6T4S1hDTZvwP4X8BF+eGaqQ7cdSG1n1IYVJ6dJ+TkcYl+itPOEfbTNLsh3amRFqmfa/QOIXCHENUspw9G/4uo18SzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Zv0M3KC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yyl/U8tC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772293015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emE+ej5sSk0Y4hS9kcAHEVBe6jQadBuSaomvxbnsYac=;
	b=1Zv0M3KCSzH+HE13/lsjTfoUEScBe5+NO1BfSguYxVecsqIKy542IxP8TQeRdJ84f+eNSW
	DPGYgIFQtbuy+J1OpDMuxbeNeszzqcqSbeG+Q7zCyWS9yXwKsl3hTXbHWo9sJqI17qnQXQ
	dbj5oeeFPokQ1tpaSavH34c+C55rDXw2ejfu8qKvfJLA+APqQYIkX0ZWpKCmGMKNsKIrES
	EamLjhs/qDZUZ4xbjj1cyWMmDm8o248znJp1WHv6BFwDxzeYP+sdyExaNyd9TpzqSGhLQv
	rMrPaJ9oSNXPjvEY5MdAxDxcX/JHWB1ggaYexbCC7CffgIZzZCk8jJ37LIBCMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772293015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emE+ej5sSk0Y4hS9kcAHEVBe6jQadBuSaomvxbnsYac=;
	b=yyl/U8tCPawr64cBhH2yht3/wnsmsc4BFbo7Bzmok0EWuQJ2cIyeQT/LjTSYbTDMKxtkGr
	Fow6jw7nzwj65rDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Provide LAZY_REARM mode
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163429.408524456@kernel.org>
References: <20260224163429.408524456@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229301394.1647592.5824754898534506798.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8325-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: C4EA81C417D
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     b7dd64778aa3f89de9afa1e81171cfe110ddc525
Gitweb:        https://git.kernel.org/tip/b7dd64778aa3f89de9afa1e81171cfe110d=
dc525
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:36:01 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:06 +01:00

hrtimer: Provide LAZY_REARM mode

The hrtick timer is frequently rearmed before expiry and most of the time
the new expiry is past the armed one. As this happens on every context
switch it becomes expensive with scheduling heavy work loads especially in
virtual machines as the "hardware" reprogamming implies a VM exit.

Add a lazy rearm mode flag which skips the reprogamming if:

    1) The timer was the first expiring timer before the rearm

    2) The new expiry time is farther out than the armed time

This avoids a massive amount of reprogramming operations of the hrtick
timer for the price of eventually taking the alredy armed interrupt for
nothing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163429.408524456@kernel.org
---
 include/linux/hrtimer.h       |  8 ++++++++
 include/linux/hrtimer_types.h |  3 +++
 kernel/time/hrtimer.c         | 17 ++++++++++++++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index b500385..c924bb2 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -31,6 +31,13 @@
  *				  soft irq context
  * HRTIMER_MODE_HARD		- Timer callback function will be executed in
  *				  hard irq context even on PREEMPT_RT.
+ * HRTIMER_MODE_LAZY_REARM	- Avoid reprogramming if the timer was the
+ *				  first expiring timer and is moved into the
+ *				  future. Special mode for the HRTICK timer to
+ *				  avoid extensive reprogramming of the hardware,
+ *				  which is expensive in virtual machines. Risks
+ *				  a pointless expiry, but that's better than
+ *				  reprogramming on every context switch,
  */
 enum hrtimer_mode {
 	HRTIMER_MODE_ABS	=3D 0x00,
@@ -38,6 +45,7 @@ enum hrtimer_mode {
 	HRTIMER_MODE_PINNED	=3D 0x02,
 	HRTIMER_MODE_SOFT	=3D 0x04,
 	HRTIMER_MODE_HARD	=3D 0x08,
+	HRTIMER_MODE_LAZY_REARM	=3D 0x10,
=20
 	HRTIMER_MODE_ABS_PINNED =3D HRTIMER_MODE_ABS | HRTIMER_MODE_PINNED,
 	HRTIMER_MODE_REL_PINNED =3D HRTIMER_MODE_REL | HRTIMER_MODE_PINNED,
diff --git a/include/linux/hrtimer_types.h b/include/linux/hrtimer_types.h
index 8fbbb6b..64381c6 100644
--- a/include/linux/hrtimer_types.h
+++ b/include/linux/hrtimer_types.h
@@ -33,6 +33,8 @@ enum hrtimer_restart {
  * @is_soft:	Set if hrtimer will be expired in soft interrupt context.
  * @is_hard:	Set if hrtimer will be expired in hard interrupt context
  *		even on RT.
+ * @is_lazy:	Set if the timer is frequently rearmed to avoid updates
+ *		of the clock event device
  *
  * The hrtimer structure must be initialized by hrtimer_setup()
  */
@@ -45,6 +47,7 @@ struct hrtimer {
 	u8				is_rel;
 	u8				is_soft;
 	u8				is_hard;
+	u8				is_lazy;
 };
=20
 #endif /* _LINUX_HRTIMER_TYPES_H */
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 67917ce..e54f8b5 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1152,7 +1152,7 @@ static void __remove_hrtimer(struct hrtimer *timer,
 	 * an superfluous call to hrtimer_force_reprogram() on the
 	 * remote cpu later on if the same timer gets enqueued again.
 	 */
-	if (reprogram && timer =3D=3D cpu_base->next_timer)
+	if (reprogram && timer =3D=3D cpu_base->next_timer && !timer->is_lazy)
 		hrtimer_force_reprogram(cpu_base, 1);
 }
=20
@@ -1322,6 +1322,20 @@ static int __hrtimer_start_range_ns(struct hrtimer *ti=
mer, ktime_t tim,
 	}
=20
 	/*
+	 * Special case for the HRTICK timer. It is frequently rearmed and most
+	 * of the time moves the expiry into the future. That's expensive in
+	 * virtual machines and it's better to take the pointless already armed
+	 * interrupt than reprogramming the hardware on every context switch.
+	 *
+	 * If the new expiry is before the armed time, then reprogramming is
+	 * required.
+	 */
+	if (timer->is_lazy) {
+		if (new_base->cpu_base->expires_next <=3D hrtimer_get_expires(timer))
+			return 0;
+	}
+
+	/*
 	 * Timer was forced to stay on the current CPU to avoid
 	 * reprogramming on removal and enqueue. Force reprogram the
 	 * hardware by evaluating the new first expiring timer.
@@ -1675,6 +1689,7 @@ static void __hrtimer_setup(struct hrtimer *timer,
 	base +=3D hrtimer_clockid_to_base(clock_id);
 	timer->is_soft =3D softtimer;
 	timer->is_hard =3D !!(mode & HRTIMER_MODE_HARD);
+	timer->is_lazy =3D !!(mode & HRTIMER_MODE_LAZY_REARM);
 	timer->base =3D &cpu_base->clock_base[base];
 	timerqueue_init(&timer->node);
=20

