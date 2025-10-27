Return-Path: <linux-tip-commits+bounces-7025-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB425C0F5C9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79406189AC02
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F70E313274;
	Mon, 27 Oct 2025 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2cVx43oM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rf84S21h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0131B800;
	Mon, 27 Oct 2025 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582686; cv=none; b=C28+5qDoly1yNOOk4/PdTiBwJa2sP9ZjD7kXzh5QUYP2E83XsjCrcv9o0LMbrZF8LfRwZVPe0gP4cYHyhOaKIDb/gZ3+H/3/ZBefImW5deDpoCfr5rl+a4ACKVy8sVdIH5q40C5ieiLt94Iphm4L6wj4njPqiHqXARUJL7bJ+fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582686; c=relaxed/simple;
	bh=UOi4GzIhu50QZt7GKzISSQm4vPb1Ub9UUlsYXV0k2ng=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ETwVj0t87jeWGsnfbRxL4DyLh652udZvvD3ChKbvaFAJnt7yB3/Ob3dUPTgvoDWb4q2uINpVUEjmJN1aBkt+Z+SwNDTLs4pcGiihPS3barMiFsa1s74SuPXC+c2zfkKGthS1KZJlW7DbeDiUlcbFzqTx7wg5POU9U7vLzm8zS5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2cVx43oM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rf84S21h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zo/tz2LOMPHoQ2dRUV9xY/qXTRh/Opz2M7tUw0QrsEg=;
	b=2cVx43oMbnleu25TYCRkwhCBLQFnRiwhwhXBl2m8PbqsA7YZQh8XSynn5ZypzwKf/7+pW7
	TO1e/MCnSC7Tm04B77WNyEFa6Pq7ctw0tTRLp1xmmxT2SbBpKOtCJ3Lvf4G7zZOzuUGrSh
	+VnUW1hAO/gjli4pF1VkR5tYrhQmdV2DGpMssualfELXir/NIU7GUfaNYq9ILGhaHejBi6
	4hiT3P9hPy0mP1Jc5Mh5KwgOTVOboPDoW1OHaPUGzN3OM0axV7ObkqadZ8V5H24mvXEM7d
	PeW63evgJc2LSXS0uzbaw4ndRw1Ia/0itFF90pycXWysNLuEQz48q+yhUaaNTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zo/tz2LOMPHoQ2dRUV9xY/qXTRh/Opz2M7tUw0QrsEg=;
	b=Rf84S21hJR22E5dW2ppJsjFJad5bXaimpvUw0Er4pOZSDSYwecuRK6klZTvm7Izk6rQ/OF
	8pu4d8LHUXUfa9BA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] ACPI: irq: Add interrupt affinity reporting interface
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-3-maz@kernel.org>
References: <20251020122944.3074811-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158268117.2601451.3370006380098181189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5324fe21ba9b77b299c02191645a97777cdd73ac
Gitweb:        https://git.kernel.org/tip/5324fe21ba9b77b299c02191645a97777cd=
d73ac
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:32 +01:00

ACPI: irq: Add interrupt affinity reporting interface

Plug the irq_populate_fwspec_info() helper into the ACPI layer to offer an
interrupt affinity reporting function. This is currently only supported for
the CONFIG_ACPI_GENERIC_GSI configurations, but could later be extended to
legacy architectures if necessary.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-3-maz@kernel.org
---
 drivers/acpi/irq.c   | 19 +++++++++++++++++++
 include/linux/acpi.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 76a856c..d159515 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -300,6 +300,25 @@ int acpi_irq_get(acpi_handle handle, unsigned int index,=
 struct resource *res)
 }
 EXPORT_SYMBOL_GPL(acpi_irq_get);
=20
+const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
+					    unsigned int index)
+{
+	struct irq_fwspec_info info;
+	struct irq_fwspec fwspec;
+	unsigned long flags;
+
+	if (acpi_irq_parse_one(handle, index, &fwspec, &flags))
+		return NULL;
+
+	if (irq_populate_fwspec_info(&fwspec, &info))
+		return NULL;
+
+	if (!(info.flags & IRQ_FWSPEC_INFO_AFFINITY_VALID))
+		return NULL;
+
+	return info.affinity;
+}
+
 /**
  * acpi_set_irq_model - Setup the GSI irqdomain information
  * @model: the value assigned to acpi_irq_model
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 5ff5d99..607db77 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1509,12 +1509,19 @@ static inline int acpi_parse_spcr(bool enable_earlyco=
n, bool enable_console)
=20
 #if IS_ENABLED(CONFIG_ACPI_GENERIC_GSI)
 int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *re=
s);
+const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
+					    unsigned int index);
 #else
 static inline
 int acpi_irq_get(acpi_handle handle, unsigned int index, struct resource *re=
s)
 {
 	return -EINVAL;
 }
+static inline const struct cpumask *acpi_irq_get_affinity(acpi_handle handle,
+							  unsigned int index)
+{
+	return NULL;
+}
 #endif
=20
 #ifdef CONFIG_ACPI_LPIT

