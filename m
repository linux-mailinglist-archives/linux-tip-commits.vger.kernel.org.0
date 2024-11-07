Return-Path: <linux-tip-commits+bounces-2821-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9089BFC30
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 03:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE27B223C4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 02:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB752199FBB;
	Thu,  7 Nov 2024 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Md7bLFsE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zha7Qi+d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B919C196434;
	Thu,  7 Nov 2024 01:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944791; cv=none; b=AEy/Y8iyEt3qMtJEqIBLkswYlc9jV7hzsKWFYp133VyQKRD1zDAoFhjXulK599vmyuEv/1UuF+dRuCpe99TFdO6U7NEHivrkFWIv3Furq6m6vWdfWvViGRRelylEofPHLAfoJf9SYGqB2VSdQlMDk3Ld6A/ceQJgu83BFkIMEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944791; c=relaxed/simple;
	bh=hP9DBB8aPW2dBUlWcI+ciUQXblfDvhfk9gayqHbp7JQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TUpJ7NrW4VaExvp/KAh/2HHYbjfzRXIqHgNenSv/SLUVqbPLOWkmVeOlvDfhwVwoDulZD920yzG8zbh1RmJNkoxRyP+A2mRuHuJafpLsIsbSfw/x6RPiAmVVhBGGd1gGRPHJG+b7ZgEDCifFf+wja7fnJq3C/QdSEHa7x+vcroE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Md7bLFsE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zha7Qi+d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 01:59:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730944788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VhmawsHkU0TITUCycX+G0dxQpBbLpPFURSIvug0iUM=;
	b=Md7bLFsEON9JSItwOiZORVXn9zucM+tC4kqUtaXNsw2GytSWXIAOaRwGZ4ixEPSbAfP0ET
	lPhHNEAnDCda7Y0J4iAMugLr3p1ebttVvjkAEWlsDrplxx5nGZeSIzhx4DZz7ClWpTrvYU
	C5I0FtPdkD/lEHB8WfS81odRKCwBXO/jSXMuUBwTxZF0TOXtBPLdRmxeJpW9b3KEZtMlOE
	vhQ1xndoQs4zpA7EgvSveoCDWCjjiByTrsMU6QI8CtugYwEeUP95nNg3dZb8jIgZM3uxzc
	TiMzFJ0vZEUS1fLc5k9mBPevZ+c3TDceTiG3G1G5OLw4W2LJmOro+IrTKuyTOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730944788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9VhmawsHkU0TITUCycX+G0dxQpBbLpPFURSIvug0iUM=;
	b=Zha7Qi+dcdpjrIahSuFDa/xRyPYeIzBmkX81np3+mFBa71FOrQ0OrZVdJOvoLzau/tjJ+1
	oi7LoyBUsAk2XmAw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimers: Add missing hrtimer_init() trace points
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C74528e8abf2bb96e8bee85ffacbf14e15cf89f0d=2E17303?=
 =?utf-8?q?86209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C74528e8abf2bb96e8bee85ffacbf14e15cf89f0d=2E173038?=
 =?utf-8?q?6209=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173094478759.32228.13172976832915495727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fbf920f255315974808ce91d934fe50198294d51
Gitweb:        https://git.kernel.org/tip/fbf920f255315974808ce91d934fe50198294d51
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 31 Oct 2024 16:14:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 Nov 2024 02:47:04 +01:00

hrtimers: Add missing hrtimer_init() trace points

hrtimer_init*_on_stack() is not covered by tracing when
CONFIG_DEBUG_OBJECTS_TIMERS=y.

Rework the functions similar to hrtimer_init() and hrtimer_init_sleeper()
so that the hrtimer_init() tracepoint is unconditionally available.

The rework makes hrtimer_init_sleeper() unused. Delete it.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/74528e8abf2bb96e8bee85ffacbf14e15cf89f0d.1730386209.git.namcao@linutronix.de

---
 include/linux/hrtimer.h | 19 +------------
 kernel/time/hrtimer.c   | 65 ++++++++++++++++++++++------------------
 2 files changed, 37 insertions(+), 47 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index aa1e65c..5aa9d57 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -228,32 +228,15 @@ static inline void hrtimer_cancel_wait_running(struct hrtimer *timer)
 /* Initialize timers: */
 extern void hrtimer_init(struct hrtimer *timer, clockid_t which_clock,
 			 enum hrtimer_mode mode);
-extern void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_id,
-				 enum hrtimer_mode mode);
-
-#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 extern void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t which_clock,
 				  enum hrtimer_mode mode);
 extern void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
 					  clockid_t clock_id,
 					  enum hrtimer_mode mode);
 
+#ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 extern void destroy_hrtimer_on_stack(struct hrtimer *timer);
 #else
-static inline void hrtimer_init_on_stack(struct hrtimer *timer,
-					 clockid_t which_clock,
-					 enum hrtimer_mode mode)
-{
-	hrtimer_init(timer, which_clock, mode);
-}
-
-static inline void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
-						 clockid_t clock_id,
-						 enum hrtimer_mode mode)
-{
-	hrtimer_init_sleeper(sl, clock_id, mode);
-}
-
 static inline void destroy_hrtimer_on_stack(struct hrtimer *timer) { }
 #endif
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 04f7d8a..4b0507c 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -417,6 +417,11 @@ static inline void debug_hrtimer_init(struct hrtimer *timer)
 	debug_object_init(timer, &hrtimer_debug_descr);
 }
 
+static inline void debug_hrtimer_init_on_stack(struct hrtimer *timer)
+{
+	debug_object_init_on_stack(timer, &hrtimer_debug_descr);
+}
+
 static inline void debug_hrtimer_activate(struct hrtimer *timer,
 					  enum hrtimer_mode mode)
 {
@@ -428,28 +433,6 @@ static inline void debug_hrtimer_deactivate(struct hrtimer *timer)
 	debug_object_deactivate(timer, &hrtimer_debug_descr);
 }
 
-static void __hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode);
-
-void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t clock_id,
-			   enum hrtimer_mode mode)
-{
-	debug_object_init_on_stack(timer, &hrtimer_debug_descr);
-	__hrtimer_init(timer, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
-
-static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode);
-
-void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
-				   clockid_t clock_id, enum hrtimer_mode mode)
-{
-	debug_object_init_on_stack(&sl->timer, &hrtimer_debug_descr);
-	__hrtimer_init_sleeper(sl, clock_id, mode);
-}
-EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
-
 void destroy_hrtimer_on_stack(struct hrtimer *timer)
 {
 	debug_object_free(timer, &hrtimer_debug_descr);
@@ -459,6 +442,7 @@ EXPORT_SYMBOL_GPL(destroy_hrtimer_on_stack);
 #else
 
 static inline void debug_hrtimer_init(struct hrtimer *timer) { }
+static inline void debug_hrtimer_init_on_stack(struct hrtimer *timer) { }
 static inline void debug_hrtimer_activate(struct hrtimer *timer,
 					  enum hrtimer_mode mode) { }
 static inline void debug_hrtimer_deactivate(struct hrtimer *timer) { }
@@ -472,6 +456,13 @@ debug_init(struct hrtimer *timer, clockid_t clockid,
 	trace_hrtimer_init(timer, clockid, mode);
 }
 
+static inline void debug_init_on_stack(struct hrtimer *timer, clockid_t clockid,
+				       enum hrtimer_mode mode)
+{
+	debug_hrtimer_init_on_stack(timer);
+	trace_hrtimer_init(timer, clockid, mode);
+}
+
 static inline void debug_activate(struct hrtimer *timer,
 				  enum hrtimer_mode mode)
 {
@@ -1600,6 +1591,23 @@ void hrtimer_init(struct hrtimer *timer, clockid_t clock_id,
 }
 EXPORT_SYMBOL_GPL(hrtimer_init);
 
+/**
+ * hrtimer_init_on_stack - initialize a timer in stack memory
+ * @timer:	The timer to be initialized
+ * @clock_id:	The clock to be used
+ * @mode:       The timer mode
+ *
+ * Similar to hrtimer_init(), except that this one must be used if struct hrtimer is in stack
+ * memory.
+ */
+void hrtimer_init_on_stack(struct hrtimer *timer, clockid_t clock_id,
+			   enum hrtimer_mode mode)
+{
+	debug_init_on_stack(timer, clock_id, mode);
+	__hrtimer_init(timer, clock_id, mode);
+}
+EXPORT_SYMBOL_GPL(hrtimer_init_on_stack);
+
 /*
  * A timer is active, when it is enqueued into the rbtree or the
  * callback function is running or it's in the state of being migrated
@@ -1944,7 +1952,7 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl,
 	 * Make the enqueue delivery mode check work on RT. If the sleeper
 	 * was initialized for hard interrupt delivery, force the mode bit.
 	 * This is a special case for hrtimer_sleepers because
-	 * hrtimer_init_sleeper() determines the delivery mode on RT so the
+	 * __hrtimer_init_sleeper() determines the delivery mode on RT so the
 	 * fiddling with this decision is avoided at the call sites.
 	 */
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && sl->timer.is_hard)
@@ -1987,19 +1995,18 @@ static void __hrtimer_init_sleeper(struct hrtimer_sleeper *sl,
 }
 
 /**
- * hrtimer_init_sleeper - initialize sleeper to the given clock
+ * hrtimer_init_sleeper_on_stack - initialize a sleeper in stack memory
  * @sl:		sleeper to be initialized
  * @clock_id:	the clock to be used
  * @mode:	timer mode abs/rel
  */
-void hrtimer_init_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_id,
-			  enum hrtimer_mode mode)
+void hrtimer_init_sleeper_on_stack(struct hrtimer_sleeper *sl,
+				   clockid_t clock_id, enum hrtimer_mode mode)
 {
-	debug_init(&sl->timer, clock_id, mode);
+	debug_init_on_stack(&sl->timer, clock_id, mode);
 	__hrtimer_init_sleeper(sl, clock_id, mode);
-
 }
-EXPORT_SYMBOL_GPL(hrtimer_init_sleeper);
+EXPORT_SYMBOL_GPL(hrtimer_init_sleeper_on_stack);
 
 int nanosleep_copyout(struct restart_block *restart, struct timespec64 *ts)
 {

