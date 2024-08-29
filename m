Return-Path: <linux-tip-commits+bounces-2138-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8799648E3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2024 16:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFFCC1C22589
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2024 14:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839851B012A;
	Thu, 29 Aug 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uQLgOdIx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vCl9LX4/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4971946DF;
	Thu, 29 Aug 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942781; cv=none; b=QEaLKXb4wMe+n8vhqH2L775+6UomawGQxyYxan1VNIAlzrpCM8OodljPX+qlJXEJx27mcP2NpZldmDO8R7PvtA2BUvs8LD7VWENOQv8tK+WFEargGczteRFS/vAIvK7JnDYxhuW1IRk6x3nl09lZjcFpyBnLP9DKIDHRlJq2S4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942781; c=relaxed/simple;
	bh=m/RsBTYlYLNg/WPbogCQqnwcvVJPOCq97cV1r4ZiC88=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CZ8b+y0mVG/ZSfaWbnjQN4Y+QkW3wuVxKdubtiGd2DQ6hkkhvY/27OvKh+qqgDqJrc+7fkUWFy8E/qRPklEUY5LqG/ZzE97EO/ElpvkmnYolnX5D7hJ7zWi4pyTo0yl+c939240tHglG/2uHulu4IpUtFqwuhEr6aeEpW48X+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uQLgOdIx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vCl9LX4/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Aug 2024 14:46:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724942778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EBesiOcDQO1SXIS3HjTRo94IsKOoc3RVQe88RAWYT4=;
	b=uQLgOdIx2CqxQV8uJj9+juusKAhTOilp8HT33slcJrY6Ddvj30v6XbCCNh6Rs3T4colrbJ
	B8yyFCZH+w2DAbYL0DrXYoUGDgFGO3QZsxmSr7QcUkdNl5YeNGD4zYiJFBeNM2QEgG6Mju
	656Q7lJMvFLsLHqK+8cs7Ffep8cwiWUkR/POsEtnSc1yc7XOp/oSsL4Y0tfrfu3ExxQEcW
	jbArQ6SlheH4aahot1DnXKTJrF6bPH9SjNy+Ji7sPFjIRTHWTli/A01P13jkF2iiz+k/ga
	c/5uClNdXsmzP0GYG9N78P6RhHhVcrvPWcrCd27gCR44M0WG1Yf9BClyWKm1fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724942778;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EBesiOcDQO1SXIS3HjTRo94IsKOoc3RVQe88RAWYT4=;
	b=vCl9LX4/L1kEMidOsjmRfl1JC1ZOGNOqWfF31P9rFZHKdjAyIwPbSosQ35TIr0SNQdWNUO
	LU/zui+1gmfB4SAg==
From: "tip-bot2 for Jinjie Ruan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Use kmemdup_array() instead of kmemdup()
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240828072219.1249250-1-ruanjinjie@huawei.com>
References: <20240828072219.1249250-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172494277775.2215.13777231385536822903.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bf1e0fb69a15fac4d6ee71d0e1c715147add986a
Gitweb:        https://git.kernel.org/tip/bf1e0fb69a15fac4d6ee71d0e1c715147add986a
Author:        Jinjie Ruan <ruanjinjie@huawei.com>
AuthorDate:    Wed, 28 Aug 2024 15:22:19 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 29 Aug 2024 16:42:07 +02:00

genirq/msi: Use kmemdup_array() instead of kmemdup()

Let kmemdup_array() take care about sizing instead of doing it open coded.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240828072219.1249250-1-ruanjinjie@huawei.com

---
 kernel/irq/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 5fa0547..1c7e515 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -82,7 +82,7 @@ static struct msi_desc *msi_alloc_desc(struct device *dev, int nvec,
 	desc->dev = dev;
 	desc->nvec_used = nvec;
 	if (affinity) {
-		desc->affinity = kmemdup(affinity, nvec * sizeof(*desc->affinity), GFP_KERNEL);
+		desc->affinity = kmemdup_array(affinity, nvec, sizeof(*desc->affinity), GFP_KERNEL);
 		if (!desc->affinity) {
 			kfree(desc);
 			return NULL;

