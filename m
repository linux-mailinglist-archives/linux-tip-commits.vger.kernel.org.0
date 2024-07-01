Return-Path: <linux-tip-commits+bounces-1556-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B43891D8AD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 09:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BDA5B21043
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Jul 2024 07:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D04D6F2F0;
	Mon,  1 Jul 2024 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PsrqYe+L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M9t38IfN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904FB69959;
	Mon,  1 Jul 2024 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818096; cv=none; b=py58SM3MM/DBdw6YhwiPxdGN6/IGaDIW3PWdopu3nt8vKGduBEOUDCpfo455QIGltSKhae3UhDdSBlDsL4ZWOj0676uDORKSc5stgrVkRY9TqPwgC+kfz6HHt1QhkZBw+jAV+8OkN3SOwqTb7HAVmNp5aVStQcnzTN3E8qd63kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818096; c=relaxed/simple;
	bh=0jdegRLGkMSpzy25XtuZ3ijvGKt4MzIqqVdilnPZYq4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jwjDf4URffWPfhX3CEI3sXA2UD1QJ33MiaL5ahBH6Ph2nfVTlYcu2c49Dn/IIeetBZjkKjgw45Q5BdflCoYy3Vp4L3krhmFQSyB01d+Z2kYE/dznmZsFiNWtkzxzdv3+fw0LMk1XPMiibPD7A9iJMcO5mYSi0c76W5dx0SvyQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PsrqYe+L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M9t38IfN; arc=none smtp.client-ip=193.142.43.55
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
	bh=XdaSvnZfkj1BPcdaLwG575o7viKXrNTySdEv4FhkRPg=;
	b=PsrqYe+L7aduFojA5BEUzKGi6724Sko75IREMMqbJPnOymNmJSJU8eydLHne1fIfr2MHcV
	QAuuJf04ftzGtLNHE/QOffI4P5gY/jrBJEzbkUGVxm9t3MjxmO4ji3csAFK9/kXWsaZpE6
	jG7yzrcsx2MXRks5dGHJi9sijV/IrLLTor1hC3LIM+yoDacbtL2PniK7fyATm0RNExCaS9
	wEXZCAztoz1twZIATRrCcG8A8j4YKuckyuTCxUaiLuRquZwYCEcZeRmVZr4o5IJHWW5pPF
	YPL/s5yIsP0zcXCfQ7vgieksJdZ3o2DB1dg5TLDX2TRkGeUvPNnTFiSxMlyDfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719818093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdaSvnZfkj1BPcdaLwG575o7viKXrNTySdEv4FhkRPg=;
	b=M9t38IfNz3YP9dCSjJSyU7GHoaMej2zB47T0kT3b8Q2FqpUhpB3TKFJ7buTwXfSmugBRve
	jGONZmON9FfJdHCg==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] task_work: Introduce task_work_cancel() again
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240621091601.18227-3-frederic@kernel.org>
References: <20240621091601.18227-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171981809270.2215.3000722988563647462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     74e45974c966fdecafb7149edb08a2f210e7ab60
Gitweb:        https://git.kernel.org/tip/74e45974c966fdecafb7149edb08a2f210e7ab60
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Fri, 21 Jun 2024 11:15:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 25 Jun 2024 10:43:37 +02:00

task_work: Introduce task_work_cancel() again

Re-introduce task_work_cancel(), this time to cancel an actual callback
and not *any* callback pointing to a given function. This is going to be
needed for perf events event freeing.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240621091601.18227-3-frederic@kernel.org
---
 include/linux/task_work.h |  1 +
 kernel/task_work.c        | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 23ab01a..26b8a47 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -31,6 +31,7 @@ int task_work_add(struct task_struct *task, struct callback_head *twork,
 struct callback_head *task_work_cancel_match(struct task_struct *task,
 	bool (*match)(struct callback_head *, void *data), void *data);
 struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
+bool task_work_cancel(struct task_struct *task, struct callback_head *cb);
 void task_work_run(void);
 
 static inline void exit_task_work(struct task_struct *task)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 54ac240..2134ac8 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -136,6 +136,30 @@ task_work_cancel_func(struct task_struct *task, task_work_func_t func)
 	return task_work_cancel_match(task, task_work_func_match, func);
 }
 
+static bool task_work_match(struct callback_head *cb, void *data)
+{
+	return cb == data;
+}
+
+/**
+ * task_work_cancel - cancel a pending work added by task_work_add()
+ * @task: the task which should execute the work
+ * @cb: the callback to remove if queued
+ *
+ * Remove a callback from a task's queue if queued.
+ *
+ * RETURNS:
+ * True if the callback was queued and got cancelled, false otherwise.
+ */
+bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
+{
+	struct callback_head *ret;
+
+	ret = task_work_cancel_match(task, task_work_match, cb);
+
+	return ret == cb;
+}
+
 /**
  * task_work_run - execute the works added by task_work_add()
  *

