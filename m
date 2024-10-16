Return-Path: <linux-tip-commits+bounces-2470-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C399A1328
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C992820E6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4DD1C233A;
	Wed, 16 Oct 2024 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YO5Fsjha";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cIo1ks9J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAED199FD3;
	Wed, 16 Oct 2024 20:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109049; cv=none; b=aXPtJuxboybkwBa98LiaKv00/RCVG2iey3UhF5Ufo6nt5oKJytGk2I8R9GuIs6c4wwqNh/kdYarUh2tjNo++b4s0n0pbRs1d7eprmseBa1CFs3J5r0ps8+dmq+FDebgnnGFCCpGxQCOU3V+Rz18uGeZo3gCLjw323iFsXsiwRMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109049; c=relaxed/simple;
	bh=TazvZvfMGw3d6iUgf0oFLct4QIA5z8XABPM2Bl4Nnto=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AOMU1ixmWhrJk3xpJtRONtL0/lZx26v0pw2UqJZsAa7NRmARFRZBNfPr5LWdLoB/UfoGiKUf93IeVIHLMuarVrDJPeU6IWqH06i2Jj+9mruYjlxvYkUp3OB40MgtX9XYFl3wih73kPfyEbDLv9OmfdCPxQ5k8XFUPnkFP8wtp98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YO5Fsjha; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cIo1ks9J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+o6OhBhcVnvBVZUoowoVL1Op2DvNzlYhBK47boldl0=;
	b=YO5Fsjha/DiTxzaZ0E7zE2jNPd3Yui8P3gn7QPjDx0DodqHGQLbutc8yWunV3fC5yU2hog
	2axo1sHFYEg5PUxVeMK1SxDdGKbhotzSqu7MCTLhjQYN81noNRmrYvdbLu5sNR2SysGvZA
	LMMxmpAKwcLIdsfGQrbL9Y2kBvjLwQql06D440kRhVRCwYb1z2LjOd5nPHO3o8pxK20Jnu
	4eV4GIa/BMsdf1DyEw33qEGoQVR7gYmqlGdRLJYZmCXvvK5+z7dZC/Es9ek7bHtijNQje6
	S7k/BN/fbSEO+a0EXbGhcpvDRtyAKKWD8uOD8zpT3B3d6Tdp9HJ7k6N7dBJqnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109046;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z+o6OhBhcVnvBVZUoowoVL1Op2DvNzlYhBK47boldl0=;
	b=cIo1ks9J0QmgkRzTn9HPHXWO+/2UO4Zu4CtDf6fgCJd2PzyFmvOdYRmiRgpOj0MxEK5FQa
	MAo+ZJv4KMeySVCQ==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Unexport nr_irqs
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-23-bvanassche@acm.org>
References: <20241015190953.1266194-23-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910904260.1442.9062571062865319567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ef4c675dc2961ee533bdc1ea20390761df0af5be
Gitweb:        https://git.kernel.org/tip/ef4c675dc2961ee533bdc1ea20390761df0af5be
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:53 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:59 +02:00

genirq: Unexport nr_irqs

Unexport nr_irqs and declare it static now that all code that reads or
modifies nr_irqs has been converted to number_of_interrupts() /
set_number_of_interrupts(). Change the type of 'nr_irqs' from 'int' into
'unsigned int' to match the return type and argument type of the
irq_get_nr_iqs() / irq_set_nr_irqs() functions.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-23-bvanassche@acm.org

---
 include/linux/irqnr.h | 1 -
 kernel/irq/irqdesc.c  | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/irqnr.h b/include/linux/irqnr.h
index a33088d..e97206c 100644
--- a/include/linux/irqnr.h
+++ b/include/linux/irqnr.h
@@ -5,7 +5,6 @@
 #include <uapi/linux/irqnr.h>
 
 
-extern int nr_irqs;
 unsigned int irq_get_nr_irqs(void) __pure;
 unsigned int irq_set_nr_irqs(unsigned int nr);
 extern struct irq_desc *irq_to_desc(unsigned int irq);
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index b073395..479cf1c 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -138,8 +138,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
 	desc_smp_init(desc, node, affinity);
 }
 
-int nr_irqs = NR_IRQS;
-EXPORT_SYMBOL_GPL(nr_irqs);
+static unsigned int nr_irqs = NR_IRQS;
 
 /**
  * irq_get_nr_irqs() - Number of interrupts supported by the system.

