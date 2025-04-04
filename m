Return-Path: <linux-tip-commits+bounces-4678-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C140A7C27E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC35F1B609E5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102A1220693;
	Fri,  4 Apr 2025 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fzO0Zh3V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V1Vv2n4h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E3E21D3EB;
	Fri,  4 Apr 2025 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788055; cv=none; b=Jz7AXUM8I/bvHMm9cFi9hjLL+sGJQVzKWlDsjvz304lMdSQaikLMbSRVmJRAJ2SAk2ahlBelTG2XdZbU2CqLBC2MMamaIzalZGXhJQcaNlQK+T9hdI/iVK6WsWtxgIBn3Jj/Ro4j+9f+cprjKjSP43XCAlYz/WZlqWETPGcDjG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788055; c=relaxed/simple;
	bh=EnNmEcwb9RA2fAK4TbiENxsA8nT0uLmnOg3oMDCXc+0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T7hYPdm+xpbEQvFlAgkgPh1gscMw4R3zLxepNImJwCXaFU7eXRDWTeHU3Ef3DLIjkE+Uy1rC7+cWmvSbGLH16r2gHsbpfWlHOGZ7jdNNCbAKKzyFYCjZuSNdH7LADwGMql6r/tqONHpncPJsSBCMNg14OlbgkoIjIMkI9cAg66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fzO0Zh3V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V1Vv2n4h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:34:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743788051;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTabLwBWRDXEPusGLYJQd7FktlpI8X2xXbduKZaYjDM=;
	b=fzO0Zh3VsRhBHY5DOvg05jId9j1XZ5Q7GjuNDTqeRqEWKLnQbe9ifiwy9LYAzTTywHQEuf
	ofXrJtb/5alQwKY2VC2aeRexQtNCVjxgP/qkkV/y+06zrG1mI39Ovv1pFRtLSgVDE5+CvC
	HKvzzY9RTIzdD5F7B9B8ISrBBCP5I5t58NpYNwdiugZYfTMZKC5unYONJsGDnoNanZnNQ/
	lTX8eo5qBsxqVS1OE0XtjpW8Bi7njKKBfN76QzTRUbTCKVvAZEmr+8VttEDgVF3b8gITC5
	4RQ0eszq1O7QGii+ES13h5+IYzzoCJ4xue5WNVM0XD+9ZUvNUr9GCJDz0aHeow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743788051;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTabLwBWRDXEPusGLYJQd7FktlpI8X2xXbduKZaYjDM=;
	b=V1Vv2n4hnSn3U6lT3r4U9fvJPxJnHljYvL4I+qyXnSdVzNE7BqQvIFQxhAt/4hXYpBTnno
	QvTqKAxjZ180UxBA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/cleanups] hrtimers: Make callback function pointer private
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C7d0e6e0c5c59a64a9bea940051aac05d750bc0c2=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C7d0e6e0c5c59a64a9bea940051aac05d750bc0c2=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378805070.31282.26909465736111586.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     96d6ac8afcdede3f80230992d587a17000357c28
Gitweb:        https://git.kernel.org/tip/96d6ac8afcdede3f80230992d587a17000357c28
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:26:44 +02:00

hrtimers: Make callback function pointer private

Make the field 'function' of struct hrtimer private, to prevent users from
changing this field in an unsafe way. hrtimer_update_function() should be
used if the callback function needs to be changed.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/7d0e6e0c5c59a64a9bea940051aac05d750bc0c2.1738746927.git.namcao@linutronix.de

---
 include/linux/hrtimer_types.h | 2 +-
 include/trace/events/timer.h  | 4 ++--
 kernel/time/hrtimer.c         | 8 ++++----
 kernel/time/timer_list.c      | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/hrtimer_types.h b/include/linux/hrtimer_types.h
index 7c5b27d..8fbbb6b 100644
--- a/include/linux/hrtimer_types.h
+++ b/include/linux/hrtimer_types.h
@@ -39,7 +39,7 @@ enum hrtimer_restart {
 struct hrtimer {
 	struct timerqueue_node		node;
 	ktime_t				_softexpires;
-	enum hrtimer_restart		(*function)(struct hrtimer *);
+	enum hrtimer_restart		(*__private function)(struct hrtimer *);
 	struct hrtimer_clock_base	*base;
 	u8				state;
 	u8				is_rel;
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 1ef58a0..f8c906b 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -235,7 +235,7 @@ TRACE_EVENT(hrtimer_start,
 
 	TP_fast_assign(
 		__entry->hrtimer	= hrtimer;
-		__entry->function	= hrtimer->function;
+		__entry->function	= ACCESS_PRIVATE(hrtimer, function);
 		__entry->expires	= hrtimer_get_expires(hrtimer);
 		__entry->softexpires	= hrtimer_get_softexpires(hrtimer);
 		__entry->mode		= mode;
@@ -271,7 +271,7 @@ TRACE_EVENT(hrtimer_expire_entry,
 	TP_fast_assign(
 		__entry->hrtimer	= hrtimer;
 		__entry->now		= *now;
-		__entry->function	= hrtimer->function;
+		__entry->function	= ACCESS_PRIVATE(hrtimer, function);
 	),
 
 	TP_printk("hrtimer=%p function=%ps now=%llu",
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 163cde3..88ea4bb 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1316,7 +1316,7 @@ void hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
 	struct hrtimer_clock_base *base;
 	unsigned long flags;
 
-	if (WARN_ON_ONCE(!timer->function))
+	if (WARN_ON_ONCE(!ACCESS_PRIVATE(timer, function)))
 		return;
 	/*
 	 * Check whether the HRTIMER_MODE_SOFT bit and hrtimer.is_soft
@@ -1629,9 +1629,9 @@ static void __hrtimer_setup(struct hrtimer *timer,
 	timerqueue_init(&timer->node);
 
 	if (WARN_ON_ONCE(!function))
-		timer->function = hrtimer_dummy_timeout;
+		ACCESS_PRIVATE(timer, function) = hrtimer_dummy_timeout;
 	else
-		timer->function = function;
+		ACCESS_PRIVATE(timer, function) = function;
 }
 
 /**
@@ -1743,7 +1743,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 	raw_write_seqcount_barrier(&base->seq);
 
 	__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, 0);
-	fn = timer->function;
+	fn = ACCESS_PRIVATE(timer, function);
 
 	/*
 	 * Clear the 'is relative' flag for the TIME_LOW_RES case. If the
diff --git a/kernel/time/timer_list.c b/kernel/time/timer_list.c
index cfbb46c..51fa7ae 100644
--- a/kernel/time/timer_list.c
+++ b/kernel/time/timer_list.c
@@ -46,7 +46,7 @@ static void
 print_timer(struct seq_file *m, struct hrtimer *taddr, struct hrtimer *timer,
 	    int idx, u64 now)
 {
-	SEQ_printf(m, " #%d: <%p>, %ps", idx, taddr, timer->function);
+	SEQ_printf(m, " #%d: <%p>, %ps", idx, taddr, ACCESS_PRIVATE(timer->function));
 	SEQ_printf(m, ", S:%02x", timer->state);
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, " # expires at %Lu-%Lu nsecs [in %Ld to %Ld nsecs]\n",

