Return-Path: <linux-tip-commits+bounces-2534-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C219AE0C5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 11:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797091F22286
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB501C4A36;
	Thu, 24 Oct 2024 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vocs0RTR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1l5Ra5jI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F801C4A25;
	Thu, 24 Oct 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762074; cv=none; b=NLsXVD+thk7mrzNU5QtabHEDICST8AGW6FtWnPXLyPIIfvmMIMbACxcoNeKjyx+ZBXQTcGh7W8OzjlJYIYhSijMzfpps3EvZxwBxE358zHBMZRUW6pOAIks9xKPTuX1Z8hOpW78gPghMd+6mI4+msTJAYu9i02fxjF//2/5//eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762074; c=relaxed/simple;
	bh=miyR+SzU+I8808ma3SpXhlGoPA3lkkwnyXAMNVmYwQs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cLRD+Su0FDbS0wLxEk4XlnLeXq0EYgKPYr65zPKxfFlIdWiFBmiGkyFcSSW3ZMIkNc2iB8F2fhiX0/zJyU78fcd9zZuY3QuCEGam14X5BD0UQmt6MyqxZxgwIvf5tT/EuSB6RpewxtceO8g2OeS5Xx1lwwxOUMFgliLEgyTLhFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vocs0RTR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1l5Ra5jI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Oct 2024 09:27:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729762070;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bttuY1UzmMWkqLcWWIvpLvijkPjjapxvk7ONObJ4n3w=;
	b=vocs0RTRqKZ8ZvnPuXMxIeRzg1Fc2gI59LNq/iye/prrAMpLTUAvYwe+W5DSmf0j6qjGAU
	ScHld+8xUCo2SLJ8B/fz170lpI8XLnT6aKhjwXY725KUiHnNwgWXPALpxzv2GeA/cg0402
	UD3eSKcmreA3ecytositYyS/NH7Dorh8XBnUA6aa+di+lS5lt7RcvsuKsbzGdozKkkQpTe
	l115Ucz/9108lw/t4fjQjvLrip10EeuA+vWBRpKaqxuLlItR00SN+DAQ1CJYOx0LDZRv6/
	D4li2JrFzpJcs1qOz11Y2HNltvxqW16I9NMmco6AJn/xqXYVpm+UXFh7ddqS3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729762070;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bttuY1UzmMWkqLcWWIvpLvijkPjjapxvk7ONObJ4n3w=;
	b=1l5Ra5jI406MpfcUZ5smMc47/JTcpnb/qZod5cN3kcT6dA15jrRVukG06rro6/D1Nz4But
	1xsXlMA/szB0nRCQ==
From: "tip-bot2 for Zijun Hu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/devres: Don't free interrupt which is not
 managed by devres
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241018-devres_kernel_fix-v2-1-08918ae84982@quicinc.com>
References: <20241018-devres_kernel_fix-v2-1-08918ae84982@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172976206906.1442.8513689121984168909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2396eefa075a31884d3336e1e94db47a0bd2a456
Gitweb:        https://git.kernel.org/tip/2396eefa075a31884d3336e1e94db47a0bd2a456
Author:        Zijun Hu <quic_zijuhu@quicinc.com>
AuthorDate:    Fri, 18 Oct 2024 20:08:25 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Oct 2024 11:20:06 +02:00

genirq/devres: Don't free interrupt which is not managed by devres

If devres_destroy() does not find a matching devres entry, then
devm_free_irq() emits a warning and tries to free the interrupt.

That's wrong as devm_free_irq() should only undo what devm_request_irq()
set up.

Replace devres_destroy() with a call to devres_release() which only invokes
the release function (free_irq()) in case that a matching devres entry was
found.

[ tglx: Massaged change log ]

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241018-devres_kernel_fix-v2-1-08918ae84982@quicinc.com
---
 kernel/irq/devres.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index b3e9866..eb16a58 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -141,9 +141,8 @@ void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id)
 {
 	struct irq_devres match_data = { irq, dev_id };
 
-	WARN_ON(devres_destroy(dev, devm_irq_release, devm_irq_match,
+	WARN_ON(devres_release(dev, devm_irq_release, devm_irq_match,
 			       &match_data));
-	free_irq(irq, dev_id);
 }
 EXPORT_SYMBOL(devm_free_irq);
 

