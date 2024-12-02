Return-Path: <linux-tip-commits+bounces-2952-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C8F9E0776
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 16:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AF417497A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E9420ADD8;
	Mon,  2 Dec 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m6S8ycLr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V6scLVXp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3232320ADD3;
	Mon,  2 Dec 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152753; cv=none; b=gwPX8h+yftJLx/VhJZdtZrLfbhIVv+Tt4CfWmAKn2n2cg5J5WL6xzbnPp+iYeEZ2YeYq6k6zXlMTMNBa4i4nBsrN2kF3QtjMlxf8CdHy7v0cCuHGgwGmmhBzwLu1R713o9WTQXCFzCMd8QvlicxH8hHXDtWYULUb/fZFc4yzqOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152753; c=relaxed/simple;
	bh=pMqk8f4ZF02LxWek4PS4btHzMHEM1ZKqlOSdscy5dSg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VFkiuMgXevdPD3A5XlcuNEs73xcx40u+0SEZ7sfzjyLWuIZWlYyh68eOOGDphq4uHXnKJporU1FV0mHl7jDi9xhbMipH1Z449l/cl7EIjsEs64hrELS+p5VAWgOtb3fMiqr4rr0M2EIBf33ONkAtnNg6lrb2Jj4FULf5F0Qa+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m6S8ycLr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V6scLVXp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 15:19:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733152747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XR5B9KFT4xE9l63plzQyJjpZNjoJx+Yy7PUgRslOnTw=;
	b=m6S8ycLrdBURHfyENSY7ljNd9BWEn+9e1UZZRTwkHZZMDq3IF8lfBLbHf1tQv30XbYvjCo
	s6PoQbJBRE8UbjiOA2s4K9vK4gW/pgRf9q61PscXEFsHV8buVBs+O13eezCp4TNHKXcvrk
	s5b+LoNQ2GrETqvPlPQK7hKWc6txEMp1izQbBQJWDCHG0WtFo2BxfLz3mgP6yYrIeDDUCS
	P169AtdBHLnus/rn2IQY4SieOZbwRK2pqLGyX6SmljY485ul8g/i7W2RwJX8rMh42cfppd
	Gy1AGbZLpXWXPrzRvtu/ORw61tY4+WrVcP7Gh4O72WTfpHdSuCdy4y+wwFRzVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733152747;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XR5B9KFT4xE9l63plzQyJjpZNjoJx+Yy7PUgRslOnTw=;
	b=V6scLVXpQ3qZfyEY/QD9Ofdq5j3J/p/siD6DxKE3ZdZUNWEPTLZgFXQexGfAaDg8/nuffK
	Qjp2Hy5AINxQ9XDQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Use kthread_run_on_cpu()
Cc: Frederic Weisbecker <frederic@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240807160228.26206-3-frederic@kernel.org>
References: <20240807160228.26206-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173315274594.412.9333883687105089333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     a763fc24ecf2ef0471ccba3b1ff6e6271f4bdc0b
Gitweb:        https://git.kernel.org/tip/a763fc24ecf2ef0471ccba3b1ff6e6271f4bdc0b
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:02:08 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 02 Dec 2024 15:35:35 +01:00

x86/resctrl: Use kthread_run_on_cpu()

Use the proper API instead of open coding it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20240807160228.26206-3-frederic@kernel.org
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 28 ++++++----------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 972e6b6..6c60c16 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1205,20 +1205,14 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
 	plr->cpu = cpu;
 
 	if (sel == 1)
-		thread = kthread_create_on_node(measure_cycles_lat_fn, plr,
-						cpu_to_node(cpu),
-						"pseudo_lock_measure/%u",
-						cpu);
+		thread = kthread_run_on_cpu(measure_cycles_lat_fn, plr,
+					    cpu, "pseudo_lock_measure/%u");
 	else if (sel == 2)
-		thread = kthread_create_on_node(measure_l2_residency, plr,
-						cpu_to_node(cpu),
-						"pseudo_lock_measure/%u",
-						cpu);
+		thread = kthread_run_on_cpu(measure_l2_residency, plr,
+					    cpu, "pseudo_lock_measure/%u");
 	else if (sel == 3)
-		thread = kthread_create_on_node(measure_l3_residency, plr,
-						cpu_to_node(cpu),
-						"pseudo_lock_measure/%u",
-						cpu);
+		thread = kthread_run_on_cpu(measure_l3_residency, plr,
+					    cpu, "pseudo_lock_measure/%u");
 	else
 		goto out;
 
@@ -1226,8 +1220,6 @@ static int pseudo_lock_measure_cycles(struct rdtgroup *rdtgrp, int sel)
 		ret = PTR_ERR(thread);
 		goto out;
 	}
-	kthread_bind(thread, cpu);
-	wake_up_process(thread);
 
 	ret = wait_event_interruptible(plr->lock_thread_wq,
 				       plr->thread_done == 1);
@@ -1315,18 +1307,14 @@ int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 
 	plr->thread_done = 0;
 
-	thread = kthread_create_on_node(pseudo_lock_fn, rdtgrp,
-					cpu_to_node(plr->cpu),
-					"pseudo_lock/%u", plr->cpu);
+	thread = kthread_run_on_cpu(pseudo_lock_fn, rdtgrp,
+				    plr->cpu, "pseudo_lock/%u");
 	if (IS_ERR(thread)) {
 		ret = PTR_ERR(thread);
 		rdt_last_cmd_printf("Locking thread returned error %d\n", ret);
 		goto out_cstates;
 	}
 
-	kthread_bind(thread, plr->cpu);
-	wake_up_process(thread);
-
 	ret = wait_event_interruptible(plr->lock_thread_wq,
 				       plr->thread_done == 1);
 	if (ret < 0) {

