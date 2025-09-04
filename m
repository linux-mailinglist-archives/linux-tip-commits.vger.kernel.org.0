Return-Path: <linux-tip-commits+bounces-6482-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDF6B43C36
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 14:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1561893F11
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6828B2FE05D;
	Thu,  4 Sep 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XaqUMO0P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Y1imAQ1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0942FDC41;
	Thu,  4 Sep 2025 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990700; cv=none; b=LMmJ5tilywaNoXXFPw2kQo+NNaGsWUwbs3VS7xsbLFfieprP1B3QqbGWgMaThsYqzWn70mYdrGusoFhxUddf1jz4Ttiyj9sjb+NCRYOBSpLGMD/jav1WNs2wjkDq9n5yJVX8iZtT0O7V0lOyxy936OUe1f7aR832zsiOu5Wo8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990700; c=relaxed/simple;
	bh=50h5w2glyFBDJt51gm2JonAi7rlB7mk+DMpFjN4MXGg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hhzgvEPzMKsESuosyd+NSAACgj62qPgN6I+bZslrb4/7iwhFQoZqSFBq7+hNGaNu1Ur2yBG9p/X2ohILMK/zRdoufVkipFkmbPx/9AoFBGDkNy7AiP1pQjW1iHVUjlhHsFz6iW3WqF7zUFi3qMP+EZUYaTbceMRqA//RHfCbLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XaqUMO0P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Y1imAQ1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 12:58:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756990697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BIObAM67M5wh4yVrBOjs/p5LeCcvIpMJFmSPItGrdk=;
	b=XaqUMO0PDpJrcJ7C/7HXnOwuisJ2LZLLkTx8jJSl2wqKqXdnje72k6IB48BQJhwsL62MJe
	E+qLKGnDk8LHRJx2SSFlXwwQEflzbx4L4PSOpcpMLKrSkUjkcXYk83RSLmF3QLkvpnhExl
	uExDoxac80IJayji0tEpDQNRdins+TxeXi+Z+HOk1M9uIf5+OgPGG96bydnZ7Zsbk3YufH
	riELslz3Xqpq4hHgdXSzBIzWCOYNQkx4xiJrcKTMavo+QyUHyeX8apVdp/9vqjZf1Dt8gC
	cMqx1cUAtZ1Sa5qdDm+t2TU5yIOolPl3ymFzFvt88ZT6LcKklalwC0by/HrtQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756990697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0BIObAM67M5wh4yVrBOjs/p5LeCcvIpMJFmSPItGrdk=;
	b=2Y1imAQ1UfGOQuO6cBIkCDS9/FRffW3DxFEzPkdGjwfVhrrRF9IVMzyarks7McRQwTk0G7
	mmOEIK3ICM2wMMAQ==
From: "tip-bot2 for Chen Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] riscv: sophgo: dts: sg2042: Change msi irq type to
 IRQ_TYPE_EDGE_RISING
Cc: Chen Wang <unicorn_wang@outlook.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C831c1b650c575380d56ef3e2faed9bee278c9006=2E1756953?=
 =?utf-8?q?919=2Egit=2Eunicorn=5Fwang=40outlook=2Ecom=3E?=
References: =?utf-8?q?=3C831c1b650c575380d56ef3e2faed9bee278c9006=2E17569539?=
 =?utf-8?q?19=2Egit=2Eunicorn=5Fwang=40outlook=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175699069594.1920.957573941231970297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     a4bd4c330d5deaaa54db3a2ca4d2dd402d3a7248
Gitweb:        https://git.kernel.org/tip/a4bd4c330d5deaaa54db3a2ca4d2dd402d3=
a7248
Author:        Chen Wang <unicorn_wang@outlook.com>
AuthorDate:    Thu, 04 Sep 2025 11:00:37 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 14:52:47 +02:00

riscv: sophgo: dts: sg2042: Change msi irq type to IRQ_TYPE_EDGE_RISING

Fix msi irq type to be the correct type, although this field is not used yet.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/831c1b650c575380d56ef3e2faed9bee278c9006.17=
56953919.git.unicorn_wang@outlook.com

---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sop=
hgo/sg2042.dtsi
index b3e4d3c..6430c6e 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -190,7 +190,7 @@
 			reg-names =3D "clr", "doorbell";
 			msi-controller;
 			#msi-cells =3D <0>;
-			msi-ranges =3D <&intc 64 IRQ_TYPE_LEVEL_HIGH 32>;
+			msi-ranges =3D <&intc 64 IRQ_TYPE_EDGE_RISING 32>;
 		};
=20
 		rpgate: clock-controller@7030010368 {

