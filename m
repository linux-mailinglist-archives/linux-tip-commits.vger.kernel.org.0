Return-Path: <linux-tip-commits+bounces-6732-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668E7BA18EB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBF1320ECF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D847323F54;
	Thu, 25 Sep 2025 21:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3gki+px3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RMp9mRuF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A2D32142E;
	Thu, 25 Sep 2025 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835982; cv=none; b=jPKQqWnOLWzSKe3DQJH6og/3jc4IYvWOOCahHKhEledzC6FyqZkw5Ow2QkrjSPpyMlyxx+WTqGlzVAhuiO6Dvob4ipjbAcL+EMT1LqH9enQcE2KRu8a/xc33zpiDwFc2ZoMGEWL1Xzj3myklYb3tFGn9rB++xuAUoVGF4oArBiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835982; c=relaxed/simple;
	bh=GVda3eKNvtlzTivZmTcFRnEhrNio8LJX2ogS4RbkiyI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=RLbVwqLmuhKeZQj8RGicrS2umdsMBO6wKK0JNJrh+q87x8AVL6I8jA+HCcBzCUSsPBkXthfKUQMQaCDxFPjLBO6ZAKB0iPWmAXq3xLI8hYfXJQFOv3eGckwj0ZGD0o/Ua8c8+FTO35iUz0fC5ahWVDK0fWklb2VN9avmqEZt2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3gki+px3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RMp9mRuF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:32:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835978;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vPvMcYt6zr2s9p19aI0C8blNljaULLIkcoDYQ92jmNo=;
	b=3gki+px34PNQHF0OAzd3w3b6aMdt4eqKriTVZ0mhheij/8D4Cg/AumqHaGIm+WcIGRdEHK
	xli82a5tMihhjyRAl5mrbZLu2Cytoj1lPxVeWeZycF9PiQ7xn3fCgy+3XO/k3KAo3LGhQC
	U0P4Uyr8MBAT84MZ1NNc5iC+c1cxWR4HJrwY6IRUtjFVo+gCvGYuRoZTjNDmA0B/PYCbB5
	XrmLta7GQD1SOn4+/X5NynpVBWZcl9IN9gX1zGQILwwpnhlnHtJ0z+EwiwjuB8q+UymAkn
	7+9b9c4e5DPTcM3iQFb5YgYE1X9TwjYX91noNURqmbT7RhLZo2NifMinP7PtXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835978;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vPvMcYt6zr2s9p19aI0C8blNljaULLIkcoDYQ92jmNo=;
	b=RMp9mRuFetRPSSfA2XwxWvnIoXOQsvPVw4zNbv4WePTVBecPFKSrM7JGl4RcZQAZj/zpfm
	SgSzUZHgD7iuP4Cg==
From: "tip-bot2 for Markus Stockhausen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-rtl-otto: Work
 around dying timers
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stephen Howell <howels@allthatwemight.be>, bjorn@mork.no, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883597744.709179.5558904385475074159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     e7a25106335041aeca4fdf50a84804c90142c886
Gitweb:        https://git.kernel.org/tip/e7a25106335041aeca4fdf50a84804c9014=
2c886
Author:        Markus Stockhausen <markus.stockhausen@gmx.de>
AuthorDate:    Mon, 04 Aug 2025 04:03:25 -04:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:32:49 +02:00

clocksource/drivers/timer-rtl-otto: Work around dying timers

The OpenWrt distribution has switched from kernel longterm 6.6 to
6.12. Reports show that devices with the Realtek Otto switch platform
die during operation and are rebooted by the watchdog. Sorting out
other possible reasons the Otto timer is to blame. The platform
currently consists of 4 targets with different hardware revisions.
It is not 100% clear which devices and revisions are affected.

Analysis shows:

A more aggressive sched/deadline handling leads to more timer starts
with small intervals. This increases the bug chances. See
https://marc.info/?l=3Dlinux-kernel&m=3D175276556023276&w=3D2

Focusing on the real issue a hardware limitation on some devices was
found. There is a minimal chance that a timer ends without firing an
interrupt if it is reprogrammed within the 5us before its expiration
time. Work around this issue by introducing a bounce() function. It
restarts the timer directly before the normal restart functions as
follows:

- Stop timer
- Restart timer with a slow frequency.
- Target time will be >5us
- The subsequent normal restart is outside the critical window

Downstream has already tested and confirmed a patch. See
https://github.com/openwrt/openwrt/pull/19468
https://forum.openwrt.org/t/support-for-rtl838x-based-managed-switches/57875/=
3788

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Stephen Howell <howels@allthatwemight.be>
Tested-by: Bj=C3=B8rn Mork <bjorn@mork.no>
Link: https://lore.kernel.org/r/20250804080328.2609287-2-markus.stockhausen@g=
mx.de
---
 drivers/clocksource/timer-rtl-otto.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clocksource/timer-rtl-otto.c b/drivers/clocksource/timer=
-rtl-otto.c
index 8a3068b..8be45a1 100644
--- a/drivers/clocksource/timer-rtl-otto.c
+++ b/drivers/clocksource/timer-rtl-otto.c
@@ -38,6 +38,7 @@
 #define RTTM_BIT_COUNT		28
 #define RTTM_MIN_DELTA		8
 #define RTTM_MAX_DELTA		CLOCKSOURCE_MASK(28)
+#define RTTM_MAX_DIVISOR	GENMASK(15, 0)
=20
 /*
  * Timers are derived from the LXB clock frequency. Usually this is a fixed
@@ -112,6 +113,22 @@ static irqreturn_t rttm_timer_interrupt(int irq, void *d=
ev_id)
 	return IRQ_HANDLED;
 }
=20
+static void rttm_bounce_timer(void __iomem *base, u32 mode)
+{
+	/*
+	 * When a running timer has less than ~5us left, a stop/start sequence
+	 * might fail. While the details are unknown the most evident effect is
+	 * that the subsequent interrupt will not be fired.
+	 *
+	 * As a workaround issue an intermediate restart with a very slow
+	 * frequency of ~3kHz keeping the target counter (>=3D8). So the follow
+	 * up restart will always be issued outside the critical window.
+	 */
+
+	rttm_disable_timer(base);
+	rttm_enable_timer(base, mode, RTTM_MAX_DIVISOR);
+}
+
 static void rttm_stop_timer(void __iomem *base)
 {
 	rttm_disable_timer(base);
@@ -129,6 +146,7 @@ static int rttm_next_event(unsigned long delta, struct cl=
ock_event_device *clkev
 	struct timer_of *to =3D to_timer_of(clkevt);
=20
 	RTTM_DEBUG(to->of_base.base);
+	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_COUNTER);
 	rttm_stop_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, delta);
 	rttm_start_timer(to, RTTM_CTRL_COUNTER);
@@ -141,6 +159,7 @@ static int rttm_state_oneshot(struct clock_event_device *=
clkevt)
 	struct timer_of *to =3D to_timer_of(clkevt);
=20
 	RTTM_DEBUG(to->of_base.base);
+	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_COUNTER);
 	rttm_stop_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
 	rttm_start_timer(to, RTTM_CTRL_COUNTER);
@@ -153,6 +172,7 @@ static int rttm_state_periodic(struct clock_event_device =
*clkevt)
 	struct timer_of *to =3D to_timer_of(clkevt);
=20
 	RTTM_DEBUG(to->of_base.base);
+	rttm_bounce_timer(to->of_base.base, RTTM_CTRL_TIMER);
 	rttm_stop_timer(to->of_base.base);
 	rttm_set_period(to->of_base.base, RTTM_TICKS_PER_SEC / HZ);
 	rttm_start_timer(to, RTTM_CTRL_TIMER);

