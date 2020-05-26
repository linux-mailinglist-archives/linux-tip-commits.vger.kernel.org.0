Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211EC1BA19E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Apr 2020 12:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgD0KqF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 27 Apr 2020 06:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726507AbgD0KqF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 27 Apr 2020 06:46:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247F9C0610D5;
        Mon, 27 Apr 2020 03:46:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jT1Gx-0000QU-NI; Mon, 27 Apr 2020 12:45:59 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5AE371C0131;
        Mon, 27 Apr 2020 12:45:59 +0200 (CEST)
Date:   Mon, 27 Apr 2020 10:45:58 -0000
From:   "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Remove unused rt_mutex_cmpxchg_relaxed()
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1587135032-188866-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1587135032-188866-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <158798435889.28353.3343865646156622642.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     23b5ae2e8e1326c91b5dfdbb6ebcd5a6820074ae
Gitweb:        https://git.kernel.org/tip/23b5ae2e8e1326c91b5dfdbb6ebcd5a6820074ae
Author:        Alex Shi <alex.shi@linux.alibaba.com>
AuthorDate:    Fri, 17 Apr 2020 22:50:31 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Apr 2020 12:26:40 +02:00

locking/rtmutex: Remove unused rt_mutex_cmpxchg_relaxed()

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1587135032-188866-1-git-send-email-alex.shi@linux.alibaba.com

---
 kernel/locking/rtmutex.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c9f090d..cfdd5b9 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -141,7 +141,6 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
  * set up.
  */
 #ifndef CONFIG_DEBUG_RT_MUTEXES
-# define rt_mutex_cmpxchg_relaxed(l,c,n) (cmpxchg_relaxed(&l->owner, c, n) == c)
 # define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) == c)
 # define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) == c)
 
@@ -202,7 +201,6 @@ static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
 }
 
 #else
-# define rt_mutex_cmpxchg_relaxed(l,c,n)	(0)
 # define rt_mutex_cmpxchg_acquire(l,c,n)	(0)
 # define rt_mutex_cmpxchg_release(l,c,n)	(0)
 
