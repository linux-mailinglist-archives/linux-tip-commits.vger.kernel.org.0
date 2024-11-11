Return-Path: <linux-tip-commits+bounces-2838-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27E59C3CDB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 12:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4B2B20797
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 11:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA05187844;
	Mon, 11 Nov 2024 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W06aKXWU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f0xLyA06"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312C156F44;
	Mon, 11 Nov 2024 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731323915; cv=none; b=eIoiAeuizyf0/7NUIacKPOLot7DKmvTXcnWsmyYIx1DvNpSyjXazflYdGkTb0zSnrsBPQ+uqJk1nq8Ny5TnjD6Gu30DegJmZH+oDJbarKrVr90aEhFtuW209eEXtWOqUp2dZgM31LwBbKCcJQVelvEJNOxxRQflZoE86ILrP0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731323915; c=relaxed/simple;
	bh=Yg9zSIm7Ca/pSMeQ6nDnneJuQ4xSLOM2UPEBdgzYByU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QKupyU2OMvsastW25u7y9h8t4+VnYz+tUqhc2YDVk2p2wYxXfM4KupSfrjVs9jaPzLMeBDXnIIE5sPW6VKxxjogfe7gNhM6vdvVAXl+8jDTCYwdzuJ2hlmd7PRgnrjNQprBElJdQHJOZLGIaW0yXvLGoh1tEKGsOVWhPh9RRMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W06aKXWU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f0xLyA06; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Nov 2024 11:18:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731323912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJ4eKqhrSsMKXuXaatrE+qCnzrKFbxFzPYHwvjA2w4Q=;
	b=W06aKXWU4sbncOYLJxnbTl7f19fFqAgP0pFxVjS0qww2B7ts5dAPs49Xp/PNyYW1gfRn+v
	XghKPHaFAM6E1+zqBky587GfJHJtoxzZU3RJhw6LaCU/nyZnj+oBGZYJ/lj4nlbCEmFcWZ
	zWlxK9t4RUqOQGELRyVlssM+yyBnLEnqj5KPn+rDM1Wwe1febepUMJtpvyMg0lE2buWWL1
	shbDxEQWabvaUaQ0bQRclSJQA0k2U169y9y7L1+3Qtgnbu5z6/6DILRZjumVo3+mlTRh6E
	hsKG6MQgi7LzzrdEvSPTU6H5vNURkS95gOfaBATETTNCt00oToLlWjdbhUWOvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731323912;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJ4eKqhrSsMKXuXaatrE+qCnzrKFbxFzPYHwvjA2w4Q=;
	b=f0xLyA06tMWU9yjx7Xc34s/dkBQFccUTT/CQtfk0d41nYYtDdlGoqvFtX6Eb63oDQccyV1
	8zh0RjOVhgDolaAw==
From: "tip-bot2 for Philipp Stanner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/platform] x86/platform/intel-mid: Replace deprecated PCI functions
Cc: Philipp Stanner <pstanner@redhat.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241111103602.16615-2-pstanner@redhat.com>
References: <20241111103602.16615-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173132391101.32228.16591774568032893394.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     90f1b42b179487ee77d182893408cc1c40d50b13
Gitweb:        https://git.kernel.org/tip/90f1b42b179487ee77d182893408cc1c40d50b13
Author:        Philipp Stanner <pstanner@redhat.com>
AuthorDate:    Mon, 11 Nov 2024 11:36:03 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 11 Nov 2024 11:59:21 +01:00

x86/platform/intel-mid: Replace deprecated PCI functions

pcim_iomap_table() and pcim_request_regions() have been deprecated in

  e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(), pcim_iomap_regions_request_all()") and
  d140f80f6035 ("PCI: Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()"),

respectively.

Replace these functions with pcim_iomap_region().

Additionally, pass the actual driver name to pcim_iomap_region() instead of
the previous pci_name(), since the @name parameter should always reflect which
driver owns a region.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20241111103602.16615-2-pstanner@redhat.com
---
 arch/x86/platform/intel-mid/pwr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/platform/intel-mid/pwr.c b/arch/x86/platform/intel-mid/pwr.c
index 27288d8..cd7e0c7 100644
--- a/arch/x86/platform/intel-mid/pwr.c
+++ b/arch/x86/platform/intel-mid/pwr.c
@@ -358,18 +358,18 @@ static int mid_pwr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
-	if (ret) {
-		dev_err(&pdev->dev, "I/O memory remapping failed\n");
-		return ret;
-	}
-
 	pwr = devm_kzalloc(dev, sizeof(*pwr), GFP_KERNEL);
 	if (!pwr)
 		return -ENOMEM;
 
+	pwr->regs = pcim_iomap_region(pdev, 0, "intel_mid_pwr");
+	ret = PTR_ERR_OR_ZERO(pwr->regs);
+	if (ret) {
+		dev_err(&pdev->dev, "Could not request / ioremap I/O-Mem: %d\n", ret);
+		return ret;
+	}
+
 	pwr->dev = dev;
-	pwr->regs = pcim_iomap_table(pdev)[0];
 	pwr->irq = pdev->irq;
 
 	mutex_init(&pwr->lock);

