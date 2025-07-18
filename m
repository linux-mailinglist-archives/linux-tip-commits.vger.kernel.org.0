Return-Path: <linux-tip-commits+bounces-6139-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68EDB0A4A5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 14:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F26D1169EF2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 12:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD582D9EE6;
	Fri, 18 Jul 2025 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LlvUP31U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="opeOZi1A"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAADC2DC321;
	Fri, 18 Jul 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843561; cv=none; b=qsP3iYAVq4l2NGuUhRh9+taCz8P/KZx7l2RijnVDoBTQIT46lDZ4HOGsefvl89lA/gnE7IiXYPxMn/Z87Fc/myFeEc6UXYm8Nbl8sZBExbFH8pq4YUUpjs3jpJoLB50rKwQev9bjb+NGb5m7RrxK8aGvx2+mUxVBgLm6ZrBYVg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843561; c=relaxed/simple;
	bh=s/0v2H8me2bDi5zhVbb7OvddlJpAbs6UDK6v/74Lenw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M2mha9OpuYnYUcP9I5KXt1aJZE+hOsWNut7FuZh6Xham5rckKU/mx/HFQVi1sOFu3d/cXUwaGYbYY05GnrBv/6J1xKlpZ4hlRukPAvZMdCzGrNAmty80epw0PlORoJGDtfIuptaa0Xfn/uJR5d6dAfKxYdPuk4rlJHVv5gSWSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LlvUP31U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=opeOZi1A; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 12:59:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752843555;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOxx3n4BHi5iPsjReqauCghraVkUYfW9DiU/tvlBDJw=;
	b=LlvUP31U3Qvz8ARKNPVlvDSKMgkdOXLKzAyt22FhfDYmMXYwI+V8GjhT2uhNAtEUPVohvq
	889pRMjZiyQftJBk17l9IUjovfyNUZPaRqaLmHpInWxg2y1xUHVICnuCloOeydl0b3+waa
	5R/rGLRlGWBKlnGdu8gdjhZ/oalNjjsc4FytjQIaEhMmKgCXNiq98FbfIGjhRLtUk1g9Nz
	SmRe7P9StIrinnKFpEDIHHnI1tz7AoSkEKL4aEbeL6+5IC8EtWBYtAwqHnJbJWxeSFJKyA
	XRWpPEFyCHL3Bsl3DMO6YJyDC2DMFYx4/zrPS6yKfCpQOUoetVQGBgR4uec5fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752843555;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BOxx3n4BHi5iPsjReqauCghraVkUYfW9DiU/tvlBDJw=;
	b=opeOZi1Ax+3vCCpkBmdMeGwWD/LeC0H0Os7l0qk6VnJz7GkbyPiyI9FizkoS9eG050uDHJ
	w1MgvlNUDOQSJ3DQ==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/ls-scfg-msi: Fix NULL dereference in error
 handling
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <15059507-6422-4333-94ca-e8e8840bd289@sabinyo.mountain>
References: <15059507-6422-4333-94ca-e8e8840bd289@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175284355454.406.2721767581082329657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     aabf4ff06b9789f3cd167bf9e2eb25f1fdb5541a
Gitweb:        https://git.kernel.org/tip/aabf4ff06b9789f3cd167bf9e2eb25f1fdb5541a
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Wed, 16 Jul 2025 14:43:45 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jul 2025 14:54:45 +02:00

irqchip/ls-scfg-msi: Fix NULL dereference in error handling

The call to irq_domain_remove(msi_data->parent); was accidentally left
behind during a code refactor.  It's not necessary to free
"msi_data->parent" because it is NULL and, in fact, trying to free it
will lead to a NULL pointer dereference.  Delete the unnecessary code.

Fixes: 94b59d5f567a ("irqchip/ls-scfg-msi: Switch to use msi_create_parent_irq_domain()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nam Cao <namcao@linutronix.de>
Link: https://lore.kernel.org/all/15059507-6422-4333-94ca-e8e8840bd289@sabinyo.mountain

---
 drivers/irqchip/irq-ls-scfg-msi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-ls-scfg-msi.c b/drivers/irqchip/irq-ls-scfg-msi.c
index 7eca751..4910f36 100644
--- a/drivers/irqchip/irq-ls-scfg-msi.c
+++ b/drivers/irqchip/irq-ls-scfg-msi.c
@@ -226,7 +226,6 @@ static int ls_scfg_msi_domains_init(struct ls_scfg_msi *msi_data)
 	msi_data->parent = msi_create_parent_irq_domain(&info, &ls_scfg_msi_parent_ops);
 	if (!msi_data->parent) {
 		dev_err(&msi_data->pdev->dev, "failed to create MSI domain\n");
-		irq_domain_remove(msi_data->parent);
 		return -ENOMEM;
 	}
 

