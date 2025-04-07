Return-Path: <linux-tip-commits+bounces-4737-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBDCA7E27F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 16:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0AAE4248A9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 14:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B446E1FCFEF;
	Mon,  7 Apr 2025 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aGDoLUA4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QJeMB679"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5DB1FC105;
	Mon,  7 Apr 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036314; cv=none; b=gx3onx2tQ3EMl68WAd4MXxtG81YunvFB/He3I+U0hbsJ9nCn1mXZmIRdaEMZ3xVoGo/hwMGgVh6jwOJabvQ2WT6Sa88C24V997TsWpoXph2Ym5HgiQcYbLlISBqTxpIDIDheoVhh4DJJ3I5/mSAe/jv2iRKwnBG7QWaM5hbRmeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036314; c=relaxed/simple;
	bh=mEAE8qVpcJZz/32RyOgJAvdA1jfZSC8IGWWd8c3Dgsw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DDvOitEIL5UZHJKrbewqqRERQJSJMIlJ36eH9G3GLKtrgOJrjcjBiIQdEp5zsJMEFPfhDtusim/JYyYEJd/FVM8q798CmAlln5m+odwjxwLHGlUgh2GNDaojRr4xhG3BRPoc6+VITzSvMx4GlLrSGlmziJnKnzsxXRKk96HXHxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aGDoLUA4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QJeMB679; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 14:31:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744036311;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzNm8M7WKVm0dUnozAHq1LmQHXgdk0oLlXMz76vdHqc=;
	b=aGDoLUA4AZOBzGVX83kSMZYfIjZNZOHs1PyJv8Lt4+NAy85KtRg4ZQvAcnkd+AmMsJIXMM
	yRhho/LXyHuoI/WeI1XykgcOJuaokcbGErJwNBaozO8wAAdHZz/0k60DuaAg37IHnngc2f
	wqXAT+uGdApFny8+4ZPaXgJ9bnGbD0E6ZuvOtIAAPar90+BsZA/mhj9o3zqajf+qNu5/yM
	vQPTbe/A+HnwFEKwP9sWl0XklVtIXTDVAdrjDvjIeUdjP7Q2ke7/Nd7Xb7YQo6d+mXxFfw
	gV/zTv2WXuRnjSZ/pOlLZYA6BXQrAHNGOv1w2GdYOGlamcRtKmHC5tkquhWslA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744036311;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzNm8M7WKVm0dUnozAHq1LmQHXgdk0oLlXMz76vdHqc=;
	b=QJeMB679fM4/dDDpyJCeesQrr6sZWebfnPV/cbfinxElM61PRHHwF29tx7nkyzbG9qL9ZK
	vxNXsKrUlQAF89AQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] soc: ti: ti_sci_inta_msi: Switch MSI descriptor
 locking to guard()
Cc: Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dhruva Gole <d-gole@ti.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250319105506.203802081@linutronix.de>
References: <20250319105506.203802081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174403631040.31282.6425329734954381811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     d70d21788a602dc9cdd154320e92f1b97e9f4e0f
Gitweb:        https://git.kernel.org/tip/d70d21788a602dc9cdd154320e92f1b97e9f4e0f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 16:24:55 +02:00

soc: ti: ti_sci_inta_msi: Switch MSI descriptor locking to guard()

Convert the code to use the new guard(msi_descs_lock).

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nishanth Menon <nm@ti.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Link: https://lore.kernel.org/all/20250319105506.203802081@linutronix.de



---
 drivers/soc/ti/ti_sci_inta_msi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index c363645..193266f 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -103,19 +103,15 @@ int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 	if (ret)
 		return ret;
 
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	nvec = ti_sci_inta_msi_alloc_descs(dev, res);
-	if (nvec <= 0) {
-		ret = nvec;
-		goto unlock;
-	}
+	if (nvec <= 0)
+		return nvec;
 
 	/* Use alloc ALL as it's unclear whether there are gaps in the indices */
 	ret = msi_domain_alloc_irqs_all_locked(dev, MSI_DEFAULT_DOMAIN, nvec);
 	if (ret)
 		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
-unlock:
-	msi_unlock_descs(dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);

