Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B424E2D492A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbgLISjl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:39:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48386 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732979AbgLISjd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:39:33 -0500
Date:   Wed, 09 Dec 2020 18:38:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mAL2zMzkTh6hP3MISpcsyU2YzUhyhDailjudNGYtL/0=;
        b=rWBsZ1k/V228JhVcgFOEux7nq8aMZAQleUQLxBYdiVTgleO7j4h29AWe2BaBTMWKOf7Vli
        XRpvR/mJRP3FaeFu4FKUM2S4YroE4n2ES3XjXN8u7wb036LB0s42OhBVPICZix/+Sd8fTA
        mmhG1RZq/7228nH8rbjY23scRDhW2vsccqpMv7nqZkOrkB5wUrwHBmUG7mIVeL0Qjc/03m
        aXqZUOPVzuJR7kcq9SCSfPxakAyQi04NW3Jcbtxsar4Cj8i2FLwlApceT54iFuQ3u/NnZ3
        HFxGaynzV0v+6yEbWojgJYS6qrPXwebQkSWMTR5BcBJftUbjSrEAsQCHxbPeOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539129;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mAL2zMzkTh6hP3MISpcsyU2YzUhyhDailjudNGYtL/0=;
        b=JmhyTd98QN7PZNdb24Q2lBmmMkBdGRfAw0UhvkuN+UNrfOdr0lWGugGVKuvGC8xoN9FToj
        vnFXQQOANS8C84CQ==
From:   "tip-bot2 for Eric W. Biederman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rwsem: Implement down_read_killable_nested
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87o8jabqh3.fsf@x220.int.ebiederm.org>
References: <87o8jabqh3.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Message-ID: <160753912926.3364.11774141440383901114.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     0f9368b5bf6db0c04afc5454b1be79022a681615
Gitweb:        https://git.kernel.org/tip/0f9368b5bf6db0c04afc5454b1be79022a681615
Author:        Eric W. Biederman <ebiederm@xmission.com>
AuthorDate:    Thu, 03 Dec 2020 14:10:32 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:41 +01:00

rwsem: Implement down_read_killable_nested

In preparation for converting exec_update_mutex to a rwsem so that
multiple readers can execute in parallel and not deadlock, add
down_read_killable_nested.  This is needed so that kcmp_lock
can be converted from working on a mutexes to working on rw_semaphores.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/87o8jabqh3.fsf@x220.int.ebiederm.org
---
 include/linux/rwsem.h  |  2 ++
 kernel/locking/rwsem.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 25e3fde..13021b0 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -171,6 +171,7 @@ extern void downgrade_write(struct rw_semaphore *sem);
  * See Documentation/locking/lockdep-design.rst for more details.)
  */
 extern void down_read_nested(struct rw_semaphore *sem, int subclass);
+extern int __must_check down_read_killable_nested(struct rw_semaphore *sem, int subclass);
 extern void down_write_nested(struct rw_semaphore *sem, int subclass);
 extern int down_write_killable_nested(struct rw_semaphore *sem, int subclass);
 extern void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest_lock);
@@ -191,6 +192,7 @@ extern void down_read_non_owner(struct rw_semaphore *sem);
 extern void up_read_non_owner(struct rw_semaphore *sem);
 #else
 # define down_read_nested(sem, subclass)		down_read(sem)
+# define down_read_killable_nested(sem, subclass)	down_read_killable(sem)
 # define down_write_nest_lock(sem, nest_lock)	down_write(sem)
 # define down_write_nested(sem, subclass)	down_write(sem)
 # define down_write_killable_nested(sem, subclass)	down_write_killable(sem)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index f11b9bd..54d11cb 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1605,6 +1605,20 @@ void down_read_nested(struct rw_semaphore *sem, int subclass)
 }
 EXPORT_SYMBOL(down_read_nested);
 
+int down_read_killable_nested(struct rw_semaphore *sem, int subclass)
+{
+	might_sleep();
+	rwsem_acquire_read(&sem->dep_map, subclass, 0, _RET_IP_);
+
+	if (LOCK_CONTENDED_RETURN(sem, __down_read_trylock, __down_read_killable)) {
+		rwsem_release(&sem->dep_map, _RET_IP_);
+		return -EINTR;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(down_read_killable_nested);
+
 void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest)
 {
 	might_sleep();
