Return-Path: <linux-tip-commits+bounces-3751-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B1AA4AD9E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E738D3AD6D9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4CF1E7C3B;
	Sat,  1 Mar 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xaW1DQfy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CubSqlmf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9231E0B66;
	Sat,  1 Mar 2025 20:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859654; cv=none; b=erCf3kkVGolzMO2jTDKeUNUZevQBu7BFo8oGQC1I2Tno2mUmYhbdMvIMNx23gNLy3qWdjNI47Z23sZFhpPzdtjdzF4ATN+n1bIRTyQK0QmSq5jduHhBaBdasCYRAQaHKn/u2G1BF0zhg3iJodJLXf3nVnPpm1Fe/FzYjjJXvMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859654; c=relaxed/simple;
	bh=HRX8bg48zVrePpmr5Qcuig82198J1MleIly9xpWf0d0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WeP+a/hUJR9Ldcg1nerDL/nUkVCGzlU6Eu1yCU8FdZyg3srS2BamU5sFMQyocy16477xUMO3AZDlud/ciTsczihrd3ImvllYZVdZJHr6QUgdHosxN51t6T84PWJL+khhm2SfUqVcUrtMJU8QB211+myyrf+YfucLohj3PRUBxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xaW1DQfy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CubSqlmf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:07:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afetMeX/yLqI3oDynFt9Aup9xZc01pv/jmu/5XB+Kto=;
	b=xaW1DQfykss2vW+9++VHb8kXQ1JXhE0TcNSUw2vsgvfVJuG4irqAMwffa+S3GJI9ip9jcb
	E4QuWB/bSKdDDA2rODTrsE1LsdFrbBTIrW5Fl6qEPvLVPC5KiHUYO8FFBQQxxmGZx4VWDs
	MSxeg6Uq4ymSNv+Mk0etaJHeKl9n9LBhrbHK3iW2oFJPoDjO1xaBSan4U97okpDoZQq3fG
	U7lVLvdAcvDi7Ksrj7R/96VQ1fD5fxJkucG1p5KAVOrJoClO410swPr/+q9ZegQ9hVL41W
	UuFqj0b5pvErMXIUe9FqkccvII0U2UxO05ivSEozhw3Zruw1bFgTJrQUiJ5iVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afetMeX/yLqI3oDynFt9Aup9xZc01pv/jmu/5XB+Kto=;
	b=CubSqlmfYdDpkCAu/IFT1zDs/4vKwgER2iSC9EB0oW7x6Eerm6xKDKkBHBrWyZKKcX1iiX
	FhHL7IrOqZkacUBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Further simplify perf_mmap()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135519.354909594@infradead.org>
References: <20241104135519.354909594@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085965060.10177.17755292034498945084.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8c7446add31e5db22ceb2f066a8674735c9753f1
Gitweb:        https://git.kernel.org/tip/8c7446add31e5db22ceb2f066a8674735c9753f1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:25 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 20:24:34 +01:00

perf/core: Further simplify perf_mmap()

Perform CSE and such.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

