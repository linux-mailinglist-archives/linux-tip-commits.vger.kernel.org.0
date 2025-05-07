Return-Path: <linux-tip-commits+bounces-5440-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B7AAE12D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70A687BD649
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A7528BA8B;
	Wed,  7 May 2025 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LZrSpSUv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7EqsxqrY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5D28B518;
	Wed,  7 May 2025 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625463; cv=none; b=CAEH+y/cki/IduDf1SeAddkdGK7BC8DK4zmfubCBZ52Yus5cB0YFSrIhrPsmsIcvu95WDhW4np5/ScF7YSQSHE2wMd1Z9VQtDXzfJLvj8tgo1ONgK2CaMSGMpOMWIk0CnJZLrL4PyVObWlSguBkhMZGLKR+lG757SMtQEShO3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625463; c=relaxed/simple;
	bh=OP1oBoVV+2BOIgqJLp/iQ1+OFRqHFdllNfXQIz+9L1w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HG+F0Q7oAPkjhcoZZ3I1D5ERuxv99r/3v/MEaAt+e+3IP6V6udbx8In5UoTTbHbSLJf0sX4ehULCyTWajT2Q59rAhloRNH1y92yuq2bF8FkU7JrKpFzViRM7ZnPqBd8Bp03UXN27hAVjN93mduP3/JyC+s4TWJ1diGLbZ50i1DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LZrSpSUv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7EqsxqrY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQaPSipvpLzA2iucLt5qL/5wEqxzr4fRwcGIa2u4e8Q=;
	b=LZrSpSUvfiGMI70QycAJ0pvQHvYPPugwJk6F2Z8DrWCuzch8V/004rjIwlC3MejZDRzKZp
	rE4v+rrJiDJJWbrv9NiArWoEhTTTuFUecg1W6PDFc7oLYe4DSVrygKAdJtSpkncJOBtCCe
	k4Dq+Pul46HIzjXUH14Y4VSa7EyDTY0VmKjXvbp3oX8rvEHJHkBMm1tWyPVKPqxxrs0E9z
	yFggVNkZObB0DqBoNbPB8rtWIZujnDI5GLGC/7VvZX4pvdVzWEahDpLwOnRwj/lVdVC2FE
	tmbrOs17gmlX/q/t6P9+n3NOgesv+5TojiHbk3ua/NTEJAfqGHt7Mw/uA5VpEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625460;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQaPSipvpLzA2iucLt5qL/5wEqxzr4fRwcGIa2u4e8Q=;
	b=7EqsxqrYYPX2LeL426jRLJtQWcS++uzS6Lz9MdxgnWaefBSgK3IRL4Ol/O1mysiDQmT+We
	LBd809JeEb7aCHBQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] nios2: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-29-jirislaby@kernel.org>
References: <20250319092951.37667-29-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662545919.406.11798592673296156126.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     c7d6eaae6009b89019225ccdfb550832caad8d86
Gitweb:        https://git.kernel.org/tip/c7d6eaae6009b89019225ccdfb550832caad8d86
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:40 +02:00

nios2: Switch to irq_domain_create_linear()

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-29-jirislaby@kernel.org


---
 arch/nios2/kernel/irq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/nios2/kernel/irq.c b/arch/nios2/kernel/irq.c
index 8fa2806..73568d8 100644
--- a/arch/nios2/kernel/irq.c
+++ b/arch/nios2/kernel/irq.c
@@ -69,7 +69,8 @@ void __init init_IRQ(void)
 
 	BUG_ON(!node);
 
-	domain = irq_domain_add_linear(node, NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(node),
+					  NIOS2_CPU_NR_IRQS, &irq_ops, NULL);
 	BUG_ON(!domain);
 
 	irq_set_default_domain(domain);

