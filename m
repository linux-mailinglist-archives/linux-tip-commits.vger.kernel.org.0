Return-Path: <linux-tip-commits+bounces-2033-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5535C950040
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 10:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90312863CA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 08:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31B31BDDC;
	Tue, 13 Aug 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FTO1IErB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0NjTJwsW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718C813A244;
	Tue, 13 Aug 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538848; cv=none; b=LH029qfpyVKDhYPsWkk9JnPTml5IIkfnbTBsVpfG0Ib3FB+oz/kCdHuvAPcVtQjr5TENTEWrXy1aBhXRTVj8+mlX1iPxi2es6wGTClmUdQCNS0m3dq9w8F/pjGfiDitUaPC9uT4TVHfN0h4rn+JUET2AuCJHUE2ary0QYIyLZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538848; c=relaxed/simple;
	bh=jyFHRdYTPuqACPOLZzmGEs0ZD9MQQeEfasvfEBsqW58=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l/Vfp94XMsmb5mv47VL/0549T6rKC4m8mqDpypb4g7RHF/R+es/efDm4mcSl2vqwFluoV8JcEN3Ijp6bRVbTr6yDaxatMI2ykBN3Ch72QGCVN+WvoBeiWsBPRcysXUNXsPayo6J0CeF3EMdtB3zm4uDgm54K+fRb7x8sc/j6ZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FTO1IErB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0NjTJwsW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Aug 2024 08:47:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723538845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S58EA59GUvM3bN3g8XLNS3HFtgXCfFpwBiE/sHgNAug=;
	b=FTO1IErBDraJMjFWr+yEOse2zCS5E2RHCGITKhn9ZtegPTEZhWEQ4Y66izsczh+t2NUvJn
	RP2QuJ96xAvs4IZey1SsIN5/k+0Pi8Ypse5fhUOAifrTH0PCtM04GM3O1UCYt6gPrckS6c
	omsbdgo8jL2f9+mKAlomRrAenYoxJV/06Wd99SQA5EEGs3nCQttDuOA1SP/e/26anIBWqM
	hntgdsHY5Q+dQcaaoraiTlbVKLC2DbWId0ypMHzctJXC6sCRtrl4+sM02KTx6lippXJiGS
	lbNUsj5jYZ4E0p5UpRb92tzAr8p6d33vVIoADgr9z0ABFtvJNsFSppSFt5whUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723538845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S58EA59GUvM3bN3g8XLNS3HFtgXCfFpwBiE/sHgNAug=;
	b=0NjTJwsWiFkSQr8lWAPJF0kb+Gr1Tahp6JqE4C+F7AsxwfOVG92At+TiB1o0TesROEDPZw
	iE5BXqiGcrhxtbAw==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Remove stray '-' in the domain name
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240812193101.1266625-3-andriy.shevchenko@linux.intel.com>
References: <20240812193101.1266625-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172353884522.2215.6326848147413150379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7b9414cb2d370b7c5149b37f585b077af2ae211b
Gitweb:        https://git.kernel.org/tip/7b9414cb2d370b7c5149b37f585b077af2ae211b
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Mon, 12 Aug 2024 22:29:40 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Aug 2024 10:40:10 +02:00

irqdomain: Remove stray '-' in the domain name

When the domain suffix is not supplied alloc_fwnode_name() unconditionally
adds a separator.

Fix the format strings to get rid of the stray '-' separator.

Fixes: 1e7c05292531 ("irqdomain: Allow giving name suffix for domain")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240812193101.1266625-3-andriy.shevchenko@linux.intel.com

---
 kernel/irq/irqdomain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 18d253e..1acc530 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -149,9 +149,9 @@ static int alloc_fwnode_name(struct irq_domain *domain, const struct fwnode_hand
 	char *name;
 
 	if (bus_token == DOMAIN_BUS_ANY)
-		name = kasprintf(GFP_KERNEL, "%pfw-%s", fwnode, suf);
+		name = kasprintf(GFP_KERNEL, "%pfw%s%s", fwnode, sep, suf);
 	else
-		name = kasprintf(GFP_KERNEL, "%pfw-%s%s%d", fwnode, suf, sep, bus_token);
+		name = kasprintf(GFP_KERNEL, "%pfw%s%s-%d", fwnode, sep, suf, bus_token);
 	if (!name)
 		return -ENOMEM;
 

