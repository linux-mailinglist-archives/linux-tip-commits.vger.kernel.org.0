Return-Path: <linux-tip-commits+bounces-6962-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F1DBE8F2E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Oct 2025 15:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4B3188AC83
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Oct 2025 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB052F6918;
	Fri, 17 Oct 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NwAgZ+kI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7KUfE2l5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57032F6915;
	Fri, 17 Oct 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708183; cv=none; b=Z2C3GHeuLByjyEO3j/769VXJL3UIHH8Fx0Pwrm+spzzqjkQMy41sNIQFWhcR89C+46slmefv95duY0S4/iy1k+uA3HYH2SI/S0o5HBjD8YFkTbwyYBGrjRXFmjW98nb+dZwbwrBnMxn0SkZQmLVYvw/239lD4Vod0oHd53L16sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708183; c=relaxed/simple;
	bh=5DNDA0GMQChm3mH+VReS9xJamPN1/BZVaNrEWVEk7TI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q61BsCz0B5tkcZHPXYevL4EDyh4q958EBjFohSDzArLR6n4dzwjeAEh2Q3SuRYKCHQpneLBzcdz/G/TURBWGSXA4nocmedVexmvoEHc5Zc52bjozzF3S5VMuVFu8i+n5MqSMhag/0GE26CSv9c2VSznQrRC/q1CAeMiLB8G3Qsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NwAgZ+kI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7KUfE2l5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 17 Oct 2025 13:36:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760708180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EzVFu/AzbOWN7RZ2IDoR8iql7FFbQMAWFA9m2isacQ=;
	b=NwAgZ+kInibQR87jU2Y+O3+44jI3O+gp4GC+XzATYG1jMJvVDnT90A9F2UybMJADW1YO8m
	Ct6SkSoKzmshr5RQ938J69u8S60hyheppbXGfLGhkaA16TPgV3jxKV1pFCeLBJiJkDIaGt
	RMX3uzepOm+vGBfpTsovyeP3TQkDuTitvqVbevBt5ICyhKTNpUmJBV3fjNWxFJXXPm9W7U
	u/2qVa5w9EV5SXLiGlQFJl1Mx8V9InTziZnqRFrok5pGYWBEX1qCcs0E3DTTXDipqXT5El
	eSuPo75xbVqxX57dSgf06hrrZuGbfN5ElOCjeln5njsxkrTBLRxBH8uUMgB0+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760708180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EzVFu/AzbOWN7RZ2IDoR8iql7FFbQMAWFA9m2isacQ=;
	b=7KUfE2l5DC0BPLy2mmwauHhG/VhgIjBL0In4PTRWGCmac7SGJImp4jP+5YsRrUw6j4667j
	qmjG60v+vIP20oCA==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/qcom-irq-combiner: Rename driver structure
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251017055226.7525-1-johan@kernel.org>
References: <20251017055226.7525-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176070817541.709179.14467580180064054334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     a7f25e00c4c97d4842117fba06b4c6064ba1e354
Gitweb:        https://git.kernel.org/tip/a7f25e00c4c97d4842117fba06b4c6064ba=
1e354
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Fri, 17 Oct 2025 07:52:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Oct 2025 15:18:18 +02:00

irqchip/qcom-irq-combiner: Rename driver structure

The "_probe" suffix of the driver structure name prevents modpost from
warning about section mismatches so replace it to catch any future
issues like the recently fixed probe function being incorrectly marked
as __init.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/qcom-irq-combiner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-c=
ombiner.c
index 9308088..0981900 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -266,11 +266,11 @@ static const struct acpi_device_id qcom_irq_combiner_id=
s[] =3D {
 	{ }
 };
=20
-static struct platform_driver qcom_irq_combiner_probe =3D {
+static struct platform_driver qcom_irq_combiner_driver =3D {
 	.driver =3D {
 		.name =3D "qcom-irq-combiner",
 		.acpi_match_table =3D ACPI_PTR(qcom_irq_combiner_ids),
 	},
 	.probe =3D combiner_probe,
 };
-builtin_platform_driver(qcom_irq_combiner_probe);
+builtin_platform_driver(qcom_irq_combiner_driver);

