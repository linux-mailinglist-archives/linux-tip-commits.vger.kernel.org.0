Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14E23D77A0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jul 2021 15:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbhG0N6v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Jul 2021 09:58:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51442 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbhG0N6s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Jul 2021 09:58:48 -0400
Date:   Tue, 27 Jul 2021 13:58:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627394327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/k17Q37ugsBja/vRZfJnzd+PFjSltQ4xGd3unrEzl4=;
        b=ulrJGEI0H3j13XUGYrCE1INY2Xf4ewU92O/aVt5LEyS3mDFZegejbJSjs+geetzCTAhl+r
        EA97OgJjXtd5c0yE+y9KgRCC/vRSQDX7Jy1zUPmfzzF4xG+WB2hZwbi88dAi4u5/J1LMud
        ucmY7YfvgYjXNrT+z9TG8GH9571XK9+V66uEP94aCmMW250P5WAUl1vdT8zHkS5sIDDRQX
        PDYt7g0YyX6d3OcKoX1Cu3t8sTPRnbjBhKfHl+JcOVV92LwwR7J3ODVoKAAd5SWg4SOPOj
        JvgofmJ0Bkwh1KbcFPBRPP58XdF8LkRDPyqesQV01BLhR5qiPeSI9kfvviDbAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627394327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/k17Q37ugsBja/vRZfJnzd+PFjSltQ4xGd3unrEzl4=;
        b=PGnOizN0ZUjb37J9hKrHpcG0gaKcJIIPspWkAHE98qU1HNVIF/RD++sqGd6OUgEQAhgFWT
        1Qd5uFtOEk9ePcCA==
From:   "tip-bot2 for xuyehan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rwsem: Remove an unused parameter of rwsem_wake()
Cc:     xuyehan <xuyehan@xiaomi.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1625547043-28103-1-git-send-email-yehanxu1@gmail.com>
References: <1625547043-28103-1-git-send-email-yehanxu1@gmail.com>
MIME-Version: 1.0
Message-ID: <162739432696.395.7214705950514731382.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d4e5076c3522658996dbb050aa6c708bd2c1a3c1
Gitweb:        https://git.kernel.org/tip/d4e5076c3522658996dbb050aa6c708bd2c1a3c1
Author:        xuyehan <xuyehan@xiaomi.com>
AuthorDate:    Tue, 06 Jul 2021 12:50:43 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jul 2021 18:46:44 +02:00

locking/rwsem: Remove an unused parameter of rwsem_wake()

The 2nd parameter 'count' is not used in this function.
The places where the function is called are also modified.

Signed-off-by: xuyehan <xuyehan@xiaomi.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/1625547043-28103-1-git-send-email-yehanxu1@gmail.com
---
 kernel/locking/rwsem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 809b001..2cad15d 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1165,7 +1165,7 @@ out_nolock:
  * handle waking up a waiter on the semaphore
  * - up_read/up_write has decremented the active part of count if we come here
  */
-static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count)
+static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 {
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
@@ -1297,7 +1297,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
 		      RWSEM_FLAG_WAITERS)) {
 		clear_nonspinnable(sem);
-		rwsem_wake(sem, tmp);
+		rwsem_wake(sem);
 	}
 }
 
@@ -1319,7 +1319,7 @@ static inline void __up_write(struct rw_semaphore *sem)
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
-		rwsem_wake(sem, tmp);
+		rwsem_wake(sem);
 }
 
 /*
