Return-Path: <linux-tip-commits+bounces-2349-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46E992087
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Oct 2024 21:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253AA1F20F66
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Oct 2024 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB4C189F2D;
	Sun,  6 Oct 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="stcf2TQf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XSvGEEc4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3517DFE4;
	Sun,  6 Oct 2024 19:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728241482; cv=none; b=DezgSyAlgGjyMjJeiD/E5IJJRUky8URDq7v+WveoZFH+RK6+Z2Uw/dE4+8CQSVGh7h0A96wuYjfgVklj214EdSnwbFdmZ7xk+yelpZt4oFYaM5pUmfpi8FEHWPDhMS1CNoUZnTY2v1/a50v8NOpnwU9oYafYUupV9ofVVV9Tg+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728241482; c=relaxed/simple;
	bh=nP5tRJwLAZp5uiryvPK5vL1/lxHMWOI/0iH6oAWEFJk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FMj53+GHnKrDm+8oExLK21BO9BE29w5hVMTycF86R/Pa9fhxTgwhf3Tie7RElYxn3g/mNthk8vhbExu0QQx6/eK1rXV/8imc5owz6ePs8kDCy7V9fWn33WtpFYXqSc3SifaLWC872Mt1bNllbukheev/d8ziH5rz3jZGZeQUTi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=stcf2TQf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XSvGEEc4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 06 Oct 2024 19:04:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728241472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6OjeNjJOp7w69Ins+HcIMamTp/DgSEVMq1TAbhU2Co=;
	b=stcf2TQfl2m27Jy4JPpkwoluEDhgD+JecJ4GhELdjlMtf+9/aozSh7BifXsnaU+QNQ07im
	NAtVQUgU7GcdBMe1V19oG0E6egQ+52gps9U8ZgfTsk1A/qcVUqMbTlzyXwAeQedn3i/nEa
	+AxMTjY1Fc9vliHSYEulBvJmaZX75AquHC4Zico5+7VE9uWl/19qktat7A4C9HHSz7sJRz
	SiwmLekStC9WFqU6R89DBVynFH+SmOAbf7E7KPmOtt57EY9gL98jN1o7NO9KROxUh2aebH
	dw2oNJ5kqCW5KXI060yUsxUbIflz4WOdcZmwq3UgjGUOWlyU3NHqhSRizdiI8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728241472;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q6OjeNjJOp7w69Ins+HcIMamTp/DgSEVMq1TAbhU2Co=;
	b=XSvGEEc47/mNvO7oh0HFq0zAgke+ho/v3PvzwVVy772fWjgDTDszeKwgUHP+C5jBEY/0oF
	f7rsJkeTwadLcqCg==
From: "tip-bot2 for Jeff Layton" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Add percpu counter for tracking floor
 swap events
Cc: Jeff Layton <jlayton@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241002-mgtime-v10-2-d1c4717f5284@kernel.org>
References: <20241002-mgtime-v10-2-d1c4717f5284@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172824147176.1442.3680169489221943386.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     96f9a366ec8abe027326d7aab84d64370019f0f1
Gitweb:        https://git.kernel.org/tip/96f9a366ec8abe027326d7aab84d64370019f0f1
Author:        Jeff Layton <jlayton@kernel.org>
AuthorDate:    Wed, 02 Oct 2024 17:27:17 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 06 Oct 2024 20:56:07 +02:00

timekeeping: Add percpu counter for tracking floor swap events

The mgtime_floor value is a global variable for tracking the latest
fine-grained timestamp handed out. Because it's a global, track the
number of times that a new floor value is assigned.

Add a new percpu counter to the timekeeping code to track the number of
floor swap events that have occurred. A later patch will add a debugfs
file to display this counter alongside other stats involving multigrain
timestamps.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # documentation bits
Link: https://lore.kernel.org/all/20241002-mgtime-v10-2-d1c4717f5284@kernel.org

---
 include/linux/timekeeping.h        |  1 +
 kernel/time/timekeeping.c          |  1 +
 kernel/time/timekeeping_debug.c    | 13 +++++++++++++
 kernel/time/timekeeping_internal.h | 15 +++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 7aa8524..84a035e 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -48,6 +48,7 @@ extern void ktime_get_coarse_real_ts64(struct timespec64 *ts);
 /* Multigrain timestamp interfaces */
 extern void ktime_get_coarse_real_ts64_mg(struct timespec64 *ts);
 extern void ktime_get_real_ts64_mg(struct timespec64 *ts);
+extern unsigned long timekeeping_get_mg_floor_swaps(void);
 
 void getboottime64(struct timespec64 *ts);
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 441792c..962b2a3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2487,6 +2487,7 @@ void ktime_get_real_ts64_mg(struct timespec64 *ts)
 	if (atomic64_try_cmpxchg(&mg_floor, &old, mono)) {
 		ts->tv_nsec = 0;
 		timespec64_add_ns(ts, nsecs);
+		timekeeping_inc_mg_floor_swaps();
 	} else {
 		/*
 		 * Another task changed mg_floor since "old" was fetched.
diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index b73e885..badeb22 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -17,6 +17,9 @@
 
 #define NUM_BINS 32
 
+/* Incremented every time mg_floor is updated */
+DEFINE_PER_CPU(unsigned long, timekeeping_mg_floor_swaps);
+
 static unsigned int sleep_time_bin[NUM_BINS] = {0};
 
 static int tk_debug_sleep_time_show(struct seq_file *s, void *data)
@@ -53,3 +56,13 @@ void tk_debug_account_sleep_time(const struct timespec64 *t)
 			   (s64)t->tv_sec, t->tv_nsec / NSEC_PER_MSEC);
 }
 
+unsigned long timekeeping_get_mg_floor_swaps(void)
+{
+	unsigned long sum = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		sum += data_race(per_cpu(timekeeping_mg_floor_swaps, cpu));
+
+	return sum;
+}
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index 4ca2787..0bbae82 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -10,9 +10,24 @@
  * timekeeping debug functions
  */
 #ifdef CONFIG_DEBUG_FS
+
+DECLARE_PER_CPU(unsigned long, timekeeping_mg_floor_swaps);
+
+static inline void timekeeping_inc_mg_floor_swaps(void)
+{
+	this_cpu_inc(timekeeping_mg_floor_swaps);
+}
+
 extern void tk_debug_account_sleep_time(const struct timespec64 *t);
+
 #else
+
 #define tk_debug_account_sleep_time(x)
+
+static inline void timekeeping_inc_mg_floor_swaps(void)
+{
+}
+
 #endif
 
 #ifdef CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE

