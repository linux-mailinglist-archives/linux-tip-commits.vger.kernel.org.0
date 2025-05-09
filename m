Return-Path: <linux-tip-commits+bounces-5516-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16D7AB1CA1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 May 2025 20:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219EB4E711C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 May 2025 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CD723C4FD;
	Fri,  9 May 2025 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xL4N83Jg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SMAcjrxt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D528723ED5E;
	Fri,  9 May 2025 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746816564; cv=none; b=IUlpj9KrFpWwOpY2Y7U12VHvA1mD9mUiT7xKwEIuokoLoKcPvbx7C9bse2/ZcA1rt7o4/tbonDpbTzDBrDUBgpqC4ADI1ldT3HGUcKLNk/Ccp+thPuTRGfxJ8qFG1TIgSAT4S54i3e++BF1iDE29FBT9w7BYzYsge3YFTr93SvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746816564; c=relaxed/simple;
	bh=vTm1UPAYBKXj/NtunEqp0VH16i8irWFyVFkAUSPo0QY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=sW44LE+q6wNbBZ1sQmVULIK//4Xp5hxfGwrcgga2GkOWlKqsQNZcdUZFfPYWLo6lz5Ksw4Bvgh01UE8rFQD17cLDUZziVQoDIoj/lGQCYrjOc/s8ifmdGGcVq/QnJeGvlLehRzApmkAU7aYXqau1e7p5pPYXOQA9L8/lE0POgj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xL4N83Jg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SMAcjrxt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 09 May 2025 18:49:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746816560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Av5RZLI0gkZU85yW1UwoZiS9zvo6O+KA2YoViJunh6Y=;
	b=xL4N83JgQFAV/o2hdRewppCiQzI3ER23nnMNDN8z8sYvvznIS+23D2R04DMlbtfokQYVnR
	oa2wASfY3x8WmBdQJnYb4J5eJqg2eJQchrzbwFlkVFuDMmAjsTiBWZ5BSqVZCfeGeQLpSf
	6EB1z1IriJbUkkvJ2n6ivkEmYPDdq7eiGjocQdh4/TOGYQr5vi9P8tPjdhbAI//jAV5N6Y
	/hdnU9LMsCwx66+zNaDg0LU93KHsAtbJK/5ddEEZGvTmjBfNKSlTSBKkt/I2BiYmnTIXQ5
	pHfbXQhbFg04/3e775IRE4UGVhfH3gVifKcj4BkY6cBMIjKQ65JTxzmsxClnHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746816560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Av5RZLI0gkZU85yW1UwoZiS9zvo6O+KA2YoViJunh6Y=;
	b=SMAcjrxt2IvQC1+JgG11oZf6K6VqCxU3ya9q7TiHZmTUO5N4wzSNR2zDhAKGasumjsUrSb
	ZVF9AbV3Yrfj0zAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix inverted condition in handle_nested_irq()
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174681655962.406.11707812475471138588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c1ab449df871d6ce9189cb0a9efcd37d2ead10f0
Gitweb:        https://git.kernel.org/tip/c1ab449df871d6ce9189cb0a9efcd37d2ead10f0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 09 May 2025 20:37:54 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 09 May 2025 20:42:26 +02:00

genirq: Fix inverted condition in handle_nested_irq()

Marek reported that the rework of handle_nested_irq() introduced a inverted
condition, which prevents handling of interrupts. Fix it up.

Fixes: 2ef2e13094c7 ("genirq/chip: Rework handle_nested_irq()")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel/org/all/46ed4040-ca11-4157-8bd7-13c04c113734@samsung.com
---
 kernel/irq/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 865cf74..1d45c84 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -497,7 +497,7 @@ void handle_nested_irq(unsigned int irq)
 	might_sleep();
 
 	scoped_guard(raw_spinlock_irq, &desc->lock) {
-		if (irq_can_handle_actions(desc))
+		if (!irq_can_handle_actions(desc))
 			return;
 
 		action = desc->action;

