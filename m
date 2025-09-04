Return-Path: <linux-tip-commits+bounces-6481-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D97B43C37
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 14:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD097BA046
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA962FE053;
	Thu,  4 Sep 2025 12:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FWvub7qR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UZhL14+Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9C2FDC28;
	Thu,  4 Sep 2025 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990700; cv=none; b=STVmYJHbQZq1fmlpeT+yMzQwWkDAK1fhsmJwI5EcGKp6oABG9k060qYxKFHE8Oo2blWhJvDmtKbB+5z6vM7j16lX2rUySZZo4qP2GzxEeAAqYBv6A8+1/dU9bOHUJjPCaq7Jcd2+/uZPb9fMWzDFbWfBuZLF85+yuy97PnG7TfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990700; c=relaxed/simple;
	bh=5CWKqmlJvBHvrlfY8mIAcNiYwJLNvCuGG0Wvt3qGtdc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MihxTiFfuKqdnLSmvZU4bYt7wpQ93CjsDf65blrFGmsef0fIxV6OV+HZuHyT0DuhIT7D7F/cPUVo0yQxedkWOPk8IMoYPzKvksLBbRYAD4jWsxhZgKyVui7Re9bGDMFPhRNMIRoKmc5ERQh9Q5ngfnEj3M+gI4Esyi1TVuc4XYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FWvub7qR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UZhL14+Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 12:58:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756990696;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQaV+b69tR6KurUbFT61rKBZW4yoJqsRnGEXeKACsro=;
	b=FWvub7qRlYD48n1R6pg5fJLOzAUeVr/E2J/VYmZRgQus6FUyTGvZS5FtToMrR6wz6cmb7V
	L3PHdQ3iTpqDxMHsnaQHL0vcXEj9z6RXgTWp6jS/4/V7wbGbGFq6LA8ss/kuX6X+7X6cte
	B4sY5glMhiti3j4D1Ro3SKZLBOuWsYUpTDyVPmVbFa0nEdlVny1g6oxZOfpC4SN0zwPh/d
	aDg3HxvgD24d5nvOayA994zdw99sif1gsr+pEV7gC1Nxa+V34y7O4NtQLwO8ZoMWKFeKDv
	epT1I+HLUgiydtVNe9Iz1HN5WHZo7hShrj9APY4VS2atRAYqmi2n0rmgBsj0eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756990696;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQaV+b69tR6KurUbFT61rKBZW4yoJqsRnGEXeKACsro=;
	b=UZhL14+ZmQ4TrdD/reokt5SXC8sYj4htRflcR1W6xFvErW0aRLSyzmIPZwPgOLl28ruGoD
	6ERlfV8xPF3rr1AA==
From: "tip-bot2 for Chen Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] riscv: sophgo: dts: sg2044: Change msi irq type to
 IRQ_TYPE_EDGE_RISING
Cc: Chen Wang <unicorn_wang@outlook.com>, Thomas Gleixner <tglx@linutronix.de>,
 Inochi Amaoto <inochiama@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc38b9b1682af978473705b7e70b6faaa36fe5024=2E1756953?=
 =?utf-8?q?919=2Egit=2Eunicorn=5Fwang=40outlook=2Ecom=3E?=
References: =?utf-8?q?=3Cc38b9b1682af978473705b7e70b6faaa36fe5024=2E17569539?=
 =?utf-8?q?19=2Egit=2Eunicorn=5Fwang=40outlook=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175699069471.1920.11603308819725905034.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     8aefd2724451dedea1368d3915ab2dd5ecebc3cb
Gitweb:        https://git.kernel.org/tip/8aefd2724451dedea1368d3915ab2dd5ece=
bc3cb
Author:        Chen Wang <unicorn_wang@outlook.com>
AuthorDate:    Thu, 04 Sep 2025 11:00:59 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 14:52:47 +02:00

riscv: sophgo: dts: sg2044: Change msi irq type to IRQ_TYPE_EDGE_RISING

Fix msi irq type to be the correct type, although this field is not used yet.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Inochi Amaoto <inochiama@gmail.com> # Sophgo SRD3-10
Link: https://lore.kernel.org/all/c38b9b1682af978473705b7e70b6faaa36fe5024.17=
56953919.git.unicorn_wang@outlook.com

---
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sop=
hgo/sg2044.dtsi
index 6ec9557..320c4d1 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -214,7 +214,7 @@
 			reg-names =3D "clr", "doorbell";
 			#msi-cells =3D <0>;
 			msi-controller;
-			msi-ranges =3D <&intc 352 IRQ_TYPE_LEVEL_HIGH 512>;
+			msi-ranges =3D <&intc 352 IRQ_TYPE_EDGE_RISING 512>;
 			status =3D "disabled";
 		};
=20

