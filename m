Return-Path: <linux-tip-commits+bounces-5429-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81999AAE10F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7A21BC84A1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C192A28A419;
	Wed,  7 May 2025 13:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O7DWNxax";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+5sHuS8u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E728A1C7;
	Wed,  7 May 2025 13:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625454; cv=none; b=SPAWhJjXhXx/2hdUiOMV98E1rc4lQAQlq8O0J+jEgbO/CwK6Hj9fm+4j+4NW/Y8AEAX8JCCgivnXt6yh6LN4wF4ClyFrCnVFWWG4+NdD67n6mQhw0PtHw0Rd1B7AeM9R91XDG0/gY/EW+y7wb+tyIr7aWRH5n7nc+oRuPb5e3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625454; c=relaxed/simple;
	bh=OnVIf34eiEO9Lf1AD7n50K0XfLKnOGYIWcSAiAMbeLU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GUeusIt6mycFL23eNpI0KnxautWIKpTFWsM/0Kpmy/rQyyG8iDu1PEr8mfxY6mEeWVWBMn4pd3X7pmn73gkQ8Fm4pr40owupPgYdIscVSH3/AcjPkvNFHDfC+wQowTiEvv8ao1S+2nTjUHj4qTzDR97LAMOzVepbHa7ZDWJqikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O7DWNxax; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+5sHuS8u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWIzMTmnJ9vPWNfH5F5aCU5rHbqxY9iILw8OF+/4lpM=;
	b=O7DWNxaxMaVizMeLe/UUSCOUKmxjYUm4nfic8k7EyYpCYYGi3CYXAKHgZ/ySe7QCpxSO2U
	5Aeft1h4LnrpGSa2Hah+ekN9UfQTAKLDYFV5pX4Mer/ZhNPK92kSpkf7FCNgLNxweaaBAN
	+Zohs0q1NWPZQTqZe1KFO/sDHbj/Eaegq0bLlDgBcEynr0pL9vBHo30hUpX+V63/pTyUUg
	BdiBGd/kV/vE5jCbsb3JisBY532khf6hO9HiaMc1AUF/+iJRf+HCzf7rNQb5OpM5RiSuk4
	bFF6jAFyIf7xlkQBdQz6huIWW8kajjs8Dx2uN06zlCoh7A5wlFncS1zUIORySg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWIzMTmnJ9vPWNfH5F5aCU5rHbqxY9iILw8OF+/4lpM=;
	b=+5sHuS8uCzuuYqgSy46mYmlGTLsfhL4YMLhlRwtPF4xBO5lhFODKTVb2xsAa6NDDOaC9nc
	9QFNjQ80AlmnnPCQ==
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
Message-ID: <174662545077.406.12125345712471913171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     76f5c9a3fac46eadd93c012a4cdeb3b620cc9604
Gitweb:        https://git.kernel.org/tip/76f5c9a3fac46eadd93c012a4cdeb3b620cc9604
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:41 +02:00

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

