Return-Path: <linux-tip-commits+bounces-6232-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9011CB19364
	for <lists+linux-tip-commits@lfdr.de>; Sun,  3 Aug 2025 12:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2BF3B992C
	for <lists+linux-tip-commits@lfdr.de>; Sun,  3 Aug 2025 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EC5139D0A;
	Sun,  3 Aug 2025 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IdHeu8zF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Lm8SPJR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B8E2222B4;
	Sun,  3 Aug 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754216486; cv=none; b=padiF7+VnKgaCT8bjBy3RVtW0brnMf2s+9tlkR7YSnNj+usx2tLYzgOPXQyiFejlxfqfA5P3FLhaN3bfdg7CX2WEMaI+tHb4O/vWgpAfVE8aHRUe7YWily+/ooadfEebRHvGbT7k1TPb5pD5q/FMJgz2p6aYhIjMgKKYZ2O1xZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754216486; c=relaxed/simple;
	bh=74gcckKZmoV8bGU0r1nWANoRA+z8bCDrNcoXEaDXpKc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=nsN0IoX2hCEbVqTW4ixDMw4FEyEQnVkW5mChQg36RtQsYS5IRJKBpwwrmCCxi7lh5QpWkJYfC1/bhxYmqkAs5QlpxVyKxAQxqwiFoQk/gPXeFUjJc/GJw5ALJxItC/DIOh6V+USPljZSD/N3va9pbWwskVVvjD6nbqaz0AZfY1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IdHeu8zF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Lm8SPJR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 03 Aug 2025 10:21:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754216482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0Xb7F4Ot/o7iJS2au9c7K359dFtNasf6/7J2A+iZqrQ=;
	b=IdHeu8zFVFwhmiRrHQe2msvt4PcrNHe5T45aakTa4rLW1pFUDROh2x33VepvVfeb3AcKuy
	DXHu95q70aGvkdaBoaGUWHOMflHjmiTFxJi0+DFMSSbyuxRCRbLCSflOGe7RPAwhAiC7BH
	BCQyRYPerOEMi4sYivTvWzWiotLv1mJs9zIyKaljigR43FxITJm8x07vwuwm1omF76IJxb
	dzJSoX0ivIKJxjVK/gOWCIJgbHSV184SIbQKdC+XPR7FlUCCYRcpdJ9htl59R7Rt+lolHS
	YTeeS8Jwtf6Ny2JhxAM770Cnwjlz6SMoefVdol8nbbj79UxZnjhBCfvDO/CF7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754216482;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0Xb7F4Ot/o7iJS2au9c7K359dFtNasf6/7J2A+iZqrQ=;
	b=3Lm8SPJRmxyrnSlnf6nG6cZ+wqEMKVdpilg9cKlDAPgn2jtqBFEDKoYoPbfnK2v2L0hou4
	H5hs4QxShKdqFkCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/riscv-imsic: Don't dereference before NULL
 pointer check
Cc: kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175421648067.1420.7724899351980545543.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     8d260bf78488bd576e619fb53806290c2a195cba
Gitweb:        https://git.kernel.org/tip/8d260bf78488bd576e619fb53806290c2a1=
95cba
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 02 Aug 2025 12:59:13 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 03 Aug 2025 12:12:17 +02:00

irqchip/riscv-imsic: Don't dereference before NULL pointer check

Smatch warns about a dereference before check:

  drivers/irqchip/irq-riscv-imsic-platform.c:317 imsic_irqdomain_init() warn:=
 variable dereferenced before check 'imsic' (see line 311)

Cure it by moving the firmware node assignement after the checks.

Fixes: 59422904dd98 ("irqchip/riscv-imsic: Convert to msi_create_parent_irq_d=
omain() helper")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/r/202507311953.NFVZkr0a-lkp@intel.com/
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

