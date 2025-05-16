Return-Path: <linux-tip-commits+bounces-5606-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7443ABA40D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04011A27DAE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B32286407;
	Fri, 16 May 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XRcTwPY1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rTlw6lU+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6FA2853E8;
	Fri, 16 May 2025 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424258; cv=none; b=SuBMGPwG3OpIrHj82fGYSIohgHvZjpry5fK3jGQ8+NHhp3ahBynzci1W9BkjPDZX9IzfESr4T63ZFTmdjv8ONJbaGG1tYSx3J7JCtozDdozR8+Bwys4u84CliUY6koTXR9sDvbqPVd7eCOXTfDd/FtrcBNWz8xcidMr479oGciQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424258; c=relaxed/simple;
	bh=7Z2Uw4RLxiWPVAi21OPuHCTqEY9gmx9XH+BrU3GtMxM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fQeIOJqn8YOKwz1IirvyyKz1Uc0oI+u4DIxCqehjBAjSke5zcGuMSaNna1xb+SD5Mkt0yg7pQ85sNRZjzY1b4cdjbVs2C/ip0q4n73UmLgCVAwR/krHZEWFHB4GtGvi9nE/5n1JiEOwP1XCBNdyarHB5mFlroAo69yYJ9vugE58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XRcTwPY1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rTlw6lU+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoQlewqoqvDkBpwdaarv9no/fWopZ3a/6snZumFC0fw=;
	b=XRcTwPY12KuC5pdoONGt5t0RdwZki9uvGATh6oZz/Sjx6rZ8JvK0SFMoUnqzq7hnlMzwGM
	46uqsRNDW69zLmaIGe81FhcpSAtRg2M8x4oeDHec7jhEB18xI+WZYA4ktfes53aQf0HfVM
	euRF/jYMuutdBPF7pJtEv2NoItLMJ8VnsOYAwIFraGTGLS/KioeFwZogaWq5ZkIRquhm4q
	cYD0Dv/D1rlrO0DH/nSdGdcQn0FjfPjt8qYMnZ/zMe1q6QoFwVTSfz9XkMGST1cOtdRbWB
	4hEXAYZpC/bN6V8NLj0xQX1JiYEi471Qqn+Z7yyzGFa1y30MuCBqX01Tj8Q5mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424255;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoQlewqoqvDkBpwdaarv9no/fWopZ3a/6snZumFC0fw=;
	b=rTlw6lU+pObEhDW/RheQ/khG/gvtup5Z4V/1NOllvkb+y9ATwLntiOSFpzZsmf2F2x4m6D
	kVq1/giNU6CDX/Aw==
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
Message-ID: <174742425427.406.15594238736693826673.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     e9bf22564413c489275a01f184e90cc457669881
Gitweb:        https://git.kernel.org/tip/e9bf22564413c489275a01f184e90cc457669881
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:10 +02:00

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

