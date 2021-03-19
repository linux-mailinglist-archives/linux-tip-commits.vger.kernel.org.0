Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C19341D75
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 13:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhCSMyf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 08:54:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36790 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhCSMyU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 08:54:20 -0400
Date:   Fri, 19 Mar 2021 12:54:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616158457;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pMVtDeL57wpuY1iC29u0zXR/vN/EFdKUZPIJhjXUX40=;
        b=LQ72q44njjnpba7mPpu3Z/0sD2oHz+advmgMoIzb5gR0i1uO/zx+j9T/w+ujnLZsq/66rk
        20rPyDe6oj+zub+UZZH6sp1M0+qCYFg0aUru2Lpd7LJT3UaMHkHoerjA1z6znUFIGc3X6+
        mo4zP3z4ICJpDNi8j3gT5Xz5tHKBkW9BM68zq04dHIO3hhaUqAChJqIX4MlWH1qqmpkzRa
        8tDsBR6RryLPq5jVFMcRnB9asjspSun3Kgg8YD6ASl0oFYllXXT1udKDHnhL3AMaUKWaJ0
        ErjCiVtmcRb99pL4iZak4CAb/bcHLDWiHB2F/f1CilIoW3w7JJN1ec8Sj5P0KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616158457;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pMVtDeL57wpuY1iC29u0zXR/vN/EFdKUZPIJhjXUX40=;
        b=3+mn0+It+G6tFBUMVJ5MiSp7RNaUMOSmyS13iZkYJGM4VeTZ9/IZeWH2GzNkFTA2cSrFg/
        GgvOomULV4YLYTCg==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/locktorture: Fix incorrect use of
 ww_acquire_ctx in ww_mutex test
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210318172814.4400-6-longman@redhat.com>
References: <20210318172814.4400-6-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <161615845666.398.7560382674265610345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8c52cca04f97a4c09ec2f0bd8fe6d0cdf49834e4
Gitweb:        https://git.kernel.org/tip/8c52cca04f97a4c09ec2f0bd8fe6d0cdf49834e4
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 18 Mar 2021 13:28:14 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 19 Mar 2021 12:13:10 +01:00

locking/locktorture: Fix incorrect use of ww_acquire_ctx in ww_mutex test

The ww_acquire_ctx structure for ww_mutex needs to persist for a complete
lock/unlock cycle. In the ww_mutex test in locktorture, however, both
ww_acquire_init() and ww_acquire_fini() are called within the lock
function only. This causes a lockdep splat of "WARNING: Nested lock
was not taken" when lockdep is enabled in the kernel.

To fix this problem, we need to move the ww_acquire_fini() after
the ww_mutex_unlock() in torture_ww_mutex_unlock(). This is done by
allocating a global array of ww_acquire_ctx structures. Each locking
thread is associated with its own ww_acquire_ctx via the unique thread
id it has so that both the lock and unlock functions can access the
same ww_acquire_ctx structure.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210318172814.4400-6-longman@redhat.com
---
 kernel/locking/locktorture.c | 39 ++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 90a975a..b3adb40 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -374,15 +374,27 @@ static struct lock_torture_ops mutex_lock_ops = {
  */
 static DEFINE_WD_CLASS(torture_ww_class);
 static struct ww_mutex torture_ww_mutex_0, torture_ww_mutex_1, torture_ww_mutex_2;
+static struct ww_acquire_ctx *ww_acquire_ctxs;
 
 static void torture_ww_mutex_init(void)
 {
 	ww_mutex_init(&torture_ww_mutex_0, &torture_ww_class);
 	ww_mutex_init(&torture_ww_mutex_1, &torture_ww_class);
 	ww_mutex_init(&torture_ww_mutex_2, &torture_ww_class);
+
+	ww_acquire_ctxs = kmalloc_array(cxt.nrealwriters_stress,
+					sizeof(*ww_acquire_ctxs),
+					GFP_KERNEL);
+	if (!ww_acquire_ctxs)
+		VERBOSE_TOROUT_STRING("ww_acquire_ctx: Out of memory");
+}
+
+static void torture_ww_mutex_exit(void)
+{
+	kfree(ww_acquire_ctxs);
 }
 
-static int torture_ww_mutex_lock(int tid __maybe_unused)
+static int torture_ww_mutex_lock(int tid)
 __acquires(torture_ww_mutex_0)
 __acquires(torture_ww_mutex_1)
 __acquires(torture_ww_mutex_2)
@@ -392,7 +404,7 @@ __acquires(torture_ww_mutex_2)
 		struct list_head link;
 		struct ww_mutex *lock;
 	} locks[3], *ll, *ln;
-	struct ww_acquire_ctx ctx;
+	struct ww_acquire_ctx *ctx = &ww_acquire_ctxs[tid];
 
 	locks[0].lock = &torture_ww_mutex_0;
 	list_add(&locks[0].link, &list);
@@ -403,12 +415,12 @@ __acquires(torture_ww_mutex_2)
 	locks[2].lock = &torture_ww_mutex_2;
 	list_add(&locks[2].link, &list);
 
-	ww_acquire_init(&ctx, &torture_ww_class);
+	ww_acquire_init(ctx, &torture_ww_class);
 
 	list_for_each_entry(ll, &list, link) {
 		int err;
 
-		err = ww_mutex_lock(ll->lock, &ctx);
+		err = ww_mutex_lock(ll->lock, ctx);
 		if (!err)
 			continue;
 
@@ -419,26 +431,29 @@ __acquires(torture_ww_mutex_2)
 		if (err != -EDEADLK)
 			return err;
 
-		ww_mutex_lock_slow(ll->lock, &ctx);
+		ww_mutex_lock_slow(ll->lock, ctx);
 		list_move(&ll->link, &list);
 	}
 
-	ww_acquire_fini(&ctx);
 	return 0;
 }
 
-static void torture_ww_mutex_unlock(int tid __maybe_unused)
+static void torture_ww_mutex_unlock(int tid)
 __releases(torture_ww_mutex_0)
 __releases(torture_ww_mutex_1)
 __releases(torture_ww_mutex_2)
 {
+	struct ww_acquire_ctx *ctx = &ww_acquire_ctxs[tid];
+
 	ww_mutex_unlock(&torture_ww_mutex_0);
 	ww_mutex_unlock(&torture_ww_mutex_1);
 	ww_mutex_unlock(&torture_ww_mutex_2);
+	ww_acquire_fini(ctx);
 }
 
 static struct lock_torture_ops ww_mutex_lock_ops = {
 	.init		= torture_ww_mutex_init,
+	.exit		= torture_ww_mutex_exit,
 	.writelock	= torture_ww_mutex_lock,
 	.write_delay	= torture_mutex_delay,
 	.task_boost     = torture_boost_dummy,
@@ -924,16 +939,16 @@ static int __init lock_torture_init(void)
 		goto unwind;
 	}
 
-	if (cxt.cur_ops->init) {
-		cxt.cur_ops->init();
-		cxt.init_called = true;
-	}
-
 	if (nwriters_stress >= 0)
 		cxt.nrealwriters_stress = nwriters_stress;
 	else
 		cxt.nrealwriters_stress = 2 * num_online_cpus();
 
+	if (cxt.cur_ops->init) {
+		cxt.cur_ops->init();
+		cxt.init_called = true;
+	}
+
 #ifdef CONFIG_DEBUG_MUTEXES
 	if (str_has_prefix(torture_type, "mutex"))
 		cxt.debug_lock = true;
