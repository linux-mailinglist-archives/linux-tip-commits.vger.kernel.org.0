Return-Path: <linux-tip-commits+bounces-4683-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72166A7C2E4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6538A3B53C2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92421859F;
	Fri,  4 Apr 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fMOn7lUo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4hrRZxTn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770918FC92;
	Fri,  4 Apr 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743789276; cv=none; b=mIDJXnyT2znoUEjYdSiVHB7R/VCERUVI3HVKcFz2h40M8eZfBGhRo4Ldl6QMfR+04RehKeDU2RTD8ahYFPl1Mm6HrBjciXj2FMSm+bLEHKeOall6XV7/hRtcGQpSaI3Trw/zWyUb9VuVPWnTNZDBe7yCgJmYMK4N1L6EPcqdyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743789276; c=relaxed/simple;
	bh=wSfbU742Gs1JQbaV51kQJsTnQAellvKi9VA318u6Ikw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jvXCWALPwfdTRG+mKwPifr1xFQxxRms+E35TvBatjri9zpzISLsRboVDpDyazy1Rja0Zsu3lTU7swDZUZ7vzcCSQSro96XWsYg3jvC+hKlJ4apYkw/rcvDy2O1BM3AdUoKiGCn/WZaZ4DJ6in/GRawZMJYhTQwAD8chru3ChzLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fMOn7lUo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4hrRZxTn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743789272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9kcu84XS9iT0hxnySV/xPiJkvzREcu18JNmweOcra8=;
	b=fMOn7lUowT5gvt4MZU91gWIUVVOGEPjwcZYCxxJB4b2PelKMi1a6fKIM1inD5Q7odAdM73
	00+4ysmLcDgNb+WvCKqsvVNEOS+rAxjtnjfnKvLmAzD92HnKvOBVTVxmCh0/tbV/C/2JuO
	ArvEWtjNv2Ue/34OxRrBd7LSjTpsyDq2DYROZKs+6YoRxCLLQj/pXLUqf0OpGmkJF4ZVXC
	QWXe35rxcOu+kksh6NKBPnZcD0lUakzMHRnaUnHsFJa6EJuoJkPW4Bn1n28fG8vKjOQmiT
	NVYMjNE+rKvarxb6Rn9aNCxg69XQMaoLE2pZlNqd9rhxuXISbG2Z4JxVtK8Eeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743789272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9kcu84XS9iT0hxnySV/xPiJkvzREcu18JNmweOcra8=;
	b=4hrRZxTnJwSvrxSvV6lN8efGZsAkYfEFjfiZpOaiBhoLQCMr1pH0Nys12O05/dq6XVytwz
	Hnj7tRXT/VBrAxAw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] tracing/timers: Rename hrtimer_init event to
 hrtimer_setup
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ccba84c3d853c5258aa3a262363a6eac08e2c7afc=2E17387?=
 =?utf-8?q?46927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ccba84c3d853c5258aa3a262363a6eac08e2c7afc=2E173874?=
 =?utf-8?q?6927=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378927164.31282.16212404106131087317.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     b33f0e454c28ce1fd504367575accecdf4c64dc3
Gitweb:        https://git.kernel.org/tip/b33f0e454c28ce1fd504367575accecdf4c64dc3
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:46:07 +02:00

tracing/timers: Rename hrtimer_init event to hrtimer_setup

The function hrtimer_init() doesn't exist anymore. It was replaced by
hrtimer_setup().

Thus, rename the hrtimer_init trace event to hrtimer_setup to keep it
consistent.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/cba84c3d853c5258aa3a262363a6eac08e2c7afc.1738746927.git.namcao@linutronix.de

---
 Documentation/trace/ftrace.rst           | 4 ++--
 include/trace/events/timer.h             | 4 ++--
 kernel/time/hrtimer.c                    | 4 ++--
 tools/perf/tests/shell/trace_btf_enum.sh | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 2b74f96..c9e88bf 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -3077,7 +3077,7 @@ Notice that we lost the sys_nanosleep.
   # cat set_ftrace_filter
   hrtimer_run_queues
   hrtimer_run_pending
-  hrtimer_init
+  hrtimer_setup
   hrtimer_cancel
   hrtimer_try_to_cancel
   hrtimer_forward
@@ -3115,7 +3115,7 @@ Again, now we want to append.
   # cat set_ftrace_filter
   hrtimer_run_queues
   hrtimer_run_pending
-  hrtimer_init
+  hrtimer_setup
   hrtimer_cancel
   hrtimer_try_to_cancel
   hrtimer_forward
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index f8c906b..1641ae3 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -185,12 +185,12 @@ TRACE_EVENT(timer_base_idle,
 		{ HRTIMER_MODE_REL_PINNED_HARD,	"REL|PINNED|HARD" })
 
 /**
- * hrtimer_init - called when the hrtimer is initialized
+ * hrtimer_setup - called when the hrtimer is initialized
  * @hrtimer:	pointer to struct hrtimer
  * @clockid:	the hrtimers clock
  * @mode:	the hrtimers mode
  */
-TRACE_EVENT(hrtimer_init,
+TRACE_EVENT(hrtimer_setup,
 
 	TP_PROTO(struct hrtimer *hrtimer, clockid_t clockid,
 		 enum hrtimer_mode mode),
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 4bf91fa..517ee25 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -468,14 +468,14 @@ static inline void debug_hrtimer_deactivate(struct hrtimer *timer) { }
 static inline void debug_setup(struct hrtimer *timer, clockid_t clockid, enum hrtimer_mode mode)
 {
 	debug_hrtimer_init(timer);
-	trace_hrtimer_init(timer, clockid, mode);
+	trace_hrtimer_setup(timer, clockid, mode);
 }
 
 static inline void debug_setup_on_stack(struct hrtimer *timer, clockid_t clockid,
 					enum hrtimer_mode mode)
 {
 	debug_hrtimer_init_on_stack(timer);
-	trace_hrtimer_init(timer, clockid, mode);
+	trace_hrtimer_setup(timer, clockid, mode);
 }
 
 static inline void debug_activate(struct hrtimer *timer,
diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/shell/trace_btf_enum.sh
index 60b3fa2..f0b49f7 100755
--- a/tools/perf/tests/shell/trace_btf_enum.sh
+++ b/tools/perf/tests/shell/trace_btf_enum.sh
@@ -6,7 +6,7 @@ err=0
 set -e
 
 syscall="landlock_add_rule"
-non_syscall="timer:hrtimer_init,timer:hrtimer_start"
+non_syscall="timer:hrtimer_setup,timer:hrtimer_start"
 
 TESTPROG="perf test -w landlock"
 

