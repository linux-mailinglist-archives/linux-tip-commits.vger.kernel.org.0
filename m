Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B594A3B065D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 15:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhFVOBs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 10:01:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFVOBr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 10:01:47 -0400
Date:   Tue, 22 Jun 2021 13:59:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624370370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUWN39zk8f13QKG8ytxWxoOEWEsVoN3FSXOfKwiTepY=;
        b=NsGtvymYX3ocTki9CDl6k6voTY01q+bAV9upQacoLlFFvqogWKoL5PBTbYipDKVr0yJYfM
        sXRTSr3EzCA3L1CdWdG3QDoxt9mVT77lyzyl+qpzVPieLdY5lO2SvVQJT8HhhGsxD79PAu
        6Uq6SgBl6cDfRFb70vR5zgGcZG4ko3vah/rJOjCywNB/0mzSAtMcvciBqr1HN8bZQgogDA
        KYcGHbLUjZtaIHKNmvwZ4dM2j8suYOvWXPK9sPl17h0Ra4ebKuFpaBnFqWAFqqqQWvAIDH
        BOisnZQmCVHNxj7f60l8yN6HHc3q6zpxr1wPWQN0X6aVLtfmuj61L0bIzToC9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624370370;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUWN39zk8f13QKG8ytxWxoOEWEsVoN3FSXOfKwiTepY=;
        b=1vrhSnXg+YxarZqYIG4S96IkpQWVdwRTY9FUWBN8rjSWzOk77RYE36rDtzZiqXTkL1DRUT
        OQ46/KzPLIFTUfBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] signal: Prevent sigqueue caching after task got released
Cc:     syzbot+0bac5fec63d4f399ba98@syzkaller.appspotmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <878s32g6j5.ffs@nanos.tec.linutronix.de>
References: <878s32g6j5.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <162437036976.395.10141270533127411803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     399f8dd9a866e107639eabd3c1979cd526ca3a98
Gitweb:        https://git.kernel.org/tip/399f8dd9a866e107639eabd3c1979cd526ca3a98
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 22 Jun 2021 01:08:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jun 2021 15:55:41 +02:00

signal: Prevent sigqueue caching after task got released

syzbot reported a memory leak related to sigqueue caching.

The assumption that a task cannot cache a sigqueue after the signal handler
has been dropped and exit_task_sigqueue_cache() has been invoked turns out
to be wrong.

Such a task can still invoke release_task(other_task), which cleans up the
signals of 'other_task' and ends up in sigqueue_cache_or_free(), which in
turn will cache the signal because task->sigqueue_cache is NULL. That's
obviously bogus because nothing will free the cached signal of that task
anymore, so the cached item is leaked.

This happens when e.g. the last non-leader thread exits and reaps the
zombie leader.

Prevent this by setting tsk::sigqueue_cache to an error pointer value in
exit_task_sigqueue_cache() which forces any subsequent invocation of
sigqueue_cache_or_free() from that task to hand the sigqueue back to the
kmemcache.

Add comments to all relevant places.

Fixes: 4bad58ebc8bc ("signal: Allow tasks to cache one sigqueue struct")
Reported-by: syzbot+0bac5fec63d4f399ba98@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Link: https://lore.kernel.org/r/878s32g6j5.ffs@nanos.tec.linutronix.de

---
 kernel/signal.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index f7c6ffc..f1ecd8f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -435,6 +435,12 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
 		 * Preallocation does not hold sighand::siglock so it can't
 		 * use the cache. The lockless caching requires that only
 		 * one consumer and only one producer run at a time.
+		 *
+		 * For the regular allocation case it is sufficient to
+		 * check @q for NULL because this code can only be called
+		 * if the target task @t has not been reaped yet; which
+		 * means this code can never observe the error pointer which is
+		 * written to @t->sigqueue_cache in exit_task_sigqueue_cache().
 		 */
 		q = READ_ONCE(t->sigqueue_cache);
 		if (!q || sigqueue_flags)
@@ -463,13 +469,18 @@ void exit_task_sigqueue_cache(struct task_struct *tsk)
 	struct sigqueue *q = tsk->sigqueue_cache;
 
 	if (q) {
-		tsk->sigqueue_cache = NULL;
 		/*
 		 * Hand it back to the cache as the task might
 		 * be self reaping which would leak the object.
 		 */
 		 kmem_cache_free(sigqueue_cachep, q);
 	}
+
+	/*
+	 * Set an error pointer to ensure that @tsk will not cache a
+	 * sigqueue when it is reaping it's child tasks
+	 */
+	tsk->sigqueue_cache = ERR_PTR(-1);
 }
 
 static void sigqueue_cache_or_free(struct sigqueue *q)
@@ -481,6 +492,10 @@ static void sigqueue_cache_or_free(struct sigqueue *q)
 	 * is intentional when run without holding current->sighand->siglock,
 	 * which is fine as current obviously cannot run __sigqueue_free()
 	 * concurrently.
+	 *
+	 * The NULL check is safe even if current has been reaped already,
+	 * in which case exit_task_sigqueue_cache() wrote an error pointer
+	 * into current->sigqueue_cache.
 	 */
 	if (!READ_ONCE(current->sigqueue_cache))
 		WRITE_ONCE(current->sigqueue_cache, q);
