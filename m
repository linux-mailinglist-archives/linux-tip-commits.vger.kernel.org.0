Return-Path: <linux-tip-commits+bounces-5280-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D05D6AAC5D2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D83F3B078C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA5E283C94;
	Tue,  6 May 2025 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1U0rUpER";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SU4wX16R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62C9283144;
	Tue,  6 May 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537625; cv=none; b=F5GuEtGXu7bl07InsgIY27U28U5WgXo267B4qceih6A7OktPE/6juejWl42CuwQkx4XItNrsy/tZqk8htUW29Xdqj75kHJ9BN+o2HPzROQl5mYzTu9MnU17JPIEKPQdVyPWGg36gScIUtdjXSK9b6nTZFoTjwZL/0Rbp0ALSFEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537625; c=relaxed/simple;
	bh=0MBsGZUQ8vLuK2KEzzCwOdJxJIrqJyTfahFlUpjRdbg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VV95PcNnut0DaPsse6xhEsA0FEur5NJFVfkfgG6Ie2tARa9EdoAK8WnaC1iKHFKdWASl5EP8lPyzs+brtQHLgUU2reUUty/8CJy2BhOmZVfb8bo+ylnciUrR/mf+u14cpAjNKLazkAAJ35sYUCXUNxmHFjmgFQ7FrxVc6BobsZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1U0rUpER; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SU4wX16R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFzHgIYensuXV3wyB4np3ip2mhbuqa8XxgIKjQbPTSo=;
	b=1U0rUpERokjL1Wy1VRM3FiVqR21lLcXf2hD58ze9y4qk6s63iPgkcDPLaE9jeCfs15Am2+
	2DkiEF9QX0sbkFDLaxoZubO1Kl7UCsPpN65UKnuYFSu1osCP9VBxDQI35EmvVs6NjOqaCV
	ziA4WM82kHPlGaSjSZJphuEyntoFiugHsz1qbitNIkaq6rDdb4T9H6zJmoj9F4uS1LW36F
	Q9Ren5ujcXv1Z6ao+ZAj9lofBhPdkZK1EJuYvHdECPOPXlNlCC733I/D3P9jE7qdTeMG6W
	9VmyuIz/UzIRahDczdpPnRVLQZK01e3fa3+QK4/XHw3s3JQl9vUfO/r0+5j6bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFzHgIYensuXV3wyB4np3ip2mhbuqa8XxgIKjQbPTSo=;
	b=SU4wX16Ri0c0EbStCEp9897V81CLP+idvjzfDoFM38bhvL6m+VDzXsCiPxgrwuKgJ/lR+z
	coKeP8jGG1dtNxDg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] gpu: ipu-v3: Switch to irq_find_mapping()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-45-jirislaby@kernel.org>
References: <20250319092951.37667-45-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653762076.406.9063012143839781485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     20f9224bb56fb699238f9d13b9da76a068705b0f
Gitweb:        https://git.kernel.org/tip/20f9224bb56fb699238f9d13b9da76a068705b0f
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:08 +02:00

gpu: ipu-v3: Switch to irq_find_mapping()

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-45-jirislaby@kernel.org

---
 drivers/gpu/ipu-v3/ipu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 223e6d5..333f36e 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1008,7 +1008,7 @@ int ipu_map_irq(struct ipu_soc *ipu, int irq)
 {
 	int virq;
 
-	virq = irq_linear_revmap(ipu->domain, irq);
+	virq = irq_find_mapping(ipu->domain, irq);
 	if (!virq)
 		virq = irq_create_mapping(ipu->domain, irq);
 
@@ -1219,7 +1219,7 @@ static void ipu_irq_exit(struct ipu_soc *ipu)
 	/* TODO: remove irq_domain_generic_chips */
 
 	for (i = 0; i < IPU_NUM_IRQS; i++) {
-		irq = irq_linear_revmap(ipu->domain, i);
+		irq = irq_find_mapping(ipu->domain, i);
 		if (irq)
 			irq_dispose_mapping(irq);
 	}

