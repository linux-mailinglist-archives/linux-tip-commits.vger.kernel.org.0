Return-Path: <linux-tip-commits+bounces-3475-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E12A398DD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 11:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8E3188BBCF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5742417EA;
	Tue, 18 Feb 2025 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W1SyQc8L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mVE5+ACP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0958241122;
	Tue, 18 Feb 2025 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739874395; cv=none; b=hynUkhaO+6+L/EdcpS97LTSbxk/s+9troO24Ir/+WdY1Dc9eCvgqG1wvBvG42DeMZLw2BVvqXhSa9/Pdy6HbufNoGSsa5J79F59/Po+ShTcBPtHSRtHZJbkK9PkbukZvGMVwWKfF6iD3dofaTaOy977zwWlXK0Wa1ZkCBKKL3rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739874395; c=relaxed/simple;
	bh=qlm8hEMLxXdQx/C4sz0YaIRrqSlsMCGhp4WdzYOSbc0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dwia8mi6ngkIDGj912sae56z4bE+WCLHe/apI8v7sp93t1W855zHXA+FAryr9brlYbhJoufGRkhPo+7MN2aE4c3a5lLKiKxuRqc2P7X3KGPm84wf3BVmzYfyB1hdoo1TA1/vcKrqm1nSHbvd5mYA0fVHpyJ0cj3B/jHR5rNMjKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W1SyQc8L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mVE5+ACP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 10:26:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739874391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMwiofBha6NPZ5ejUzGSgPFXmW/fOmFq0lNogG2BIZw=;
	b=W1SyQc8L7hNHz02sjvMpZot0Z0iBB6IB9JghpOZRytGtO1zNhHCNL7x2MO0Gd9MAMWtLTo
	XGRM5R7jWixsg/9e6aThxI+Ot1g+zVPoqttzWLd2bsFF5t6XJL0FLLs6/hY4pWkOvyXmHt
	H5WfA8lOykpx9IhWUwflghXR1gAR9nDBmymMEjyYlKUNvfdC9OgIDFDLufVRwRNFJhpwIe
	ajeAEOH99j8gt16F5dF5HEdazuNe7JH/SBWcA4z2lW2bkK9ckCKg5zUzd4dJwQhQTGAHS5
	CbbO/KEdibuT/SkU187IZTTTvqnjA6TOze4xQ9qxskho5Lv9WANrNWEKXmJ3SQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739874391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMwiofBha6NPZ5ejUzGSgPFXmW/fOmFq0lNogG2BIZw=;
	b=mVE5+ACPN6VarngMKoPpnRrnNXURI6F/bMQPTvcLzcB5P9h7Mi3oQPncBLizXwL6tcc1k3
	iv97HDUFs4YSoTDA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] i2c: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 Zack Rusin <zack.rusin@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6a0d31244560b76cc7e76954bf68dbe14a4761e3=2E17387?=
 =?utf-8?q?46904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C6a0d31244560b76cc7e76954bf68dbe14a4761e3=2E173874?=
 =?utf-8?q?6904=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987439135.10177.15569548246627518878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     f1061c1442c1eddd71a25fe86516ee346ff4b7aa
Gitweb:        https://git.kernel.org/tip/f1061c1442c1eddd71a25fe86516ee346ff4b7aa
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:46:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 11:19:05 +01:00

i2c: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://lore.kernel.org/all/6a0d31244560b76cc7e76954bf68dbe14a4761e3.1738746904.git.namcao@linutronix.de

---
 drivers/i2c/busses/i2c-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index ee0d25b..9e5d454 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1723,8 +1723,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	spin_lock_init(&i2c_imx->slave_lock);
-	hrtimer_init(&i2c_imx->slave_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	i2c_imx->slave_timer.function = i2c_imx_slave_timeout;
+	hrtimer_setup(&i2c_imx->slave_timer, i2c_imx_slave_timeout, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS);
 
 	match = device_get_match_data(&pdev->dev);
 	if (match)

