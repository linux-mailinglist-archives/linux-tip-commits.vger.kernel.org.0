Return-Path: <linux-tip-commits+bounces-1770-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C2193F1B1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 724AD281781
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EC8145B27;
	Mon, 29 Jul 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JdqDJIgm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5FB7r78E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6851448E4;
	Mon, 29 Jul 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246591; cv=none; b=bneg/G6F4C1pknZTmU4eLybwKwJ8B/UB4aMxMLpzuIFRwxLYm6na22fGk/g9R7R/ZmwDueZymqIZk7DG2b/y6GKXiDWdCwiNQ+9xxgecIwX4yvcMOJdrX7o8PqaRfRJGTdQPgFCfk+knMcl1bUN7KIIKzWzIv0zmQQuQKBITXK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246591; c=relaxed/simple;
	bh=8ztALsF+KiuGE5Ezbh7j+hd0U3F7+QrnAfHzekb6sC4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oTeNNWJ0FFjDV909FXIPrRU4ftJyOYOzb6OcEiYYPijQ5RXxOVly6H84/IdfbBOJWJIJP56tVuw438Gg9umRBCNV6SLLBBe6o6MQgvpv1kd4R1IBS1bCoI28hZ6ZAa6CKv9+HihrX9w/nagA4/CYJb9Jqny2PwNoYatJB/FmGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JdqDJIgm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5FB7r78E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abMFNA7Sf+rH9sMYQoeeuNKExE5Xc4MhCKG1cLakKPY=;
	b=JdqDJIgmo+ZrZxaBJbANaIl2Evr+p08XUd2SrmtaIK22zwgm/0BWTPrurCigxpE4nijKkD
	ORMaHQbIPAhjNWwvnVt18zcf7OD5aA2QOhPyOeuLDm9bq6Z1hBq0X2diA6nTUX7GOTYhWP
	E7+uxJfaSrwCoZLTo72fiNiK6OGV1yRISVLUsfmYT9f8ndaoX70SFYigSgoSx5+RKnW74l
	GgJfddZEQVPU1bwCGL3Be7OgNLGUk9+RzdJ+Ic1sDz7hFIOWh48B4d7w0QXSbnl659Qd2q
	8VwGkXeVTMgqVEeLUTf+SM/3B2lpDvKTCTfM5W7GCo6qnZd5kt0k2h9TT/GXFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abMFNA7Sf+rH9sMYQoeeuNKExE5Xc4MhCKG1cLakKPY=;
	b=5FB7r78E2vswqOyf4YCvSqbH87yQQDcT2OnOGBjj5JyyMBLkJXeW7u2jbuWz4lTFckrVKN
	+vNmeJ8fZMr2XZDQ==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Simplify is_percpu_irq() code
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240708151801.11592-9-kabel@kernel.org>
References: <20240708151801.11592-9-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658605.2215.12603304589653785703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4b75b6d09a258f9a0b3f0087e8848f8963e4a398
Gitweb:        https://git.kernel.org/tip/4b75b6d09a258f9a0b3f0087e8848f8963e=
4a398
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:22 +02:00

irqchip/armada-370-xp: Simplify is_percpu_irq() code

Simplify the code in the is_percpu_irq() function. Instead of
  if (condition)
    return true;
  return false;
simply return condition.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240708151801.11592-9-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index b9631cc..cfd6dc8 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -201,10 +201,7 @@ static inline unsigned int msi_doorbell_end(void)
=20
 static inline bool is_percpu_irq(irq_hw_number_t irq)
 {
-	if (irq <=3D MPIC_MAX_PER_CPU_IRQS)
-		return true;
-
-	return false;
+	return irq <=3D MPIC_MAX_PER_CPU_IRQS;
 }
=20
 /*

