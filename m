Return-Path: <linux-tip-commits+bounces-2008-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C357394C0FA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DC1288B0A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C8C1917F2;
	Thu,  8 Aug 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dYVYMYwu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0W07o/HM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3202F190685;
	Thu,  8 Aug 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130507; cv=none; b=n3BBwsQKczkmRTE/JfOgwnB386HWwejRS+HrCv67luxW7wagJ4hrhl3LxQhvHJxOmcj402mSxWGgd8fZ7XWUGN5PZfFq9sE2fDn5OEcsZtrVil8uKwv+gc//1qZh7pQVFiclEdkbYFmSXa/kFyu57OiyN1kIahkw7lBUZP75Ky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130507; c=relaxed/simple;
	bh=7L53TTfEafGk0z0Ewj7sTnkAChiavpO/9pQVxKlwi6M=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=LTqFCe3BlqyZcX+By3ueafAauRiRJtwY4bBnj98tw/QWjMdZS4v/7rc+trCpSLKEzYa3oXHl+iUUoKHP2Q6WF3eq8LX6mXGgu7NeiHopJ8b7GiVcNqc7p+cIssIdnv1oRjO1h9WLfZV6lb9CbHzPffiZN6qjVGfHQG4i/Fcr65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dYVYMYwu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0W07o/HM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=SnQW/FFLL7SgiLZeQ0Dz1RJo9o9fIdwKO6XLOMC7tqk=;
	b=dYVYMYwuByajm93pPKiLmXCUBcTc3QsEn6jQ0vcrNwfCt6XJ6m42WywxzF6ZcVwPZO11eT
	xP7+6d//wTO49OQ0QJE+2jwattY8EFeiAjzWgbA9Bl0fUe82IqxLt/vFqIbXZw5ytDenX/
	tkMPCO3ZubGisEtXZWwR9KoNIOiX+hnVrhcLex/9L8Grh1diqS9hO4N2xrIcUbq/LnSLHQ
	zGUT+6hiFIc7eq90YQmTxlDRgr2C8hn8nBlN4ubFG5uwRw7JUMcNTccOfjTcVC+bU30Y7m
	3Ekfrb8Fhw/j2MUG8SVeXjOiUimjLtI462nqmActP19KH2o5TWQPe1Ez3cTycg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130504;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=SnQW/FFLL7SgiLZeQ0Dz1RJo9o9fIdwKO6XLOMC7tqk=;
	b=0W07o/HMH/FpLymJmjBBxPOM/316oHj6PGk+7+YZROQdXmRvqwPIdZPIxPQBIARhVfGlAz
	TYZ0PQES55jFDnAA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Dynamically allocate the
 driver private structure
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050422.2215.10066962800289262491.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6abd809a543936ca005fd37efa32906c78409aea
Gitweb:        https://git.kernel.org/tip/6abd809a543936ca005fd37efa32906c784=
09aea
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:41:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:01 +02:00

irqchip/armada-370-xp: Dynamically allocate the driver private structure

Dynamically allocate the driver private structure. This concludes the
conversion of this driver to modern style.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/irqchip/irq-armada-370-xp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 5710ce2..f8658a2 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -187,7 +187,7 @@ struct mpic {
 	u32 doorbell_mask;
 };
=20
-static struct mpic mpic_data;
+static struct mpic *mpic_data __ro_after_init;
=20
 static inline bool mpic_is_ipi_available(struct mpic *mpic)
 {
@@ -575,7 +575,7 @@ static int mpic_starting_cpu(unsigned int cpu)
=20
 static int mpic_cascaded_starting_cpu(unsigned int cpu)
 {
-	struct mpic *mpic =3D &mpic_data;
+	struct mpic *mpic =3D mpic_data;
=20
 	mpic_perf_init(mpic);
 	mpic_reenable_percpu(mpic);
@@ -726,7 +726,7 @@ static void __exception_irq_entry mpic_handle_irq(struct =
pt_regs *regs)
=20
 static int mpic_suspend(void)
 {
-	struct mpic *mpic =3D &mpic_data;
+	struct mpic *mpic =3D mpic_data;
=20
 	mpic->doorbell_mask =3D readl(mpic->per_cpu + MPIC_IN_DRBEL_MASK);
=20
@@ -735,7 +735,7 @@ static int mpic_suspend(void)
=20
 static void mpic_resume(void)
 {
-	struct mpic *mpic =3D &mpic_data;
+	struct mpic *mpic =3D mpic_data;
 	bool src0, src1;
=20
 	/* Re-enable interrupts */
@@ -824,11 +824,17 @@ fail:
=20
 static int __init mpic_of_init(struct device_node *node, struct device_node =
*parent)
 {
-	struct mpic *mpic =3D &mpic_data;
 	phys_addr_t phys_base;
 	unsigned int nr_irqs;
+	struct mpic *mpic;
 	int err;
=20
+	mpic =3D kzalloc(sizeof(*mpic), GFP_KERNEL);
+	if (WARN_ON(!mpic))
+		return -ENOMEM;
+
+	mpic_data =3D mpic;
+
 	err =3D mpic_map_region(node, 0, &mpic->base, &phys_base);
 	if (err)
 		return err;

