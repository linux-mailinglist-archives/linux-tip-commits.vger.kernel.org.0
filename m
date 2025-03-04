Return-Path: <linux-tip-commits+bounces-3863-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2C1A4D745
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A170189BE2F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1317A1FECA6;
	Tue,  4 Mar 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4MxPV3sr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lVqzHxOk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB11FCF72;
	Tue,  4 Mar 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078624; cv=none; b=uVXEsJVC0Yrn4rexflY3R1AmkTesXQ35khnZqIzbkzMxYIe07vdACTM981agqvoo2Lwx+PByfesIIkUGMg05IfELu+KsGtVtjPVoBDziTedCC0/b856InViHMpS97TVvNvoypInmUek53RPmU1wvhSd5LpOud71XQF3rHBlDDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078624; c=relaxed/simple;
	bh=2aO7PQ1wbUHZmtdj4MVaQR2dC0guvvLiW85hZcI928g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uHnAO5K2NpRpe0nlkiU//J9nO45vv0q+aokkk10Y7SleVrRDLr/4PdppsLQFZk24oAfe6acoXIr/UIFcT0xAzshVbX5vJM2tAAFD37yWTGcPO5TH6g6OlMbTsCMcBtPGtI2lryXmzn1iE2+Gbl2wtLNwfiNIsz599Phg3ntHAqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4MxPV3sr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lVqzHxOk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:57:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TelvfEWvQBBYete5jbZU8eHCXzkjCzo/X5J5WdnL2rI=;
	b=4MxPV3sr5CmtoGyUYxGGEK1wJRKL91UbhQ4Kt6AtHYZPISyCEVJ854m/7ramr0ScJqe57p
	hX2hMSoMnHR+nclgNU4hPFpGaZaTmV2LJb1lLR2wylhEseVIgKly2DHexb1exxGpcNJ5gU
	hQ0utvDkC6msSokYtahKsV3LCV1MirKneFrZw32szgL2tJfz9L85dyRVcYqiUwLbT0akQc
	NizgtXY8BDXR5cFLhtMSTMoaDPIr4OyB3CDOUeb0KEzUgKeHxPYKXYF5o77hkKM1xZcbsV
	CH2/Wfxbggu99jnRZRvK48pNCACnuv1Yl26DIXmbnheBEpL7llufp11r5kJd4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TelvfEWvQBBYete5jbZU8eHCXzkjCzo/X5J5WdnL2rI=;
	b=lVqzHxOkwHAs6lXXBM/gRY5Smq3JJ33/TNvCYviO1SBAVjPxxpljeOZ//fBFGGSvNJDbyA
	+tJcY2o6EMzxBfCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Further simplify perf_mmap()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135519.354909594@infradead.org>
References: <20241104135519.354909594@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107862006.14745.6046201773718670869.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0c8a4e4139adf09b27fb910edbc596ea2d31a5db
Gitweb:        https://git.kernel.org/tip/0c8a4e4139adf09b27fb910edbc596ea2d31a5db
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:43:10 +01:00

perf/core: Further simplify perf_mmap()

Perform CSE and such.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20241104135519.354909594@infradead.org
---
 kernel/events/core.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d1b04c8..4cd3494 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6698,9 +6698,18 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		return ret;
 
 	vma_size = vma->vm_end - vma->vm_start;
+	nr_pages = vma_size / PAGE_SIZE;
+
+	if (nr_pages > INT_MAX)
+		return -ENOMEM;
+
+	if (vma_size != PAGE_SIZE * nr_pages)
+		return -EINVAL;
+
+	user_extra = nr_pages;
 
 	if (vma->vm_pgoff == 0) {
-		nr_pages = (vma_size / PAGE_SIZE) - 1;
+		nr_pages -= 1;
 
 		/*
 		 * If we have rb pages ensure they're a power-of-two number, so we
@@ -6709,9 +6718,6 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		if (nr_pages != 0 && !is_power_of_2(nr_pages))
 			return -EINVAL;
 
-		if (vma_size != PAGE_SIZE * (1 + nr_pages))
-			return -EINVAL;
-
 		WARN_ON_ONCE(event->ctx->parent_ctx);
 again:
 		mutex_lock(&event->mmap_mutex);
@@ -6735,8 +6741,6 @@ again:
 			rb = event->rb;
 			goto unlock;
 		}
-
-		user_extra = nr_pages + 1;
 	} else {
 		/*
 		 * AUX area mapping: if rb->aux_nr_pages != 0, it's already
@@ -6748,10 +6752,6 @@ again:
 		if (!event->rb)
 			return -EINVAL;
 
-		nr_pages = vma_size / PAGE_SIZE;
-		if (nr_pages > INT_MAX)
-			return -ENOMEM;
-
 		mutex_lock(&event->mmap_mutex);
 		ret = -EINVAL;
 
@@ -6795,7 +6795,6 @@ again:
 		}
 
 		atomic_set(&rb->aux_mmap_count, 1);
-		user_extra = nr_pages;
 	}
 
 	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);

