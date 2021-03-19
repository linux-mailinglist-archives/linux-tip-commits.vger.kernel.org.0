Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA6341D71
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 13:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhCSMyf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 08:54:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36818 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhCSMyU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 08:54:20 -0400
Date:   Fri, 19 Mar 2021 12:54:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616158458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Po6dBNT/n61UXXRklMcoA4R/HjEjyRTLs7IjXbRF3U=;
        b=iwYx7+WshDEdZcKk5SnxSXM8qOTNo98YHGf0wt+E+Dy0RNM2ly1RUSTF80MNd3sIZdEQGV
        YZM2+Co9L2FLQi0r4Vg10wvpd/QT0NeAjFye8PUPNJarFdspOmLftj230KWEBtoJwMlFH5
        VLCowxtj04AvKIJPDyBrrQDbcKCBTWu/xozSGp/i8xvJL67p12FFy2vK5vJMulHVL5AYvq
        8LybKgUdRIPyYeCPErHtg5uLCWf4JMpOvoo9ebe+GjkrLNKf3r7WZgZhOLRcXboVWq5vGv
        shmtOK89ciztowrq62VigK9HSJ5etbnaRCkGbVdNOIdDLfkBv0jHA1AsBmCFsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616158458;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Po6dBNT/n61UXXRklMcoA4R/HjEjyRTLs7IjXbRF3U=;
        b=BbVgzhmzgCP+u/bOW9Amnp+8TKspTfAjRjUHKFfn4KtIzEZgt14Dp2NlWDP2bMr/8JompL
        DflIlIO2hPgfo1Bw==
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/locktorture: Fix false positive circular
 locking splat in ww_mutex test
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210318172814.4400-3-longman@redhat.com>
References: <20210318172814.4400-3-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <161615845780.398.3515033532845132919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2ea55bbba23e9d36996299664d618393c8602646
Gitweb:        https://git.kernel.org/tip/2ea55bbba23e9d36996299664d618393c8602646
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 18 Mar 2021 13:28:11 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 19 Mar 2021 12:13:09 +01:00

locking/locktorture: Fix false positive circular locking splat in ww_mutex test

In order to avoid false positive circular locking lockdep splat
when runnng the ww_mutex torture test, we need to make sure that
the ww_mutexes have the same lock class as the acquire_ctx. This
means the ww_mutexes must have the same lockdep key as the
acquire_ctx. Unfortunately the current DEFINE_WW_MUTEX() macro fails
to do that. As a result, we add an init method for the ww_mutex test
to do explicit ww_mutex_init()'s of the ww_mutexes to avoid the false
positive warning.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210318172814.4400-3-longman@redhat.com
---
 kernel/locking/locktorture.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 0ab94e1..3c27f43 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -357,10 +357,20 @@ static struct lock_torture_ops mutex_lock_ops = {
 };
 
 #include <linux/ww_mutex.h>
+/*
+ * The torture ww_mutexes should belong to the same lock class as
+ * torture_ww_class to avoid lockdep problem. The ww_mutex_init()
+ * function is called for initialization to ensure that.
+ */
 static DEFINE_WD_CLASS(torture_ww_class);
-static DEFINE_WW_MUTEX(torture_ww_mutex_0, &torture_ww_class);
-static DEFINE_WW_MUTEX(torture_ww_mutex_1, &torture_ww_class);
-static DEFINE_WW_MUTEX(torture_ww_mutex_2, &torture_ww_class);
+static struct ww_mutex torture_ww_mutex_0, torture_ww_mutex_1, torture_ww_mutex_2;
+
+static void torture_ww_mutex_init(void)
+{
+	ww_mutex_init(&torture_ww_mutex_0, &torture_ww_class);
+	ww_mutex_init(&torture_ww_mutex_1, &torture_ww_class);
+	ww_mutex_init(&torture_ww_mutex_2, &torture_ww_class);
+}
 
 static int torture_ww_mutex_lock(void)
 __acquires(torture_ww_mutex_0)
@@ -418,6 +428,7 @@ __releases(torture_ww_mutex_2)
 }
 
 static struct lock_torture_ops ww_mutex_lock_ops = {
+	.init		= torture_ww_mutex_init,
 	.writelock	= torture_ww_mutex_lock,
 	.write_delay	= torture_mutex_delay,
 	.task_boost     = torture_boost_dummy,
