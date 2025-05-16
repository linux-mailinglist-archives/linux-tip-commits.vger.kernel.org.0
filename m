Return-Path: <linux-tip-commits+bounces-5589-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBD8ABA3E9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E59A23DD8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2B280308;
	Fri, 16 May 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0C8+f9E7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HHbuKYsI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB2280002;
	Fri, 16 May 2025 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424245; cv=none; b=CT1GhyzbRL4tCcpFC1xE+l/CFvuo+tpWR1A9AB8e0x7HAZQEr0i+QcT79LDeB7u34KWdYKR4yfcu6AN+CL9bP7hLXTlNeMhZSgqzU6JPW2IfdqpwEp2p2PI9z7kzMmiqC4PvFEo0+Pv98Of2JFl2lQQOx0QvYHZb4HjFbG428Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424245; c=relaxed/simple;
	bh=tEj+iJLus4sUWV1mNEBhVL5GdchrdvPovMwlgo77BDM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gKdwvU07W7LP2EpywXepmSregx+8ctLN1fgHOdtxRr+j1/j9x2yZz3I1tY0/r9k43IwpSbnHUjZSgSOHf0GekgKdq2ed7U6tsKiMMZsMVEwI2SMl721LyLgiLqDtZ3Ny49Ey/8eOGSEYAo+V5lEy76kofLox7gAEzS/UibW8EtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0C8+f9E7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HHbuKYsI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kchuLnzhr2q0tiEx/kcQ1dtomanYUB2PkaqkidzgF80=;
	b=0C8+f9E7jfBAW0wRGsRp6c4NN7Tf5naivT+/8SS9WyMmozDzHN8Rz0vLZVOV+p06rHmgaV
	ryKwL/gZPWbBriXTAUPWTQ+hjB/WMO1AC+qhJ5juX8+tDhOn+F2BBPrKWOyy0xl/rmiVKr
	R8pCTQe5vjuQD4HrjSV54SaxcWuKXmLiMaF7bITnroYriUjBY8ETX5QP3kKYi78C2NU2fj
	a2zeT9m3+B2XW5EQ1WOo4VuPsLo8X417lXOAdcbvdNCXSdMO3VS98RmPhOdMCqxK4/+KCN
	xJBeN8kPvoezw+onlM3l/97jE0rW0tfv93I7C10hrhGj+cBUiO4Eo5W/hgjOhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424242;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kchuLnzhr2q0tiEx/kcQ1dtomanYUB2PkaqkidzgF80=;
	b=HHbuKYsIY8CCK0RU4fjx962OF6iIsWrj1Dp5W0Uv6mxBRQU7Ln9OMgpsO1Ey70ZhA+XNKi
	P+nN50rXRDlvphAQ==
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
Message-ID: <174742424156.406.10852836547689045402.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     66cbf17fe67156608421e717975c415a85c08466
Gitweb:        https://git.kernel.org/tip/66cbf17fe67156608421e717975c415a85c08466
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:13 +02:00

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

