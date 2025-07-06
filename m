Return-Path: <linux-tip-commits+bounces-6005-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0DDAFA43E
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Jul 2025 12:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B1918982F4
	for <lists+linux-tip-commits@lfdr.de>; Sun,  6 Jul 2025 10:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212941E86E;
	Sun,  6 Jul 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qPAwvPqc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TnDCM2zf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC12E36EF;
	Sun,  6 Jul 2025 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751796086; cv=none; b=G4OOUspMxxUo3iDrQoM+lki7ValVEaGcfMejXXj8XZOvFCG2mQugdjsh2jVjR75ER1ubwuJl6f37MheuoOltwUjl8XHlPVObDJbACo1Ju8htzaQdoMlX6PhuMQmfYT6x5T1WmZ8DJOHQtvyaPHr/olXyDEq7j/fLnEJ4W8h9Xng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751796086; c=relaxed/simple;
	bh=KXBup4bw9v/gwx8rjKNqMnPDdqBmdOebrKTvjd3ifGA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=a0Sfn9ygtDkljJEmZO068ZRPMR3iFt1wthGuy0lziAeq3LxFl2msrUbP0yVZl8pceyfCEmc6QlMgoDrRkjpPl6Ra1sci+q9uCuvUnMw3In9Ss6De3UmJMp3NynQbwkwjJRI1/5mVLnyAjd6CtscwXoBPRCApzwGDydpF8n+tWDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qPAwvPqc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TnDCM2zf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 06 Jul 2025 10:01:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751796075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgK8bkOxLYF46AwADhta0znjIVz7ejANJtAbVBrIwuE=;
	b=qPAwvPqc6wZnF6+uxmsPhlk6AOhqSx0gx+nlxZI9IMozA7PeBa+vCyqKvZPN6gu2irul2H
	sfMGQY6PqYP0z55jv29yVh3utQ0Et+Xn6jOrXPN47GS3zjNIQmAa1pVs9+5qn8AuXpYSXG
	7Riwz0/hgpViiki5urtb7zI9sRo0tSgtf68HbwHQVtpYev95j1zXfRJQOBIC+JVk2/7lqY
	0ckioAVdxIbQDbu5fuBeRDWOHkOVEfBL63AJEzy/2xw/sKz/j2/SpAVF1B19z68YzKrP+r
	f7vJBMz2jlQZimR6quqXegNymqC7Q6XSKDK+myS7yhjvR8jq3ByOivfgdnHu/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751796075;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SgK8bkOxLYF46AwADhta0znjIVz7ejANJtAbVBrIwuE=;
	b=TnDCM2zf9oI0+iaWjHqaHH/Cptvhiho1cfYTnJkkl/9Gj/yXTBZFhDiYo9DeGQ1ztL9/ZE
	8DJDMyQavy5ytkCw==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] smp: Wait only if work was enqueued
Cc: Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250703203019.11331ac3@fangorn>
References: <20250703203019.11331ac3@fangorn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175179607401.406.16648050119866359640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     946a7281982530d333eaee62bd1726f25908b3a9
Gitweb:        https://git.kernel.org/tip/946a7281982530d333eaee62bd1726f25908b3a9
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Wed, 02 Jul 2025 13:52:54 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 06 Jul 2025 11:57:39 +02:00

smp: Wait only if work was enqueued

Whenever work is enqueued for a remote CPU, smp_call_function_many_cond()
may need to wait for that work to be completed. However, if no work is
enqueued for a remote CPU, because the condition func() evaluated to false
for all CPUs, there is no need to wait.

Set run_remote only if work was enqueued on remote CPUs.

Document the difference between "work enqueued", and "CPU needs to be
woken up"

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Link: https://lore.kernel.org/all/20250703203019.11331ac3@fangorn

---
 kernel/smp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 99d1fd0..c5e1da7 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -802,7 +802,6 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 
 	/* Check if we need remote execution, i.e., any CPU excluding this one. */
 	if (cpumask_any_and_but(mask, cpu_online_mask, this_cpu) < nr_cpu_ids) {
-		run_remote = true;
 		cfd = this_cpu_ptr(&cfd_data);
 		cpumask_and(cfd->cpumask, mask, cpu_online_mask);
 		__cpumask_clear_cpu(this_cpu, cfd->cpumask);
@@ -816,6 +815,9 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 				continue;
 			}
 
+			/* Work is enqueued on a remote CPU. */
+			run_remote = true;
+
 			csd_lock(csd);
 			if (wait)
 				csd->node.u_flags |= CSD_TYPE_SYNC;
@@ -827,6 +829,10 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 #endif
 			trace_csd_queue_cpu(cpu, _RET_IP_, func, csd);
 
+			/*
+			 * Kick the remote CPU if this is the first work
+			 * item enqueued.
+			 */
 			if (llist_add(&csd->node.llist, &per_cpu(call_single_queue, cpu))) {
 				__cpumask_set_cpu(cpu, cfd->cpumask_ipi);
 				nr_cpus++;

