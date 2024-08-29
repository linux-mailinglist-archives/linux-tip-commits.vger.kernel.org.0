Return-Path: <linux-tip-commits+bounces-2137-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0286C9648E4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2024 16:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17BB6B20E6E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2024 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556851AF4CA;
	Thu, 29 Aug 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QmsYPL4I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="043ONIQW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633B1922F1;
	Thu, 29 Aug 2024 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942781; cv=none; b=mWzdw29iCE10HmqgGSR+YKyLogcVs2LFS5dcxZlOiovx5u8wKq7S7d+st2/IMhkcKB+o35tjbCwPUS51Na3NOdmm15Eeo74lYNZ+qjYZJA4FDBOV7pKOzZVZvgskrOUzG6r71X3Ep7nFAaulKSjNS7e6aZL2vbnTIbNP2RJq7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942781; c=relaxed/simple;
	bh=LfIKx7LuG9qc6J4r7dTMtl93D23CmqEGx+49R841UCI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=E12WCLyaRNqHMTwy+gVjvqsyJkCI42En89d4l0r//1c50G9n/vsPhM3tZLPfjUN8ztvHRAnCL2wio5HcbrRXV6S8iGgEjhwG/IWNpQzF9NHjBpanouy8GOMcLprgxY9gVzYMdl0c6ZgyLjvd3YBG8ReqS2ev3/FFtuJ+X8fNtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QmsYPL4I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=043ONIQW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Aug 2024 14:46:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724942777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWLiZrJbDnuarPFWVeR6QQPBU+5g6Ry4mE218yAoFmA=;
	b=QmsYPL4Iw6IiSHpYE/MeWSvcISogN7GqUjEIZ2w2T73A302N2uDR0Get0cOifvFN2LSmwU
	ZAFbhDRR/bDBIyRD9+ByO85Qj5FXIGRujJMgCJeDXQOgiuSnriJyM9glGrXnzbnDR2+2ep
	jHwYyp7JiyzzXvhd4lBxvhc3plGCDjZAI8D7xbo2vdCjNECyoYDZImMdEvpZpFxcPO6SM0
	TFr9VfCfJc23fqzpP+TniWzblFUDl5sE7ngkMU/yZOt2Jvj/MS2XBITDDZ/ZCrCb01ylXb
	tmELkpdE+4nlkbqpezQoctKxldAiugVnDm+Uzsh38l0mKnNiar8h8zJoxZ9sKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724942777;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWLiZrJbDnuarPFWVeR6QQPBU+5g6Ry4mE218yAoFmA=;
	b=043ONIQWDqQrXKuRgIO51xLVKccylpq50/uHls4Zi4UlmSwPLKpUduS75Hm6uMiisI4pdi
	JuoXcNm/FuVqJxCw==
From: "tip-bot2 for Hongbo Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Use IS_ERR_OR_NULL() in
 irq_domain_trim_hierarchy()
Cc: Hongbo Li <lihongbo22@huawei.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240828122724.3697447-1-lihongbo22@huawei.com>
References: <20240828122724.3697447-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172494277702.2215.13037320585005222364.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4609c6eab67bb1785a5337ddafb5c74c796bcd35
Gitweb:        https://git.kernel.org/tip/4609c6eab67bb1785a5337ddafb5c74c796bcd35
Author:        Hongbo Li <lihongbo22@huawei.com>
AuthorDate:    Wed, 28 Aug 2024 20:27:24 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 29 Aug 2024 16:42:07 +02:00

irqdomain: Use IS_ERR_OR_NULL() in irq_domain_trim_hierarchy()

Use IS_ERR_OR_NULL() instead of open-coding a NULL and a error pointer
check.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240828122724.3697447-1-lihongbo22@huawei.com

---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5df8780..e0bff21 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1403,7 +1403,7 @@ static int irq_domain_trim_hierarchy(unsigned int virq)
 	tail = NULL;
 
 	/* The first entry must have a valid irqchip */
-	if (!irq_data->chip || IS_ERR(irq_data->chip))
+	if (IS_ERR_OR_NULL(irq_data->chip))
 		return -EINVAL;
 
 	/*

