Return-Path: <linux-tip-commits+bounces-5319-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68284AAC965
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 17:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3ECC9827B5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71502820DC;
	Tue,  6 May 2025 15:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZsawMpd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8/VckwY3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353DA2836AF;
	Tue,  6 May 2025 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544971; cv=none; b=urdAjG739fgnyXM7QZQQHHpwK3uUIUa/G3V0iRwNy+IgF82q+425HB1mCTxh2rQwuSNeVRjpcnORzY739cjKn5FpcTqB5wwSZJ4yGSD683PZPdwFBwWqvYg+gl//ZMp7ovEHjXimpRwCT9LArMtNANMEfd46h82y8dEGME4Y4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544971; c=relaxed/simple;
	bh=vvLwrt+vR8KHLhF3zpuPlP67S02q3KQa9oHQBX8soNQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B0kpgICE8ozVhq7VYTGqtAiACUOL4+i7bCnlSNpMV+CNc2fDOmmxuP6dFsq5SyHx/3BbiOBkWfd1/8evz2kk7NFJS+necrD1qliWQujUJ/8HR983LyUCS7XYNtsHJYeheqaQsyFZje8IGbXZqKgBgFD4Twj5CAjhsnexR5Vnuoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yZsawMpd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8/VckwY3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 15:22:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746544968;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tx71nHvpttGOnY0SJJXKMLEcYMq87pb/1N+QB7oyqEQ=;
	b=yZsawMpdyq+qoUi9/1CnjwDslG6nxn9NMsqOFbxS0m9cUiaxqZwZYROcqfIchXHRJxvMZe
	7f9DHVLYuao4DXWEAvuOhUWf5QZkgGiYIz9PSgyoh+cuCmjf8wt/s7n+H4cG5QpKGJlcK4
	L971OCwpAjMPzgt2sG49z9ExM2u1x3v0sC4ZjcdieXQjXL3/cpsTqcpkPQP8eyTNsKbS27
	GceEkrcnIGFm9hCVBqtBo+9XsmRaicem/hDL8swvDCSpFLmpzfQzN/Dn2fSYK2meGj/Bg+
	rZwV0ImePfLlHiOBxhFQNcHsOSDnuUWeWC9b3TLNQG63R8EpyrnwPvNOjlr55A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746544968;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tx71nHvpttGOnY0SJJXKMLEcYMq87pb/1N+QB7oyqEQ=;
	b=8/VckwY35u2OyqYTQOU9TmyURbJMi6l8RKNdjFA/PWRX+fXBNPzT302e4HcNSUQVKf+Ep6
	dlzMg1dXBZypQWBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/econet-en751221: Switch to
 irq_domain_create_linear()
Cc: Thomas Gleixner <tglx@linutronix.de>, Caleb James DeLisle <cjd@cjdns.fr>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <877c2top39.ffs@tglx>
References: <877c2top39.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174654496739.406.10029798982347531476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     85cf5c63d32f39874d0dc1cd6c12b40e1ba8370e
Gitweb:        https://git.kernel.org/tip/85cf5c63d32f39874d0dc1cd6c12b40e1ba8370e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 06 May 2025 15:17:46 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 17:18:31 +02:00

irqchip/econet-en751221: Switch to irq_domain_create_linear()

irq_domain_add_linear() is about to be removed. Switch to
irq_domain_create_linear().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Caleb James DeLisle <cjd@cjdns.fr>
Link: https://lore.kernel.org/all/877c2top39.ffs@tglx

---
 drivers/irqchip/irq-econet-en751221.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-econet-en751221.c b/drivers/irqchip/irq-econet-en751221.c
index 886d60c..fd65dfe 100644
--- a/drivers/irqchip/irq-econet-en751221.c
+++ b/drivers/irqchip/irq-econet-en751221.c
@@ -286,7 +286,8 @@ static int __init econet_intc_of_init(struct device_node *node, struct device_no
 
 	econet_mask_all();
 
-	domain = irq_domain_add_linear(node, IRQ_COUNT, &econet_domain_ops, NULL);
+	domain = irq_domain_create_linear(of_node_to_fwnode(node), IRQ_COUNT,
+					  &econet_domain_ops, NULL);
 	if (!domain) {
 		pr_err("%pOF: Failed to add irqdomain\n", node);
 		ret = -ENOMEM;

