Return-Path: <linux-tip-commits+bounces-1557-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F243D91D8AC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 09:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D56A28132B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 07:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811097174F;
	Mon,  1 Jul 2024 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LPoe9+Wl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wUnPsgQu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DB66E2BE;
	Mon,  1 Jul 2024 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818096; cv=none; b=MY4Tbl9hmFMQ6KWu3RtBGFnAHowoI+e3hwtpXUWROu0NFMYc8goCfYuzXWW/VELU9cZGOgK7js+03zI1nVVo2BTm4TCzSPzGS9pTWT8uqCMRPLqVT1WdizGDEt5dNFi4NJBcbOx9MNdSX1JMQ+UCe2yEitPOebpBZyp6F8ssYDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818096; c=relaxed/simple;
	bh=rPAa5vn/Qo11zfBkto0+8kgUP3z2BmM2j77tOCf0dlA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C9OQ6YUomZ9qNsRnrQnyXvSHc0EQ1xOJlJeH/Ebz9fd9zix9323fee3TFGMOqDyITEkZFdT47Z5sCupg1tCBt24QMWi3Y4wrvWidWBxLJlpzje6TQawCjIhBlPAz+/ruDJTfIeaeHr/JkCSkcsqJ2OyMtR7afHcjz7FbPDlEPT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LPoe9+Wl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wUnPsgQu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Jul 2024 07:14:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719818093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLk3Bx57c2GRlIXyMyGtKV3+Y8pbT7lL526uLOTUd50=;
	b=LPoe9+Wlj+0jz+DSB5iPjQ0TTBeW3/kGGwFK8GR36TgZV3Yc5I10WBPhjx9cjuCq255tm5
	fVWhqSwGTpMDu4B/6RDOTHCJWLgz5DhQlS+EEHGjsF3r4ebZS3Qd0FPS5aX8snqDoK1jYe
	kDRPNuZBkf/x7wV7HMPFjba3PfkNaNdX16Tt6uaongFD43P/3Q9qm5htMOTTjwRGQCXUUQ
	9jLW67zy2G7zg2rdVt9dSlcY+QHCI9bbCgNfpHXhY2oWafDg1Y2sd7M1ZyQ0dxRmH7eU6t
	qJV/3pOs1VVztYZsGI1Qa+zmuIlfaJ6keXkML6yl2oDpFLZXeW/5HzOsr+7H9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719818093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLk3Bx57c2GRlIXyMyGtKV3+Y8pbT7lL526uLOTUd50=;
	b=wUnPsgQuZ68mUQ3Ol61vznC2xrtxl8dBAYJr2Gn73UupwN2lmzRaxHByeEdbUBDK7+g15/
	0zBkqlxzwTqJLcCQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] task_work: s/task_work_cancel()/task_work_cancel_func()/
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240621091601.18227-2-frederic@kernel.org>
References: <20240621091601.18227-2-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171981809294.2215.15420538071880369389.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b3d9ad61dc099bfd1e289460cde199b1ca4a7415
Gitweb:        https://git.kernel.org/tip/b3d9ad61dc099bfd1e289460cde199b1ca4a7415
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 21 Jun 2024 11:15:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 25 Jun 2024 10:43:36 +02:00

task_work: s/task_work_cancel()/task_work_cancel_func()/

A proper task_work_cancel() API that actually cancels a callback and not
*any* callback pointing to a given function is going to be needed for
perf events event freeing. Do the appropriate rename to prepare for
that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240621091601.18227-2-frederic@kernel.org
---
 include/linux/task_work.h |  2 +-
 kernel/irq/manage.c       |  2 +-
 kernel/task_work.c        | 10 +++++-----
 security/keys/keyctl.c    |  2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 795ef5a..23ab01a 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -30,7 +30,7 @@ int task_work_add(struct task_struct *task, struct callback_head *twork,
 
 struct callback_head *task_work_cancel_match(struct task_struct *task,
 	bool (*match)(struct callback_head *, void *data), void *data);
-struct callback_head *task_work_cancel(struct task_struct *, task_work_func_t);
+struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
 void task_work_run(void);
 
 static inline void exit_task_work(struct task_struct *task)
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 71b0fc2..dd53298 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1337,7 +1337,7 @@ static int irq_thread(void *data)
 	 * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
 	 * oneshot mask bit can be set.
 	 */
-	task_work_cancel(current, irq_thread_dtor);
+	task_work_cancel_func(current, irq_thread_dtor);
 	return 0;
 }
 
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 95a7e1b..54ac240 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -120,9 +120,9 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
 }
 
 /**
- * task_work_cancel - cancel a pending work added by task_work_add()
- * @task: the task which should execute the work
- * @func: identifies the work to remove
+ * task_work_cancel_func - cancel a pending work matching a function added by task_work_add()
+ * @task: the task which should execute the func's work
+ * @func: identifies the func to match with a work to remove
  *
  * Find the last queued pending work with ->func == @func and remove
  * it from queue.
@@ -131,7 +131,7 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
  * The found work or NULL if not found.
  */
 struct callback_head *
-task_work_cancel(struct task_struct *task, task_work_func_t func)
+task_work_cancel_func(struct task_struct *task, task_work_func_t func)
 {
 	return task_work_cancel_match(task, task_work_func_match, func);
 }
@@ -168,7 +168,7 @@ void task_work_run(void)
 		if (!work)
 			break;
 		/*
-		 * Synchronize with task_work_cancel(). It can not remove
+		 * Synchronize with task_work_cancel_match(). It can not remove
 		 * the first entry == work, cmpxchg(task_works) must fail.
 		 * But it can remove another entry from the ->next list.
 		 */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 4bc3e93..ab927a1 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1694,7 +1694,7 @@ long keyctl_session_to_parent(void)
 		goto unlock;
 
 	/* cancel an already pending keyring replacement */
-	oldwork = task_work_cancel(parent, key_change_session_keyring);
+	oldwork = task_work_cancel_func(parent, key_change_session_keyring);
 
 	/* the replacement session keyring is applied just prior to userspace
 	 * restarting */

