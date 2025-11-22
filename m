Return-Path: <linux-tip-commits+bounces-7472-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A402C7D3AB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 17:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 055C1342F35
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Nov 2025 16:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B2822D9F7;
	Sat, 22 Nov 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TjHkipGA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AJkk41Qv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2074C1DE2A5;
	Sat, 22 Nov 2025 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763827911; cv=none; b=jk3GAW4gFqE/ileBuJnQWjUoMY9GIYmplVscIim4YZHTj7W95qhZ8DM5Fw14vw85BGbhpoUb9lxCJ5UdxMYPbKhXrRelt4CfsCl1Hg3Qruoo4yf04wHQAkT680r0Yh39sqIJKathwwODLxYVcAb7G3m3FhvUfUJ/0OBLmzm80/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763827911; c=relaxed/simple;
	bh=ucrhHrVUEckSgbWfO3WDdJxcZ3N28Mz3NR3/A31GzeQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JtY1/74MAuFytKEuTiL+hcx+aN0IgNKbANWj4QwO+gxzNIeBZpDgQZW0tj0AZo5ZgK0jCIHZDHeVAnBL4gS/v1pFGAcuF8ThtYlga2wSUGHMw2h+xlYjqNkYe3QSyOhLTKUveRXaateWbrw6ZRrnXOOPA6jvWVDjBKYq8E0DZbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TjHkipGA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AJkk41Qv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Nov 2025 16:11:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763827908;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzUauZASvcXlZll5Ck1pU/z0Quzs6IZYzHN7kWNVfdo=;
	b=TjHkipGAQdv9BGExOuSlsjdiN7Z7xnwEqrzqZFig522RxCtL3nF6aFBKhGm6twazW1ofF+
	haayd+Yk0ZiWRj7v7gec61pib2So3kEW7yyUsaRh6S5glxN0JXESaGP5hLhH5MqJx1AlXm
	TALmppe01aD9D+UBs2ghyNWAJOOUewAhGGAIGqhUD8PytLqIlR7G9wLMLnMgN2qcQ4UQFg
	7V1l/jHP+3aU2dOd5S8ynh1TotlwIblOCIMNhrVdSxsBZD1ppCu81bbCoMMpLL1knQarTi
	8s58OlUGYsGxZaHA3VB1g5Nq3i627oSwtfC4w69oHNSGET9niqgA7Md0/U3j4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763827908;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UzUauZASvcXlZll5Ck1pU/z0Quzs6IZYzHN7kWNVfdo=;
	b=AJkk41Qv9VUn3VZaahTsKFbHo4mAtPoYu/kXbJb0Ycnw9ZhtfjzXx6+qSOvvr4N+PzilQa
	P3kMXK9MuTv2o7AA==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI: iproc: Implement MSI controller node detection
 with of_msi_xlate()
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251021124103.198419-5-lpieralisi@kernel.org>
References: <20251021124103.198419-5-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176382790748.498.16266737819766872891.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     4f32612f6a4e5a9b1344aebf856aa1a1581a426d
Gitweb:        https://git.kernel.org/tip/4f32612f6a4e5a9b1344aebf856aa1a1581=
a426d
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Tue, 21 Oct 2025 14:41:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 22 Nov 2025 17:09:03 +01:00

PCI: iproc: Implement MSI controller node detection with of_msi_xlate()

The functionality implemented in the iproc driver in order to detect an
OF MSI controller node is now fully implemented in of_msi_xlate().

Replace the current msi-map/msi-parent parsing code with of_msi_xlate().

Since of_msi_xlate() is also a deviceID mapping API, pass in a fictitious
0 as deviceID - the driver only requires detecting the OF MSI controller
node not the deviceID mapping per-se (of_msi_xlate() return value is
ignored for the same reason).

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20251021124103.198419-5-lpieralisi@kernel.org
---
 drivers/pci/controller/pcie-iproc.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pci=
e-iproc.c
index 22134e9..ccf7199 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/phy/phy.h>
@@ -1337,29 +1338,16 @@ static int iproc_pcie_msi_steer(struct iproc_pcie *pc=
ie,
=20
 static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
 {
-	struct device_node *msi_node;
+	struct device_node *msi_node =3D NULL;
 	int ret;
=20
 	/*
 	 * Either the "msi-parent" or the "msi-map" phandle needs to exist
 	 * for us to obtain the MSI node.
 	 */
-
-	msi_node =3D of_parse_phandle(pcie->dev->of_node, "msi-parent", 0);
-	if (!msi_node) {
-		const __be32 *msi_map =3D NULL;
-		int len;
-		u32 phandle;
-
-		msi_map =3D of_get_property(pcie->dev->of_node, "msi-map", &len);
-		if (!msi_map)
-			return -ENODEV;
-
-		phandle =3D be32_to_cpup(msi_map + 1);
-		msi_node =3D of_find_node_by_phandle(phandle);
-		if (!msi_node)
-			return -ENODEV;
-	}
+	of_msi_xlate(pcie->dev, &msi_node, 0);
+	if (!msi_node)
+		return -ENODEV;
=20
 	/*
 	 * Certain revisions of the iProc PCIe controller require additional

