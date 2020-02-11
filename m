Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF12158F09
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Feb 2020 13:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgBKMtC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 11 Feb 2020 07:49:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46097 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgBKMsb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Uxk-0007n0-H1; Tue, 11 Feb 2020 13:48:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 29A4D1C2017;
        Tue, 11 Feb 2020 13:48:24 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:48:23 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/percpu-rwsem: Convert to bool
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200131151539.984626569@infradead.org>
References: <20200131151539.984626569@infradead.org>
MIME-Version: 1.0
Message-ID: <158142530387.411.5572831777224897340.tip-bot2@tip-bot2>
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

Commit-ID:     206c98ffbeda588dbbd9d272505c42acbc364a30
Gitweb:        https://git.kernel.org/tip/206c98ffbeda588dbbd9d272505c42acbc364a30
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Oct 2019 20:12:37 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:10:54 +01:00

locking/percpu-rwsem: Convert to bool

Use bool where possible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200131151539.984626569@infradead.org
---
 include/linux/percpu-rwsem.h  | 6 +++---
 kernel/locking/percpu-rwsem.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index f2c36fb..4ceaa19 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -41,7 +41,7 @@ is_static struct percpu_rw_semaphore name = {				\
 #define DEFINE_STATIC_PERCPU_RWSEM(name)	\
 	__DEFINE_PERCPU_RWSEM(name, static)
 
-extern int __percpu_down_read(struct percpu_rw_semaphore *, int);
+extern bool __percpu_down_read(struct percpu_rw_semaphore *, bool);
 extern void __percpu_up_read(struct percpu_rw_semaphore *);
 
 static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
@@ -69,9 +69,9 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 	preempt_enable();
 }
 
-static inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
+static inline bool percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 {
-	int ret = 1;
+	bool ret = true;
 
 	preempt_disable();
 	/*
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index aa2b118..969389d 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -45,7 +45,7 @@ void percpu_free_rwsem(struct percpu_rw_semaphore *sem)
 }
 EXPORT_SYMBOL_GPL(percpu_free_rwsem);
 
-int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
+bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 {
 	/*
 	 * Due to having preemption disabled the decrement happens on
@@ -69,7 +69,7 @@ int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
 	 * release in percpu_up_write().
 	 */
 	if (likely(!smp_load_acquire(&sem->readers_block)))
-		return 1;
+		return true;
 
 	/*
 	 * Per the above comment; we still have preemption disabled and
@@ -78,7 +78,7 @@ int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
 	__percpu_up_read(sem);
 
 	if (try)
-		return 0;
+		return false;
 
 	/*
 	 * We either call schedule() in the wait, or we'll fall through
@@ -94,7 +94,7 @@ int __percpu_down_read(struct percpu_rw_semaphore *sem, int try)
 	__up_read(&sem->rw_sem);
 
 	preempt_disable();
-	return 1;
+	return true;
 }
 EXPORT_SYMBOL_GPL(__percpu_down_read);
 
