Return-Path: <linux-tip-commits+bounces-3750-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E018A4AD9D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF291891FB4
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0E31E7C27;
	Sat,  1 Mar 2025 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P2+aeEKL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OITxMqlx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21B1B6CE4;
	Sat,  1 Mar 2025 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859654; cv=none; b=GqzOQmjFeBVfxE8bOPv44A2rvqp8g+++k5luibdMu9C1DUHxtxOgaX2tQCN8j6kVjSqt7OWOTiiUB56tpoK3kYMSeMxazuMwwckGgRC0BFjzXnqg7fTHkQ3SypLiGsB/6wVZCbp0tqW9RCx0blAn7IRWIX2zOzd724pvYT+iOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859654; c=relaxed/simple;
	bh=smmfRA297WhMBInI9HeaX/fbQLEUGT5und0qOD/dUQ0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nzWEoEQO+CDCbL9ZZrpCTBoYJa70mdo8tt6+K2zWvUoxI47drKzW7AS6+0rvDBVLbaN/qDYMxCs99lZl6klYRAGb7de0cjpyA2xwvFSX2wpaHbtmYfGp5YTcYbsIqglSwbLrodlp/zed7uYwtmPdEY+0cPpcqClbiI+hsa80N2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P2+aeEKL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OITxMqlx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:07:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60MPj+LRy8AuTB1wQrSgfRk5sUhfosgff0YdZhZsIVE=;
	b=P2+aeEKLX5vdWEcu1yz7ZF71HY6rfUeuRYBGLBxYHFVOO6V43qhK8eAVhkKHgIE9lKl5dA
	xlIU6PYYXEQDs4+Reyzt9WvOrU6TuTMU1y/ahjk18Qw9iUtkoOoTCc3HcvL4FbgQQR/X5Q
	vJ1EypEaMOt8fMw6zD7F3oh9Fe3QX5ye+tKHAE2byzMDzVQtLWiswAJvHEIzmgZlMjso5e
	Q6u6qKDBSgLyDtk0fUO2xXwlNf94xVfXRrSeyTG77jlFT2Co/MGQpUUUqdLFDzWW7ottzj
	MXOm7FPpwiLloQ9BFQV4YcZ8098oufqnshuslWdwmzGbbgkSBNBjVghJd68KAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859650;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60MPj+LRy8AuTB1wQrSgfRk5sUhfosgff0YdZhZsIVE=;
	b=OITxMqlx5Z9rXs8c95vnlN1qVhVmpaPtRJVPWaHVHq6hIzUkxyAcexz5qgNDKU8+MKN0+h
	xoQYqiQGEKiG89Dw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Lift event->mmap_mutex in perf_mmap()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135519.582252957@infradead.org>
References: <20241104135519.582252957@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085964964.10177.16091258779077170017.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     244b28f87ba48daaed81bbfe5af079e320c1e093
Gitweb:        https://git.kernel.org/tip/244b28f87ba48daaed81bbfe5af079e320c1e093
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:27 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 20:32:30 +01:00

perf/core: Lift event->mmap_mutex in perf_mmap()

This puts 'all' of perf_mmap() under single event->mmap_mutex.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241104135519.582252957@infradead.org
---
 kernel/events/core.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ca4c124..773875a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6680,7 +6680,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	unsigned long vma_size;
 	unsigned long nr_pages;
 	long user_extra = 0, extra = 0;
-	int ret = 0, flags = 0;
+	int ret, flags = 0;
 
 	/*
 	 * Don't allow mmap() of inherited per-task counters. This would
@@ -6708,6 +6708,9 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 	user_extra = nr_pages;
 
+	mutex_lock(&event->mmap_mutex);
+	ret = -EINVAL;
+
 	if (vma->vm_pgoff == 0) {
 		nr_pages -= 1;
 
@@ -6716,16 +6719,13 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		 * can do bitmasks instead of modulo.
 		 */
 		if (nr_pages != 0 && !is_power_of_2(nr_pages))
-			return -EINVAL;
+			goto unlock;
 
 		WARN_ON_ONCE(event->ctx->parent_ctx);
-		mutex_lock(&event->mmap_mutex);
 
 		if (event->rb) {
-			if (data_page_nr(event->rb) != nr_pages) {
-				ret = -EINVAL;
+			if (data_page_nr(event->rb) != nr_pages)
 				goto unlock;
-			}
 
 			if (atomic_inc_not_zero(&event->rb->mmap_count)) {
 				/*
@@ -6754,12 +6754,6 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		 */
 		u64 aux_offset, aux_size;
 
-		if (!event->rb)
-			return -EINVAL;
-
-		mutex_lock(&event->mmap_mutex);
-		ret = -EINVAL;
-
 		rb = event->rb;
 		if (!rb)
 			goto aux_unlock;
@@ -6869,6 +6863,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			rb->aux_mmap_locked = extra;
 	}
 
+	ret = 0;
+
 unlock:
 	if (!ret) {
 		atomic_long_add(user_extra, &user->locked_vm);

