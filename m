Return-Path: <linux-tip-commits+bounces-2360-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95CD9941E8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 10:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529291F2B509
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 08:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B791220C46F;
	Tue,  8 Oct 2024 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O9LJuDw5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W3+DJXAa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2841E47DC;
	Tue,  8 Oct 2024 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374185; cv=none; b=BegDLntcHp7tMJsblOy0cK3kSVdcE7M+NmUWRyebLtkCpLdDmv1nvrOldTOpHaqgB7ZGdA8rke1u7Das4sVmUi4C9Bb06rDiRv3srCE3nI16u2pysHFvd9fLJn9VXZyjPH/AKLZzfIJDWR5tou36djXoiFuuRRe6BHDa05WkdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374185; c=relaxed/simple;
	bh=OnZdR/PeIStOl/UwKGSNmYgyBjQlSaVWMVmJ7hglGIU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tbU8wXjAuaD21VG5b0C+l734AAXggAsFUC8nBVSKV0SW8kbiwL2rxQwvnAGSQvNKB0cAIOYgV87E4HvGsx/uUZjE6tIruFtfC9jOfyrVX9Ty97zft/8PhuST7Dm67hs/eND/BVf/t66u41yorVO4P0f3KzXuLlvZd6bge/2IlCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O9LJuDw5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W3+DJXAa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 07:56:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728374182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjG+YXoheuV4tyzsZL+44/97M+trG4fGWcGM6FdA75Q=;
	b=O9LJuDw5KBcZ1vTVvh8WQ16KrHxioNPzG6CI0sHlfPTJuxVhjKmEWompA1Mz/sWvWJ9CO4
	8YtJyIiOT3N1ohGB2t073JMedpMACgjb/eEX863HnQCkJ4rFAxnF9Wtt3He3P+TWvGWIGI
	QYaclujemuMOX0EwSvkGKv/MHuPXulLaa20aIKhRL9JBKK5vontawdWEmAh0J4LrKWDY2W
	WAngi2TbhrGB37YkxIPPTeo2CUsB2XwHr7h9UdzWyf2qzjwMJHeTUDsuRTF+XCLq+QShRu
	aI635u1Be/NC1w5hAXahrJBC5/re3TZ0+TPOttoXmGswspLVuT5nHqEIMsY/Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728374182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjG+YXoheuV4tyzsZL+44/97M+trG4fGWcGM6FdA75Q=;
	b=W3+DJXAarcQ6PYaY+W1+H3zHzP3G+ZXee+LDFb/1ERffLTyitq/Ei5D0RAGO+VGBzCU+xO
	394qJvk2XjcWfCDw==
From: "tip-bot2 for NeilBrown" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: add wait_var_event_io()
Cc: NeilBrown <neilb@suse.de>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240925053405.3960701-7-neilb@suse.de>
References: <20240925053405.3960701-7-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172837418166.1442.8175035816812384640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     80681c04c5e8e4297b9ebf201ca3ce6242aa16c3
Gitweb:        https://git.kernel.org/tip/80681c04c5e8e4297b9ebf201ca3ce6242aa16c3
Author:        NeilBrown <neilb@suse.de>
AuthorDate:    Wed, 25 Sep 2024 15:31:43 +10:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:39 +02:00

sched: add wait_var_event_io()

It is not currently possible to wait wait_var_event for an io_schedule()
style wait.  This patch adds wait_var_event_io() for that purpose.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240925053405.3960701-7-neilb@suse.de
---
 include/linux/wait_bit.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 6aea10e..6346e26 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -281,6 +281,9 @@ __out:	__ret;								\
 #define __wait_var_event(var, condition)				\
 	___wait_var_event(var, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
 			  schedule())
+#define __wait_var_event_io(var, condition)				\
+	___wait_var_event(var, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
+			  io_schedule())
 
 /**
  * wait_var_event - wait for a variable to be updated and notified
@@ -306,6 +309,34 @@ do {									\
 	__wait_var_event(var, condition);				\
 } while (0)
 
+/**
+ * wait_var_event_io - wait for a variable to be updated and notified
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ *
+ * Wait for an IO related @condition to be true, only re-checking when a
+ * wake up is received for the given @var (an arbitrary kernel address
+ * which need not be directly related to the given condition, but
+ * usually is).
+ *
+ * The process will wait on a waitqueue selected by hash from a shared
+ * pool.  It will only be woken on a wake_up for the given address.
+ *
+ * This is similar to wait_var_event(), but calls io_schedule() instead
+ * of schedule().
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
+#define wait_var_event_io(var, condition)				\
+do {									\
+	might_sleep();							\
+	if (condition)							\
+		break;							\
+	__wait_var_event_io(var, condition);				\
+} while (0)
+
 #define __wait_var_event_killable(var, condition)			\
 	___wait_var_event(var, condition, TASK_KILLABLE, 0, 0,		\
 			  schedule())

