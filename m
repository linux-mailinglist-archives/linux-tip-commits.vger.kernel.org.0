Return-Path: <linux-tip-commits+bounces-5331-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45BBAAD970
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133743AFFC1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E362236FC;
	Wed,  7 May 2025 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="45QU5xqP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2gxyegyy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B6221FDB;
	Wed,  7 May 2025 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604674; cv=none; b=Ju+9fPR3R2+RwFolxFc7gnLpNdGkxAb1XxM+lBkZcnfzZBX0P8K+vwEd2IEhgEkwDm3bW8DVZaVSRBdhlJ3c5IreRfq0DTPGqXpuQouZZ1Up/a8KWVDPY6bwFRkXN41MhbmF/kW4SRSxypIoeffBy7sBpSXJnBQSJ+VA1Qd3nxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604674; c=relaxed/simple;
	bh=eNrnROEBVwNrHqjvZfvRtYNTjpLgvlj+/6LkAOKkOiQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GFG0G0DF3gcjKtO3q5ec/OTSGE6LRBWJfhQJ1/uGkVWuXYlA/SXMIA6GWG84Hg693/ZB1J7NFpeoRIOYEvyO3L8i/zrVlBfAYIJpqjTUeCMsmjC5fJLKyQPDfikLtvCD1posBs7qnABXiOt3d0dVItNGN674Rq1rN1iajFJmDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=45QU5xqP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2gxyegyy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:57:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xrwef6L76zJIMzE9tetXHojPfolpJ2pAXPQiE9G6QgI=;
	b=45QU5xqPsoiUcVAXLDxEVfRa648Ao6C1XxBcUNOyIPPQAoqAMUgrFE3gK2+bB4ilFgQ75E
	LXcZwbapUb8m+Q0IgWjZ7rG9FwATh/HrlhKgKnM/ZUUeF23mnoFtE3+NUe1fLp1/InwaNY
	fmgzeM0iBlKdfRgEzGW6wI4+myo67BPDn7qWiSWm2zNPVCKO3UZHoJiSOPyJfUVAbCLg2E
	qdJdwpPmp4u8vxqc0YCEqA9HnT0AImb7KmUa8qb3VE5oWmdN715EeCaAO6w0y5R9+ZFNyS
	2FuR46Lv1qg8VNJ05c1pC5aYiS3HdxI8rUH+NifdNmfCh4QrTHBsfjiIP6W+ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xrwef6L76zJIMzE9tetXHojPfolpJ2pAXPQiE9G6QgI=;
	b=2gxyegyym3aHxIHlbHJ15ugQyN45ZHERddx7UZG1Eovgy2LaVUUdCyYEWA11QQipW3u2/W
	c1pemK9wMHhlFbAg==
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
Message-ID: <174660467052.406.5620382634619871629.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     43466b23b056a2478b97ca6594d839a9336b465c
Gitweb:        https://git.kernel.org/tip/43466b23b056a2478b97ca6594d839a9336b465c
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:25 +02:00

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

