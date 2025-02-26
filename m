Return-Path: <linux-tip-commits+bounces-3632-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B3EA4574E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 08:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465B37A2427
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 07:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD9E271286;
	Wed, 26 Feb 2025 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A4WLs/BD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t9/OFfAe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E945224249;
	Wed, 26 Feb 2025 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740556299; cv=none; b=kBNUp3zd8tijN4z1qa+KADTyhiv5J5gxiv6MPNmp5ppLvbIqmclh8Yz6mMbJu4OYy1b13+7eGfkZ59cX+yXfdFcFPlob5J2K/eQGs9tf/iK5LXDTTbyA8ewKm8ghdm6pY+MPHkkQ135LwFVyb5IbUkdcZKzxo5nPC/1xgbPGCwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740556299; c=relaxed/simple;
	bh=ZenfNeMV6+9GnXRrsF8Grg09WBJF1uOFpAAdO2uG1Pk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HT1s4ZjsS3MTCRjEbl6X0DPX/wOMU8yruDkiNGlmLFkwJQ6uHULQddL+iXbTQJrVq5Ob5ImI4SC7aMQs06uajTd/gLNbyMVCeiCHHaPs0txScFzMRlaeuODqDqD9VKL9ageMGeiOS5Iss2/19snjTzfWdiZHbGVKQ6YmlxSTi3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A4WLs/BD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t9/OFfAe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 07:51:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740556295;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+cv/hHQA4Bxqa7Tdev9Mtys53BxoXr0ORorFZ5HD2Y=;
	b=A4WLs/BD2jdXiYPqpS1pNAi3zDKjqrAM35xEE6dvnHrPP5UWK4fSBCA7mc8JteNjL7zBun
	YN89TL0bDEwy5rVI0T+iX+3Xd3Z1edMXtSfMzdCChjVVEC2flpD6GAFStbuenSZY60IUn7
	Ix3DuzuM1WXDwlD19SHGmp9+NXPZbIHQD8IeskLO9ATfeBy4RNGaT/TtWTwbnhh4tyauVS
	t6Qs3Vcr1DuB/OpALSLJkE9OLlW2tECen4XLjVApDOC9VgRqTxdCCAUmTYgMP5BuCNFirg
	DoI8xZl/BSVKMAadLpfv7m9aRoguR2LU3PMhcGTpDdQBB8ZRD7weRtdPU41GHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740556295;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+cv/hHQA4Bxqa7Tdev9Mtys53BxoXr0ORorFZ5HD2Y=;
	b=t9/OFfAeS/9WV9qIKsk8phrqbD5KgJFp4eibk+tPYUm3rs0a/IQ3VYqGM1iAaCAuEWoV7r
	2YF/iBg1GlBa0WBw==
From: "tip-bot2 for Chen Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] riscv: sophgo: dts: Add msi controller for SG2042
Cc: Chen Wang <unicorn_wang@outlook.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf47c6c3f0309a543d495cb088d6c8c5750bb5647=2E17405?=
 =?utf-8?q?35748=2Egit=2Eunicorn=5Fwang=40outlook=2Ecom=3E?=
References: =?utf-8?q?=3Cf47c6c3f0309a543d495cb088d6c8c5750bb5647=2E174053?=
 =?utf-8?q?5748=2Egit=2Eunicorn=5Fwang=40outlook=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174055629167.10177.2318536825336903930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     0edaa4593efe9377b4536211f9bc3812e3e53315
Gitweb:        https://git.kernel.org/tip/0edaa4593efe9377b4536211f9bc3812e3e53315
Author:        Chen Wang <unicorn_wang@outlook.com>
AuthorDate:    Wed, 26 Feb 2025 10:15:37 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 08:41:28 +01:00

riscv: sophgo: dts: Add msi controller for SG2042

Add msi-controller node to dts for SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/f47c6c3f0309a543d495cb088d6c8c5750bb5647.1740535748.git.unicorn_wang@outlook.com

---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index e62ac51..fef2a0e 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -173,6 +173,16 @@
 			#clock-cells = <1>;
 		};
 
+		msi: msi-controller@7030010304 {
+			compatible = "sophgo,sg2042-msi";
+			reg = <0x70 0x30010304 0x0 0x4>,
+			      <0x70 0x30010300 0x0 0x4>;
+			reg-names = "clr", "doorbell";
+			msi-controller;
+			#msi-cells = <0>;
+			msi-ranges = <&intc 64 IRQ_TYPE_LEVEL_HIGH 32>;
+		};
+
 		rpgate: clock-controller@7030010368 {
 			compatible = "sophgo,sg2042-rpgate";
 			reg = <0x70 0x30010368 0x0 0x98>;

