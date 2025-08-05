Return-Path: <linux-tip-commits+bounces-6235-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F38B1B045
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Aug 2025 10:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AE57175DAE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Aug 2025 08:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC53257AC6;
	Tue,  5 Aug 2025 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5afC7Aq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhjHj15M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1897256C89;
	Tue,  5 Aug 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383044; cv=none; b=jB6vleZTxuh4Em8xd6FK7TOy4ea4azQHPuKNN/PI/+BaFwlN0S3QQ5xoAymLUlwZOv07fYDdqRgFJYlbbXtxmvRCEsHSvMnvGOmI0p6Sc8eo7pPNWN0U9X7p+BUn6vvt1eXRRe5wK+kFDpdTI66OjclEYCsETwPRsEx1NaaebUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383044; c=relaxed/simple;
	bh=ZJqlsKXUoC5wwrOfI/jTSTKnnHWHADq9o2e0bONZ97c=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gogrzAkm4OeXmwEYcE9nLvvxkoEcyYgOrgw7YlHZndvaq6VEW+/4cf02OYNQ1jj345rdLguVTyEmg8ga0gKtCLol02Uk1Is2hXaU8yX6gylGJ/kIpQV5Nyi4iOwyCBJOafUGEOO3O0pAL9CwbPlcrfnOtsB5dLRT80q2Ivc4eO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5afC7Aq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhjHj15M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 Aug 2025 08:37:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754383037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=eW8zUxOGPj2ZG3rEitKqA76BulVYVqiloQ646gBKSmc=;
	b=X5afC7Aq7+Wb1s2yoqJa3CN/AIA+JHjA+ARDtAxt/0EXcvajLOlA9MllqRjidj54IRTIuV
	LU7n9akVdKAgWfLnO7eWrtkklFJCJrN3HuAGjPENQRbCB+VQRQzjkvZrcorrCeJ5rvs9tH
	FxA0fdIQlpKMzH0xqxWStmEMDF6qyYwl0pr6jqc7+tKBnoRzbu5I9plVndo8Qs4pIocKAj
	XdLt7d05nvsARLKJgmuIK7anZ+ruUfKmzOntI1ELO12PW6gUdawGzZP2VB57QivskyN/E1
	XyHva6LacHnqTSIxHdxUXF5UcVbm7XF7XTPMduQKQax/bCIv59/albpC254ebA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754383037;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=eW8zUxOGPj2ZG3rEitKqA76BulVYVqiloQ646gBKSmc=;
	b=qhjHj15MaJWdH++xQWQZsRy0f0sMPWBagijpXURyLoLQYE2d02ifuBVAftf/1Z+zg2dI3s
	J5j90yzsZd6ZcKBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv-imsic: Don't dereference before NULL
 pointer check
Cc: kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175438303557.1420.5309890165754623173.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     cb9f6a40382ca7b7a81d6f52285f897b09b5851b
Gitweb:        https://git.kernel.org/tip/cb9f6a40382ca7b7a81d6f52285f897b09b=
5851b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 02 Aug 2025 12:59:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 05 Aug 2025 10:29:24 +02:00

irqchip/riscv-imsic: Don't dereference before NULL pointer check

smatch warns about a dereference before check:
drivers/irqchip/irq-riscv-imsic-platform.c:317 imsic_irqdomain_init() warn: v=
ariable dereferenced before check 'imsic' (see line 311)   =20

Cure it by moving the firmware not assignement after the checks.

Fixes: 59422904dd98 ("irqchip/riscv-imsic: Convert to msi_create_parent_irq_d=
omain() helper")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/r/202507311953.NFVZkr0a-lkp@intel.com/       =
                                                                             =
                                                                             =
                                                                             =
         ---
 drivers/irqchip/irq-riscv-imsic-platform.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---
 drivers/irqchip/irq-riscv-imsic-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq=
-riscv-imsic-platform.c
index 74a2a28..643c8e4 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -308,7 +308,6 @@ static const struct msi_parent_ops imsic_msi_parent_ops =
=3D {
 int imsic_irqdomain_init(void)
 {
 	struct irq_domain_info info =3D {
-		.fwnode		=3D imsic->fwnode,
 		.ops		=3D &imsic_base_domain_ops,
 		.host_data	=3D imsic,
 	};
@@ -325,6 +324,7 @@ int imsic_irqdomain_init(void)
 	}
=20
 	/* Create Base IRQ domain */
+	info.fwnode =3D imsic->fwnode,
 	imsic->base_domain =3D msi_create_parent_irq_domain(&info, &imsic_msi_paren=
t_ops);
 	if (!imsic->base_domain) {
 		pr_err("%pfwP: failed to create IMSIC base domain\n", imsic->fwnode);

