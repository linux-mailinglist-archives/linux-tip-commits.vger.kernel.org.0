Return-Path: <linux-tip-commits+bounces-5274-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2DAAAC5BE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88B39520960
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC729281529;
	Tue,  6 May 2025 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ud0ZLekW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LtUTA898"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC458281357;
	Tue,  6 May 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537621; cv=none; b=uDNDoNvK3BpxYxqCYz9225IcAG79H3vIPpNLF2T1i6xBLMvchvuMoKeQRLsavktizq81OOmTZLqyFUpO5aDnn8A630t3jt58DPfh8pmruLaSTm8lbrR1Fz6fU9Wx93lW5htqzD5WJ97U69SA8VNMRTIsD7Xkggi5BQRrHNBpvTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537621; c=relaxed/simple;
	bh=4buGsWoDyt8JDIIzhV6y+f4YaORuBhjx9zQn9i9Dn/I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rS+OXAqnljnFvAhUHe+7M/YQl0s11kMuPEeqCyi8tOQgFx3oAX97ZxL+QeUAQJZTmas5XQUvR8QL8XIZbOZz7xiRUKXHzNRplS4FdV7rMxlxnE1kt+33LCFCsHzS7CzDosmhzSP0JYH5JiQqKs+vx8vCXKewmWjwaoSL9Z+B8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ud0ZLekW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LtUTA898; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmnOaup16FLaXd9CYMDNncK3Ek1+YiH+rZ5iFVu4KqI=;
	b=ud0ZLekWFw1rtYdbUa+2+4eDvZlNCwIKw8yiEmOuEmgE+lfLwi4tkhadTreOOyxHKpZI64
	DHiUtHB8II3jXG6FbGnnEc0DUoy9eSEiigLq6a51sHE59T8lTy6RoMTSktdCmP9+uvSjsg
	5UpgvbRoaFySZTqddqFSGsbwU4kd+P9Rr61UtLn8bWrakI/0HnR6729ybMl1AeUPB2VzCQ
	QzsRADyX5CkRASznn8OLYO+hOeMyHeSrqehn5XwTrQAkdPapWy2Rv94ZQ+gFlEqpZrBNng
	Zt7w59+hpyF6x5m+HI3G2g7V3VoS8ThZYdybg7h4Xpwe5eb0C/CEq+FK1w/Hkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537618;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EmnOaup16FLaXd9CYMDNncK3Ek1+YiH+rZ5iFVu4KqI=;
	b=LtUTA898S1yZ0vHDbmnyIagPEpnOcS89fTSWVXhlmtcA0ktFx/zv4EFWpheuUmnv7vq+g6
	BW7L++8Za8P1FqAA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] irqdomain: Make struct irq_domain_info variables const
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-52-jirislaby@kernel.org>
References: <20250319092951.37667-52-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653761733.406.16139342821848404669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     d206007c2bb99da5241ad60222f71d058cce6f7a
Gitweb:        https://git.kernel.org/tip/d206007c2bb99da5241ad60222f71d058cce6f7a
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:08 +02:00

irqdomain: Make struct irq_domain_info variables const

This is just expressing it explicitly as irq_domain_instantiate() takes
const already. No functional change.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-52-jirislaby@kernel.org

---
 include/linux/irqdomain.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 1e38584..66a26df 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -396,7 +396,7 @@ static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handle *f
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	struct irq_domain_info info = {
+	const struct irq_domain_info info = {
 		.fwnode		= fwnode,
 		.hwirq_max	= max_irq,
 		.direct_max	= max_irq,
@@ -416,7 +416,7 @@ static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	struct irq_domain_info info = {
+	const struct irq_domain_info info = {
 		.fwnode		= fwnode,
 		.size		= size,
 		.hwirq_max	= size,
@@ -432,7 +432,7 @@ static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fw
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	struct irq_domain_info info = {
+	const struct irq_domain_info info = {
 		.fwnode		= fwnode,
 		.hwirq_max	= ~0,
 		.ops		= ops,
@@ -548,7 +548,7 @@ static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *
 					    const struct irq_domain_ops *ops,
 					    void *host_data)
 {
-	struct irq_domain_info info = {
+	const struct irq_domain_info info = {
 		.fwnode		= fwnode,
 		.size		= size,
 		.hwirq_max	= size ? : ~0U,

