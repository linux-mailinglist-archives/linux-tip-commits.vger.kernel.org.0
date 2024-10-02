Return-Path: <linux-tip-commits+bounces-2342-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7B298E03F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 18:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546CC1F2153F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A433B1D0E1C;
	Wed,  2 Oct 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sReYQCR/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mDVMeAsW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE01D0DFE;
	Wed,  2 Oct 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885456; cv=none; b=GoD7OdpG4w5PpbKH13de7jdwVtc3pDU6YTfgFSBkIBklswMSIJKHUC5ldf8t2Zb7Yr7ycFR36NBdD+CrZy+y9f7c4UxRxLEP1wuDnPUiDR0SmSXqtD0ZbmR589IMum3udizvlztwVa2KIYLO2sGU8urDi/vS01rGf+7R5UuQAfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885456; c=relaxed/simple;
	bh=S0bEazovr3KK61VHevTSYXagSHa86i1sek1Chk5SAho=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tFLdTSqj+dOzXzE8Gy1+V40UhOAzxxM6SlexJfXALdSDUGWlog2YxgIDkPcORvl4gl/31JDF0P7myPZN8FNh9ZCjngO7Avk8If3WIjZxeTYA7970wASwqOhWUynpYHH+DD0GOce5mZa/QJ0vnYQuj6N4bqUNRInau+vbDoOIt1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sReYQCR/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mDVMeAsW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 16:10:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727885453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xj4I58Mc8PkHHadtrNFdyCnhrMgvilVkvaa0I6Bbfg=;
	b=sReYQCR/18gtlJ/sYCAyL5GcAW2Qc3c7GJRV6uN4grVMJSv9lSBY8abYWM7ZVF0cvqsvrg
	ycxCXWPB64YiSFkcSK3KQtJ+cr2YwEKGR859JBXZZ9M1NPyPWPcl6b/2uGPsmkXyfYiSU/
	6PK/1mbdSUL0cLEs/X65L+xF28OlMlzKWc0INPOmDT5kdnsT43Nx2ROeD0UQ3WOL6Dp6Pq
	jOud+XYVmGDx7++fpfLBbQ1y4x92rAnC93Y2yRu3mPIo1N8PHstaSBqxRWJPeccygko1/W
	q88lr2P1Ex6MgybJplLzlihzLPvHAZ4A57YAa9B0j0V1dTewp5tKZCHLrTveqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727885453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0xj4I58Mc8PkHHadtrNFdyCnhrMgvilVkvaa0I6Bbfg=;
	b=mDVMeAsW4OH4ve24qldk6JiKO9KlopNwTxuXiNV3Jn3aCPLaJkI6wy3TtLSwXK19+5oORl
	UqReiu2XbmzDEQCA==
From: "tip-bot2 for Steven Price" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Rely on genpool alignment
Cc: Steven Price <steven.price@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241002141630.433502-3-steven.price@arm.com>
References: <20241002141630.433502-3-steven.price@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788545248.1442.3411580477111504820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e36d4165f0796536b338521ef714551be0feb706
Gitweb:        https://git.kernel.org/tip/e36d4165f0796536b338521ef714551be0feb706
Author:        Steven Price <steven.price@arm.com>
AuthorDate:    Wed, 02 Oct 2024 15:16:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 18:00:41 +02:00

irqchip/gic-v3-its: Rely on genpool alignment

its_create_device() over-allocated by ITS_ITT_ALIGN - 1 bytes to ensure
that an aligned area was available within the allocation. The new genpool
allocator has its min_alloc_order set to get_order(ITS_ITT_ALIGN) so all
allocations from it should be appropriately aligned.

Remove the over-allocation from its_create_device() and alignment from
its_build_mapd_cmd().

Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20241002141630.433502-3-steven.price@arm.com

---
 drivers/irqchip/irq-gic-v3-its.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 6c1581b..be77f92 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -706,7 +706,6 @@ static struct its_collection *its_build_mapd_cmd(struct its_node *its,
 	u8 size = ilog2(desc->its_mapd_cmd.dev->nr_ites);
 
 	itt_addr = virt_to_phys(desc->its_mapd_cmd.dev->itt);
-	itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
 
 	its_encode_cmd(cmd, GITS_CMD_MAPD);
 	its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
@@ -3488,7 +3487,7 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
 	 */
 	nr_ites = max(2, nvecs);
 	sz = nr_ites * (FIELD_GET(GITS_TYPER_ITT_ENTRY_SIZE, its->typer) + 1);
-	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
+	sz = max(sz, ITS_ITT_ALIGN);
 
 	itt = itt_alloc_pool(its->numa_node, sz);
 

