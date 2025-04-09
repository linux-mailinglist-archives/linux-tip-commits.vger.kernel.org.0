Return-Path: <linux-tip-commits+bounces-4800-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEE7A82FC5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 20:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3448F8A2C0B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 18:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FB827CCED;
	Wed,  9 Apr 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0jGhMruw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bwfJeshv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071DA27CB3F;
	Wed,  9 Apr 2025 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224873; cv=none; b=JjNMXg+QCptGIjmAwKuVQcrP0cyVZ2/XfqB0SCuuhue21+iB7m5T3NvCrf8HQwl93o5/pKuD/QAdpGwsLhY/jLa7NZOQosMO06c4+hGJyNkRVFKkLwa6Ui1zN2BNLf2nzZHMlrAbNCI866guDMhPr2poxADuQTvsW+K2qLXkwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224873; c=relaxed/simple;
	bh=fZgGukVtoNWBNId69g6rO/5ISDL5Rqr6EIKeleljth0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E0MJDabJeWrsx513ecZtaNPKAg6YQ7Q+r7CSmYxiTuonQly59EN5sCHCTtsb+W2TcYDJ+x9i1+Lv5p7onNoEXtyJko43kgTVSuGEDfxKO7qabdtPOFBPXBL0XKwnF0IMv+t39UM1HTwsFelNzuVEcTEf9HoTt54ER+N+SQAoDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0jGhMruw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bwfJeshv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 18:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744224870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MujWxkvIDdnC+vATwoLQT4he0k1NIaW67ZJyWskOi/I=;
	b=0jGhMruwOmIjH4eoqc0AZjLpWMLLXUGLOruCYJjuimUn+smumlQa5bWuZdKna8MwaEL6k2
	5wJQNYiIjvfsV6kXvkkTIjvE66sNlqZFD/O72wBfkl9RjJaOpodz+u+14IQWb273/u49dp
	NRtBK6ehZOtXOTZx+cGNStKkA54VpYq4X4w9YK+mDTpDaFhijz/cWieHOvZFtzkPrhl6cT
	p3zti+ehXuTeLODosH7xtOxDty/j2CFvwQPccAYGBvsQZB8mxTXKlqtxVH8m8qaXI8kA7b
	9m+r/a4qqOcyFEPupiq34UZoE/Bz5YdZvoQNgd84+yvdPEcAcz7TnWMpWV1E2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744224870;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MujWxkvIDdnC+vATwoLQT4he0k1NIaW67ZJyWskOi/I=;
	b=bwfJeshv5s96tv54Mbn9AmxFFm4G1cSpfGq4YbfEk8GlRBvmCWsPu/0TRXmbYzDb+yQs3J
	Li3fP5qIZ+x6B8BA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI: hv: Switch MSI descriptor locking to guard()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.624838146@linutronix.de>
References: <20250319105506.624838146@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174422486956.31282.1252235934209625256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     6552e90e2a23b8861488653c76605f7aa1c77ad8
Gitweb:        https://git.kernel.org/tip/6552e90e2a23b8861488653c76605f7aa1c77ad8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 20:47:30 +02:00

PCI: hv: Switch MSI descriptor locking to guard()

Convert the code to use the new guard(msi_descs_lock).

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/all/20250319105506.624838146@linutronix.de



---
 drivers/pci/controller/pci-hyperv.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ac27bda..e1eaa24 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3975,24 +3975,18 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
 {
 	struct irq_data *irq_data;
 	struct msi_desc *entry;
-	int ret = 0;
 
 	if (!pdev->msi_enabled && !pdev->msix_enabled)
 		return 0;
 
-	msi_lock_descs(&pdev->dev);
+	guard(msi_descs_lock)(&pdev->dev);
 	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_data = irq_get_irq_data(entry->irq);
-		if (WARN_ON_ONCE(!irq_data)) {
-			ret = -EINVAL;
-			break;
-		}
-
+		if (WARN_ON_ONCE(!irq_data))
+			return -EINVAL;
 		hv_compose_msi_msg(irq_data, &entry->msg);
 	}
-	msi_unlock_descs(&pdev->dev);
-
-	return ret;
+	return 0;
 }
 
 /*

