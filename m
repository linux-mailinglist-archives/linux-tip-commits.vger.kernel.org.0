Return-Path: <linux-tip-commits+bounces-5360-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6B6AAD984
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507BA4E588E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF823535A;
	Wed,  7 May 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WH1uxN15";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ozM8j1V3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46712230BD5;
	Wed,  7 May 2025 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604697; cv=none; b=AiGy0+irXbTG21PiTjzUjEpoZgdyAA6ZL2Bj4Py4UICZkGzTRzvtUKoeP8MxiBXI/Iw64NFPAv1auibQg5f9NU/YC3BYS9TgikZ3nlRFWEI2X9sWBAXlf3tb7QwLXLgGrCTIGPTFa1Kaj7IH0CkVGHex7u9Xhh1EjJaSGDWbsJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604697; c=relaxed/simple;
	bh=bNID1G/HoUS2mAH+E8N9OxcgAincQ5SEVbbd3JKcNrk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P5Dy3w78DMXzHK1G9B3S+OXdu7+8eyS5FhHqtdv4puUhnU2h61dZe1xrLwUlOz01xmyFsay53QcmGN4IpveZPPN7qySaEcwFjHSNpZCSfw6/DwkapHskkdXj2XgOgN/Wms9J3wCik6Rh6rEIXfEBBXWOarcH1OtvnzIbNppdrWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WH1uxN15; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ozM8j1V3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbnBx0g44rPHlDVv61XxQHixyheFeAYzv5M2cA+gBFs=;
	b=WH1uxN15z28TSppvlIQjWN1nJDZB3hjD2ycfxzDZe9Zw2eicLKwHC2UIY8Dy0jEESkzKE2
	PAr1Jfy2VvllFCvFkL9FLtr6TS5vq15PhtaUzzR0y/bkG8tNLRYuLUKrA1ahgrYpnCXw+b
	E4ImQE9srGEQXoUH+mMVUCBcM4btihUXj3h3c8FvRsz1wJyrCDTU01Gg7ULAVRuWjB6/1v
	Q9iqJP9fVLQ8eak+0C8N/utsD1h8175ODSPQaTXYmN2Af3UAQISzoevWfYKpWHrrFKxtyc
	/DC0ZXq44BYx7ly6K5HUyuObNuMWan3EAg55WenzEaz1pOsZzhMqqLDq88YZvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604693;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbnBx0g44rPHlDVv61XxQHixyheFeAYzv5M2cA+gBFs=;
	b=ozM8j1V3iKPI5pXc086dpUzPsWNX9uYJUhSI+kNkMP8KX1Z2crFIU6rPTmaVgJ3q1f+/az
	03gl1ggUFsdC7/BA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] bus: moxtet: Switch to irq_domain_create_simple()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-16-jirislaby@kernel.org>
References: <20250319092951.37667-16-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660469290.406.1938318210573562223.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     14eb9e3d0bb93f66ad6c3a1ff9ec1c1d9935d194
Gitweb:        https://git.kernel.org/tip/14eb9e3d0bb93f66ad6c3a1ff9ec1c1d9935d194
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:22 +02:00

bus: moxtet: Switch to irq_domain_create_simple()

irq_domain_add_simple() is going away as being obsolete now. Switch to
the preferred irq_domain_create_simple(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-16-jirislaby@kernel.org

---
 drivers/bus/moxtet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/moxtet.c b/drivers/bus/moxtet.c
index 1e57ebf..6c3e5c5 100644
--- a/drivers/bus/moxtet.c
+++ b/drivers/bus/moxtet.c
@@ -737,9 +737,9 @@ static int moxtet_irq_setup(struct moxtet *moxtet)
 {
 	int i, ret;
 
-	moxtet->irq.domain = irq_domain_add_simple(moxtet->dev->of_node,
-						   MOXTET_NIRQS, 0,
-						   &moxtet_irq_domain, moxtet);
+	moxtet->irq.domain = irq_domain_create_simple(of_fwnode_handle(moxtet->dev->of_node),
+						      MOXTET_NIRQS, 0,
+						      &moxtet_irq_domain, moxtet);
 	if (moxtet->irq.domain == NULL) {
 		dev_err(moxtet->dev, "Could not add IRQ domain\n");
 		return -ENOMEM;

