Return-Path: <linux-tip-commits+bounces-5495-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F4AB0174
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB911C05406
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC9E286D4C;
	Thu,  8 May 2025 17:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V2wt787r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xtrCfbMU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD871946A0;
	Thu,  8 May 2025 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725235; cv=none; b=Lk52b/EmgozI0n4XAleAe62LJc2CT/GtR95vxfjPp0RIpMSFtLfkyq90/UE049oXRCn7KF+es14xCTVhR8MME17YK3jIeBzdPnSDo6ezsmb0LSQaB7LB808++mm1hEMj9ruM8UBaImvx8cDf9BWnk/syEZkTRP8KXcUG6lCb68Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725235; c=relaxed/simple;
	bh=SQ44V2APk/bmlGRXlW3QfAfco3cL+4TDZ5i2BW2XiYY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UgEQoizKNADwUM+hWNHiQLW4L5xKcGn1NOTqEhgNMP66HPJFI7pJPL4ToAD5FU37yBvueu4E/SuoORUeROmte9S0lCfrmcSw6e29w49mCs7FDD0yx7apTaXEVor97zOmVpM7Y1inVNmAalsz38x+JdJ6cdLuLI55B+cWVTCl1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V2wt787r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xtrCfbMU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 17:27:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746725232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xfgmd7doSirp7FkJrQShwwczyzq2S2/iruioMOwrrxc=;
	b=V2wt787raiHEqfoJefyAZDBzSbXg6xLtaXj+l1a6+of3EQG4PWeJ+U0LKdvulPrr8+5lZF
	zA0wR4ZGnBUDRvdAwxk5k4Z5G40y1SZs1ZYgR5yUpx7pZQSxrB/KoSyQwLJc/O/Jhqh329
	HmcEr4KK8tjCFc45Cb+FjRg3qkirPCUBOYIeigNeYdM/obzD6ZYDbI13tiIF7xzRIN4FH/
	1ojdrRdWpqBaQ6FQmJhlVU/PYFpx1NlSgqhkk0zs1cnxfO9XImrXUBexECkPUwgnG4bNFm
	JaOlWLL3pR9/31yQdm02LZEC0XD9ci6YPr+578KBSm2mNw1JULgW8ovHs5YpTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746725232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xfgmd7doSirp7FkJrQShwwczyzq2S2/iruioMOwrrxc=;
	b=xtrCfbMUYzkxPNdr2zIZXRY7dwEIkqRJfhNp01fYGIxbwuCEL7bJmYeijjEsRMnhAN4JE2
	STXRlK1L6tD9tCBA==
From: "tip-bot2 for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and
 irq_domain_is_msi_immutable()
Cc: Frank Li <Frank.Li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250414-ep-msi-v18-2-f69b49917464@nxp.com>
References: <20250414-ep-msi-v18-2-f69b49917464@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174672523199.406.14075204124200521213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     b8c7bfb7a0f01521297d688ca5fe1482c81e8910
Gitweb:        https://git.kernel.org/tip/b8c7bfb7a0f01521297d688ca5fe1482c81e8910
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Mon, 14 Apr 2025 14:30:56 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 17:49:00 +02:00

irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and irq_domain_is_msi_immutable()

Add the flag IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and the API function
irq_domain_is_msi_immutable() to check if the MSI controller retains an
immutable address/data pair during irq_set_affinity().

Ensure compatibility with MSI users like PCIe Endpoint Doorbell, which
require the address/data pair to remain unchanged after setup. Use this
function to verify if the MSI controller is immutable.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250414-ep-msi-v18-2-f69b49917464@nxp.com

---
 include/linux/irqdomain.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index bb71111..bccfff5 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -231,6 +231,9 @@ enum {
 	/* Irq domain must destroy generic chips when removed */
 	IRQ_DOMAIN_FLAG_DESTROY_GC	= (1 << 10),
 
+	/* Address and data pair is mutable when irq_set_affinity() */
+	IRQ_DOMAIN_FLAG_MSI_IMMUTABLE	= (1 << 11),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -691,6 +694,10 @@ static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
 	return domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE;
 }
 
+static inline bool irq_domain_is_msi_immutable(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
+}
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)

