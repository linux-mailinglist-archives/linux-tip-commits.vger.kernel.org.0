Return-Path: <linux-tip-commits+bounces-7296-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F21C4D757
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A254C4FC47E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8AA359FAA;
	Tue, 11 Nov 2025 11:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jndL2CI5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Po+b8CQN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429E0359717;
	Tue, 11 Nov 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861038; cv=none; b=j7JP8xn9xYMan//Uwxn7aTgjkxIFtMR3l9kyrxtnEyIjy//2SRZBIZ5EBF1PSobcY24Z6v4POSgpV6dJBFym/zSQmShngEa00UEhCYKnFkmqSAMyWNzmK3jf2ZhZciGUNKQUqFaMaAuSd/rFQG9Ghjgpb0H2+RjHs9xN4/7+4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861038; c=relaxed/simple;
	bh=UbQ6xhIQFO9rKAktYBv/aWPFrwviV5Ff5FMK0MceDwE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TOrV0uc8EZaCfcATWYeu23ADfZAEYCRHfzYOqQzdTVZqs/R8uKLIihRRHACQjSMu+857kAw81rHuP+ULPraJJo6dwqW9lNNiCT6Tj9u1PC6kV2qUQEUjw9ZJFGnGJ3Z/nMTlC7YfWM7Ik9Y7xFg70qcDcOIEeUstV/5gm3sD5Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jndL2CI5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Po+b8CQN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8q6nMQ0muOgmpEEuZ2nXxtFiKqrJ6OhENjQArPlmuOY=;
	b=jndL2CI5ESDV0kO6acAJ21Rm4KcCF7LJjNFjAsSMeoFQkxLgjkRPSJVyPO419801+1rNJF
	lzk6ok18S1m6svE6HUtnylsqI2proihHV9QsQOPvfX7WI33ryEi5tmLt2v5Manse2VuUdP
	yqRzOUTsRMTXoYDWVIMqPDl1WrMwwrtfaZKRD/5twaRmqcQZyrM6sT10rUYhwdCS0uzaB3
	yAvJHvizTc9cJ9Lw8/ojuGpZ3AuuqB2cEAacbqYwtuO9j6cmDNOkSpK7V8LEhAtD3QUZu/
	Y32LsGSv/WkZlIAxJIYCh4qFcTyoTnm/E4kzGL7dXNB0JB5pr7O5Akz9Cxk8oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8q6nMQ0muOgmpEEuZ2nXxtFiKqrJ6OhENjQArPlmuOY=;
	b=Po+b8CQNv9v62tZQVnq+be2DHTupSZ5SiIdDLShl5K2Q1SO7jW4UClE5I/KRX6lZS6OVKr
	dDhWQMZbwqTZNeDg==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/deadline: Minor cleanup in select_task_rq_dl()
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014100342.978936-2-sshegde@linux.ibm.com>
References: <20251014100342.978936-2-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286103375.498.796898019095098678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     46f61fb2e7678daae743d601efac3b957041ed56
Gitweb:        https://git.kernel.org/tip/46f61fb2e7678daae743d601efac3b95704=
1ed56
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Tue, 14 Oct 2025 15:33:41 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Nov 2025 12:33:40 +01:00

sched/deadline: Minor cleanup in select_task_rq_dl()

In select_task_rq_dl, there is only one goto statement, there is no
need for it.

No functional changes.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://patch.msgid.link/20251014100342.978936-2-sshegde@linux.ibm.com
---
 kernel/sched/deadline.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index e46df89..141c9b9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2384,7 +2384,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int f=
lags)
 	struct rq *rq;
=20
 	if (!(flags & WF_TTWU))
-		goto out;
+		return cpu;
=20
 	rq =3D cpu_rq(cpu);
=20
@@ -2422,7 +2422,6 @@ select_task_rq_dl(struct task_struct *p, int cpu, int f=
lags)
 	}
 	rcu_read_unlock();
=20
-out:
 	return cpu;
 }
=20

