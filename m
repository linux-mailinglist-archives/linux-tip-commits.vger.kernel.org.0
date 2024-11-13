Return-Path: <linux-tip-commits+bounces-2856-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBD09C7CD0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 21:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0A21F22ADC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 20:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E1E20DD47;
	Wed, 13 Nov 2024 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IWgr1zLO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DmyJn2Gw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAA220A5D2;
	Wed, 13 Nov 2024 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529257; cv=none; b=T7N64Jo0QqgY3wtOFRUWaAZReszu1DO77YThR2OaWYZ90Y3wQoY/cDH6lVeRh1W/486jtET8AVC/JXzQmQ07pg6LCznHOu1G9ZjJfad6jASDNNj19lsc0fn5FkM/7hRC/gsqevOIe1hKiNhzdNK/gb7aOolt2GZlkdS0U2aYETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529257; c=relaxed/simple;
	bh=Kft1Z1EYVKngKkNcoMvtAJiKX9uz22Z5q3n6uDXXkKI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Xuae1ggnQpJr3EDr9voiKC+oielA87QhoVKOzlUoB3f+p+XzRY/K9TcwXFqo5C62VqhunkRJlwHQStgW8sMuzHpyT9aOLkpQAykKGunXYyd/CL1LQM1wlwUFkQeQwEsPHjV+dkGH6QJcdQrhnGy8BEPv4mpIIlNS5pXF7/x0q8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IWgr1zLO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DmyJn2Gw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 20:20:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731529253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lB0mAv0ja15zZABjC06qmH+bu3/Z+zzsoTDtiDfjbgQ=;
	b=IWgr1zLOK2kqmtH8Ki6R/jcUh+wSN4rBTGlwg5XnpQF8wQHqdp8dN3+HQ4eSC9GQ2zhuaC
	cRkJqyBoup7hg4JUAf2Q/B2e0IPdb8e3Kee0xmUpKE1qC2Rikj1F3COnFcWVpZMBGoaybK
	CLIDe7sxehO9Iq+WDXPczIS0fVM8sIjerLQ/RXxOD0Bz3muqrCATDW0nRX73tiP02qIMiZ
	pFWe9SGV56ceqKtoAWbds0gLPSeBMYFSTuv73qL1WVvJZshChTuOb30AHNNY+AfM+VgWVY
	xN6413GWOB+lGYnwBamA+ma+237Cn3nKdDfbEK2BXbjqdiCW1vtSmMLIsKBqWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731529253;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lB0mAv0ja15zZABjC06qmH+bu3/Z+zzsoTDtiDfjbgQ=;
	b=DmyJn2GwdZGj0kTVdZ6IlzZQxPbkwYM8Q0SOHbhBfAiULyTnorqZDfcOhbjfzlOtAnSj3P
	nSkznUCKM3rbeSDg==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/dw_apb: Remove unused
 dw_apb_clockevent functions
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241025203101.241709-1-linux@treblig.org>
References: <20241025203101.241709-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173152925296.32228.3697535630081020156.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1d58f7f3a1373734b2e86a246edcf1cd39359f3e
Gitweb:        https://git.kernel.org/tip/1d58f7f3a1373734b2e86a246edcf1cd39359f3e
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Fri, 25 Oct 2024 21:31:01 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 13 Nov 2024 13:49:33 +01:00

clocksource/drivers/dw_apb: Remove unused dw_apb_clockevent functions

dw_apb_clockevent_pause(), dw_apb_clockevent_resume() and
dw_apb_clockevent_stop() have been unused since 2021's
commit 1b79fc4f2bfd ("x86/apb_timer: Remove driver for deprecated
platform")

Remove them.

(Some of the other clockevent functions are still called by
dw_apb_timer_of.c  so I guess it is still in use?)

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Link: https://lore.kernel.org/r/20241025203101.241709-1-linux@treblig.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/dw_apb_timer.c | 39 +-----------------------------
 include/linux/dw_apb_timer.h       |  3 +--
 2 files changed, 42 deletions(-)

diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index f5f24a9..3a55ae5 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -68,25 +68,6 @@ static inline void apbt_writel_relaxed(struct dw_apb_timer *timer, u32 val,
 	writel_relaxed(val, timer->base + offs);
 }
 
-static void apbt_disable_int(struct dw_apb_timer *timer)
-{
-	u32 ctrl = apbt_readl(timer, APBTMR_N_CONTROL);
-
-	ctrl |= APBTMR_CONTROL_INT;
-	apbt_writel(timer, ctrl, APBTMR_N_CONTROL);
-}
-
-/**
- * dw_apb_clockevent_pause() - stop the clock_event_device from running
- *
- * @dw_ced:	The APB clock to stop generating events.
- */
-void dw_apb_clockevent_pause(struct dw_apb_clock_event_device *dw_ced)
-{
-	disable_irq(dw_ced->timer.irq);
-	apbt_disable_int(&dw_ced->timer);
-}
-
 static void apbt_eoi(struct dw_apb_timer *timer)
 {
 	apbt_readl_relaxed(timer, APBTMR_N_EOI);
@@ -285,26 +266,6 @@ dw_apb_clockevent_init(int cpu, const char *name, unsigned rating,
 }
 
 /**
- * dw_apb_clockevent_resume() - resume a clock that has been paused.
- *
- * @dw_ced:	The APB clock to resume.
- */
-void dw_apb_clockevent_resume(struct dw_apb_clock_event_device *dw_ced)
-{
-	enable_irq(dw_ced->timer.irq);
-}
-
-/**
- * dw_apb_clockevent_stop() - stop the clock_event_device and release the IRQ.
- *
- * @dw_ced:	The APB clock to stop generating the events.
- */
-void dw_apb_clockevent_stop(struct dw_apb_clock_event_device *dw_ced)
-{
-	free_irq(dw_ced->timer.irq, &dw_ced->ced);
-}
-
-/**
  * dw_apb_clockevent_register() - register the clock with the generic layer
  *
  * @dw_ced:	The APB clock to register as a clock_event_device.
diff --git a/include/linux/dw_apb_timer.h b/include/linux/dw_apb_timer.h
index 82ebf92..f8811c4 100644
--- a/include/linux/dw_apb_timer.h
+++ b/include/linux/dw_apb_timer.h
@@ -34,9 +34,6 @@ struct dw_apb_clocksource {
 };
 
 void dw_apb_clockevent_register(struct dw_apb_clock_event_device *dw_ced);
-void dw_apb_clockevent_pause(struct dw_apb_clock_event_device *dw_ced);
-void dw_apb_clockevent_resume(struct dw_apb_clock_event_device *dw_ced);
-void dw_apb_clockevent_stop(struct dw_apb_clock_event_device *dw_ced);
 
 struct dw_apb_clock_event_device *
 dw_apb_clockevent_init(int cpu, const char *name, unsigned rating,

