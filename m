Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76278306435
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Jan 2021 20:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344527AbhA0Tfe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Jan 2021 14:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbhA0Tb6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Jan 2021 14:31:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7472AC061786;
        Wed, 27 Jan 2021 11:31:17 -0800 (PST)
Date:   Wed, 27 Jan 2021 19:31:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611775876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmwX9I7TEiX9jdiCIFhkG1Mot+9odzLF89TAKXB+K8U=;
        b=g3M2pWo7T5Kq/1/KeVxWL+Puxzsl4W6WGp5K/635wbmwhB2/pM48alyOJYEwIh/e+Udjjk
        HXrYSj20OWjiVShueYSHOmVDVcQPe1QRjAZKD8Egt6hrkEc4SsGcWkkPDlEf4V4PWLzoor
        0cHz4J/I19vZ8HojibbcUUzgPHdcQHmfmrQHtXfyy6DEMIwXookSB3W8pIGCBp797iSqP5
        WLUGVSTqkVQAWhHIaqhpzXsT+5xiP7iq1qsRDfPFpPw2DLda97X87KuQ9DQdxwdi9tUAlm
        V1S8HBO58g+pr4/h1jBa73ZVWrlkpgKTMZNRIndknFdvEri7PzJTT80uB2Ny0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611775876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hmwX9I7TEiX9jdiCIFhkG1Mot+9odzLF89TAKXB+K8U=;
        b=D75FXHKRXnf75GwaJsiV25sFIEcY/jsQBGl5BDe8cYZIEbDPspz58HAVL5HMWYr1pbpVDZ
        hHrtGa6g0OQ1P2BA==
From:   "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Add missing kernel-doc markup
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1605257895-5536-2-git-send-email-alex.shi@linux.alibaba.com>
References: <1605257895-5536-2-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <161177587549.23325.16141968098815646844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     59ea5f1508e15cecddd8e2ca828f7962ea37adab
Gitweb:        https://git.kernel.org/tip/59ea5f1508e15cecddd8e2ca828f7962ea37adab
Author:        Alex Shi <alex.shi@linux.alibaba.com>
AuthorDate:    Fri, 13 Nov 2020 16:58:11 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 27 Jan 2021 12:44:52 +01:00

locking/rtmutex: Add missing kernel-doc markup

To fix the following issues:
kernel/locking/rtmutex.c:1612: warning: Function parameter or member
'lock' not described in '__rt_mutex_futex_unlock'
kernel/locking/rtmutex.c:1612: warning: Function parameter or member
'wake_q' not described in '__rt_mutex_futex_unlock'
kernel/locking/rtmutex.c:1675: warning: Function parameter or member
'name' not described in '__rt_mutex_init'
kernel/locking/rtmutex.c:1675: warning: Function parameter or member
'key' not described in '__rt_mutex_init'

[ tglx: Change rt lock to rt_mutex for consistency sake ]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/1605257895-5536-2-git-send-email-alex.shi@linux.alibaba.com

---
 kernel/locking/rtmutex.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index cfdd5b9..a201e5e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1604,8 +1604,11 @@ void __sched rt_mutex_unlock(struct rt_mutex *lock)
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
 
 /**
- * Futex variant, that since futex variants do not use the fast-path, can be
- * simple and will not need to retry.
+ * __rt_mutex_futex_unlock - Futex variant, that since futex variants
+ * do not use the fast-path, can be simple and will not need to retry.
+ *
+ * @lock:	The rt_mutex to be unlocked
+ * @wake_q:	The wake queue head from which to get the next lock waiter
  */
 bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
 				    struct wake_q_head *wake_q)
@@ -1662,13 +1665,15 @@ void rt_mutex_destroy(struct rt_mutex *lock)
 EXPORT_SYMBOL_GPL(rt_mutex_destroy);
 
 /**
- * __rt_mutex_init - initialize the rt lock
+ * __rt_mutex_init - initialize the rt_mutex
  *
- * @lock: the rt lock to be initialized
+ * @lock:	The rt_mutex to be initialized
+ * @name:	The lock name used for debugging
+ * @key:	The lock class key used for debugging
  *
- * Initialize the rt lock to unlocked state.
+ * Initialize the rt_mutex to unlocked state.
  *
- * Initializing of a locked rt lock is not allowed
+ * Initializing of a locked rt_mutex is not allowed
  */
 void __rt_mutex_init(struct rt_mutex *lock, const char *name,
 		     struct lock_class_key *key)
