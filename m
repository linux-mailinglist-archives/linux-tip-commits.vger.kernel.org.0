Return-Path: <linux-tip-commits+bounces-2965-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28C99E1ABE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 12:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77161165915
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6F11E3777;
	Tue,  3 Dec 2024 11:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uvi4ul4x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4SHuJ8xp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7412E3EE;
	Tue,  3 Dec 2024 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224835; cv=none; b=gGIr0SakG0nbsjfA+eYJ4N3pGWWzBq6beGT4B/7HEaJVYa7um5xU0VByWmKJOs9MGSLWttCXe3zcgEyiGhVQ9DksWYK8qbLZ473z8ZYA6OyPM34GYixp3UZdQzakYgFelmwojfHnBXS/qb02rmxoCM8JR+fvJJcWj6QNNGKhZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224835; c=relaxed/simple;
	bh=IrOds1AfF3qfQU/V1TrBrirtQwmj6Y4gQ3/oooCF2UM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dbWEjSBDL+R4Nz4iv+ZoOZn50NHsZJ1B/w671/XgtmpcSHRQcJoyduwYDFH7R9ESr6O8ZF/u2fc3nhJua1RMgktZ2KSHwXFAsjAOxmmdWXUbhDJjZLw+Lrm4IKa5Wa/l5GptoNRCOpnj47CACMQMeIHZ3hj14xiJEL6ywEx43h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uvi4ul4x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4SHuJ8xp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 11:20:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733224831;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKSlW9JgnklFs5c0a0ULJV2gr076i67p9722g9MJu6M=;
	b=uvi4ul4xYZSSs2BJ8EFthjntc54kCQUUq96g55lUI0RPq0GTRbnjS5wI08D5DladLxAp2P
	QVuaNEWwpTpogxCMUWIfMbHkZKjd15G8DjqQl8vzeZOWztiMRkWpIe5k25poiEvbhXZVPF
	E59v2DIsc9+zVNGEAQt3212Tj0deLu5hEUY16sB6O2bUQxon3dUQn7YIF4J7jSpLTihdfj
	2y8Pck9qS4NQ9AcE4XzWSlsiwPSSwsFVs5upH6M4hah80NMXwkUq4XNRXDuL3OtmGXvsJt
	tIOu9uf5Jq5dVYOc2aLYLpUTpdzg7BflfgF3bF3BdKqIvi0Yk2MwvJKk+iOBUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733224831;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKSlW9JgnklFs5c0a0ULJV2gr076i67p9722g9MJu6M=;
	b=4SHuJ8xpRWu74Q0AYO2diwIN3UsAXmg+oEIV8BTBhZjBTb7Zv8dODdC9/76EIxNsRT6Ioy
	bqyrGiNBhQEXOWCw==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3: Fix irq_complete_ack() comment
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241202112518.51178-1-lpieralisi@kernel.org>
References: <20241202112518.51178-1-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173322483031.412.486815577722753671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f58326c70df0dc413bb58848b188523b3662cf0f
Gitweb:        https://git.kernel.org/tip/f58326c70df0dc413bb58848b188523b3662cf0f
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Mon, 02 Dec 2024 12:25:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 03 Dec 2024 12:15:42 +01:00

irqchip/gic-v3: Fix irq_complete_ack() comment

When the GIC is in EOImode == 1 in irq_complete_ack() it executes a
priority drop not a deactivation.

Fix the function comment to clarify the behaviour.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241202112518.51178-1-lpieralisi@kernel.org
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 8b6159f..34db379 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -817,7 +817,7 @@ static void gic_deactivate_unhandled(u32 irqnr)
  *     register state is not stale, as these may have been indirectly written
  *     *after* exception entry.
  *
- * (2) Deactivate the interrupt when EOI mode 1 is in use.
+ * (2) Execute an interrupt priority drop when EOI mode 1 is in use.
  */
 static inline void gic_complete_ack(u32 irqnr)
 {

