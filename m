Return-Path: <linux-tip-commits+bounces-4740-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE6CA7E2D3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899F9424C37
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306001DED46;
	Mon,  7 Apr 2025 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w2lPKJab";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oFu8/Jk4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C11FDA76;
	Mon,  7 Apr 2025 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036327; cv=none; b=gEoPQoix9r68lGR7slNX6vLStQzGzDaIetk0trDqz1uEgraffzpdc0BpKGogQSvs9/uFSFnvyOC4mnzr5AI4nA8+KcHlqjEMNVvazzrn2ZNliUvgHnu8ALsgEbMpPw6mx0YxUveVU7JUYeW/hnxGL/YlQ5P+nbeNT7XWAJZCc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036327; c=relaxed/simple;
	bh=f1mf8qB1hEihuYqVGvsz1Lueoti5eOCQLLOjESBXItA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AH1DtH+iXf5BCG8E8J1nhoWGupa56XRV9isH1ZC24qspFRMaBRWCebjGuE45co1n4aOAyugwwLkBVTcHVb+qDSzfd98RpTG/aATeNjmQZv6ZLCQa9N2ZeKQFJVvlpXprygHY2pgEG3KLraD7kW7pGIL9cl6IxZA7xeOkU1UMnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w2lPKJab; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oFu8/Jk4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036313;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Au2bM08PL9+O2eG+ub0yoz767KoizfRSzpTEISyXlXY=;
	b=w2lPKJabwTxteqlpXBv111gP2A9uicMXLy/ZotGvuUE6fZQ055sHL+Hg+Z5/uffRO7t8E5
	T68ChLm/KXADoGQP6axuridJujUPsle43ibZQRNM8i3gR8IL6MMZwewikaws7AiajeiSdQ
	FXv2kEFBPZJb1JkE2w9uNthYfYONxUH55RTzUqywzvpe8oNkb4AsHNcggCcn3qUYVQbzy6
	yIO6IKOJ60+cG9uCmkq3UwBbSOez15x1AvNw6ordlVKyJuLfeV4yIdihVI4ch/emRPn7oK
	hP7klkwqnoLF6Sh074vi1ZucPsS5zE9SRJa6oVIQDnaFAcPJqnV555YqK8Zj3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036313;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Au2bM08PL9+O2eG+ub0yoz767KoizfRSzpTEISyXlXY=;
	b=oFu8/Jk4BLO1C9Hu8XfPDbQ77dt9Lo+FtFDR13aW3I1YTYQmCvi28yVsn13Cl95xUjDVWU
	vrrJfx/ZYXyy9cBA==
From: "tip-bot2 for Stanimir Varbanov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/irq-bcm2712-mip: Set EOI/ACK flags in
 msi_parent_ops
Cc: Stanimir Varbanov <svarbanov@suse.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250407125918.3021454-1-svarbanov@suse.de>
References: <20250407125918.3021454-1-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174403631319.31282.2508799148556971518.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f35508b93a2fc127a8d185da2e5beade2f789977
Gitweb:        https://git.kernel.org/tip/f35508b93a2fc127a8d185da2e5beade2f789977
Author:        Stanimir Varbanov <svarbanov@suse.de>
AuthorDate:    Mon, 07 Apr 2025 15:59:18 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:27:48 +02:00

irqchip/irq-bcm2712-mip: Set EOI/ACK flags in msi_parent_ops

The recently introduced msi_parent_ops::chip_flags sets irq_eoi()/irq_ack()
conditionally, but MIP driver has not been updated. Populate chip_flags
with EOI | ACK flags.

Fixes: 32c6c054661a ("irqchip: Add Broadcom BCM2712 MSI-X interrupt controller")
Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250407125918.3021454-1-svarbanov@suse.de

---
 drivers/irqchip/irq-bcm2712-mip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-mip.c
index 49a19db..4cce242 100644
--- a/drivers/irqchip/irq-bcm2712-mip.c
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -163,6 +163,7 @@ static const struct irq_domain_ops mip_middle_domain_ops = {
 static const struct msi_parent_ops mip_msi_parent_ops = {
 	.supported_flags	= MIP_MSI_FLAGS_SUPPORTED,
 	.required_flags		= MIP_MSI_FLAGS_REQUIRED,
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI | MSI_CHIP_FLAG_SET_ACK,
 	.bus_select_token       = DOMAIN_BUS_GENERIC_MSI,
 	.bus_select_mask	= MATCH_PCI_MSI,
 	.prefix			= "MIP-MSI-",

