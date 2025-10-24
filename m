Return-Path: <linux-tip-commits+bounces-6989-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B301C056CC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 11:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75223AFFCE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804F230C61E;
	Fri, 24 Oct 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uqzwg6NK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+4R4Mey0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E156630C342;
	Fri, 24 Oct 2025 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299096; cv=none; b=fD4IIvYFq/T9R7YMP+DdfGyjH59T16NOIfAXYi3jH6vc+F25Qg1664cNRin4/IoL13+gy+mx/1sqXT/Pz1kRplvKqkvhj/KpGGbgfFMyGcfAWav1cxlHCD6BzWOXwFJYIxpGfQxF93RDd0vZthLkh5GaI+SdoLloXLap5HS4NHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299096; c=relaxed/simple;
	bh=2Wsuvs7ozI/wbk679FER+wiCkRPcvXV1vK3pRrcw43U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i2xibJrMrcjn7jeBTuHTmDaB6vc/9dV9c82V7ole/s4PfXTx6/QMgoNkoPTGS/I5gD8zBnSEljOkuYGjHCNMkJdj29y7oUvmaN7xX/mAcgdibrTuVrKDh3M7YIcRHmiYGe0qQ1FJkkPqkLhz2+0vecyaelq3UVRAOVo+aOAkBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uqzwg6NK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+4R4Mey0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 09:44:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761299093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifUsMrURgYpTZNB3ERHE1ks244U1nvbV2UcD+r3Cz54=;
	b=Uqzwg6NKauKhA4LouCCqF77gXQ8pdyhROi9nQtexLMXXSWegpzQpdWQ+ns0Yguc2uqa4tC
	H08BRuG+hbPGAu2IoNpCv/D0ZBwd76RJv+ODUBeJhM0njY6bSol6SNvtwT3Hk1iwRbAltH
	XhL09GaIkntb8iUwc83raJYuz5BJzJh2/T+WCx/40Py0c+W42bTE7zxv3WRHCZM0U/JJEy
	qNlDBxXqj6fUTKx948BvnkyFGDbcLQhnv2cPfs+ur/PcOJ+jyXYcCialGF4roGNrAqt+Gh
	UvFqKe29IlgjpVqxPqgvGR3kCZQj/9i9aaXHaW8/0xfUcDda6BMg9oYyDIz6SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761299093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ifUsMrURgYpTZNB3ERHE1ks244U1nvbV2UcD+r3Cz54=;
	b=+4R4Mey0FDyWdPmxCW8joe0/pBPsMK6hl0d7ECsw2NRoFsrZtD34twQJlz2dkLI3+1ydti
	5NHUnuSukXSX9BAg==
From: "tip-bot2 for Charles Keepax" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] genirq/chip: Add buslock back in to irq_set_handler()
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251023154901.1333755-2-ckeepax@opensource.cirrus.com>
References: <20251023154901.1333755-2-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176129909186.2601451.9949829768587454748.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     5d7e45dd670e42df4836afeaa9baf9d41ca4b434
Gitweb:        https://git.kernel.org/tip/5d7e45dd670e42df4836afeaa9baf9d41ca=
4b434
Author:        Charles Keepax <ckeepax@opensource.cirrus.com>
AuthorDate:    Thu, 23 Oct 2025 16:48:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Oct 2025 11:38:39 +02:00

genirq/chip: Add buslock back in to irq_set_handler()

The locking was changed from a buslock to a plain lock, but the patch
description states there was no functional change. Assuming this was
accidental so reverting to using the buslock.

Fixes: 5cd05f3e2315 ("genirq/chip: Rework irq_set_handler() variants")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251023154901.1333755-2-ckeepax@opensource.ci=
rrus.com
---
 kernel/irq/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 3ffa0d8..d1917b2 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1030,7 +1030,7 @@ __irq_do_set_handler(struct irq_desc *desc, irq_flow_ha=
ndler_t handle,
 void __irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_c=
hained,
 		       const char *name)
 {
-	scoped_irqdesc_get_and_lock(irq, 0)
+	scoped_irqdesc_get_and_buslock(irq, 0)
 		__irq_do_set_handler(scoped_irqdesc, handle, is_chained, name);
 }
 EXPORT_SYMBOL_GPL(__irq_set_handler);

