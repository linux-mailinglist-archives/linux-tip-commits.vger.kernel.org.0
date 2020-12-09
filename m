Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF132D4930
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733274AbgLISkJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733267AbgLISkJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:40:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8421FC0617A7;
        Wed,  9 Dec 2020 10:38:53 -0800 (PST)
Date:   Wed, 09 Dec 2020 18:38:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=piXY0GyN2JaiC4fVOFbAGREbLm9q1/m6T+tF64E3wzM=;
        b=X7jTIWn/BF9VBM73dFJUKCIMBiYp5yZ87xJ4FWZiF+TVo98ScJukPBnHxHpNJKx6Qs41w4
        TTontJybDD636pe6Fp91+thssfY+dQ8EmAYQ4kDDoxWFS36wiX86QeHPI2kAOVsJ9INu8X
        fy2VGEwqrTKNf/cU6j5/SF9ubvw6iDmm9mcRH8BwrAi9mhQrNeJZLvpKGbfPBHiR8x045n
        xRqmAYtu6Jsx2enUufn44GC1vEn/TcVo3hEJORtdsalEt4N8X8Z19Sie84aw+vnSPXJl+n
        8cgQDmJrD25Fg/6yqp97VAvSWsiBG9xyhFmLStoSZ58mWt5kmq/o8ApqK6YeHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=piXY0GyN2JaiC4fVOFbAGREbLm9q1/m6T+tF64E3wzM=;
        b=ne80XH8e0xcWOf0CmvauDoBCCoB6lGSaw5XCwnjXDYCLHyv1VcxXHMI6Q7WiEZl3ap8pF5
        9RuyNFIcw+mlgCBw==
From:   "tip-bot2 for Eric W. Biederman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rwsem: Implement down_read_interruptible
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87k0tybqfy.fsf@x220.int.ebiederm.org>
References: <87k0tybqfy.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Message-ID: <160753912899.3364.3947297068679861678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     31784cff7ee073b34d6eddabb95e3be2880a425c
Gitweb:        https://git.kernel.org/tip/31784cff7ee073b34d6eddabb95e3be2880a425c
Author:        Eric W. Biederman <ebiederm@xmission.com>
AuthorDate:    Thu, 03 Dec 2020 14:11:13 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:42 +01:00

rwsem: Implement down_read_interruptible

In preparation for converting exec_update_mutex to a rwsem so that
multiple readers can execute in parallel and not deadlock, add
down_read_interruptible.  This is needed for perf_event_open to be
converted (with no semantic changes) from working on a mutex to
wroking on a rwsem.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/87k0tybqfy.fsf@x220.int.ebiederm.org
---
 include/linux/rwsem.h  |  1 +
 kernel/locking/rwsem.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 13021b0..4c715be 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -123,6 +123,7 @@ static inline int rwsem_is_contended(struct rw_semaphore *sem)
  * lock for reading
  */
 extern void down_read(struct rw_semaphore *sem);
+extern int __must_check down_read_interruptible(struct rw_semaphore *sem);
 extern int __must_check down_read_killable(struct rw_semaphore *sem);
 
 /*
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 54d11cb..a163542 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1345,6 +1345,18 @@ static inline void __down_read(struct rw_semaphore *sem)
 	}
 }
 
+static inline int __down_read_interruptible(struct rw_semaphore *sem)
+{
+	if (!rwsem_read_trylock(sem)) {
+		if (IS_ERR(rwsem_down_read_slowpath(sem, TASK_INTERRUPTIBLE)))
+			return -EINTR;
+		DEBUG_RWSEMS_WARN_ON(!is_rwsem_reader_owned(sem), sem);
+	} else {
+		rwsem_set_reader_owned(sem);
+	}
+	return 0;
+}
+
 static inline int __down_read_killable(struct rw_semaphore *sem)
 {
 	if (!rwsem_read_trylock(sem)) {
@@ -1495,6 +1507,20 @@ void __sched down_read(struct rw_semaphore *sem)
 }
 EXPORT_SYMBOL(down_read);
 
+int __sched down_read_interruptible(struct rw_semaphore *sem)
+{
+	might_sleep();
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
+
+	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_interruptible)) {
+		rwsem_release(&sem->dep_map, _RET_IP_);
+		return -EINTR;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(down_read_interruptible);
+
 int __sched down_read_killable(struct rw_semaphore *sem)
 {
 	might_sleep();
