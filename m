Return-Path: <linux-tip-commits+bounces-4807-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F689A82FDB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954947B2389
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 18:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7773B27EC7C;
	Wed,  9 Apr 2025 18:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="picDJyXY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WT/4A1oc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8D627E1A3;
	Wed,  9 Apr 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224877; cv=none; b=PepgRrkOdM0ZbnmQ1Y/OJFpBo3XPRlzpiXRzVoCUeoEpC+dCF00rCTYPGNvATeLbgq30VoxQbmxdLZs4Ad4PqVuQ0F6H+BCyzVST/HtiXP+prP75NDIzoBQpIKE+O4h5FEpFVJu4Ju8mkHjGFn2LChEUC2BuZNoUNFWLeVfZgfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224877; c=relaxed/simple;
	bh=2/eVMRtNPjMAtdM4bNWyYRO1fHoyqnUl/lijDQEDxrs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E5NrIv5cvmV/Rq679FBr4PPPRgN8pZztODlNvRPSaxv7HbYQWkR0aJjUwKmBRcwjSBGsJa9WiwqnDr+Il618xFZ9QIa0vLQeUAgGLlDVAZJ/VARYVG9HxRwdkW4CTbyY0ojHT8hDfD0fyGWrBMMd6pupbKnlQAe+K5Bl7DcAaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=picDJyXY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WT/4A1oc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 18:54:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744224873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLYmJ+oCpU5OrNaKb6kHJmRGBmzC8FCwnkzHFUn1HTY=;
	b=picDJyXYJBaNHe0sci9FKlhxX+ZEV9ql5iApFzx5lWTUJw6dDMi2V1v8Jpt6NCeqBsn8PK
	M/WnU2w3NtJ6JpHbOaJ/D7cKwiN8g9UenDBGXqGb+1nZg+3NMgrxOBgw4jydScUBeuMOX8
	1RSfgk5aYQx3WlYgEHVP1MlUKuBBSaEYz770buGTzBDJEvm3jl9kpb0AkD3LkS03bl5j6U
	k3bsogXH0gyplPwm2DD6eyGnhnM3bepJ/7KBPiQGhT7z7wrwiLZq4Ptclj4pkwsQxjHfyj
	regRTZoyBi0KXpJGMKp6TL539U9i7YAuI1IpiVUSPZ7JpAJHSciOS/yJ/bhwOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744224873;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TLYmJ+oCpU5OrNaKb6kHJmRGBmzC8FCwnkzHFUn1HTY=;
	b=WT/4A1oc1UaKokw+3zgNLCLGJRhPLpfEFFKpH69eT0txbJpGRk4H4eFIXOF8FVwQ014UMA
	qSenjjcMHTZlT5Bw==
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
Message-ID: <174422487317.31282.18140916889849767959.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     8f3315cf7e97785241a32457061a1c62035c65ef
Gitweb:        https://git.kernel.org/tip/8f3315cf7e97785241a32457061a1c62035c65ef
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 20:47:29 +02:00

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
 

