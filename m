Return-Path: <linux-tip-commits+bounces-8046-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECEFD393B9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 11:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6EB13003190
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F6027CB0A;
	Sun, 18 Jan 2026 10:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="laHfU509";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S9cLJaS7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62C191F98;
	Sun, 18 Jan 2026 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730581; cv=none; b=pHC7sm/rWJZV8oXnG3zwmi+T/eWe0UzzTR9uadzxh07MMX6D8Lap/rurAzLaLsEk79DRvYoR/c5Tocy/QVHAo27Hfq2lUlznNujmBtmXvN7ASN0xjXu6tI7ff/0FQyhfO2qm1P7X1qN1MtDi/CUPumJjG4SluuVGfmYFapRPtDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730581; c=relaxed/simple;
	bh=51zGdABCJgijvlHRHS3+q0zy3ydPMzwapu3F0DJEtkA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SATVcMcuP++fDcfjoVgUqIxsL3U47rBkw4TXLZclAYfp+pJCp4i67INXfWXf3q47rjbSxEw01XlseXbZ0QlLy7z9R59ZpscIGM+JLk59o+qobAywDWpnc5nOQ8dNrRVlAMLyvhHCDqd4lFa0IU+OSqSeaT/NZ+DIV74G2BWqioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=laHfU509; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S9cLJaS7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 10:02:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRi7fN5LhJmXp1GZLl5YuofXKRPDsPu3al0f3NmbMKc=;
	b=laHfU5096nBdvKWZOhmUhVnuxFLnTDmZs14x9OGGlOkjRqmRbv2NWsmpIJ9C3/58afNIeD
	NN20Kh0bETHkc/t6Eme8WkLotE4QX+XarujpONIadMRSFzyzkhxwgYbnloQn1gV5+Pmu57
	xLvcHjeL9zBuNwjhOtVxpzoocIQHaeKiw1eu5btEQATgceUdubCGQibNm3f9ehZ4NHYA4b
	BFuhvDvTb6f52ej0xnfuSzRz+CUJoFrD2bouDoTDF8UsgCX0e3Ygg9FBsCu8nO5GTisQJC
	SQ1kbvU/O3NDRIcovi97NOAuEYqgHSRCk0WfkWvSWcRHDKF2AVfyk4ChtOUAng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRi7fN5LhJmXp1GZLl5YuofXKRPDsPu3al0f3NmbMKc=;
	b=S9cLJaS7nxmk9jg1FSqcZk9jgvQ7tWqbSUaI/VHdfgDM273mtK10j+8n4e2skdumPo0Wnl
	k4VV7ToSUGe5vpCQ==
From: "tip-bot2 for Vladimir Kondratiev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/aslint-sswi: Fix error check of
 of_io_request_and_map() result
Cc: Chris Mason <clm@meta.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260118082843.2786630-1-vladimir.kondratiev@mobileye.com>
References: <20260118082843.2786630-1-vladimir.kondratiev@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873057716.510.10300343254854755779.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     d9fbb5a1550516faa0d737ea2749e90d2b36d523
Gitweb:        https://git.kernel.org/tip/d9fbb5a1550516faa0d737ea2749e90d2b3=
6d523
Author:        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
AuthorDate:    Sun, 18 Jan 2026 10:28:43 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 10:42:02 +01:00

irqchip/aslint-sswi: Fix error check of of_io_request_and_map() result

of_io_request_and_map() returns IOMEM_ERR_PTR() on failure which is
non-NULL.

Fixes: 8a7f030df897 ("irqchip/aslint-sswi: Request IO memory resource")
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260118082843.2786630-1-vladimir.kondratiev@m=
obileye.com
Closes: https://lore.kernel.org/all/20260116124257.78357-1-clm@meta.com
---
 drivers/irqchip/irq-aclint-sswi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-aclint-sswi.c b/drivers/irqchip/irq-aclint-s=
swi.c
index 325501f..ca06efd 100644
--- a/drivers/irqchip/irq-aclint-sswi.c
+++ b/drivers/irqchip/irq-aclint-sswi.c
@@ -110,8 +110,10 @@ static int __init aclint_sswi_probe(struct fwnode_handle=
 *fwnode)
 		return -EINVAL;
=20
 	reg =3D of_io_request_and_map(to_of_node(fwnode), 0, NULL);
-	if (!reg)
-		return -ENOMEM;
+	if (IS_ERR(reg)) {
+		pr_err("%pfwP: Failed to map MMIO region\n", fwnode);
+		return PTR_ERR(reg);
+	}
=20
 	/* Parse SSWI setting */
 	rc =3D aclint_sswi_parse_irq(fwnode, reg);

