Return-Path: <linux-tip-commits+bounces-2962-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281879E1A38
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 12:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09F9283CC9
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B71E32C1;
	Tue,  3 Dec 2024 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tyaJ57Mn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAf69PKe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D441E0E13;
	Tue,  3 Dec 2024 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223736; cv=none; b=tT6nqKytNrLP/6pqO8CBWDmTb0+PDgV7k+zRU9yS71ScYWGaRkg33G3c262gMF8A+bQ5EYDAqYOdASCP7z9hh0oBaRwWIngCtH2L/HM0ROOnbodMF4HlPH6jdYBJ0EOGMtfZcLboWfdiVNItjDo5jLMhVUguZFk2cNqsQdVOjds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223736; c=relaxed/simple;
	bh=jfoUSW9PC6aLsnh1IVpdGI7KlmJvRfvogaqnQH69nUU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sc5aLCK2XbDGPwIfFds9ZPT/UpZ/iD4o02ZUzi/J19CxoSJYM/rFGhF/PYjZ6sSp5XYaeyQUf/knu1GqnVhxDTyJc8Im80sCOxveVZKK8Wmlvd0yKqxLWt+224tfHG5qFEG+mbQv5mM77gT00ZJFVED60rEb+T3LtdeUBSB5djY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tyaJ57Mn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAf69PKe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 11:02:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733223732;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1qQPvOZRf5a5Ky5RZFViHbhIVqoO9/swauT7VkQKYgc=;
	b=tyaJ57Mnut1A8Q6DsGTExoFshFS2y4HO5OI54zeUJr3oQ9EE2X9i021uaD5wwr0gPJ5rgm
	Z7JeFrXZe+kKX+mTvRfp1woMc9Wgwdqg3UrJOLvvDobtBkCbj8EsRzMLy4VRjUQpE/Mk1y
	A3J0uXPor4TVVdWvyl0QolVoRtclcVtbHcvsZs0kgyLSQQP+9tg/BK7N47d+kqrIDxrfpe
	RpcxcpDPILXJNvNFPQOfhvBOlHvzx06Noo04nzNVb9kdKwnC8iOr00tiL/jIdSwdWlUlMl
	Kl6xxfPHYMkAPriZKNLkj7k372KiKkBYdTbboGCdRbIUpaQjMA45CpYTMw3SEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733223732;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1qQPvOZRf5a5Ky5RZFViHbhIVqoO9/swauT7VkQKYgc=;
	b=sAf69PKetYPrpxyDIR/I4oNKeNNj9tIMNATHyA3z9SHDzrmosP1deuNg/l7W93njIJwZ9W
	1OuIEot9zFkH1pDg==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Reuse irq_thread_fn() for forced thread case
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241119104339.2112455-3-andriy.shevchenko@linux.intel.com>
References: <20241119104339.2112455-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173322373121.412.8539732173985701272.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     429f49ad361cd999ca221d8b562ae2552b7c3e2c
Gitweb:        https://git.kernel.org/tip/429f49ad361cd999ca221d8b562ae2552b7c3e2c
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Tue, 19 Nov 2024 12:42:35 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 03 Dec 2024 11:59:10 +01:00

genirq: Reuse irq_thread_fn() for forced thread case

rq_forced_thread_fn() uses the same action callback as the non-forced
variant but with different locking decorations.  Reuse irq_thread_fn() here
to make that clear.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241119104339.2112455-3-andriy.shevchenko@linux.intel.com

---
 kernel/irq/manage.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 230f470..f300bb6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1210,11 +1210,7 @@ static irqreturn_t irq_forced_thread_fn(struct irq_desc *desc, struct irqaction 
 	local_bh_disable();
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_disable();
-	ret = action->thread_fn(action->irq, action->dev_id);
-	if (ret == IRQ_HANDLED)
-		atomic_inc(&desc->threads_handled);
-
-	irq_finalize_oneshot(desc, action);
+	ret = irq_thread_fn(desc, action);
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_enable();
 	local_bh_enable();

