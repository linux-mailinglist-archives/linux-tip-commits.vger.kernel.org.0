Return-Path: <linux-tip-commits+bounces-2097-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E4B95D569
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 20:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640852834A5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2024 18:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA4B5466B;
	Fri, 23 Aug 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BCaZm+cR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fUR1+pDL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69C558BB;
	Fri, 23 Aug 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438708; cv=none; b=PEz0fD/o2In79UcJbseCsX5VfXEcX3koROMkg07jjr4N9yHwhE45MXnhRVRkbt3acKmKmZ2rLldA2VUR1DlfSF9YwrcMSCg2QDothXeLL1VE2AG0wPhpgnQbCgyLE7DIAPQovTTifFZcF1JJqCouZNx4JP/EzjRXNQvSsFmmGNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438708; c=relaxed/simple;
	bh=QBQ/iuOoSVV+bD4COD+MqAZKkw8YaXT1xfGt1aiPvHM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sT1LxAtDNMvMm2wpsk4g9Z5px41sEKo/m0OWMLF5IzYrGjI+i80eKnH99KnhBrBhfMfakXhMs3zKJEjeCj/cvjHaQMJSn5oIioYDXweDRck9LqGkRvdveEzgPrn6NgHZRvUZNcNLiApalE5VdUqw2n1vXILedx1EBxGKVnTl1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BCaZm+cR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fUR1+pDL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Aug 2024 18:45:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724438705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzrT/7DRvSuslrwdyi4w2dDA3Af6n2qBxEpKoIlA4Cw=;
	b=BCaZm+cRyUnK6N7POP4t1CD8tpk8LM0X9qRqYyoqNyGCm0Xw9DT/ztX9ftvrhAQ4U6CcMc
	FYrGP8cyv46kZu8uQvjjgq5UQ95jeZFsAt2FBXEBps8bwDjmbwkcOWbjfyldO4uhANysyb
	JH0KLwSHVh64g1rS9rrMoL4cYYnsA4RoLA3tjrDHjQRed4tSPaQTr2NGcr9OzGI4LkM8Bu
	mDh8ZVQ1jEPf6BZajde4uazAyLwLiNRifyNCmMp1Nof8D6pj/5xIurtKrRhmJL4D8319vS
	2Bqexod2efFAnv9U/Foh9sODYv9tCFsQo8h0v5MTOQPfUi7CH/ZTMrdUaKXLjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724438705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzrT/7DRvSuslrwdyi4w2dDA3Af6n2qBxEpKoIlA4Cw=;
	b=fUR1+pDL/ylHBxjaq8Us/Qx4UY5Gpp+cVeB3UFTKrv+EyP7ufjjRKJa1tT0tAn51jCyfZy
	5SqCVz4Yt/lpspCQ==
From: "tip-bot2 for Tianyang Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/loongson-pch-msi: Prepare
 get_pch_msi_handle() for AVECINTC
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Liupu Wang <wangliupu@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Tianyang Zhang <zhangtianyang@loongson.cn>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240823104337.25577-1-zhangtianyang@loongson.cn>
References: <20240823104337.25577-1-zhangtianyang@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172443870536.2215.16437712166328065700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a1d4646d34c6642194a421ca9afbd060b0f9aa00
Gitweb:        https://git.kernel.org/tip/a1d4646d34c6642194a421ca9afbd060b0f9aa00
Author:        Tianyang Zhang <zhangtianyang@loongson.cn>
AuthorDate:    Fri, 23 Aug 2024 18:43:36 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Aug 2024 20:40:27 +02:00

irqchip/loongson-pch-msi: Prepare get_pch_msi_handle() for AVECINTC

On Loongson-3C6000 and higher systems with AVECINTC irqchip, there may
be multiple PCI segments, but only one PCH-MSI irq domain. In this case,
let get_pch_msi_handle() return the first domain handle.

Co-developed-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Co-developed-by: Liupu Wang <wangliupu@loongson.cn>
Signed-off-by: Liupu Wang <wangliupu@loongson.cn>
Co-developed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Tianyang Zhang <zhangtianyang@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240823104337.25577-1-zhangtianyang@loongson.cn

---
 drivers/irqchip/irq-loongson-pch-msi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index d437318..0dc1455 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -255,17 +255,17 @@ IRQCHIP_DECLARE(pch_msi, "loongson,pch-msi-1.0", pch_msi_of_init);
 #ifdef CONFIG_ACPI
 struct fwnode_handle *get_pch_msi_handle(int pci_segment)
 {
-	int i;
+	if (cpu_has_avecint)
+		return pch_msi_handle[0];
 
-	for (i = 0; i < MAX_IO_PICS; i++) {
+	for (int i = 0; i < MAX_IO_PICS; i++) {
 		if (msi_group[i].pci_segment == pci_segment)
 			return pch_msi_handle[i];
 	}
-	return NULL;
+	return pch_msi_handle[0];
 }
 
-int __init pch_msi_acpi_init(struct irq_domain *parent,
-					struct acpi_madt_msi_pic *acpi_pchmsi)
+int __init pch_msi_acpi_init(struct irq_domain *parent, struct acpi_madt_msi_pic *acpi_pchmsi)
 {
 	int ret;
 	struct fwnode_handle *domain_handle;

