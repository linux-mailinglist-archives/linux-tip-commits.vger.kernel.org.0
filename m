Return-Path: <linux-tip-commits+bounces-5424-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B283BAAE100
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5BF1BC81EB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474C528982F;
	Wed,  7 May 2025 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fkko8bcG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2ODIFELZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852E728936E;
	Wed,  7 May 2025 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625451; cv=none; b=G76GhYAcvVKiEThQ/O79V01xh/jFBroWAEJruasJUecuY+DZR3lCn+owGJWRAAMhUc/i2Y/JDNiLfq/98dLZWdb5vQKplbpYyvGAFa0YunmTb7d9a7DpYlq0ce/QnZqYGk4ZjuKHydTLtbWiASy96hNDLKYsa2H18A4xZ+suL28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625451; c=relaxed/simple;
	bh=9TehTs5us6mzxbEtgjkzTCs96vS0vzjub9VRS1mB/PM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=abqRUVAIy+QQaZpS+jlgK2+dfY99Yr9gYzPX8LpW/b1CrP8+5o15rYCmscUcDagbPWKPMCkd4AwYiUnwbOpLRnLzvZ3zLJEDe44buqONHVeNXfW1RbbkVvI0Mr7nRjDw+RBJHixy/Bt4y7N/9RtS66+RqI2VN/DAEpbCHZ2vx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fkko8bcG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2ODIFELZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625448;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46CLHiZos8Q+gmXrFj6929scDijYeCCwk/eJ3PEfst4=;
	b=Fkko8bcGkLQdbVpSc2QXHBRKEUYsElkj7kj7mioWgTxaLyYgoJjz4AdUKmYgdB/RxmsICK
	73+aR0KpWYnqdvTuvgFgMRsYnx+BeY0G5SmLl4vN/ikQgsRhpweBJY8Z5Q8DKBTjNsfmf1
	beUIQ0XWCs2f2iqvtBZXtd0eDxkmnkD117RT/u1bDtjql1ljewiQVlyTKMKbZ1+u5w9ka1
	XX0AiMqEeh/efqYRYstKi/em569dmzXvRyVYA1ObqETb2RhVC9AtFhAxiY5kbQYXOvYncp
	QWZelTMl6P/SZqjwy16Oudw3fNlZW7pHvKu/JrwhPkYZR0iPfK/4LdrZ635e9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625448;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=46CLHiZos8Q+gmXrFj6929scDijYeCCwk/eJ3PEfst4=;
	b=2ODIFELZX088mONxa4dOOJCiHHL984Yim3Ib3pGE0WrPt5K6lr1zeVDlGYG3h7JCOyaxzc
	mJHVZYmzvc2LGNBA==
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
Message-ID: <174662544737.406.5642413979723406365.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     91854572f918c0f88d39a7013731dc3b7d3a1cf5
Gitweb:        https://git.kernel.org/tip/91854572f918c0f88d39a7013731dc3b7d3a1cf5
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:42 +02:00

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

