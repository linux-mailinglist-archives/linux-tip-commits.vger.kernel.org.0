Return-Path: <linux-tip-commits+bounces-2140-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 767659648E8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2024 16:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5641C21295
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2024 14:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B8B1B143C;
	Thu, 29 Aug 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3FRwllDZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTaazP5E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9B91AE05A;
	Thu, 29 Aug 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942782; cv=none; b=K9GfiZiWZX/ScH03cXBuk+BLSrahHyeWf97qGd/B/Qnum0CaAJwFYBwtcr3U/TICxq6BbBzHQRF1lOEp1NYIJaJBg57YdfPhT4Nmi+zBEpGI0N1w5W88CiUsMH/BIa79rz5gOa4T15eK7BmBCJZyo331prO3q5A0tm+OBkl6+hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942782; c=relaxed/simple;
	bh=FDurmdrMf6lC86QFgfCtyRq4XozNDcsQsIvObe8qhxE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rq3Ueood4oczo4x56ota1zhBhvwMFcDMkXu67RTOLMH7FBL8XjR4JhKElbhdbjjuvjJ4SXXVrJvx69qn30SLoqQBayUqF1aeqIdifO7k4c9h+r9VJmXbqWOYbQOJjpXCFUSvSvJBUXT6xqx4zRSGHsgTytx5v89md4nbGxsmDvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3FRwllDZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MTaazP5E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Aug 2024 14:46:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724942779;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEmnID1Jb7vw/V5aveXCQ3hH9t/6shaFDk4Xt0jBQ4I=;
	b=3FRwllDZcBDXzcl4zibQC0T2edB5bv70nSuzTPbnhoTk8100CXXU4yhmQ3N/tsox+wFQHo
	PssdsKuZUr4Bz16fyrPHHv/Qe115xen05RM6cFPvxk8dAriAljlBQfA5oFvEUwuZFHpXqD
	rbK8uYG8FcMiuAMUmF84AqkvTxBpJMvMZ0gmK3x+9cmAbkyC4vaD+hQT2+Lta88sUesGbu
	84aB+eSDmve+mTeYUCmwP5mSkxSj+KSc7KUQABZwIqT2LfZuzcg2IeKwyrC8ngg4PoyDT0
	e6iYhxlj9TcPWGu33nG9RIFhsZFaZETbSJTUwU1TA5C1WejKZ27U1S8uIndqtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724942779;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qEmnID1Jb7vw/V5aveXCQ3hH9t/6shaFDk4Xt0jBQ4I=;
	b=MTaazP5Es0Q/QD4zhwQBAKUxNA1Mdoay++aVFR1O5eqj2sy+TnMvkIedHAaloVwq9SeTRK
	JFO3gXW3P2hwSVAg==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq/proc: Use irq_move_pending() in show_irq_affinity()
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240829111522.230595-1-ruanjinjie@huawei.com>
References: <20240829111522.230595-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172494277887.2215.17333037706996183626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     9012f84e1c5b653c282b7a6cca81454ecf7c5a0a
Gitweb:        https://git.kernel.org/tip/9012f84e1c5b653c282b7a6cca81454ecf7c5a0a
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Thu, 29 Aug 2024 19:15:22 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 29 Aug 2024 16:42:06 +02:00

genirq/proc: Use irq_move_pending() in show_irq_affinity()

irq_move_pending() encapsulates irqd_is_setaffinity_pending() depending on
CONFIG_GENERIC_PENDING_IRQ.

Replace the open coded #ifdeffery with it.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240829111522.230595-1-ruanjinjie@huawei.com

---
 kernel/irq/proc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 9b3b12a..d98fb9c 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -52,10 +52,8 @@ static int show_irq_affinity(int type, struct seq_file *m)
 	case AFFINITY:
 	case AFFINITY_LIST:
 		mask = desc->irq_common_data.affinity;
-#ifdef CONFIG_GENERIC_PENDING_IRQ
-		if (irqd_is_setaffinity_pending(&desc->irq_data))
-			mask = desc->pending_mask;
-#endif
+		if (irq_move_pending(&desc->irq_data))
+			mask = irq_desc_get_pending_mask(desc);
 		break;
 	case EFFECTIVE:
 	case EFFECTIVE_LIST:

