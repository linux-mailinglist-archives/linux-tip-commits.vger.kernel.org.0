Return-Path: <linux-tip-commits+bounces-4673-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE4EA7C275
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072C47A934E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40EB21B9D8;
	Fri,  4 Apr 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1EM9d/FQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fLisv/Sy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC221930D;
	Fri,  4 Apr 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788047; cv=none; b=uo7dneOgm8dEnKVni63HIICdvcXD3iyAr7cB8LsxTFUcsXUSWZBr8cDooRL9n7nG3lziYTEIkw7zgXmWVAKWmeXjMTk8d0ICCO38OAC2G8b8jTbgQyEYbqC1zFxTP5HM41zs3mPTuY1sU1T67p1CxuEz8Yh/SpRoX7QP/0xItdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788047; c=relaxed/simple;
	bh=IF5oHoO8C6ivrEqcXhe8Ro+Lq5nsYu2Y+ZWaquEz57E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UGEXkgkL2kVOptJkuf3lG+32x2CH9J0hdDWCdN2BrcrsavFjvQBWs9m6EnqQ7KmfQL/50suGeFWgTdfdbF8HE9S1lmsilYAjbzc5heaB5/zNlGTeVbWCi/E3o/RXXiXp9D80Nn8avtg3KSVR+zN2hfQySFBdWS7X7hPqkunxM3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1EM9d/FQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fLisv/Sy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:34:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743788043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sO2ss37hevj6ozIogD6LTpjpe5oYgOvizGtJ0XorT2k=;
	b=1EM9d/FQ3PY9BbRw+Cw+OmspNVWQcfffiJJDa1zAUIAk8icYeSq63iplfuc6+F1ZTDZPmD
	mvXhDxDuDtVZ2lzio3ZsVy5GQ95dKRaSOg/BT4Ygw3/fZIOxlH5NaAyI29eIz+Fr4b8WpC
	tPwXIC4+kGvvmQbAodvZPumhYU54NuJTjUV57DWak7No3Vx5FP4gdhHhZK+aQni1ING3Ht
	WBAKboNVL1us5Z5KgFvm2WdLeiSFL243bVCxiHcZ7NQWz4yNGnsS3muMIDwrGvyLjl9xAg
	GW0bQcWnYkOjygmVxvqLdxkiJRcyz9eULCduoJzVZTZlxs0Zfe2qq5LxMgoxEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743788043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sO2ss37hevj6ozIogD6LTpjpe5oYgOvizGtJ0XorT2k=;
	b=fLisv/SyaVJQBgFKZ9UXbrZM8WsoQitQFnYPzE21sDUPyCJfn2sExK5YTpjcI7sCxLgbg+
	nXxZhofRPUIvfQCQ==
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
Message-ID: <174378804321.31282.7177939189948821917.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     8cc954cc3ab8670048a1bbb63fd10b5287677eeb
Gitweb:        https://git.kernel.org/tip/8cc954cc3ab8670048a1bbb63fd10b5287677eeb
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:55:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:26:44 +02:00

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
 

