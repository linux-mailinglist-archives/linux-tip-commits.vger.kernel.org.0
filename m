Return-Path: <linux-tip-commits+bounces-5538-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF12AB6893
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 12:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8ABA4A571C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 10:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B85274FCB;
	Wed, 14 May 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cWsqkVAK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O2wh3NFE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EC8274672;
	Wed, 14 May 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747217745; cv=none; b=KsHGnlYxRK7ylgpLPNZUZ+il2Axolakpr2MG1H2wH2VsPYa5UHWScELwLPo8WUfYKq1Cl+pmZdF8A+RGnjXgfPnRoFcAgJhQxo29dBcJ2O6rWnH+HDdVeHdiNt1wcTPiGRJ2gZEwq4xlZmg2Jejus3oShMpBXNj5dBIRqO1gWus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747217745; c=relaxed/simple;
	bh=io0fuEqu2zUdnHEFnufD9IYz8rdr9vOH4izP/ZTKp4o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S1EkpBZBCof9wAw2ELi/EBjdJ2dYda7u3fcafmMa7SyGE7d+qv4zYplGkEdej46yX3UVHjP8Y0v2byQlg5jZ0pfJnLp7oQBqBk1X/Msad0S7hCPIfqF48Q79P8qJpbvVlQlAcoTOjLw1/YhF24zweeosl9/cOQUoSTPDmjvAW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cWsqkVAK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O2wh3NFE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 May 2025 10:15:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747217742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ne44DSn6E2PNnBd9PVaHQ31yx5UAzOe8msVi/cc7N2U=;
	b=cWsqkVAKiFxxnFahd9iWE0pz/jAsGQNnkYNTngXBwBKjM71yjYBiFZintfkkQTyeaWG2Gp
	wVDIz2HkLXZow/5RY+b/WRqZ5UOFw+QypuVfrqArUSds23Y21a/W7Oqwjxg9SlSKqdM+9m
	NSY74HMYGXOdiCJCfr6To2Ts80Mse0U91Oz4r33xpKdyGeD/RSpzAjlylwKjck0S5CYQ7a
	YYqvruuAfIUraup9RWQ9Au0hVss50pWhuSsBK8xuNb5rgNkY6SL21KU4u/TGWJgRrupteX
	bGemQwxGuCsYI5gB0IWgbDjHqM21Yhl89kajXS1etIuZ71orFEccODcBMz/ksQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747217742;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ne44DSn6E2PNnBd9PVaHQ31yx5UAzOe8msVi/cc7N2U=;
	b=O2wh3NFE+1X+2yathWEIJdvWcdbySaXX7oIGki221Ixdbwhfl1Y+U2+vEhLHxcn8TPMp4o
	H5OBzGoLRgqQX/Dg==
From: "tip-bot2 for Jon Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Use the correct lock guard in
 irq_set_irq_wake()
Cc: Jon Hunter <jonathanh@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250514095041.1109783-1-jonathanh@nvidia.com>
References: <20250514095041.1109783-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174721774116.406.2638049997395737811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     58eb5721a445ea0af310d1410d7117a1910627bc
Gitweb:        https://git.kernel.org/tip/58eb5721a445ea0af310d1410d7117a1910627bc
Author:        Jon Hunter <jonathanh@nvidia.com>
AuthorDate:    Wed, 14 May 2025 10:50:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 May 2025 12:05:58 +02:00

genirq/manage: Use the correct lock guard in irq_set_irq_wake()

Commit 8589e325ba4f ("genirq/manage: Rework irq_set_irq_wake()") updated
the irq_set_irq_wake() to use the new guards for locking the interrupt
descriptor.

However, in doing so it inadvertently changed irq_set_irq_wake() such that
the 'chip_bus_lock' is no longer acquired. This has caused system suspend
tests to fail on some Tegra platforms.

Fix this by correcting the guard used in irq_set_irq_wake() to ensure the
'chip_bus_lock' is held.

Fixes: 8589e325ba4f ("genirq/manage: Rework irq_set_irq_wake()")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250514095041.1109783-1-jonathanh@nvidia.com
---
 kernel/irq/manage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2861e11..c948373 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -846,7 +846,7 @@ static int set_irq_wake_real(unsigned int irq, unsigned int on)
  */
 int irq_set_irq_wake(unsigned int irq, unsigned int on)
 {
-	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
 		struct irq_desc *desc = scoped_irqdesc;
 		int ret = 0;
 

