Return-Path: <linux-tip-commits+bounces-5594-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90103ABA3EE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623EA5032D5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A1228137B;
	Fri, 16 May 2025 19:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KCigJZrF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d00kdISU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1536280A3A;
	Fri, 16 May 2025 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424248; cv=none; b=PufB2Mc1+N7fjsqkIbMvvGv7X6rWBJ+OKbtXGpwj6Cn3gkRylEWSbPND8E64HsrNBNbCzFUNJ61MLOKSwwlMJwT9YghzAuidkHSnC0yTC5Te0qcOwzrEDEF+rDq3CmadRD8hGXBDe6KgCdQhjJggC0cqSdGRNWqcQaArhiRhTIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424248; c=relaxed/simple;
	bh=C9VyGzog2sfO9IZJzLsSgdydr0U2TKqMiHMl7mBp6RM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=odK7FFKcGkvohGKRpx49M6trB7Repg20eUFHf61OgIlhtv6OEh9I1txICRft0H+d0aY9SEaWCa3UbRfREGoM2kUYf7ecsG9mzHjTX3PQWmr1zNBGmObxeL0DqmfsIeTmkJL+IFgyed1+8QiwPulN1j63CyIZ1NmuKUjcZeY9Ywg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KCigJZrF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d00kdISU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ChEU05Bje26w9FOy9ws8x9uCszHxSnVl2vQkmxL2VQ=;
	b=KCigJZrFWs5YSEO0o0ksVdGli3RFRLO+o8a1/ekOeMl/vCaMn6lJXjdTyp6Dg/jUyAIGke
	/NpxnQXycw85970YXkC8qbYt86WhIJTAmXe7TqO8gk6Lk8XsSAxMgTliubFcWt+IZHon7a
	GSTaVGtG26OuMT0N9tIm7VwjYKDPvk0o11jEdEMJZg7xkw1l+po0FnmDwnEB9adBanh6Hc
	sQ8j2v2S/KecSfOzykVnCA2fmP9TYY08TTBarlfX+kBSTBoHGI0F6/LtQZ9TyQS4A2HxSG
	JNr032VYW0Z0RennN5IAKjAbvvlotE3+VXyR8nvl6rYWBEQJSCSWlC0YctGrDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424245;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ChEU05Bje26w9FOy9ws8x9uCszHxSnVl2vQkmxL2VQ=;
	b=d00kdISUIAckBkuYqlYrP38oBBFPPY0Y2b/otphkgY7UId+9vz2zVMw5GtUHtbcROSOaKk
	RXbQGi/Z44Bm0vDA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] irqchip/armada-370-xp: Switch to irq_find_mapping()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-47-jirislaby@kernel.org>
References: <20250319092951.37667-47-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742424448.406.10054501603504515226.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     31b3ad400245b5ddf8081394330ba460f8b431e7
Gitweb:        https://git.kernel.org/tip/31b3ad400245b5ddf8081394330ba460f8b431e7
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:12 +02:00

irqchip/armada-370-xp: Switch to irq_find_mapping()

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-47-jirislaby@kernel.org



---
 drivers/irqchip/irq-armada-370-xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index e516129..67b672a 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -546,7 +546,7 @@ static void mpic_reenable_percpu(struct mpic *mpic)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
 	for (irq_hw_number_t i = 0; i < MPIC_PER_CPU_IRQS_NR; i++) {
-		unsigned int virq = irq_linear_revmap(mpic->domain, i);
+		unsigned int virq = irq_find_mapping(mpic->domain, i);
 		struct irq_data *d;
 
 		if (!virq || !irq_percpu_is_enabled(virq))
@@ -740,7 +740,7 @@ static void mpic_resume(void)
 
 	/* Re-enable interrupts */
 	for (irq_hw_number_t i = 0; i < mpic->domain->hwirq_max; i++) {
-		unsigned int virq = irq_linear_revmap(mpic->domain, i);
+		unsigned int virq = irq_find_mapping(mpic->domain, i);
 		struct irq_data *d;
 
 		if (!virq)

