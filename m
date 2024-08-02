Return-Path: <linux-tip-commits+bounces-1915-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21D8945E36
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 14:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D5A1C21277
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 12:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A561E3CA5;
	Fri,  2 Aug 2024 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NcHKNbKY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KSKoFnkx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3651DB449;
	Fri,  2 Aug 2024 12:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603562; cv=none; b=W7dbhxJnVP5UTflDrgAA2qXV/47yp7f2857qChpqooUTkeda5ZIBNZ7lVrH1h7FymjmdeFk8HjwJ1Hl35aHWe0akE/W5CfVzIoF7VuC09vXxlr9i7qKylYjrerslGIijPTzN0pxA9kWp5YzVnzFm5mwAFIBFEX6uGn0e4QlQLG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603562; c=relaxed/simple;
	bh=8AeZ7fFeOvcsQTQtRT8VLN+5n6mQD9f7VRwnkn/Q5zg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ix9nov9/8Fu6KglcYLHASWm9Nh+DsXKLEiHG9o8EzVwUbMUMDBU8Pntqg082lhYgYks5ehzAvkPzQ7sT3QwHnXJf+c26DUy6UGDrcvnHvdalPN9EBsJCf/sbKlvGIiz7U83K+V8haZevF2H6Oie+xBiVRXIkIxPy2mFOURYL96E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NcHKNbKY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KSKoFnkx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 12:59:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722603558;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DI9Cx61e0POTGtDcFjtJKpbkQDzMatKldKJdqsywcsI=;
	b=NcHKNbKYYF5rgfgWVZ2YrC90svlgeKTHPb/3nyWKayKev4+ZLbs9yz5r+Cu1Pttbkzx1/G
	Xcxfca78nr9xuTC1niRrAmOO8hpDQz5866Nncj1+HMemCUg2K1xMrPzs/sdqgeXLVHpzMV
	Exiw3h8Iy7qXSSjpplCHGs0jX8u4DII7NiGGoXJc7fI/RFyAmVXxfEhNHd7g831PVleA0M
	q4bwfNwrtkvhjUbZ/xNE19l3FW3OM2NV1v7/5tfs3nI3L6NAkc7t8xuIEmhHj4mu5fuuML
	PTx6lLdxJvxQrAEL8Tz64+l8bOPT80d8fOR2Zo0quN2kr8qzFWtUIT47pyeV+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722603558;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DI9Cx61e0POTGtDcFjtJKpbkQDzMatKldKJdqsywcsI=;
	b=KSKoFnkxdVmKHG/t6PkGz00XeiEyV8PHx05LQCmniFVUmjzUY2w+j2kdgQk9KEhGra3k5R
	KuCPBExIUa4mt0DA==
From: "tip-bot2 for Anshuman Khandual" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v4.1: Replace bare number with
 ID_AA64PFR0_EL1_GIC_V4P1
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Zenghui Yu <yuzenghui@huawei.com>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240802085601.1824057-1-anshuman.khandual@arm.com>
References: <20240802085601.1824057-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172260355813.2215.3564057730782452257.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bb4531976523c6e394188c4f4a7eeaf5e9efdd48
Gitweb:        https://git.kernel.org/tip/bb4531976523c6e394188c4f4a7eeaf5e9efdd48
Author:        Anshuman Khandual <anshuman.khandual@arm.com>
AuthorDate:    Fri, 02 Aug 2024 14:26:01 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 14:54:25 +02:00

irqchip/gic-v4.1: Replace bare number with ID_AA64PFR0_EL1_GIC_V4P1

Use ID_AA64PFR0_EL1_GIC_V4P1 instead of '3' in gic_cpuif_has_vsgi() to
check for the GIC version.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20240802085601.1824057-1-anshuman.khandual@arm.com
---
 drivers/irqchip/irq-gic-v4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index ca32ac1..58c2889 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -97,7 +97,7 @@ bool gic_cpuif_has_vsgi(void)
 
 	fld = cpuid_feature_extract_unsigned_field(reg, ID_AA64PFR0_EL1_GIC_SHIFT);
 
-	return fld >= 0x3;
+	return fld >= ID_AA64PFR0_EL1_GIC_V4P1;
 }
 #else
 bool gic_cpuif_has_vsgi(void)

