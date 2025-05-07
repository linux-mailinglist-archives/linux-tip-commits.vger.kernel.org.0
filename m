Return-Path: <linux-tip-commits+bounces-5337-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A4DAAD97A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73D08B20625
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 07:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7F6227B95;
	Wed,  7 May 2025 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l4eDDuAV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X697qiWk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417E224AF7;
	Wed,  7 May 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604679; cv=none; b=Q79V+B/UOJZA0+eS9xMm5Z5z2TSZwa9Q0pk6on8XbhI7lPQghpeo4hjFvOnQnNp/WqkihRRSjxuvRa2hmImdXYLFRzfZeR7XDyahP21VkeK1uh5gL9KVpcjaKhP5HrKM7OqA4nmTorUb4zL3Vk90mPUp4VJPQWBTTGykXtG59FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604679; c=relaxed/simple;
	bh=EK/4qLSXFQVnWXQ9qj1Sv+T79I8txX1AC1ZDQY+6H/U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UwAhQPhZ/A1XVXUNDR7BSjU0Oa0oC959of/mAYAjWkxrKWXYLfb/BzqQws/gO3zMJUbCFZ29eBnyaAAgeWVmlMkOpxupH439gJ3LRd90ci9nQF0Ab44lOecLWahAVN8KeNSoNpVKgKbE1gUh1irAMRj1qgEYTLHrdlyq5i0rNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l4eDDuAV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X697qiWk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:57:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pgJjIRLm7/pN+l7nk9ZMjmbi59DBjcX0HFzxml4ZqI=;
	b=l4eDDuAV4oji2gnjgZ8zsctqb89kTqLbD8c7CLrMb/f9b/c0ixRpE7+h67B46QUmLAk6sB
	5dbspJiDKn/g7vfDEsiNFCKJ19N3d1Pf6mjTNvWqWNIdRdkWuBAVAdV3OdlYDm3KxGXjPD
	pEFFzrr+zYa7qS14cg9mh1rUVqe8WZtSr0wZ5q7Aj7OjzG64NxEBvNr6MGbehrPjpEuMTg
	fvwCzoh/AQnDr74Rp/ShkVH5SbCC/Ed9ZGbb+3atZ4H3IFNddnKjMD72mKz+cbkWbuG5cS
	aQw6Fk5cizi0BqMfezJgHXbtkwHO4zf6V1OXQnP6tHUfq91RUIN2yznkfbq/XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pgJjIRLm7/pN+l7nk9ZMjmbi59DBjcX0HFzxml4ZqI=;
	b=X697qiWkHZRQWNkad6XrQpb4QT3ljAy+l4vyX0FULihJ9VC7AHgYSNH7FVvdguU5Kyr/xG
	wgoMSGzMQEypFuBA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] gpio: idt3243x: Switch to irq_find_mapping()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-44-jirislaby@kernel.org>
References: <20250319092951.37667-44-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660467498.406.14632736241119689661.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     438ff42640f0c2e5dfff92cfed8a7bec10110a96
Gitweb:        https://git.kernel.org/tip/438ff42640f0c2e5dfff92cfed8a7bec10110a96
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:24 +02:00

gpio: idt3243x: Switch to irq_find_mapping()

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/all/20250319092951.37667-44-jirislaby@kernel.org

---
 drivers/gpio/gpio-idt3243x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-idt3243x.c b/drivers/gpio/gpio-idt3243x.c
index 00f547d..535f255 100644
--- a/drivers/gpio/gpio-idt3243x.c
+++ b/drivers/gpio/gpio-idt3243x.c
@@ -37,7 +37,7 @@ static void idt_gpio_dispatch(struct irq_desc *desc)
 	pending = readl(ctrl->pic + IDT_PIC_IRQ_PEND);
 	pending &= ~ctrl->mask_cache;
 	for_each_set_bit(bit, &pending, gc->ngpio) {
-		virq = irq_linear_revmap(gc->irq.domain, bit);
+		virq = irq_find_mapping(gc->irq.domain, bit);
 		if (virq)
 			generic_handle_irq(virq);
 	}

