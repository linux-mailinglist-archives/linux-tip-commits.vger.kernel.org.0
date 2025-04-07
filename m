Return-Path: <linux-tip-commits+bounces-4730-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5395A7E260
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544154225BC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4D61F891D;
	Mon,  7 Apr 2025 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c4v8K67h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qv9kESTT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D551F76C0;
	Mon,  7 Apr 2025 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036307; cv=none; b=AFDc6dTdSegUR3LWb0cihKSZbOuM+7xZiOyfjOooYqdMvq3V7efMtNbPDIiDIZ3Tg6tgIg5Xbo9CKaiDdyUoeSJAp5830pH90HXXJi79eYWZLFtFktzsH22Dg7wCrm09776YE4UbNhi0awSShffTcb88mmu9LrfBA+GxbLrvONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036307; c=relaxed/simple;
	bh=OJFPleKG+faoB8AqRW9IAlbv/ZpT62wCGqi4wruK4xg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ndZbBdPnc3i6E9RPfDp+081c4tkfXO9bkxPziwusFnmC5+q9liDTGgZo11x8ht34x3wabQldkpkGI7lJYBW0boUlcjB4ZaHp/5oCZ6wfc7gLcUdMofV5M7lkEj5axT1F/6FkzSr1fJIQybfpNVe6F2UllBZ1mI9mrpDNbYZaE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c4v8K67h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qv9kESTT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUUOtPKD5SS9sUddMuKWxcHe4sZQiAobRXFRbOsAntQ=;
	b=c4v8K67hLF5GKinPypNZ9+6Njz1lfg24FyluDlIs6bYnbix16iOxvR0DTiDPLGceCXCTYp
	R+mrkYmH4JMbcaadj3I5MKwKHUM5P8v4NIMm4KVUOuvd5EU9tivJU2hHNS430pxRU7xj1r
	uaFlB0JwUiRuPJovXBYzHm/E3WfuGerWkCF6xbfxXuv5JSK+Nt1wdRiBSu5/9YCe7W7z3s
	Brx3Gp8BtJcXj+3fTWJdNvGShCYqkV8goUFhfOGeY0bsDVQBhCECYNX6yczjGpPiuZ9U2i
	Yu+wUAUuxtc1aQYMCXwXAS6NSIDU5+lM/sBqKjmmxZfKf/VdgimlYA7r6ZYTFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TUUOtPKD5SS9sUddMuKWxcHe4sZQiAobRXFRbOsAntQ=;
	b=qv9kESTT3rknkWsc6Cvj0RJol4j9LZBbZl9SlbrGePMyZsg84Mw4Dx57YuV/4+pOfbXB1+
	8xbYxuMnUIyokdAw==
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
Message-ID: <174403630303.31282.7040370239515737751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     159e0676bcb0c14960aef912fbe95b0858243d51
Gitweb:        https://git.kernel.org/tip/159e0676bcb0c14960aef912fbe95b0858243d51
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:56 +02:00

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

