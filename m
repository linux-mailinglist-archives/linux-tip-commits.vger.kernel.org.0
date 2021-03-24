Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3E934725F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Mar 2021 08:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhCXHWt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Mar 2021 03:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbhCXHWc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Mar 2021 03:22:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8843C0613DD;
        Wed, 24 Mar 2021 00:22:31 -0700 (PDT)
Date:   Wed, 24 Mar 2021 07:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616570548;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMRvbGZOg+FzBovNBUtmieykQ0Spfn6ar+6Y68Ba/DI=;
        b=4Ojb3Q9fFSu1fgdTD/3yYQU57+iHtJ4au82xVmrp8g+cHOVEsj6S7UaZmXd/Eui1mn9fk0
        T1ILwDjKiJIwSGgZk/4ff2VFM5yUySqBi1zCH2SLAahTXVUie2jIpSZ6tguiNubdHK+WyS
        b7HQ8/Zp5nN7TgX8ebUXJ671MG72ZNSyS8Y/8IQyHTJxh5Z2o9Np+j0fArOjx/KoyHDtIG
        OmSdRQaGnD/XtmN79wFxoGWTLzcbvg7wnVhYFXFP8eofz7sB98nHpXNhGJPitPweUDOX5P
        IlKXXaOUCBbr1CwiHXnzz4h/e+5hILX7DdMsXvJKjgk9+6l/OTgiQ3URg6RC5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616570548;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oMRvbGZOg+FzBovNBUtmieykQ0Spfn6ar+6Y68Ba/DI=;
        b=x8f5EODunwBC+/mf9f5S3GCoo/Cv2v+se1mJq+xlj5qGQe1lhZty0kzf+8RwyVXx3znzo1
        lTbYvnnoOTWV+pCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Fix misleading comment in
 rt_mutex_postunlock()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210323213708.809432652@linutronix.de>
References: <20210323213708.809432652@linutronix.de>
MIME-Version: 1.0
Message-ID: <161657054764.398.2659618297092475200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     5677c86221d14c18c6edea59d8f0f02e36e2b2db
Gitweb:        https://git.kernel.org/tip/5677c86221d14c18c6edea59d8f0f02e36e2b2db
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 23 Mar 2021 22:30:32 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 24 Mar 2021 08:08:16 +01:00

locking/rtmutex: Fix misleading comment in rt_mutex_postunlock()

Preemption is disabled in mark_wakeup_next_waiter() not in
rt_mutex_slowunlock().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210323213708.809432652@linutronix.de
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 3612821..bece7aa 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1399,7 +1399,7 @@ void __sched rt_mutex_postunlock(struct wake_q_head *wake_q)
 {
 	wake_up_q(wake_q);
 
-	/* Pairs with preempt_disable() in rt_mutex_slowunlock() */
+	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
 	preempt_enable();
 }
 
