Return-Path: <linux-tip-commits+bounces-2012-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065294C103
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 17:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF24A1F2789D
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2024 15:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564851922F3;
	Thu,  8 Aug 2024 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhJA7D/s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rXLwnLTT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB91191F6C;
	Thu,  8 Aug 2024 15:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723130510; cv=none; b=AncwHYDyjzIKeJxWZ1ubMmskeL29MJ013hGIh+oR4SxTfAqZjFvplg1r0pMUTwcUC9RG0O3XdnZeADOZZNSzG6VEz/UTREqr6JGYnsV+dj7wsOWrncQBEG/KDO/7+KxSOUSTetibc7TWqarOnXxdyo7WF8/T1tU/7AvhucZoOcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723130510; c=relaxed/simple;
	bh=bVWsPpVn2ofqACQBsQ8dAzK4BNsQfGD2bJQy5Zjy6RA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hdC+UaqoK+cZR4qcdmVfl8v8ReKhrgFLl+IVIFA90LXUEB/Pxf+tnE9HMRBrgGv8EGwXO30wM0tNrH5heqyWQo5RL4eDVYsih4rlNWDSD1ve2MotV7iOqarzAUOfFEKvJwKhdjAKDLfXPSeMRLEj7SseaMjKGVjQZyAoYQdygUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhJA7D/s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rXLwnLTT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 Aug 2024 15:21:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723130506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZpXlfwGs72EHOFmjnjt6IkeXG2WfbLSK8+6ZGUgDxNU=;
	b=qhJA7D/szRVR8ocIoBSkOGD9dMur4h56ukoGFZLxx61aRYjFYNq5AiBVRWdnYiy08XJI92
	gv+m89Tw/i7p1UgVQPDhtoS9BigP+qlgd3ovJfBGqRSyBgAnbJk3UYAGUTvvozJy/Gn0Y6
	bwbSwv5q700kcDj7PhYTC46wK3cODAltCGMhlLWwLnAZQ2YuCmHXd8GNk2OACwHXwsynu1
	xDCLRHXtSs37j6uLunG0Y+MYcazjwJMEkE4oNn7RwbOT7R1twX8sHRphtoGRtd1/U/1MKB
	PY/3X0YnnSlxQssQtUe4xz05ED7H8HdiqRRaol1XraTQ3yZcwwW7pGP0FRiG3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723130506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZpXlfwGs72EHOFmjnjt6IkeXG2WfbLSK8+6ZGUgDxNU=;
	b=rXLwnLTTeiKIKu87u1DEuX5rFbdeYFpRe+9PHXs1a3lol/CM0tmCMHjO0VPQyt5y48kYcu
	UEnRRn/vmZhWrEBA==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Add the __init attribute to
 mpic_msi_init()
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172313050629.2215.10039101444248344982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     37e130c224fd0da168570003355fcbd091a87030
Gitweb:        https://git.kernel.org/tip/37e130c224fd0da168570003355fcbd091a=
87030
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Wed, 07 Aug 2024 18:40:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Aug 2024 17:15:00 +02:00

irqchip/armada-370-xp: Add the __init attribute to mpic_msi_init()

Add the __init attribute to the mpic_msi_init() function. It is only
called from the device initializer, and so can be dropped after boot is
complete.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index fcfc5f8..f5a6937 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -314,7 +314,7 @@ static void mpic_msi_reenable_percpu(void)
 	writel(1, per_cpu_int_base + MPIC_INT_CLEAR_MASK);
 }
=20
-static int mpic_msi_init(struct device_node *node, phys_addr_t main_int_phys=
_base)
+static int __init mpic_msi_init(struct device_node *node, phys_addr_t main_i=
nt_phys_base)
 {
 	msi_doorbell_addr =3D main_int_phys_base + MPIC_SW_TRIG_INT;
=20

