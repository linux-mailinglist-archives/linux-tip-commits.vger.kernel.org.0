Return-Path: <linux-tip-commits+bounces-6227-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E079B18E33
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Aug 2025 13:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3ECF189D3E3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Aug 2025 11:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A759221FB6;
	Sat,  2 Aug 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z1VB5sla";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vNNhuaah"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5E20012B;
	Sat,  2 Aug 2025 11:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754133811; cv=none; b=sV12AnSdsXyG0O5VnXkPTXvy8deZ3Y0tgs/l6+wwKPFzE14kevQ0c8AvVGH1bDjPzBYgGN4HsgW1soWHC2GXOMbJ3+5kiq6OHCDt4n51h8CvzksWTe+nwHLDUUv2vLdvvFt6QhCTmyM4jIHn8ynyuL6Fpwfya/MyjhbJpG1RTJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754133811; c=relaxed/simple;
	bh=k6f/WPvo2cJFteZIZiAnYwZp2G1iIfB052f3SEd0MDU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Eiv3LA7KPby5k3SYOEvYw5neqZym0aHohvo0HbTPr5wegEb8+ivIjt9hJp4uN43SwYBYHEPOBEXkh4KiqAMJMZT1nipKX705jNHdENKYW3HggCFZmGDCJvx/520rcWJb4RJm60AUE7WbNO2HnQ3LKCvSdbWPiq8FobTdmOYI/2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z1VB5sla; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vNNhuaah; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Aug 2025 11:23:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754133802;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BcwxD4WjIrnTFf/Z9VflOqS24H3+TspPuJuL/LOsgvQ=;
	b=z1VB5slal1ktzu2GEBTKl5U4esJPe395XZoD7Iob80BKLjWRXjkD3B7zwsnRAJlDPbk+Th
	WDCugbCv8x3DY9cEsz4ajtPd+XecXQPH3IBe2QV1k/8/2OghoVIBP/rVDIaRiIPI82uYOj
	e5opCC1q36C0PjF6ylsb5iyOsElByDRio0VBp7E4oCi9lXEz/ZSIW4q26lE7h3T4lLQ5+N
	+8Wjw0f+NMi9svyAKMfrYxx8WVHkh8o+628wURVgIJOuixzY3YEGesksRax+dbd7HBN9cZ
	GZh8g3f2uDGr6T0HcNsJzlNu+BH+wdb9w6jGTznpGcPFwgNOQV6sPNgQN5el2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754133802;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BcwxD4WjIrnTFf/Z9VflOqS24H3+TspPuJuL/LOsgvQ=;
	b=vNNhuaahF5QqdXyMB/44n+8GErRkJodaJFviJvyPJfUvnJj7P9H1XL0el3ZD7fX5O5ufc7
	I4A/ne2IOqIsbbBg==
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
Message-ID: <175413379015.1420.18366381372680056743.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     6a6bc9b279e666a825ae2d1f60b545186d10be52
Gitweb:        https://git.kernel.org/tip/6a6bc9b279e666a825ae2d1f60b545186d1=
0be52
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 02 Aug 2025 12:59:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Aug 2025 13:09:51 +02:00

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

