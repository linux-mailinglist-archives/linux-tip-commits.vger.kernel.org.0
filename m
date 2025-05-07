Return-Path: <linux-tip-commits+bounces-5404-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A24BAADB01
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7587B4651AA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08082472A1;
	Wed,  7 May 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ayVBKvBo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZExXUFZx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89224467E;
	Wed,  7 May 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608866; cv=none; b=r3F4Tq2hfcvnibVDERHfyMPwWtjV9LziUH7+9nMTpmfLP0DUG1ypRfS2x+FAazBx4tFSytv5lWrGlxxXzKxrgIT7Lx5ao54y0S4075TdRsp7cKEIKZsjV9KfJnVQBcCMANw1ncHAJY5C4DrB/r+5kTwjqmNmKCShdDiQDC8dCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608866; c=relaxed/simple;
	bh=XziCG7/eglqj6XOz8Hs7WbpeWMTTsmGPoBvpspDMT6Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C57e6ZFABiW/vnyAep4uHjb7K6nI37bVngpPw/afkrjrHT1/mt1bOcUeTnh5FcXthyq/BPbcfbNC9xzaumW4wBnHryz4f7ei21if5RxJx3xNR4Dqo1MnS0gv6gvDIwaCE/CaIMDX7bVLbnFFhwSr+zI531WjeCt8go0vpDFUuis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ayVBKvBo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZExXUFZx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjcGWO7pJJ4CtZZ64wabW4mu73QdoDIBojVC4IFejIU=;
	b=ayVBKvBov8jnhsKAhFmhyJXTuJ9DruiicVWvkV3CkZsxqCD17ooPG9vAzYI3zNPoYMAc6y
	8XzMXVEDFbYsHyHpPyxOsMt8JCSUEtQvmlEN+3mAX610Lvze0Fzj7Lhn6ThJLq/rl4mYwC
	dT5GlluJVQAe/2zBrhidVqnY5Itl+oH2NQc1A2uiHuYVdZewc80W+J4Q6N+SRCyysidb0Z
	SXKXEOkzOlBLaJrOtJnLMobRjiHaHsq87Ch88t7oRDBsccNzeK0jMXHipseqpeJJXG6oSl
	80hvovPwgmP5BUZo9mrKYPliBPXXravBVH5fp5/04Jv58L53ob4oS3W/tlHIiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cjcGWO7pJJ4CtZZ64wabW4mu73QdoDIBojVC4IFejIU=;
	b=ZExXUFZxYJlnV82Uj6X8L/CF7ErlFROWkbP9XR5Q/sRxHzvNb7o+F9em9Qbb9l6GhCsqrA
	L2kiksvHaTuhJGCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/debugfs: Convert to lock guards
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.620200108@linutronix.de>
References: <20250429065420.620200108@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886236.406.15941482668744436211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ecb84a3e7e7cccd7578d8b4c57035e98cd89901f
Gitweb:        https://git.kernel.org/tip/ecb84a3e7e7cccd7578d8b4c57035e98cd89901f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:12 +02:00

genirq/debugfs: Convert to lock guards

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.620200108@linutronix.de


---
 kernel/irq/debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index ca142b9..9004a17 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -160,7 +160,7 @@ static int irq_debug_show(struct seq_file *m, void *p)
 	struct irq_desc *desc = m->private;
 	struct irq_data *data;
 
-	raw_spin_lock_irq(&desc->lock);
+	guard(raw_spinlock_irq)(&desc->lock);
 	data = irq_desc_get_irq_data(desc);
 	seq_printf(m, "handler:  %ps\n", desc->handle_irq);
 	seq_printf(m, "device:   %s\n", desc->dev_name);
@@ -178,7 +178,6 @@ static int irq_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "node:     %d\n", irq_data_get_node(data));
 	irq_debug_show_masks(m, desc);
 	irq_debug_show_data(m, data, 0);
-	raw_spin_unlock_irq(&desc->lock);
 	return 0;
 }
 

