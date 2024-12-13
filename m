Return-Path: <linux-tip-commits+bounces-3054-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C449F0BE2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 13:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A53F281EB7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 12:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B621DF277;
	Fri, 13 Dec 2024 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVEYNQUs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ONQlSYEk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0523E1DE3D5;
	Fri, 13 Dec 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091565; cv=none; b=QX1QyYuCnkdIxpmCcQFvq4Iyg+XYb8YD5X1qNSE6hzCedGGCI8T4t7pO5rInlW7KDb6SSsvwqfq1ziaXIFWHC3hXcski5kAJOVhu3SfZHJ9MsfQcO3zIxKG3XLCnRxX+cIBuYak7uB3yYse0Ths5AtrdbzYksUUos1vhhz15K+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091565; c=relaxed/simple;
	bh=+RZFa2Xfhc8BH2RESSI3IRpzEiCblXT+GkQ/ZoYO32g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=of44pa+2d4z7YUXq98NP9X0vjbJ5KmxLUAyrGkZknByltiRSPf6Y5E0wWNGKAiCB1y/cCdWfXHiVpHPrW3PNtE2EZSkHDkrZsVTggus/6k9aZaF8/wWTF2InUlYuiZJQ0gXU+78r04CmNs7xJnws/hTE/uplfX9EBG/iMpkqCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVEYNQUs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ONQlSYEk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 12:05:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734091559;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muAdKLGkA67I6SLs6zGptZMBU+e9lqYpUtvz61biYfs=;
	b=oVEYNQUsT00JOByA19FH5hpYirk7e3t+Y14HT4i7P6F5QbRD+lCXXW1UO6BBgKCVy+0aPV
	zTW3TdUc591hDNyvsdx/glciqMjHzHA56TR4AF6SPJIz/9DinIJI4kHWoRiuBYKjTIU1dz
	JSY3QxL5dToR+oIP+eENPDVFXYzRW9vY3mYKMiOwFEgphfJ5iU30xM4qk71qz82vPUmzR2
	EyaCeajV39/iIlWfzlaS9AeHDDMVhxlQlxSdlSO86YQZP3e5C/qyqwt5cfuMw1t3VtwySZ
	KHLEyR2kXiv7EnrGZGhwRbY97eko9NGKOIFug0f4JbWdw2XUKu4hXPnuGIp9RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734091559;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muAdKLGkA67I6SLs6zGptZMBU+e9lqYpUtvz61biYfs=;
	b=ONQlSYEkg3kFxGHhrYcgXE8JvSU5i5MK79A3Ou55jR1BN4+DQqvdwgmNhgoJ9RZL6rKJJu
	XZzLeaoUYYVuxsDQ==
From: "tip-bot2 for John Stultz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: deadline: Cleanup goto label in
 pick_earliest_pushable_dl_task
Cc: Todd Kjos <tkjos@google.com>, John Stultz <jstultz@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241206000009.1226085-1-jstultz@google.com>
References: <20241206000009.1226085-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173409155850.412.11730564987439132370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7675361ff9a1d9038025c05267600d0c762c0236
Gitweb:        https://git.kernel.org/tip/7675361ff9a1d9038025c05267600d0c762c0236
Author:        John Stultz <jstultz@google.com>
AuthorDate:    Thu, 05 Dec 2024 15:59:35 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Dec 2024 15:07:06 +01:00

sched: deadline: Cleanup goto label in pick_earliest_pushable_dl_task

Commit 8b5e770ed7c0 ("sched/deadline: Optimize pull_dl_task()")
added a goto label seems would be better written as a while
loop.

So replace the goto with a while loop, to make it easier to read.

Reported-by: Todd Kjos <tkjos@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20241206000009.1226085-1-jstultz@google.com
---
 kernel/sched/deadline.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 33b4646..643d101 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2516,16 +2516,13 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
 		return NULL;
 
 	next_node = rb_first_cached(&rq->dl.pushable_dl_tasks_root);
-
-next_node:
-	if (next_node) {
+	while (next_node) {
 		p = __node_2_pdl(next_node);
 
 		if (task_is_pushable(rq, p, cpu))
 			return p;
 
 		next_node = rb_next(next_node);
-		goto next_node;
 	}
 
 	return NULL;

