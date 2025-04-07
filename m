Return-Path: <linux-tip-commits+bounces-4736-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB46BA7E2D5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156793A37B4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336921FC7C1;
	Mon,  7 Apr 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YYEprZ9a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oL/xEM0u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730251FBC8A;
	Mon,  7 Apr 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036313; cv=none; b=XK10Bywh4/Th6W91LBOctLLup/OXxtP+4XXJdpRT/GxCyEde1k+zGBVl44mlSP0ws0zyOgDQgX+RpmIBSkRThEqO/UVKTpmzARN3IfoQQkw8oXDIQOvVEppB1Qlb1PTh+fWVYLxmT8QE7KYucTOPDRbIHIqN4rE+VEBO5y9omIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036313; c=relaxed/simple;
	bh=oKyyMfZEPqqIHPRAhNeYPEWSVsmfJXkm1AjVw7AFtIQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BtTY7AHovxfiO9msU97zXKkrZ3udgj5zQpeNXSB9m1OIPhZrCcp5RLEB3XdTaJGA71gyG7AM2jpJDNiXx4mbiau3+yMBbMXBBmNjjKzmcgjoy2opOFRVpbgDXAI7K/iwUGV3S/D2ynQ5yDIyGm5JJ4+wxpUM9wAZF1MNBjCeiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YYEprZ9a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oL/xEM0u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036310;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSrIohlpBAJ4cUY1mrGQusZa4vhdooSGWKC4U026ins=;
	b=YYEprZ9aOAYnNRcC9Irdb4is3NqsAHRbXi7d9g81j/Yoa16Eaqke5V8aEZPQQ/lq6SMDiF
	pW3PABD4/0x1c4EO+mRoYd9evOmJIyaKs3o8fFwahgG5JvLOzq8KSTU6t4Jk9zuvOPYK8V
	ioC+1yX4UBUfRP3GMMIv3e+98euE2Z6RFRatGTvNqjugQOIwaPGwcge7EKI6Mlv/YHC3bp
	k/tR0GBJkOGYtqg2YYYOPx+cfrKhjiAaEFDUXvkiLFGpNP+ojC8pFBPkpyo7cXzBICRaQm
	Z4XcVE07W39It1V+bL81nrYrcnV14CdahQ6/ghtA/gYrA/0ji10xkbmVP33gGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036310;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSrIohlpBAJ4cUY1mrGQusZa4vhdooSGWKC4U026ins=;
	b=oL/xEM0uv/5G2qG7meqhMa2efui9Iu2IaDPC2pY2p3j/9XOr+E8P2pLgLB8RKbF611Bxvp
	x6CBAb9UBB9NzXDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] NTB/msi: Switch MSI descriptor locking to lock guard()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Logan Gunthorpe <logang@deltatee.com>, Dave Jiang <dave.jiang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.263456735@linutronix.de>
References: <20250319105506.263456735@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174403630906.31282.2855902838471294390.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     6e7dacb83da43bd0c35e37eca70816a035d605c6
Gitweb:        https://git.kernel.org/tip/6e7dacb83da43bd0c35e37eca70816a035d605c6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:55 +02:00

NTB/msi: Switch MSI descriptor locking to lock guard()

Convert the code to use the new guard(msi_descs_lock).

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Link: https://lore.kernel.org/all/20250319105506.263456735@linutronix.de




---
 drivers/ntb/msi.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 6295e55..368f6d8 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -106,10 +106,10 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 	if (!ntb->msi)
 		return -EINVAL;
 
-	msi_lock_descs(&ntb->pdev->dev);
-	desc = msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
-	addr = desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
-	msi_unlock_descs(&ntb->pdev->dev);
+	scoped_guard (msi_descs_lock, &ntb->pdev->dev) {
+		desc = msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
+		addr = desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
+	}
 
 	for (peer = 0; peer < ntb_peer_port_count(ntb); peer++) {
 		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
@@ -289,7 +289,7 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
 	if (!ntb->msi)
 		return -EINVAL;
 
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_for_each_desc(entry, dev, MSI_DESC_ASSOCIATED) {
 		if (irq_has_action(entry->irq))
 			continue;
@@ -307,17 +307,11 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
 		ret = ntbm_msi_setup_callback(ntb, entry, msi_desc);
 		if (ret) {
 			devm_free_irq(&ntb->dev, entry->irq, dev_id);
-			goto unlock;
+			return ret;
 		}
-
-		ret = entry->irq;
-		goto unlock;
+		return entry->irq;
 	}
-	ret = -ENODEV;
-
-unlock:
-	msi_unlock_descs(dev);
-	return ret;
+	return -ENODEV;
 }
 EXPORT_SYMBOL(ntbm_msi_request_threaded_irq);
 

