Return-Path: <linux-tip-commits+bounces-1662-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AE892D668
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC2228A555
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27AF1991B3;
	Wed, 10 Jul 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yzrcAFgG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l4knIJje"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCA198E7E;
	Wed, 10 Jul 2024 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628756; cv=none; b=E9NQyhSvcF4DM5eWoJ8Say6KwCCknnLi3Pq6M7I+0hc8psc3gJTL7bo+GnO6mTJEQADgxQ7htDWkw4ONZfjWPACgLNBZuzVyRZHOVeeWhaCDYgq49kMZ8qVMnieCmuawaOAfzGbhI6knx9xAcQdkIgZwvqka/toNyErU5uI4KEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628756; c=relaxed/simple;
	bh=bozvZ0KucpgnxdF+va08JQ+1p6rnET7k/5A17qZ1nSs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gUBX6/T5AReV4CWUr9OJJRXzm5oGYtUx5eE8FLZRO/gxF0oKk1/xMoNWrr74KeYsX9b32yUd1P7VTWcTQsyypIuy5t4/YDOm4mZVfQ7TVv1P4krxSIiOZm1IZDUYIy/QgPFlQ5xwxqFBt48a8ykGTJX83cR2HG48gJrpSkeKSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yzrcAFgG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l4knIJje; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628753;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJv5lFha/SBdPoNpfy92TfXB2NILWuWDiNlx70GfvQg=;
	b=yzrcAFgGtcMYqkuPdXNeNcQqI7rBn+plJcuSDZ0v5AtzmfprXGswKaWT0yS3fuU7TyZeEi
	Q4Ai80l07tj+vgHVecmykSoH8hZt4zy2FAnybzZlAYFfpNTzTvqmXMsRoA6CwwKbiEcSyz
	JetqMUPJSbenBRqFAa9k80XrQ+7iCQDB+NB8PlDE3e/1D//SEt6PI9BZRd7d2x5WkotQ+D
	oc1hdF8NupW33Mu8M9q/UH54s6XGtRY/msSeIKejLHO+yLJxF8JvK2TMPVyhLZF8GPh6xu
	jq7EZk0MZbDIddi4AfYPQMIrv/lbMGWQrMiG1NZEtb2OKPhljLeLSp8ffLqC8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628753;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJv5lFha/SBdPoNpfy92TfXB2NILWuWDiNlx70GfvQg=;
	b=l4knIJjed3PVywUEPWDARpM7I6eRXlIY16MmAqxQR2RGRgHiR25CVlVoTLWr8t8y9cJo9F
	uxnJf2W/XwhsBnCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/irq-msi-lib: Prepare for DOMAIN_BUS_WIRED_TO_MSI
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142235.207343466@linutronix.de>
References: <20240623142235.207343466@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062875268.2215.9085636267384724335.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d318b8855a34e1ade18b69fde60b0c394aa0e462
Gitweb:        https://git.kernel.org/tip/d318b8855a34e1ade18b69fde60b0c394aa0e462
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:24 +02:00

irqchip/irq-msi-lib: Prepare for DOMAIN_BUS_WIRED_TO_MSI

Add the new bus token to the accepted list of child domain tokens.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.207343466@linutronix.de



---
 drivers/irqchip/irq-msi-lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index b98a219..d20a0e6 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -69,6 +69,8 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 
 		/* Core managed MSI descriptors */
 		info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
+		fallthrough;
+	case DOMAIN_BUS_WIRED_TO_MSI:
 		/* Remove PCI specific flags */
 		required_flags &= ~MSI_FLAG_PCI_MSI_MASK_PARENT;
 		break;

