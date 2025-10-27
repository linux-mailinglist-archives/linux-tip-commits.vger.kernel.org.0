Return-Path: <linux-tip-commits+bounces-7002-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49A3C0F59F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F06C6463170
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347CC31329D;
	Mon, 27 Oct 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xs4rxVqp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BewNI4h8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC533126A1;
	Mon, 27 Oct 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582658; cv=none; b=GXxkZv9b4eJqoMtC4F9E4DcOu6sWuXylWYQja123/3I3JKYaYPMuXd6ALWMaNCZ3rjk/qDOJw5/+njK+YQPzodYjsfwvJscVNTmCFRgbcl7pUZx1gK0nvOTa/mhy8eBRX2wcpukoxp3eBPLjiP7Bj9eRhqU/6cHXKcF86tGPw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582658; c=relaxed/simple;
	bh=vVrC8qU8Iw5sevbZkFKjgzwXuTwdiUNH0cAKN77hP8Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uhj4yvYq/9K6JxP1P+zY+y9i/7URoKA0N2P0L873wFLIrDrbL4WeKNcOmpvU/GuS3IBIUduKdxvq8M5zMpfQpYqdvpah8krGXKb9pOSiFXc+VREh+QNLqFNFwM/taRXharmiMCzk3cEaONm0W0GWr+o/yHBvhRmMeN1IgPyA6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xs4rxVqp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BewNI4h8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:30:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBUrfTNuQYGHviIBH6phUofQ4VgKSTMJgXWYJa+T0qs=;
	b=Xs4rxVqp/8jgMC4ETy7gvoiCGnGY6dFwSKOxAIIFq4ZXpHVzDSwaiu9BO8bOn/GXmSqY91
	hAwT0q/uMyBpwxYLtHk92t5nKtrhQqZ1QPvwhj12oZ/rdb3X7O0VqD50JEFtMj8OP2ck5N
	deIQ1CK+p4fbJcmugwx2RESgDISVBWXTgAvRqBEOm+nETMtUnAs0D+lV6QSia/IAjKwdsO
	VH44C8TxrHLkv1hYkwuksof3FXEP1DEziypyyBVAz/R0LDLW423/cGIphB327ob+XgBSv+
	vXr9tqNHLUpcSgXKi/ymuyk7TWELNylyvo7XjKPv3PO4V6ys+0J+wV4i/wjsHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBUrfTNuQYGHviIBH6phUofQ4VgKSTMJgXWYJa+T0qs=;
	b=BewNI4h8xR2QqTjgXoNLwdf52+NuihwuOke/uhLFpZibSy4kk+91/RorEFfwddkNhJxUeY
	iG3BNY7NhI9Ej/Dg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Kill of_node_to_fwnode() helper
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-26-maz@kernel.org>
References: <20251020122944.3074811-26-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158265268.2601451.2399732061358073631.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ebac4649fcadc6047030810326875c6e612c7b2f
Gitweb:        https://git.kernel.org/tip/ebac4649fcadc6047030810326875c6e612=
c7b2f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:37 +01:00

irqdomain: Kill of_node_to_fwnode() helper

There is no in-tree users of this helper since b13b41cc3dc18 ("misc:
ti_fpc202: Switch to of_fwnode_handle()"), and is replaced with
of_fwnode_handle().

Get rid of it.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-26-maz@kernel.org
---
 include/linux/irqdomain.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 9d6a5e9..5907baf 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -730,12 +730,6 @@ static inline void msi_device_domain_free_wired(struct i=
rq_domain *domain, unsig
 }
 #endif
=20
-/* Deprecated functions. Will be removed in the merge window */
-static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *no=
de)
-{
-	return node ? &node->fwnode : NULL;
-}
-
 static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_=
node,
 						     const struct irq_domain_ops *ops,
 						     void *host_data)

