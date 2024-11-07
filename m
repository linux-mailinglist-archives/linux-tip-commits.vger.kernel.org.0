Return-Path: <linux-tip-commits+bounces-2805-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DC09BFC0E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271FCB22994
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 01:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1A217C79;
	Thu,  7 Nov 2024 01:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bDWpDmxY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5qSjIDaL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840A012B63;
	Thu,  7 Nov 2024 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944779; cv=none; b=fnT8xcKId+RJCthz6s4YuDb7oI/F6ivlIXL34P5oJtg8KEjOP72Iltx5Zyihns+icLkHpYKfaeLNghPLXOZeKaQTnjOLB+uGlGg17AZsig03P181OBPX43jPhhwBX++Ox5IhIt3fQODnN5+woLK9/QADzY540uV7LGVUlJ+AWKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944779; c=relaxed/simple;
	bh=1erqBs3JogQ1JYfpMx2Tzi+x0lblr062IT24cV6H+4w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wh0mfgoSj0gpGCDjAA/lhgR3grueRHLDK7yC5n4sv4sxnNpafC5ueCwsF0oKcia2Ij5RpVIWpuiOObbPvPjOgdaOjc3bihBv5UYevaexzuTfEWsjaLXHfvvA5yAFr6VaYmfeqhpcK4WvL4Wy8ICiSkoS1oZ+19rP6TfXdk8bd2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bDWpDmxY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5qSjIDaL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944776;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMvc4kwK/QRhqm7DovPfIUf/wntoqVQAWB+q1YiLoeE=;
	b=bDWpDmxYzHW4WLrImCZbAEi1jPV+r/C9t1CZaY/Xfb01+PJ7XD3MD/GB/Ig6UbboxowuBs
	WeaP1EljeJEdnCNqvtWOG7euFL2OqX6Pi25GVygOnxj1cohP8ORFsCjhJHXP8q8WVSJYeQ
	w+jVKi1RY/wcGmFM1kFHlLtp0lfDm21pSgEejT3x7xx0GiWT1HzQtKayJOTUwcw05fWZiu
	av32RrgQ+UANV+0mBQM919p8XxpeCvEQLuiBDeANWieQNV+CfNWMcEh+iq3cgrOQ/0kR1i
	8tw/t46o/4Cw2pSI+9Ncr98seqRqa8oHo3PpQmHG7NZZIShn5kp21d3+ADoE+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMvc4kwK/QRhqm7DovPfIUf/wntoqVQAWB+q1YiLoeE=;
	b=5qSjIDaLDih3cRR1XCZh6jVLQE9GDMmhrpYkju5VVUxnihKxZBjDy9JH56pg2MxTGOg5Py
	E5A4UT2YCuviVsCQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] io_uring: Switch to use hrtimer_setup_on_stack()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf0d4ac32ec4050710a656cee8385fa4427be33aa=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cf0d4ac32ec4050710a656cee8385fa4427be33aa=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094477612.32228.15482096656457929024.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fc9f59de26afb3b4a33d37f1ba51a441b050afbb
Gitweb:        https://git.kernel.org/tip/fc9f59de26afb3b4a33d37f1ba51a441b050afbb
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:06 +01:00

io_uring: Switch to use hrtimer_setup_on_stack()

hrtimer_setup_on_stack() takes the callback function pointer as argument
and initializes the timer completely.

Replace hrtimer_init_on_stack() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/f0d4ac32ec4050710a656cee8385fa4427be33aa.1730386209.git.namcao@linutronix.de

---
 io_uring/io_uring.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index feb61d6..0842aa3 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -2435,13 +2435,14 @@ static int io_cqring_schedule_timeout(struct io_wait_queue *iowq,
 {
 	ktime_t timeout;
 
-	hrtimer_init_on_stack(&iowq->t, clock_id, HRTIMER_MODE_ABS);
 	if (iowq->min_timeout) {
 		timeout = ktime_add_ns(iowq->min_timeout, start_time);
-		iowq->t.function = io_cqring_min_timer_wakeup;
+		hrtimer_setup_on_stack(&iowq->t, io_cqring_min_timer_wakeup, clock_id,
+				       HRTIMER_MODE_ABS);
 	} else {
 		timeout = iowq->timeout;
-		iowq->t.function = io_cqring_timer_wakeup;
+		hrtimer_setup_on_stack(&iowq->t, io_cqring_timer_wakeup, clock_id,
+				       HRTIMER_MODE_ABS);
 	}
 
 	hrtimer_set_expires_range_ns(&iowq->t, timeout, 0);

