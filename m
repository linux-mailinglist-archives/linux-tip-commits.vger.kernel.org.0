Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C201B41F056
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354798AbhJAPHO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353627AbhJAPHN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:13 -0400
Date:   Fri, 01 Oct 2021 15:05:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ev22JqFvEX2ked3SaopykKB0hrWGEF5XtMs1/Lz0po=;
        b=3vXGWP3g1/n+m8Hft+lAfmZ9U4pZHdHODwA808V431liWiDDXheqEIC12NOYgYJ3ICGodN
        IJux9RQmElJ2tIYn4labhaRvAEvh7/XRdPsUu8+r/oUmzaaTkEZCHmt9a6CFl8Se20Kuku
        h6uIpiDA/3nZxkZI+0HJckQeNe/9lPBDtM/wyEvNf4+gJK2wlCyD4zMSQXFVOvEiQy2+xt
        p8jHcu2BsLAHT991sbWqx4d6mbrFQTMYFEL/ca2aXDVB4QDYg6HSbFYfEfKUATRydp8gzt
        MFrs8bPlJc/OTJl3is4OX1XndH1au5qSda+a1c2JFl4YBBiukEAiGVNkw9CLZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100728;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5ev22JqFvEX2ked3SaopykKB0hrWGEF5XtMs1/Lz0po=;
        b=hRGMlFI+pCKQfeTZyOR4BtQqHyOYFJ4Gw/Y83DlJA8VMCKN7Pr481NVUBo5c3OufbekLL4
        +kTLcAxQr+txg7Cw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rtmutex: Check explicit for TASK_RTLOCK_WAIT.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928150006.597310-2-bigeasy@linutronix.de>
References: <20210928150006.597310-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310072740.25758.11209079661688151613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8fe46535e10dbfebad68ad9f2f8260e49f5852c9
Gitweb:        https://git.kernel.org/tip/8fe46535e10dbfebad68ad9f2f8260e49f5852c9
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 28 Sep 2021 17:00:05 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:52 +02:00

rtmutex: Check explicit for TASK_RTLOCK_WAIT.

rt_mutex_wake_q_add() needs to  need to distiguish between sleeping
locks (TASK_RTLOCK_WAIT) and normal locks which use TASK_NORMAL to use
the proper wake mechanism.

Instead of checking for != TASK_NORMAL make it more robust and check
explicit for TASK_RTLOCK_WAIT which is the reason why a different wake
mechanism is used.

No functional change.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210928150006.597310-2-bigeasy@linutronix.de
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 6bb116c..cafc259 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -449,7 +449,7 @@ static __always_inline void rt_mutex_adjust_prio(struct task_struct *p)
 static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
 						struct rt_mutex_waiter *w)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state != TASK_NORMAL) {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state == TASK_RTLOCK_WAIT) {
 		if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 			WARN_ON_ONCE(wqh->rtlock_task);
 		get_task_struct(w->task);
