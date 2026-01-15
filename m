Return-Path: <linux-tip-commits+bounces-8023-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75597D28D28
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12C4C3025506
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5933065B;
	Thu, 15 Jan 2026 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kfXSZOT6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yV39hSXP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940632FA22;
	Thu, 15 Jan 2026 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513455; cv=none; b=eAjdNhisBw/ZASYSLW7Kfw+4o4SU5DbW1k0T90j5H+XxRLZL66haomRyDwrmsnT/BZNaLvIOhnHzUcBtB6JlO/bbSCql9PO+0geQ+O8Pgn9bt9p/bMVuylPVe3MWiiGMn8+6WoSJ3vl78cUHGYnefl85kPERiZsh4nxAvkHEiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513455; c=relaxed/simple;
	bh=huChQ0u2BCn7gXNwfZTkUSsXo9/3LLiXWmTQYYHNToA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dzOcAQWgolnoGcH9QDELkVaQiXDYWrKEMUo/r+sWjSoizLpmTt4BCZPAMtX6E3/d2OkccqiOmYCT41xwI5Zf/wUkkvJlauHFAR0HmakH5jR+xz5uQfgZD/xt//P46Fn14+702u1LBkhgPnHxaMYqNFo1tUs+6As1bvAvhz01XGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kfXSZOT6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yV39hSXP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iu4QgydaaMi/RSPazc4YJlLrlgiHcP6uG+2nrg8dGE=;
	b=kfXSZOT6UvhWpYbEXoefWbcOHaGPjDvkaagQd5aScyT8+yYqV78eUY4kYPgq7OTklAST9x
	sWsEof01zob4jnBnBXJ2l5qHBZveW3Szh0gGc/ZhBZPe3X1WgMsb5to6tDUkwgIyI1Y5ra
	0tZlh4NabsnD7gIcKLPTNqFUsH1DIKgaDe3O4Plc/rzB9tsSHFHRbLmwHzUQjYiELujC++
	olu+puQ8tSMuvNCDQNAk2fcQMTeFxslutCOST2pJsTaDmnbS18KXkXbQ2QCkQiX2hVcf+e
	LWWuETlztw2qSKxn8c9JuB1ybreLWpVK57hQfDQFXxkDHkqnScvOE1+RRn7MqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513452;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/iu4QgydaaMi/RSPazc4YJlLrlgiHcP6uG+2nrg8dGE=;
	b=yV39hSXPG75NJgX7Q1drPa/Rstgkz9tHzwGrsO65b+BBMJpxJCmzvAoDwyOSWp7vxKbIjq
	3yT/naLOY52woTCg==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix slow perf_event_task_exit() with LBR
 callstacks
Cc: Rosalie Fang <rosaliefang@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260112165157.1919624-1-namhyung@kernel.org>
References: <20260112165157.1919624-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851345131.510.5041502314619080345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4960626f956d63dce57f099016c2ecbe637a8229
Gitweb:        https://git.kernel.org/tip/4960626f956d63dce57f099016c2ecbe637=
a8229
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Mon, 12 Jan 2026 08:51:57 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 10:04:26 +01:00

perf/core: Fix slow perf_event_task_exit() with LBR callstacks

I got a report that a task is stuck in perf_event_exit_task() waiting
for global_ctx_data_rwsem.  On large systems with lots threads, it'd
have performance issues when it grabs the lock to iterate all threads
in the system to allocate the context data.

And it'd block task exit path which is problematic especially under
memory pressure.

  perf_event_open
    perf_event_alloc
      attach_perf_ctx_data
        attach_global_ctx_data
          percpu_down_write (global_ctx_data_rwsem)
            for_each_process_thread
              alloc_task_ctx_data
                                               do_exit
                                                 perf_event_exit_task
                                                   percpu_down_read (global_c=
tx_data_rwsem)

It should not hold the global_ctx_data_rwsem on the exit path.  Let's
skip allocation for exiting tasks and free the data carefully.

Reported-by: Rosalie Fang <rosaliefang@google.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260112165157.1919624-1-namhyung@kernel.org
---
 kernel/events/core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 101da5c..da013b9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5421,9 +5421,20 @@ attach_task_ctx_data(struct task_struct *task, struct =
kmem_cache *ctx_cache,
 		return -ENOMEM;
=20
 	for (;;) {
-		if (try_cmpxchg((struct perf_ctx_data **)&task->perf_ctx_data, &old, cd)) {
+		if (try_cmpxchg(&task->perf_ctx_data, &old, cd)) {
 			if (old)
 				perf_free_ctx_data_rcu(old);
+			/*
+			 * Above try_cmpxchg() pairs with try_cmpxchg() from
+			 * detach_task_ctx_data() such that
+			 * if we race with perf_event_exit_task(), we must
+			 * observe PF_EXITING.
+			 */
+			if (task->flags & PF_EXITING) {
+				/* detach_task_ctx_data() may free it already */
+				if (try_cmpxchg(&task->perf_ctx_data, &cd, NULL))
+					perf_free_ctx_data_rcu(cd);
+			}
 			return 0;
 		}
=20
@@ -5469,6 +5480,8 @@ again:
 	/* Allocate everything */
 	scoped_guard (rcu) {
 		for_each_process_thread(g, p) {
+			if (p->flags & PF_EXITING)
+				continue;
 			cd =3D rcu_dereference(p->perf_ctx_data);
 			if (cd && !cd->global) {
 				cd->global =3D 1;
@@ -14562,8 +14575,11 @@ void perf_event_exit_task(struct task_struct *task)
=20
 	/*
 	 * Detach the perf_ctx_data for the system-wide event.
+	 *
+	 * Done without holding global_ctx_data_rwsem; typically
+	 * attach_global_ctx_data() will skip over this task, but otherwise
+	 * attach_task_ctx_data() will observe PF_EXITING.
 	 */
-	guard(percpu_read)(&global_ctx_data_rwsem);
 	detach_task_ctx_data(task);
 }
=20

