Return-Path: <linux-tip-commits+bounces-3864-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FAFA4D747
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A60189B683
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD2A1FECC0;
	Tue,  4 Mar 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r9KA1jbt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JbpZWl8X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD51FCFD8;
	Tue,  4 Mar 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078624; cv=none; b=f/6JP/1EdjZFQyDfpLe13KWA+TCKeMguZYGK0cx170TXu6V33i0/uYfM9qz4xJMVajFLX2XbacbihEHlqR02ErsO0L63EDD5ZzgVy9TMuk1xO3KRCmhdJytagx/jJBJl2/qMA3lDlG7FFROTzzrXK4dUm/BZXyXfpVPYFO0a2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078624; c=relaxed/simple;
	bh=VPrbrFJj6gJNxy54hoWMLKmTGx9oUcl5mEHFDecQy68=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pcgd/3TFceqml5E/X3CjQahiNWJIQqCtmU8OExaUc/YvaUWNokmPZxg5Xp5qSiJFYIYiT11EobI+Ra5ow/sCGIsAZi3bYam4qx5tt4eDI77mQSybXxwKBS0mzpSdptbiAcR+/s/ID3obE34zAT4iqUoF7ATIX0HLvE9/v3IYVAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r9KA1jbt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JbpZWl8X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:57:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsZrhUbnJpf68D4N+P/rquxoKp1FTlHeu6ioDKQJ9e0=;
	b=r9KA1jbtoSZFWeAh0vW1VhShJC7paBXqyEO/Vo0zUEvVGz1x1mZ9CzR53cKcYm+RT09PqY
	y4+N6N2SKwDXmc8gjELVvNiPi/0sgNyotceb6/t25KFiURKcE5c+kZi27dvwMbcKi9iikp
	CLETLbHxhJEXvJe2o3WeX4C0L/MPsIPBbPU/fEmaOvbGg0xjPa/um1Sbv0dKsen9GdJ8se
	NltFPN6dwLTc38DY6G/3zSIcyA0CBug5oA7qtXS4wLPAfdvdQcYEHFbYVOraEKOi+Lthvy
	8rGiVuBkAJx/WaLHDSkTJiQCgVzybBXi/+XnIj7U/IAH54fQZK1fvLANb+GFCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsZrhUbnJpf68D4N+P/rquxoKp1FTlHeu6ioDKQJ9e0=;
	b=JbpZWl8XAcK2dJgGOq9BBHZpHfy0UUmtWq3jRmDezbjtGPK2tx39higSp5v4I5faP/XA9n
	6kzSFndX33PSf6Bw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Simplify the perf_mmap() control flow
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135519.095904637@infradead.org>
References: <20241104135519.095904637@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107862072.14745.3493282788451575265.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     954878377bc81459b95937a05f01e8ebf6a05083
Gitweb:        https://git.kernel.org/tip/954878377bc81459b95937a05f01e8ebf6a05083
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:43:05 +01:00

perf/core: Simplify the perf_mmap() control flow

Identity-transform:

	if (c) {
		X1;
	} else {
		Y;
		goto l;
	}

	X2;
  l:

into the simpler:

	if (c) {
		X1;
		X2;
	} else {
		Y;
	}

[ mingo: Forward ported it ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20241104135519.095904637@infradead.org
---
 kernel/events/core.c | 75 ++++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ab4e497..d1b04c8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6701,6 +6701,42 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 	if (vma->vm_pgoff == 0) {
 		nr_pages = (vma_size / PAGE_SIZE) - 1;
+
+		/*
+		 * If we have rb pages ensure they're a power-of-two number, so we
+		 * can do bitmasks instead of modulo.
+		 */
+		if (nr_pages != 0 && !is_power_of_2(nr_pages))
+			return -EINVAL;
+
+		if (vma_size != PAGE_SIZE * (1 + nr_pages))
+			return -EINVAL;
+
+		WARN_ON_ONCE(event->ctx->parent_ctx);
+again:
+		mutex_lock(&event->mmap_mutex);
+		if (event->rb) {
+			if (data_page_nr(event->rb) != nr_pages) {
+				ret = -EINVAL;
+				goto unlock;
+			}
+
+			if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
+				/*
+				 * Raced against perf_mmap_close(); remove the
+				 * event and try again.
+				 */
+				ring_buffer_attach(event, NULL);
+				mutex_unlock(&event->mmap_mutex);
+				goto again;
+			}
+
+			/* We need the rb to map pages. */
+			rb = event->rb;
+			goto unlock;
+		}
+
+		user_extra = nr_pages + 1;
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
@@ -6760,47 +6796,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 		atomic_set(&rb->aux_mmap_count, 1);
 		user_extra = nr_pages;
-
-		goto accounting;
-	}
-
-	/*
-	 * If we have rb pages ensure they're a power-of-two number, so we
-	 * can do bitmasks instead of modulo.
-	 */
-	if (nr_pages != 0 && !is_power_of_2(nr_pages))
-		return -EINVAL;
-
-	if (vma_size != PAGE_SIZE * (1 + nr_pages))
-		return -EINVAL;
-
-	WARN_ON_ONCE(event->ctx->parent_ctx);
-again:
-	mutex_lock(&event->mmap_mutex);
-	if (event->rb) {
-		if (data_page_nr(event->rb) != nr_pages) {
-			ret = -EINVAL;
-			goto unlock;
-		}
-
-		if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
-			/*
-			 * Raced against perf_mmap_close(); remove the
-			 * event and try again.
-			 */
-			ring_buffer_attach(event, NULL);
-			mutex_unlock(&event->mmap_mutex);
-			goto again;
-		}
-
-		/* We need the rb to map pages. */
-		rb = event->rb;
-		goto unlock;
 	}
 
-	user_extra = nr_pages + 1;
-
-accounting:
 	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
 
 	/*

