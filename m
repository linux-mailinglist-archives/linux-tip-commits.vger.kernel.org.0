Return-Path: <linux-tip-commits+bounces-5377-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802BCAADAC6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED1D34E77F3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D9F2356B0;
	Wed,  7 May 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TD4mwFf9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rEH8f0AY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899AF233D88;
	Wed,  7 May 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608848; cv=none; b=kfOpADH/1sJ+EEviZ47y8nb19Mgy051rmgyQvhCOwwqxzYQlpvli9vAY9arNTj2mes/ANaTyl165w+zZXQQBD7MaNQkfUwASxLP56Az28oedQcIvG+fBVionLwoYOoa0j6q/SlQ5LFUMlpTqUWEXzhSLHz+Cz1aKFC1yffAWiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608848; c=relaxed/simple;
	bh=VX2S6lja5ZbVcHZc1mUyssIYH5e8AHhyRM7Jlk24zYQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TRKKGK9bJ6rmXftylvT3XgxjpLoxNBdO8TKY80TIyHhxLfnukXdGsi5gXyLwGY9ZwSLxuM6U8kvJMlwNJ9S3+VWDFPrlTTBFlOf6fev7PHXOLRC2uBQDPiuPci7gGRKwxNW+EzrV3vN0VjW7UEzVnITvotEXJohHa6YPhdNcjUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TD4mwFf9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rEH8f0AY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPCl88Jkd134MgQ/ExD5FQMnm5wnjLLM2zlL5sT6scc=;
	b=TD4mwFf9THwy1wFKj271uCVprb2MJOc7lE9njs9j20wMLCgsA0wQzSLni2bbNx6LUpzBpz
	prCA0UIh6sQH5XP3r5kkVXzFnj0mOB2aZ6OeKU8k/iuAonH2Vm4a/3L5b552DwZT69X5tc
	j6GMtLDWOihotBOXmmpZ4cgs/T2gDrS5KYqjWbZ5qIC7gS9NDVBzW9MBIyJIa6+QNERBzk
	3sxGIuvalIYdrIm3Pdi5uk07n/Fjf07eWfnCawiWsdVrqltd9xZgj0fVmbFqrsEZ/Z2se7
	L/kuHdEBQTFYUm7LpwV4wovE5eSOeCATTKbCk8uIk+wWEcF8StrzFHaV62XFYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608844;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPCl88Jkd134MgQ/ExD5FQMnm5wnjLLM2zlL5sT6scc=;
	b=rEH8f0AYBF1bivKoeBr21pzjoH2vwa8C+1oZ4cajPndMUgR4JgtYepl15s0TlSaYBRZgnT
	3pmc6xQweVC51tCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework irq_set_parent()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065422.258216558@linutronix.de>
References: <20250429065422.258216558@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884395.406.11099834875422739763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     90140d08ac7a1e1ea3136132e1fab9baec174c25
Gitweb:        https://git.kernel.org/tip/90140d08ac7a1e1ea3136132e1fab9baec174c25
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:15 +02:00

genirq/manage: Rework irq_set_parent()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065422.258216558@linutronix.de


---
 kernel/irq/manage.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index b6f057a..a08bbad 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -959,16 +959,11 @@ int __irq_set_trigger(struct irq_desc *desc, unsigned long flags)
 #ifdef CONFIG_HARDIRQS_SW_RESEND
 int irq_set_parent(int irq, int parent_irq)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-
-	if (!desc)
-		return -EINVAL;
-
-	desc->parent_irq = parent_irq;
-
-	irq_put_desc_unlock(desc, flags);
-	return 0;
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		scoped_irqdesc->parent_irq = parent_irq;
+		return 0;
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(irq_set_parent);
 #endif

