Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F4C2779D2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Sep 2020 21:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgIXT6J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Sep 2020 15:58:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50976 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXT6I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Sep 2020 15:58:08 -0400
Date:   Thu, 24 Sep 2020 19:58:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600977485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLLQdVTVheDnB1iAawxlSbbAXm6Fy6TLhHdlRVHvUKk=;
        b=vMKOZSFPp0Q/SQ4P4dGMdiM+iawYq+pyVIK+peLTxDnN0xlo90CpvqHuCcfLqs9Fbz67If
        4k8/g4o43P37szQvlLAPozeUlXl4eZAgesPZ6Vh9VZQ22XFtBrqdidF6oEdZGWynZvDjVk
        iqSVLEtn5BR7TgHQTb0sb9JV+hRsdRb6ng2LIoio/Nfrk+v4yWLBzjfI6Wbs9QCUTazyIY
        oLyB/07y5zBMKkGkoshhhsRHnGBpuSFZQ9pAFs85G1ps0tZiLic2MuRQXZNtGOQy/aCgQE
        3c3w6WjeID5rF1yHAnv8eF5TJS2HJ2EREaHeEdLKH83pBAvRQ97hdc6iNGjNUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600977485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLLQdVTVheDnB1iAawxlSbbAXm6Fy6TLhHdlRVHvUKk=;
        b=61mP5yMH3MaGpciyyDBNRy4b5xxmtH4ewoDwNt0wjfivS4noh8Sfno4uqfo51NJFkvTd4X
        WuCcEu8k721kljCw==
From:   "tip-bot2 for Stephen Boyd" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] treewide: Make all debug_obj_descriptors const
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200815004027.2046113-3-swboyd@chromium.org>
References: <20200815004027.2046113-3-swboyd@chromium.org>
MIME-Version: 1.0
Message-ID: <160097748447.7002.11424228113247959299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     f9e62f318fd706a54b7ce9b28e5c7e49bbde8788
Gitweb:        https://git.kernel.org/tip/f9e62f318fd706a54b7ce9b28e5c7e49bbde8788
Author:        Stephen Boyd <swboyd@chromium.org>
AuthorDate:    Fri, 14 Aug 2020 17:40:27 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Sep 2020 21:56:25 +02:00

treewide: Make all debug_obj_descriptors const

This should make it harder for the kernel to corrupt the debug object
descriptor, used to call functions to fixup state and track debug objects,
by moving the structure to read-only memory.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200815004027.2046113-3-swboyd@chromium.org

---
 drivers/gpu/drm/i915/i915_active.c   | 2 +-
 drivers/gpu/drm/i915/i915_sw_fence.c | 2 +-
 kernel/rcu/rcu.h                     | 2 +-
 kernel/rcu/update.c                  | 2 +-
 kernel/time/hrtimer.c                | 4 ++--
 kernel/time/timer.c                  | 4 ++--
 kernel/workqueue.c                   | 4 ++--
 lib/percpu_counter.c                 | 4 ++--
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index d960d0b..839bd53 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -81,7 +81,7 @@ static void *active_debug_hint(void *addr)
 	return (void *)ref->active ?: (void *)ref->retire ?: (void *)ref;
 }
 
-static struct debug_obj_descr active_debug_desc = {
+static const struct debug_obj_descr active_debug_desc = {
 	.name = "i915_active",
 	.debug_hint = active_debug_hint,
 };
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index 4cd2038..038d4c6 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -34,7 +34,7 @@ static void *i915_sw_fence_debug_hint(void *addr)
 
 #ifdef CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS
 
-static struct debug_obj_descr i915_sw_fence_debug_descr = {
+static const struct debug_obj_descr i915_sw_fence_debug_descr = {
 	.name = "i915_sw_fence",
 	.debug_hint = i915_sw_fence_debug_hint,
 };
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index cf66a3c..e01cba5 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -167,7 +167,7 @@ static inline unsigned long rcu_seq_diff(unsigned long new, unsigned long old)
 # define STATE_RCU_HEAD_READY	0
 # define STATE_RCU_HEAD_QUEUED	1
 
-extern struct debug_obj_descr rcuhead_debug_descr;
+extern const struct debug_obj_descr rcuhead_debug_descr;
 
 static inline int debug_rcu_head_queue(struct rcu_head *head)
 {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 2de49b5..3e0f4bc 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -469,7 +469,7 @@ void destroy_rcu_head_on_stack(struct rcu_head *head)
 }
 EXPORT_SYMBOL_GPL(destroy_rcu_head_on_stack);
 
-struct debug_obj_descr rcuhead_debug_descr = {
+const struct debug_obj_descr rcuhead_debug_descr = {
 	.name = "rcu_head",
 	.is_static_object = rcuhead_is_static_object,
 };
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 95b6a70..3624b9b 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(ktime_add_safe);
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 
-static struct debug_obj_descr hrtimer_debug_descr;
+static const struct debug_obj_descr hrtimer_debug_descr;
 
 static void *hrtimer_debug_hint(void *addr)
 {
@@ -401,7 +401,7 @@ static bool hrtimer_fixup_free(void *addr, enum debug_obj_state state)
 	}
 }
 
-static struct debug_obj_descr hrtimer_debug_descr = {
+static const struct debug_obj_descr hrtimer_debug_descr = {
 	.name		= "hrtimer",
 	.debug_hint	= hrtimer_debug_hint,
 	.fixup_init	= hrtimer_fixup_init,
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a50364d..8b17cf2 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -611,7 +611,7 @@ static void internal_add_timer(struct timer_base *base, struct timer_list *timer
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 
-static struct debug_obj_descr timer_debug_descr;
+static const struct debug_obj_descr timer_debug_descr;
 
 static void *timer_debug_hint(void *addr)
 {
@@ -707,7 +707,7 @@ static bool timer_fixup_assert_init(void *addr, enum debug_obj_state state)
 	}
 }
 
-static struct debug_obj_descr timer_debug_descr = {
+static const struct debug_obj_descr timer_debug_descr = {
 	.name			= "timer_list",
 	.debug_hint		= timer_debug_hint,
 	.is_static_object	= timer_is_static_object,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c41c3c1..ac088ce 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -427,7 +427,7 @@ static void show_pwq(struct pool_workqueue *pwq);
 
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
 
-static struct debug_obj_descr work_debug_descr;
+static const struct debug_obj_descr work_debug_descr;
 
 static void *work_debug_hint(void *addr)
 {
@@ -477,7 +477,7 @@ static bool work_fixup_free(void *addr, enum debug_obj_state state)
 	}
 }
 
-static struct debug_obj_descr work_debug_descr = {
+static const struct debug_obj_descr work_debug_descr = {
 	.name		= "work_struct",
 	.debug_hint	= work_debug_hint,
 	.is_static_object = work_is_static_object,
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index a2345de..f61689a 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -17,7 +17,7 @@ static DEFINE_SPINLOCK(percpu_counters_lock);
 
 #ifdef CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER
 
-static struct debug_obj_descr percpu_counter_debug_descr;
+static const struct debug_obj_descr percpu_counter_debug_descr;
 
 static bool percpu_counter_fixup_free(void *addr, enum debug_obj_state state)
 {
@@ -33,7 +33,7 @@ static bool percpu_counter_fixup_free(void *addr, enum debug_obj_state state)
 	}
 }
 
-static struct debug_obj_descr percpu_counter_debug_descr = {
+static const struct debug_obj_descr percpu_counter_debug_descr = {
 	.name		= "percpu_counter",
 	.fixup_free	= percpu_counter_fixup_free,
 };
