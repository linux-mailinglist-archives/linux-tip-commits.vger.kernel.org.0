Return-Path: <linux-tip-commits+bounces-2521-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381859A6B17
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Oct 2024 15:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3751F22B2B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 21 Oct 2024 13:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39DB282ED;
	Mon, 21 Oct 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2CZjMY6g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ry+OjZ/1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74B11EF089;
	Mon, 21 Oct 2024 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518841; cv=none; b=Ks2bTvB1KdnVucuD+lO7HOWnmsGYgWyLm7IQNLQ5xzDObHtggKKvBE/S+JyzZNNOjBCUHKbSEyS05dv8DWS7bODqggiNfPB0dhAH4AQRMdMtoO848yZZgWpYAEmp29zkKogQyy3ASwEzIBgXNbpYCeAXgFgdM9P2D5WkHU+Liz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518841; c=relaxed/simple;
	bh=Zd4c4+rijIamlnsve3HxDK1QswabA8o7nV/NnV69Jeo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fT1Rv4EEgAUQjS1ySv4qb5j6EAviEHImTlcKagWzetkncDMcF7sN6PcczvbkiKh4yXTQV4U0/oXEeKKX+vYijwnrXrln0+sdHw1MwfOyZwlL1VkR0HtCUrmz1B8CvPsqJE/vrb4NJDyaV1oPzv/HXGAaGyyD8dxMmgNvJ/M/Gjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2CZjMY6g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ry+OjZ/1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 21 Oct 2024 13:53:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729518837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GejrPEVSQ9sQAkj1Fg1rd1munzFih0HkdkJe5yUfIcw=;
	b=2CZjMY6gcLzdolLLB3vg7awGRq2IWvW6jdSWgfrThn+m/0fM2xQPImRsmpY0v92BEz37IJ
	ktiIIwdz/8bqmeP7yFSsGUptuRr9QL1hfLIJgn2ga0NCeYG+c3/et77WYtBUlXzS8xyAs2
	2lhIll2Lz+nahn0b16BPuenoK67ed8jkhibd4B/KiujgjG/sLq3TBKu52lQ9PwtmMFfE6l
	dZBFiDK7vZKHfw+ozht5YPhs01q0sXJGFBD80W+4UTYsdaKYmnoa7VgAvH5qDOGKUCrnfL
	AVKmI0cwH4WTnKkmbTPHm3auc247eDRluP0KcsjV5sJ0r18HRYVqd+JHSi3aVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729518837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GejrPEVSQ9sQAkj1Fg1rd1munzFih0HkdkJe5yUfIcw=;
	b=Ry+OjZ/1/LSgV8w5C/jh7I26IY0Y4Q9LQZxyjyW876std3NwpXj54QW/hQu2AtlA/zPPi1
	UE5emZ/UTUvVS4BQ==
From: "tip-bot2 for Steven Price" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/gic-v3-its: Fix over allocation in itt_alloc_pool()
Cc: Shanker Donthineni <sdonthineni@nvidia.com>,
 Steven Price <steven.price@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <1f6e19c4-1fb9-43ab-a8a2-a465c9cff84b@arm.com>
References: <1f6e19c4-1fb9-43ab-a8a2-a465c9cff84b@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172951883672.1442.6614400207420844826.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bc88d44bd7e45b992cf8c2c2ffbc7bb3e24db4a7
Gitweb:        https://git.kernel.org/tip/bc88d44bd7e45b992cf8c2c2ffbc7bb3e24db4a7
Author:        Steven Price <steven.price@arm.com>
AuthorDate:    Mon, 21 Oct 2024 11:41:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 21 Oct 2024 15:49:15 +02:00

irqchip/gic-v3-its: Fix over allocation in itt_alloc_pool()

itt_alloc_pool() calls its_alloc_pages_node() to allocate an individual
page to add to the pool (for allocations <PAGE_SIZE). However the final
argument of its_alloc_pages_node() is the page order not the number of
pages. Currently it allocates two pages and leaks the second page.
Fix it by passing 0 instead (1 << 0 = 1 page).

Fixes: b08e2f42e86b ("irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor")
Reported-by: Shanker Donthineni <sdonthineni@nvidia.com>
Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/1f6e19c4-1fb9-43ab-a8a2-a465c9cff84b@arm.com
Closes: https://lore.kernel.org/r/ed65312a-245c-4fa5-91ad-5d620cab7c6b%40nvidia.com
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index be77f92..395961f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -261,7 +261,7 @@ static void *itt_alloc_pool(int node, int size)
 		if (addr)
 			break;
 
-		page = its_alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 1);
+		page = its_alloc_pages_node(node, GFP_KERNEL | __GFP_ZERO, 0);
 		if (!page)
 			break;
 

