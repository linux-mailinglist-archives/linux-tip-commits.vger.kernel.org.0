Return-Path: <linux-tip-commits+bounces-4631-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4A1A7A1D0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 601643B5D0A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 11:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDECB746E;
	Thu,  3 Apr 2025 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hu2oZ9Y2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="odzNzDws"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AC9161320;
	Thu,  3 Apr 2025 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743679600; cv=none; b=HefGAPkuJIPH7SNZGP1FVQn18v5+VJG5eRFIBoe342tQPpHoQHDo9Re1Y14gHzU++T81qis4WZmbhMP93WHP7gV+GGZXtLcddJjL3wCgsck/dnBN7yVMhdwcDjvewZkvdAFXFwk6tIYAVkwjE3tvRnhF3w4x4N29ny8UY96zqdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743679600; c=relaxed/simple;
	bh=rS3BIFhO7Scj/OffZVUYYibFEFSgamdlXu2+hANWw6Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bpcd8PnE5nge+uyJV42ILDl5NO2Pg6WF7FGsZbFOmZk6QDS63R6IbKZyupQeDnbANP76jMdWDhO/JwO+/MGE1bM7VWlvTe9zwwCuQ997tPlmtO2ba9sGL9FBqS5gE6Nf5E+Wy9sBxjCApe2dwXvak++ngLIOzkgd4dKTZR9YLVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hu2oZ9Y2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=odzNzDws; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 11:26:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743679597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWRQuXR+O4982s+lGdZM8l5ZKghIETw9NPkFGg+OkNM=;
	b=Hu2oZ9Y2iI1t/3iQXm5dR1OFrtjocgmIqcv2tdEWTCObT0Qm4VVViioxB18ioEeybCf/5x
	bMdFMbrbH9ylOVouH7CbrAjcCGabdlL0veCSy9taB/Z0pu4G7wKqllj3fwFGVSwspVHvhi
	d/N9Z6giRpeFdZo0qT8FfUnh8+FIQ/FGKY5FWXtVd6KQ0MQO2Qgmy+3UdU1ZKdt7ltaw/B
	kWO1X5tKgZoOe+Ujgj3YAsWc8zDJbZh639IlJCfSNOnnbaZf8HuDg1iXqU3t43wAUMlt5w
	rf2UlKzU0EWgT0VnoRsJA99QjY2Gt/Y8aVbfz78av+b2Lr6spFbMSL/SqtLhIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743679597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWRQuXR+O4982s+lGdZM8l5ZKghIETw9NPkFGg+OkNM=;
	b=odzNzDwsL1XGLerWVckFdR58eOYAg8SlSzDuq8Syr4NDMNWVkFLdc2O+BFsR5UXXo+T6v2
	qZpz4dQwY/xj8KBQ==
From: "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] rseq: Eliminate useless task_work on execve
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327132945.1558783-1-mathieu.desnoyers@efficios.com>
References: <20250327132945.1558783-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174367959256.14745.905696151357329121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     169eae7711ea4b745e2d33d53e7b88689b10e1a0
Gitweb:        https://git.kernel.org/tip/169eae7711ea4b745e2d33d53e7b88689b10e1a0
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Thu, 27 Mar 2025 09:29:45 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Apr 2025 13:10:47 +02:00

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

Also move the rseq_execve() to right after sched_mm_cid_after_execve()
in bprm_execve().

[ mingo: Merged to a recent upstream kernel, extended the changelog. ]

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250327132945.1558783-1-mathieu.desnoyers@efficios.com
---
 fs/exec.c           | 3 ++-
 kernel/sched/core.c | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 5d1c0d2..8e4ea5f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1864,9 +1864,9 @@ static int bprm_execve(struct linux_binprm *bprm)
 		goto out;
 
 	sched_mm_cid_after_execve(current);
+	rseq_execve(current);
 	/* execve succeeded */
 	current->in_execve = 0;
-	rseq_execve(current);
 	user_events_execve(current);
 	acct_update_integrals(current);
 	task_numa_free(current, false);
@@ -1883,6 +1883,7 @@ out:
 		force_fatal_sig(SIGSEGV);
 
 	sched_mm_cid_after_execve(current);
+	rseq_set_notify_resume(current);
 	current->in_execve = 0;
 
 	return retval;
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

