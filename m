Return-Path: <linux-tip-commits+bounces-3861-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84037A4D72F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ADBD7A3FDB
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441461FCF62;
	Tue,  4 Mar 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZIAeiSDx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQLES6mt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D01FC108;
	Tue,  4 Mar 2025 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078622; cv=none; b=Pf7jkbVre+h1KDEcf++bjzFVss5Wk7L3mJC4ketFWAD8PCHZMlQfDaCNeS0CCu4dvvmPqVKBqSinzxgLDcpALTjgo4fq3DeuBqGU71udqftQQe0dz0HexP7fPMvjXkvSlMXVhtqIwoO8zWrxwT+HiZgIquFDP1UeiWNmrZnOtq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078622; c=relaxed/simple;
	bh=83YQIQf/AUHg8+iTwxggwWGdK77oE5zHDdXJKprZm38=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d5fnqOtVXfyOqt+yGBdKhcvUdTwpH0bkzayIP6ipTy0ZJ/8OU65HnhcRQzFCOiGhnzm+N7HuIX4cjd89QR+gdKyq81sp38z4J9b2Mm5kJiqk0C7rFmDJatfvPCk8QCBfyJKo8vkzo5kRz6kaU2v+QF3HMVMfTct+RfqjDT+/Cuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZIAeiSDx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQLES6mt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:56:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCe6oN2pR7yqOZE8HGCxS1JB4+pXQ9FRQKdngccvN2g=;
	b=ZIAeiSDx2u3JzIid3wYRhguePELWG9LUup5Fy9PEa1gE6b1OxSChy+S0NqB9YqnQHg6Pum
	/GbeWecdoJqAVEUvBmLoiBYnvSb+JsU/aKrCmZAMSFzHcZdJnXLjdt17412ap7RzDo97Ym
	RixN9ukvhRMYw/5vnJNOj288kqtDc7QHL4NCppiwOyOV4N2Z7iCF+o/1Jv+2+GKoOLtH4C
	eR8hzlTzvnZHk/fnSLlrySPOzMuDZgU+hKqbCLBJygj7fxoo9TJjcKXe3GdfiGDS8vZo6W
	e8g+Vqi09TeSh6r8vfMM0m1kFJvAQoMy4F/24UVy6LTPNrVV2nCgbLvzKx8xNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078619;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCe6oN2pR7yqOZE8HGCxS1JB4+pXQ9FRQKdngccvN2g=;
	b=oQLES6mtNFaB8GxNXQZB9n93qKa8fRN7di22Jd2X/kO0Dle3QEDfd5KZsj1H/bqzvksgYf
	y76I7Sgt3WEPgoAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Lift event->mmap_mutex in perf_mmap()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135519.582252957@infradead.org>
References: <20241104135519.582252957@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107861864.14745.13235275220207492350.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0983593f32c4c94239e01e42e4a17664b64a3c63
Gitweb:        https://git.kernel.org/tip/0983593f32c4c94239e01e42e4a17664b64a3c63
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:27 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:43:19 +01:00

perf/core: Lift event->mmap_mutex in perf_mmap()

This puts 'all' of perf_mmap() under single event->mmap_mutex.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
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

