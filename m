Return-Path: <linux-tip-commits+bounces-3066-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E32DD9F17C5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 22:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE863188FB5F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB971E1021;
	Fri, 13 Dec 2024 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IeNucRcw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VTuB/OCP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75001A8F60;
	Fri, 13 Dec 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123769; cv=none; b=d3DLsOzjKGwvafh28O2kH9dhpzAn0wFohI013PoW/urB4hFwsXk1xKRCWV/2PQ3kuLSy4RdJfSmW7XFyQx/kRu72QTtAVGQ9LV0SWjtsfOkyxlfBEUTUkht+uePqyWGdjMlSxRGI1cf5N+tW8lNSCoifiIJ3JkIgyILyBBNzFio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123769; c=relaxed/simple;
	bh=dy7IuC3wohCQz6h8AsPtp9hQFu86VGIZIGShaR/I3Nk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cldg6yjldyk0a27SYoHRfynn+gfMqv01vCU/O36jUQs9tD7gKGWimtq8QYsTtBe02KEAB7xKziKsN4dQVAH2fWEm7dSNwmrRNODIr7HdTEhoCDtIVAwMs2XqNmUzkHEJykNvRtN01go4/Jcdj6wViuxoF7MbO/EnTYHYAKIAIpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IeNucRcw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTuB/OCP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 21:02:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734123766;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpZjK133TngO0jA+6keLNSvsqYq2SYpMRve43G8kCZA=;
	b=IeNucRcwVcMnOYbDW/xfj9gHltcc0QGL02GgSRFNtnvAAbPSXeaktSGYu4tatVZ0mxnZQj
	WTB7FxmFVr8FgFRi2QqHhlod27sPSom64taj8WA77CR7hV+cDVXrjEgIUzIsxeI87JCrW2
	AAv3RKnCsE7HNs7H8yAr6yUL4BCSVw0fYEyQKLLNQNQfoKD8hmHxa5sSo3xH7vBn6qmyQG
	hWasrlRfOztCLVz9/KPAa5XXyDJ5dbdf8Yxn71CT1YQQqupoh5GxgEHkMSLzWUSm6tdsFX
	GGSzkqgYYcy1W7B/53eec/Kjxl3JYJwhz4HKmkBrqc3EtXO5toow79TAA7m1Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734123766;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpZjK133TngO0jA+6keLNSvsqYq2SYpMRve43G8kCZA=;
	b=VTuB/OCPaTdwHfDfhtVcqj32/mJ37mbJliaiDCti37xe9Sjnhir3lm+hDy7sTcanK+OjSb
	T36wv3KehnRg9sCg==
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
Message-ID: <173412376503.412.2725711598101418834.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     135eef38d7e081303fd9cdb982b37fcad32f9be0
Gitweb:        https://git.kernel.org/tip/135eef38d7e081303fd9cdb982b37fcad32f9be0
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:02:08 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 09 Dec 2024 20:19:48 +01:00

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

