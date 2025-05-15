Return-Path: <linux-tip-commits+bounces-5549-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 088F8AB8A52
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 17:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5A1188B9F3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 15:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6C420B80D;
	Thu, 15 May 2025 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xvA3ASyf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yAyynYCr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB21A0B08;
	Thu, 15 May 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321791; cv=none; b=bJ0T8E3MeTxvHCeNI1KJM7OAvKzzBTb7JZGiX7ZqsdpxjA52+1HfXZM1IsEa016TNdhCx8d/goLBEWdCkjnAfvs9fQjjY7NYHuttocVD0iy6xyOxPH9Jl2LRZ6MaT7LkCwajbO+wkDsMLNsd1IzKvYXjDV2Hfpr4J/UPSCY/7TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321791; c=relaxed/simple;
	bh=6R+4QOJDrRWUDayZX/bkkK6mKOhZFv9yOswdoJNl1r0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c9Vr0iItuzh1OKodlHyyd7wMycwR/BqVMTAF5ZEjC9L4B9giK0PdBGBUBqvZytAVUqLy1F5gQeFWxtDhok/Kce9OrdLcBPQGUzPdjb/hmve8ByIMGzd4YaeHhk/LzqlDO7VSixFFgeO0mSb4HnFwNeSjDY+G4fpWuBSRMKgHj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xvA3ASyf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yAyynYCr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 15:09:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747321787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Au29+eyyLbjjd8srM1d/tRQaOdYqULWJK/n1vpIf/c=;
	b=xvA3ASyfkNlFBKtsoXUdc40/ja76NadpDldAxIqrBXg4Ke4jWaF2tYaMHSwbnWULFm3bEO
	9ij5kljKaEMobZdK5iI4wviOStFzaYSZeL8RLL+hNngaRmg4/+1W9ZR8KVN5FGDWvsGREC
	q4PaRBCqLjYWAOXKsT+072SrAgcX4gVt5os8gu1qH9tw9p83mwfMO7z1vVWdsrdYYTNzUC
	7HUJHLZBnwYdDjHg6tgL7bl+zXuGsNWL0CMKp5Cgb1QJi1sFsfqndpSAcP22Xp6pn8iaKE
	cuxt0h2IDh3HsBXlJz15/gHss7+xW66oq3RdZ3rltWhK4Qr5wahsJLiftJfKww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747321787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Au29+eyyLbjjd8srM1d/tRQaOdYqULWJK/n1vpIf/c=;
	b=yAyynYCrWXRrvSt9YsKOi0vyoPoif6q58NB0tte1UMCs4P0qdFZPSDtuvQPYtbElPOLd+E
	kef/INfamqkkJ4Aw==
From: "tip-bot2 for Chen Ni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-pruss-intc: Simplify chained interrupt
 handler setup
Cc: Chen Ni <nichen@iscas.ac.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250515083450.3811411-1-nichen@iscas.ac.cn>
References: <20250515083450.3811411-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174732178684.406.1124313007424946758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     3e402acd5c4f9d447849b9bfb5a5c61f10668b7e
Gitweb:        https://git.kernel.org/tip/3e402acd5c4f9d447849b9bfb5a5c61f10668b7e
Author:        Chen Ni <nichen@iscas.ac.cn>
AuthorDate:    Thu, 15 May 2025 16:34:50 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 May 2025 17:06:48 +02:00

irqchip/irq-pruss-intc: Simplify chained interrupt handler setup

The chained interrupt handler setup installs the handler and handler data
with two function call.s

irq_set_chained_handler_and_data() can set both in one operation. Replace
the two calls with one.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250515083450.3811411-1-nichen@iscas.ac.cn
---
 drivers/irqchip/irq-pruss-intc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index bee0198..af76847 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -581,8 +581,7 @@ static int pruss_intc_probe(struct platform_device *pdev)
 		host_data->intc = intc;
 		host_data->host_irq = i;
 
-		irq_set_handler_data(irq, host_data);
-		irq_set_chained_handler(irq, pruss_intc_irq_handler);
+		irq_set_chained_handler_and_data(irq, pruss_intc_irq_handler, host_data);
 	}
 
 	return 0;

