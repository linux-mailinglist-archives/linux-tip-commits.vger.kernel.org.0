Return-Path: <linux-tip-commits+bounces-5110-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94117A9ADB7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 14:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CB4E1940EE3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Apr 2025 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B027A93D;
	Thu, 24 Apr 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gfM78MLQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kk16abOx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8817227A92E;
	Thu, 24 Apr 2025 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498395; cv=none; b=mboYYp4s3hrE/yN9XAQGOFNb7Ri/AX+4aqtihYcszlOE7MufhZdhkVIVxmqbheUVC9OqDVfVJCeHfwfuwy6jNhlKHscUXVxzPhc7Gz22O4PRjNrViZC98hPcirWpVDhy5MPag3NFrQ4LJ+u1oFNuVVgqSJMKYFlNcPQiK6FCT34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498395; c=relaxed/simple;
	bh=bOcBuw537nES9l4PPzQBgvVO/KArmd1yYxCutO3UvEA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CRFA20ueTEP8u7cVuqVu0CjHcrN0U99M272GhF1TXaKCLBV/KjGsO4yBp5k4gPPkuQKj03F9ytUIHiXFdwrt7iSfIuFP02mfplam26WR4rq8gm0e7Rclzyspe0ybc0RfcObnbiFRrDKDqt/jdLtedX2TQPa4MjO81w85qiFQQkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gfM78MLQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kk16abOx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Apr 2025 12:39:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745498391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHNMiWtVeYPrtClpQQjNHSHGTpZ8TlSO7G+a0x4aQao=;
	b=gfM78MLQsewBkfOnl8kf9A5NN6jqpb4qYMl5dCmDgrwCZT8uevxWmWo6RTJeoltTyNDcSL
	p3X/1O2NCK/Cn1QyWleLEgQqvtV1UgsBRi6+mCpOMuVirkfSekiHEC4RRHtgpb1AHYcQxQ
	JkDy0y8PX9ucutLjnmNVk6LsqoY8qpnqCeHl2Xt20t33zXVPL1B2GFF5tDIBQRTzPsLjmn
	z/D8AFFEsCKLn4oNamTdDthWMvw/bskHb+JTUHWPyiMoTArU0nnLAnVUQONa/E7HPgym6o
	oPBdROc7CBlEuxlnmRWTf2BGPLDs0Qn3JJd8mdMM7Y/Csu49ezvABWMyaDSn4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745498391;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nHNMiWtVeYPrtClpQQjNHSHGTpZ8TlSO7G+a0x4aQao=;
	b=kk16abOx7qOMifSqY5x4iQNOyTh0Dl6ENwWg9eVdB9KpyjglYUQ7SqvRm85LLeitM9lloU
	vr6uWCs7Y+HqnuAg==
From: "tip-bot2 for Cheng-Yang Chou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix typo in IRQ_NOTCONNECTED comment
Cc: "Cheng-Yang Chou" <yphbchou0911@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250410105144.214849-1-yphbchou0911@gmail.com>
References: <20250410105144.214849-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174549838755.31282.18203311859990087700.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0128816c42b52c6ee339718621aeda85855cd3be
Gitweb:        https://git.kernel.org/tip/0128816c42b52c6ee339718621aeda85855cd3be
Author:        Cheng-Yang Chou <yphbchou0911@gmail.com>
AuthorDate:    Thu, 10 Apr 2025 18:51:43 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Apr 2025 14:31:03 +02:00

genirq: Fix typo in IRQ_NOTCONNECTED comment

Fix a minor typo in the comment for IRQ_NOTCONNECTED:
"distingiush" is corrected to "distinguish".

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250410105144.214849-1-yphbchou0911@gmail.com

---
 include/linux/interrupt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c782a74..51b6484 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -140,7 +140,7 @@ extern irqreturn_t no_action(int cpl, void *dev_id);
 /*
  * If a (PCI) device interrupt is not connected we set dev->irq to
  * IRQ_NOTCONNECTED. This causes request_irq() to fail with -ENOTCONN, so we
- * can distingiush that case from other error returns.
+ * can distinguish that case from other error returns.
  *
  * 0x80000000 is guaranteed to be outside the available range of interrupts
  * and easy to distinguish from other possible incorrect values.

