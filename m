Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E284F3EF3AF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbhHQURT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbhHQUPx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF9AC0619F6;
        Tue, 17 Aug 2021 13:14:33 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:14:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AlYi6XHfzX6ox7aBeosEeKVhu5OGZKn7eYj0g9vWTGM=;
        b=uiDG4kWmrf4QkuU1j3Q2dksej07qEExa5e0jutIGYReD+rxrT9d0ZeyMPFTMQfKwn6GIem
        iSr0nYsTEZbeTXjgv6UbQfDQqGYviVJ4dtttmLYVWVZhgy4OLd4BxG97DQt17meZeIbfZy
        X1GHTlDTdseYpntRwUhQ19Erzseo1ACqPJ6qKXMo4cs2chAdstvf/KFBjOa9d7CknH2Fae
        LXbk+3it5rmogkUF3PoYtf3dK3v/I8fZKkdMiw2E6Qqt8DHLhasqEHzojoU52J2T+OJYoo
        QwGCuHPQOdpFxHc1353GwJyS1qBNCQDxtwB5TfhVedzfqunBEIh+Syb6W7IsYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231271;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AlYi6XHfzX6ox7aBeosEeKVhu5OGZKn7eYj0g9vWTGM=;
        b=NrINekc03m66PIcmjax05KSF1WPMINgpZAGmndho55KbKFOBoFk9xImxLcb9IfSzqOMhNW
        xtQgmzhVJ0twTpDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Switch to from cmpxchg_*() to
 try_cmpxchg_*()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.668958502@linutronix.de>
References: <20210815211302.668958502@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127114.25758.2857575229779520098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     709e0b62869f625afd18edd79f190c38cb39dfb2
Gitweb:        https://git.kernel.org/tip/709e0b62869f625afd18edd79f190c38cb39dfb2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:27:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:01:47 +02:00

locking/rtmutex: Switch to from cmpxchg_*() to try_cmpxchg_*()

Allows the compiler to generate better code depending on the architecture.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.668958502@linutronix.de
---
 kernel/locking/rtmutex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 5187add..98f06c5 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -145,14 +145,14 @@ static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
-	return cmpxchg_acquire(&lock->owner, old, new) == old;
+	return try_cmpxchg_acquire(&lock->owner, &old, new);
 }
 
 static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex *lock,
 						     struct task_struct *old,
 						     struct task_struct *new)
 {
-	return cmpxchg_release(&lock->owner, old, new) == old;
+	return try_cmpxchg_release(&lock->owner, &old, new);
 }
 
 /*
