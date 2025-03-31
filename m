Return-Path: <linux-tip-commits+bounces-4595-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2C4A7650B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 Mar 2025 13:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E88E1882076
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 Mar 2025 11:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269251DE4FF;
	Mon, 31 Mar 2025 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UScGGvhY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hauMgtrX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0E5189F36;
	Mon, 31 Mar 2025 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421000; cv=none; b=kX9iXtWQmTwoa4x1uHa4koDA5f86t7v8yib4Lt6uynjYS13FWN2ZAcbZ0UFpCkz7rV6Vh2D2xrXvozQi5EkhEjWtE1MC7/NGOnbHyEB3JRCmZ3UD70e30Rrw4GhV43XaIS5bzZnYIYUrQ0dqPDEuAKQoQdgozuY4dSoOX8s+Vx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421000; c=relaxed/simple;
	bh=vYroxuavsWveUhCjqbhjCVioW/F+uO8YLlLOjYDeL0I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eIX22IqIj4rsO0PBH7TCw1Efu5NNhDyQKaQnPuWDg7DZWUlIdRJZfzBw4P4+Uab+bhmO+NTyzjKIuq4W0sUrs20r85NSYHIlWGvYTEUO8s+on9WPga5+NSKHZBkUegzGQFt17r8zFPvAfNHfjlbnW/cdF/Ie7ol0pZc1DdiKZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UScGGvhY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hauMgtrX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 31 Mar 2025 11:36:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743420996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZGhP5sU+Kl/E1O24FEL/O6QCvbfJI8HJONEw+cxvhA=;
	b=UScGGvhYN5qlTLf0XFdNvqNIKxnq1Ib9wONDfKJbQodkTNn07z5+UgQX56KPn9/odWPkgJ
	PVZp8NUAkikdBz/pyZmMEfLE/NgMFSW0L6Z7DukJniLd/CPqW3D2mPSWgyt1tOnTFv3rNX
	DFukycNfzTcdI8QdXQXnm9uYdAoIDRwdZgenrb3g1GB/rkOjo+kHKoxQIs7kpxa0PcBN9d
	yo7NQP0o1BpD26/bn/Wsmb3l1Y++wIehkbkvmKhRkf5nPsjKr24xGGlDsLaVAdou0So4j5
	5bp0dcZCR4TIAruc6cxBji9deJhDZRQ0Rq++ysoP5qEBmZhwa2z3SboVWwtTiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743420996;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZGhP5sU+Kl/E1O24FEL/O6QCvbfJI8HJONEw+cxvhA=;
	b=hauMgtrX6ugdgmm+5Y+dN9KF+HPwZpeyRTvd2VunIihgSejEFTacUivYgDcJWhDzO5XGBM
	cxj/FHiE0fmb5qCA==
From: "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Eliminate useless task_work on execve
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250327132945.1558783-1-mathieu.desnoyers@efficios.com>
References: <20250327132945.1558783-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174342099606.14745.8266804278210076386.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     328802738e1cd091d04076317f3c2174125c5916
Gitweb:        https://git.kernel.org/tip/328802738e1cd091d04076317f3c2174125c5916
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Thu, 27 Mar 2025 09:29:45 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 31 Mar 2025 12:30:01 +02:00

rseq: Eliminate useless task_work on execve

Eliminate a useless task_work on execve by moving the call to
rseq_set_notify_resume() from sched_mm_cid_after_execve() to the error
path of bprm_execve().

The call to rseq_set_notify_resume() from sched_mm_cid_after_execve() is
pointless in the success case, because rseq_execve() will clear the rseq
pointer before returning to userspace.

sched_mm_cid_after_execve() is called from both the success and error
paths of bprm_execve(). The call to rseq_set_notify_resume() is needed
on error because the mm_cid may have changed.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250327132945.1558783-1-mathieu.desnoyers@efficios.com
---
 fs/exec.c           | 3 ++-
 kernel/sched/core.c | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index f45859a..f511409 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1859,10 +1859,10 @@ static int bprm_execve(struct linux_binprm *bprm)
 		goto out;
 
 	sched_mm_cid_after_execve(current);
+	rseq_execve(current);
 	/* execve succeeded */
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
-	rseq_execve(current);
 	user_events_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
@@ -1879,6 +1879,7 @@ out:
 		force_fatal_sig(SIGSEGV);
 
 	sched_mm_cid_after_execve(current);
+	rseq_set_notify_resume(current);
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cfaca30..c81cf64 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10703,7 +10703,6 @@ void sched_mm_cid_after_execve(struct task_struct *t)
 		smp_mb();
 		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, t, mm);
 	}
-	rseq_set_notify_resume(t);
 }
 
 void sched_mm_cid_fork(struct task_struct *t)

