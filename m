Return-Path: <linux-tip-commits+bounces-5347-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C437CAAD963
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD436161EE1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4762722DA1E;
	Wed,  7 May 2025 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MvEO1L9a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GdS4Z5so"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7522C22D794;
	Wed,  7 May 2025 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604687; cv=none; b=A5Z0E6SFPmcv/f/maV3JWgujQxkfpKfv4fn9LzNlvowxEkymjsUezZYJkHCeuTP/4wgjuIfQghdBcSmm3c939vXvYO1hgp6XF6JxVB3u8UuCVUGQAv7+KfHqbUPmIAo65/q33gCdXwbMATumMDjvWms2rNAJ1leG97iMiBPAoeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604687; c=relaxed/simple;
	bh=8xCq5AOQ4fP+CDPys9f5AUlYm7dsXu8bYs1YJlIK78g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QAqn2d07v3SnAKC9MTWRPl7Q4Gkac9SpGzTzNdIF5+zE05LRuWhJQcizIruA1ruo9gsyqDbOByT4Ccd8gTXuW78wDzVr17U0N6K1dNDFQ0ZXXsTU8g9Kb1dPdX7OD3UoK1eDEZw4DDPBndSV1FluSeIlc/bY9esKkATgvhcpyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MvEO1L9a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GdS4Z5so; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dG1dPqZBUuHezEeA4HOJDtmT22DW98Tbh2v/oHMxaQQ=;
	b=MvEO1L9aiSAHHikRMwcUieyG8aBkaVPdGtOpHq6YEf44Hk/qR0e/XdY4zd7GzNqzMSQ4J8
	7gXI2lcn7uEBKgViVCMJP+1EHx3II98f1enTzPjk3KI5qggtFy1VEIXIJpLhVmTsJAey34
	fkzfF3D5P6dfrZpGNMxluZmqi5jXWmkme69W1ZDh8X+M31GhA6j0I5lXhwGLVp/1ttjVAK
	lSFxWduty6y1YqHa0qwMHatwq9rU0HivB/W8h2BPlxHWWa/hH2I/O+5jJf7rvDAjgwabPx
	BOoUvZ0avx/PoGDoigqHu8yj5wh/xUgAMnke5+Iy56SzRjp/x7jBfCzI7yTmuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dG1dPqZBUuHezEeA4HOJDtmT22DW98Tbh2v/oHMxaQQ=;
	b=GdS4Z5sogAWyJFhVTgBspHJSrRVpe1BMjOMxIZFOMRAieWOEkpILy5Gq4CKPANbC5h3b2H
	FW5qYqR/T0XFFOAg==
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
Message-ID: <174660468318.406.14694139099563404271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     6013f019b0cd0080fc4367ec5feeb0cfecae29eb
Gitweb:        https://git.kernel.org/tip/6013f019b0cd0080fc4367ec5feeb0cfecae29eb
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:23 +02:00

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

