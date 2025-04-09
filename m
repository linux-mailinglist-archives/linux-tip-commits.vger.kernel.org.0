Return-Path: <linux-tip-commits+bounces-4808-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEA2A82FE1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 161CF7A246C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 18:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B2527F4CA;
	Wed,  9 Apr 2025 18:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4hzfTjqa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0yjMM6Hp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC727E1D5;
	Wed,  9 Apr 2025 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224878; cv=none; b=FLNYZVbiC/MLvrOoHjd+3pNc91wSGR7PkZ37HQSb7sR91k0cJ2f3Pw8yl3dVwLOHuyvZHGIi/p2ELawnF7lc7HvM3pKVrjsE87+yZ0UENfoIOieNy+/EnC/M1aJMH23aBdOT0gf6Ar3ec6bGH/5m0ibwV4Cl4ZExQwY361q+37Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224878; c=relaxed/simple;
	bh=6r0PXyajJXly8o0OZPmKVUGwUr5ZQ1jApja7tbRd2To=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y2zaff2/2vhM8ff19j4bgrQb0MdsDYJva3h6vFP2I/7Lce8RWM1/hy8WhvTRtPG1cPQRB7rCxHb/1+2HAlPECZvpT8pKHRe16fBKr9lVqkKjRXJqH0ERwhkvVHL4WpQEviJmfsfbq+3LyAGXd1mI1U8HbunzuXyG+kXjovvHic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4hzfTjqa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0yjMM6Hp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 18:54:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744224874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDJ8xhfCDuM6+hV2Iwfjz60bO8EgP3DQZDEVdl/SR9s=;
	b=4hzfTjqavhWxpCUcncdOvhLRI41jKwx8cNGB3rPEbWxvmN56wSEtI2PSN/E8NfvGbc/ZuP
	oadz5xIyn/7cjAr97GJ6lI6Yok+kXv8X0vuhhUpMHj9JIUzT4LURiorKdKDJwvkcsIhS1h
	OmeQqvrXRW6YEUtwfoMaWjIAg9pKqvlyCndcvGiyMU9sSWjIzEQzp5/nriSHgscDnP0OGA
	F0rokX5ZZu/G6pVBlybXrLUyKaNQSrSZP8EmxBejY5/Fp+rEJp+GX3D+poJPDEVg9mco3z
	Y+9TEkrKg0nDJjxkUNwNNPLigsibLZbF72eWdR+lrlwv3FvIvW0QwNhfW4mAXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744224874;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eDJ8xhfCDuM6+hV2Iwfjz60bO8EgP3DQZDEVdl/SR9s=;
	b=0yjMM6HpwvYXHHXcN7+32Zkno+acS8TN2w9XfjBBDJRkGMUMnFmgnPro8qanpK22tfCzD3
	h8cFCEwR7SOqKfDg==
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
Message-ID: <174422487379.31282.4539074487666148812.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     f25dd9ac48463c695185f3944770b59bfdf91058
Gitweb:        https://git.kernel.org/tip/f25dd9ac48463c695185f3944770b59bfdf91058
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 19 Mar 2025 11:56:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Apr 2025 20:47:29 +02:00

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

