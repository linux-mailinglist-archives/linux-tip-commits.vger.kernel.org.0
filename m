Return-Path: <linux-tip-commits+bounces-5297-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B77AAC5DE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B4EF7B3393
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E36286D73;
	Tue,  6 May 2025 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iJLUu8cr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ll8oEWsC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F5D2868A8;
	Tue,  6 May 2025 13:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537637; cv=none; b=acuRQ1/zR2pIjLklbh8TFQL1Yb/koMtMAlSDWt/2dAt26Lfpdmb218fcCmr3YcEUT2nW9T7oTFy18bPiP6bEhPINDiW1aTvVW+mzfReR0q3JhF8XaYLfHcqKCSlkXgsyU7Li2eWD4tGAXOsAXYAmbBKcuOsf0gEpcE9I95pdJbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537637; c=relaxed/simple;
	bh=myxmDfk9I6k9MrFTssoy8dfjRiz+d92T21eaIR5VI4c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Isn29lB/iWWfmF2ynBTaw/MdOZl1lQDYQJWTy0dxaagDZtLMNTVzO2Gq1J25OhhD2rktyOnw21WV8rkWANOIlBiYF2TDmI5sQeYFFhtgbU3C5112iGyjOnDaFvsXgRTmRzG4wKYag+jwqOHM0+3IRJ+K/zHLpiItAkmVU1jv+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iJLUu8cr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ll8oEWsC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1uxQ2YIgUJUhJOKXk6o0m+MTYj6vdFMRGl/yjSImBM=;
	b=iJLUu8cr3oABJKd164KN6aFPnKUsxEAkXNNK6HSXEv7lVW3FIqzLHxijQ9/lvry6gpAoPf
	iWkLlfB/xfvRfLT8YcLBqSxxnqVqXBpemd3Owg42j5kAzILzwG+4ckisKJ/FidGcDyrwCq
	/m9T773MO32XpY/USeG/XYUllNFbZwf6/0zIMUm387Y7+qE99nDRxoLQv51cOJksRx4txs
	sq8eMWBxX9m42/qJCbevTH6F4Yy0HS9w8Q6YNa6j7lEuGdWaZ6RDFJbUX1OChuBcgDUZpm
	nVp28gB0dgS1+tAw7EGjZka6G8fpeSQaMSskLIV7we4cQvcWPEnPLiwuLy8wwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537633;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1uxQ2YIgUJUhJOKXk6o0m+MTYj6vdFMRGl/yjSImBM=;
	b=Ll8oEWsCOV+qY0bj7g2Pcduq6OXe48zMHSAkl9xi4dlPPO2/LMHY06v3qthwpwz9uF0qsx
	G/SteRA3m55sujCQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] mailbox: qcom-ipcc: Switch to irq_domain_create_tree()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-23-jirislaby@kernel.org>
References: <20250319092951.37667-23-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653763294.406.8024375207538333252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     5c50b162e2278df1ed5f27cd33f54b5b8983e414
Gitweb:        https://git.kernel.org/tip/5c50b162e2278df1ed5f27cd33f54b5b8983e414
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:05 +02:00

mailbox: qcom-ipcc: Switch to irq_domain_create_tree()

irq_domain_add_tree() is going away as being obsolete now. Switch to
the preferred irq_domain_create_tree(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-23-jirislaby@kernel.org

---
 drivers/mailbox/qcom-ipcc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index 0b17a38..ea44ffb 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -312,8 +312,8 @@ static int qcom_ipcc_probe(struct platform_device *pdev)
 	if (!name)
 		return -ENOMEM;
 
-	ipcc->irq_domain = irq_domain_add_tree(pdev->dev.of_node,
-					       &qcom_ipcc_irq_ops, ipcc);
+	ipcc->irq_domain = irq_domain_create_tree(of_fwnode_handle(pdev->dev.of_node),
+						  &qcom_ipcc_irq_ops, ipcc);
 	if (!ipcc->irq_domain)
 		return -ENOMEM;
 

