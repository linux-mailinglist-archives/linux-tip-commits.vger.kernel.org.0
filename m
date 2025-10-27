Return-Path: <linux-tip-commits+bounces-7024-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A4C0F63B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685FC466CFA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C70313269;
	Mon, 27 Oct 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0MfEQDci";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aemu6QbK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC331D39A;
	Mon, 27 Oct 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582684; cv=none; b=Hjjyd9ffWi6i59mphcNxaU7BQiNAyly1TCBHOvEoqibtG9KKNssY6TXNNBLADgnW7+IwN6rl+QkoAXa2VFIGb+PC0MC4JH5vfKPtZKddfIkHGa52fmU5WTH4fIyrlGHo4gtE4DaH9e8MytsnCuQle8SzJwwaZvCjz9zSmjJcLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582684; c=relaxed/simple;
	bh=dJAbl51UqJleNBnS71pvtYw0ZKgejLVloAB6zwxvmGA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WXPpxVOdRtXZpRq6K4BW6LCAbIrPE+GtYcKfvkNJTpOLWS09gM8gOAjaYpaXIEDAC+qnrCGjqJr7uBTzIf8HloBkhLzZn36yoXuEltxHnQ+qTgYLo6R5WqJEhNHD+pKukeCfEIUqhDCHwmQpSBO622h8bjMxZ/XWDUnhkBj4fkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0MfEQDci; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aemu6QbK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582681;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDXZoU5c7IKLS4FvxlQApL/l1sLjMV133qAjJ+v9Nto=;
	b=0MfEQDciA9zz/JyurduMdedojgGZZClHolT45BVakHlukbfS/4ep019jlgJ5P4dKpjJoxe
	wR77iqsoJJRMQtoBRH5j2SpgLllrFITxGpd19NjiuewJ1EM8wRZf3TVUD9Mjt7y2HGdqdh
	lJmac5ir1HVtKbqDx+nhxBsjZS8+cc1MhCZ00LDoV5gSKnvkLQcXXa76hVg9tcdEzMKEq/
	YWhf+NXd2AVv1KtPc0bbhvEjZ+CzRn6TajquqG/F+4thWolvbhimFNJewwePAZxhpqkA71
	33SXqqTpqOik56hvVEqaTkEBfXZA6jZK5SR7Ns3CXqZ1MXvheiqn7zifqNe9Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582681;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VDXZoU5c7IKLS4FvxlQApL/l1sLjMV133qAjJ+v9Nto=;
	b=aemu6QbK+Sr+dEvPrBBchTTx28nP4WKSE6auVVTn9EW6nRz+77YJTxHRnXpaNZQ9OSldr9
	UVqfeJDyIc/D14BA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] of/irq: Add interrupt affinity reporting interface
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-4-maz@kernel.org>
References: <20251020122944.3074811-4-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158268004.2601451.6343399192637491833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5404f5c06dd41fd4445a01dec77a629e254a62e8
Gitweb:        https://git.kernel.org/tip/5404f5c06dd41fd4445a01dec77a629e254=
a62e8
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:20 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:32 +01:00

of/irq: Add interrupt affinity reporting interface

Plug the irq_populate_fwspec_info() helper into the OF layer to offer an
interrupt affinity reporting function.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20251020122944.3074811-4-maz@kernel.org
---
 drivers/of/irq.c       | 20 ++++++++++++++++++++
 include/linux/of_irq.h |  7 +++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 65c3c23..168fde9 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -479,6 +479,26 @@ out:
 }
 EXPORT_SYMBOL_GPL(of_irq_get);
=20
+const struct cpumask *of_irq_get_affinity(struct device_node *dev, int index)
+{
+	struct of_phandle_args oirq;
+	struct irq_fwspec_info info;
+	struct irq_fwspec fwspec;
+	int rc;
+
+	rc =3D of_irq_parse_one(dev, index, &oirq);
+	if (rc)
+		return NULL;
+
+	of_phandle_args_to_fwspec(oirq.np, oirq.args, oirq.args_count,
+				  &fwspec);
+
+	if (irq_populate_fwspec_info(&fwspec, &info))
+		return NULL;
+
+	return info.affinity;
+}
+
 /**
  * of_irq_get_byname - Decode a node's IRQ and return it as a Linux IRQ numb=
er
  * @dev: pointer to device tree node
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 1db8543..1c2bc02 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -43,6 +43,8 @@ extern int of_irq_parse_one(struct device_node *device, int=
 index,
 			  struct of_phandle_args *out_irq);
 extern int of_irq_count(struct device_node *dev);
 extern int of_irq_get(struct device_node *dev, int index);
+extern const struct cpumask *of_irq_get_affinity(struct device_node *dev,
+						      int index);
 extern int of_irq_get_byname(struct device_node *dev, const char *name);
 extern int of_irq_to_resource_table(struct device_node *dev,
 		struct resource *res, int nr_irqs);
@@ -76,6 +78,11 @@ static inline int of_irq_get_byname(struct device_node *de=
v, const char *name)
 {
 	return 0;
 }
+static inline const struct cpumask *of_irq_get_affinity(struct device_node *=
dev,
+							int index)
+{
+	return NULL;
+}
 static inline int of_irq_to_resource_table(struct device_node *dev,
 					   struct resource *res, int nr_irqs)
 {

