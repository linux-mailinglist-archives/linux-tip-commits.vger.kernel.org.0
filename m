Return-Path: <linux-tip-commits+bounces-6538-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128A0B4AC6E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 13:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B84CC345CC3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3924B32255A;
	Tue,  9 Sep 2025 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tb5wLSvG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3iCUC6+b"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B114320386;
	Tue,  9 Sep 2025 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418150; cv=none; b=DGXb7hrddk7ZG3PoX58BnCsW0NxusNuHWbAxXIHGy1Ecinbhw49nX0ktI++JZUZ6lizNXiXFi8slFFYi/vJh1WpdhqXSKNN53Td/tsWPbeIiUmNt1df9VB06T+Dy8DjLSeRDe54HICsQrd6/wRx6FLr3anSFy4i8w7gX8UJpgwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418150; c=relaxed/simple;
	bh=fL79pmM3/YHNe/KiJMa3fwuPk29xx8UamKW0+fz+t3I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CNVVyYQ/TxUZzydcGbBz/keB/XxdAXaQ03BD4d/Ao3qMbW+AzP+Q1dd8+jbvR1e6PqbdF3YsQ20Xv36kkw1cMFKcZWLTgfZjRqDgKr6xMXcLxp8nr53bBdop3vI8/rnNezv1YOh1E5wnYWUwDmNBU39HzE3GiiLHYETtgHoJhgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tb5wLSvG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3iCUC6+b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 11:42:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757418145;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SuQNpwQsJ8UxEbOQKLpdzYPagTR16dWBPsTEOgz0Yc=;
	b=Tb5wLSvGAGrR2YqQrYRIpAF4ArGNyLHbbN+utNbnrS5GY7lG5GXjSntpt0F+59AK6x93zy
	JLwwOU/DVmpg+Cnn0d8jvLPE/fmWtYFFMoqBaQyTV363wB9DsnIb06WBaRFhmbha2kw15x
	wfljMGINlfGDBowZkAij5GpIHbL8Lda5GMkOYLCxKoOD3M1OJLLFTlpiktCqvEyCBo76Rk
	hLpJttrpjGE9EpgykSeUoklqqv6Env6idgMQIpQqQtoCX/y/dWPVyYuhbADhvCCn+OTHiw
	w1dJJolvpmEEj9pZ3AzFbwJ+oGUVIAnachPSb98uh8GxvjdEzAeA0zOz3ISRGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757418145;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2SuQNpwQsJ8UxEbOQKLpdzYPagTR16dWBPsTEOgz0Yc=;
	b=3iCUC6+bxq7XbXHDoztxVXp3vellq42mdC6Jy4OInsyY2FcjQKe9+g9WPyQWWIz48BwrU2
	WKYKE1EA8EyG2RAw==
From: "tip-bot2 for Bibo Mao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] tick: Do not set device to detached state in
 tick_shutdown()
Cc: Bibo Mao <maobibo@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250906064952.3749122-2-maobibo@loongson.cn>
References: <20250906064952.3749122-2-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741814446.1920.436308541178879101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fe2a449a45b13df1562419e0104b4777b6ea5248
Gitweb:        https://git.kernel.org/tip/fe2a449a45b13df1562419e0104b4777b6e=
a5248
Author:        Bibo Mao <maobibo@loongson.cn>
AuthorDate:    Sat, 06 Sep 2025 14:49:51 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 13:39:00 +02:00

tick: Do not set device to detached state in tick_shutdown()

tick_shutdown() sets the state of the clockevent device to detached
first and the invokes clockevents_exchange_device(), which in turn
invokes clockevents_switch_state().

But clockevents_switch_state() returns without invoking the device shutdown
callback as the device is already in detached state. As a consequence the
timer device is not shutdown when a CPU goes offline.

tick_shutdown() does this because it was originally invoked on a online CPU
and not on the outgoing CPU. It therefore could not access the clockevent
device of the already offlined CPU and just set the state.

Since commit 3b1596a21fbf tick_shutdown() is called on the outgoing CPU, so
the hardware device can be accessed.

Remove the state set before calling clockevents_exchange_device(), so that
the subsequent clockevents_switch_state() handles the state transition and
invokes the shutdown callback of the clockevent device.

[ tglx: Massaged change log ]

Fixes: 3b1596a21fbf ("clockevents: Shutdown and unregister current clockevent=
s at CPUHP_AP_TICK_DYING")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250906064952.3749122-2-maobibo@loongson.cn
---
 kernel/time/clockevents.c   |  2 +-
 kernel/time/tick-common.c   | 16 +++++-----------
 kernel/time/tick-internal.h |  2 +-
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index f3e831f..a59bc75 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -633,7 +633,7 @@ void tick_offline_cpu(unsigned int cpu)
 	raw_spin_lock(&clockevents_lock);
=20
 	tick_broadcast_offline(cpu);
-	tick_shutdown(cpu);
+	tick_shutdown();
=20
 	/*
 	 * Unregister the clock event devices which were
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 9a38594..7e33d3f 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -411,24 +411,18 @@ int tick_cpu_dying(unsigned int dying_cpu)
 }
=20
 /*
- * Shutdown an event device on a given cpu:
+ * Shutdown an event device on the outgoing CPU:
  *
- * This is called on a life CPU, when a CPU is dead. So we cannot
- * access the hardware device itself.
- * We just set the mode and remove it from the lists.
+ * Called by the dying CPU during teardown, with clockevents_lock held
+ * and interrupts disabled.
  */
-void tick_shutdown(unsigned int cpu)
+void tick_shutdown(void)
 {
-	struct tick_device *td =3D &per_cpu(tick_cpu_device, cpu);
+	struct tick_device *td =3D this_cpu_ptr(&tick_cpu_device);
 	struct clock_event_device *dev =3D td->evtdev;
=20
 	td->mode =3D TICKDEV_MODE_PERIODIC;
 	if (dev) {
-		/*
-		 * Prevent that the clock events layer tries to call
-		 * the set mode function!
-		 */
-		clockevent_set_state(dev, CLOCK_EVT_STATE_DETACHED);
 		clockevents_exchange_device(dev, NULL);
 		dev->event_handler =3D clockevents_handle_noop;
 		td->evtdev =3D NULL;
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index faac36d..4e4f7bb 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -26,7 +26,7 @@ extern void tick_setup_periodic(struct clock_event_device *=
dev, int broadcast);
 extern void tick_handle_periodic(struct clock_event_device *dev);
 extern void tick_check_new_device(struct clock_event_device *dev);
 extern void tick_offline_cpu(unsigned int cpu);
-extern void tick_shutdown(unsigned int cpu);
+extern void tick_shutdown(void);
 extern void tick_suspend(void);
 extern void tick_resume(void);
 extern bool tick_check_replacement(struct clock_event_device *curdev,

