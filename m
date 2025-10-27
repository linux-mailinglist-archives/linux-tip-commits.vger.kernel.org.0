Return-Path: <linux-tip-commits+bounces-7007-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1DFC0F53C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D29D1892BCF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43947315D48;
	Mon, 27 Oct 2025 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ACU7Q2AR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qaWOkbcU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF14F315760;
	Mon, 27 Oct 2025 16:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582664; cv=none; b=pgFzCxwolM5q2vA+jJIGYmcyMSDCcnjvzpC2tDKawv5fDnvesyRwk5kWgEhSP2GEH7AKDpZ5J5hjzi4AeMGXhc5YLmMjOlsca/18zl3WYxPPGqt7OAV/KSeF1cLMhgXk5T3CJdw7oFuqKLhhEY6hmcKgDye/qAS7ljJ5tEeet0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582664; c=relaxed/simple;
	bh=NT90keN5drUDcuvhr6hzjChcSLujcyppJy6Tww1ZBvg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EBpgt/1nZt9EJWZ7yDMjfK31r3PzDExkBTyfZoA8eswdkaJpLGFqKMFcHfDo78cLvVMk2/SbJdFQkqu5uV2SQrkQdjWzsNkI3ga0RDY9pWVAgw4QSCjiqLZhgVM5IADQJ/OtebEBLxxnbeGMZM9qteuLMyBKGfqwAdK7hd1vb9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ACU7Q2AR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qaWOkbcU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:30:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582660;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucqRqG49jS5BSPbVUFdq0jj6nbOC4io7Ok3n2GiiQYs=;
	b=ACU7Q2ARAvrjsbaSwdMvvOtq4KNaptSegE2ZEPMBr70flkEJs+DQo7k239zJUyUQ0G/WsQ
	ugUDviTWdR5VmmeFXKzXOCxTAmQIqsDeUThL67pndWf/5GmiVNc07ySV/ewSPrnXyvoOXv
	sMcSwLtX6LSuuGkgQTR3MVZORcdWSgnJKOcBXRPXQ620Bw1hZ2CZR/AVwx9cfQaPQuHMhm
	lmQQ+5//svoAMOpcGExsuYn1vKHLAIC7b1XDejLKLmLJfSqhEafvF3JH5gDf6cLseJWcua
	GFEkj8h0bh645350VWTkTsHyoEJ3DHIc+MOUMLQ9ydenzxUEb89+n79LZv90uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582660;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucqRqG49jS5BSPbVUFdq0jj6nbOC4io7Ok3n2GiiQYs=;
	b=qaWOkbcUiPHMc03wWPpSpe3tvz2Za71tuOGU5PYqhahbsz0UGsN2SJy+JAONSrHZgAIZZE
	Q4bxXtryw0T/DfBQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] coresight: trbe: Request specific affinities for per
 CPU interrupts
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-21-maz@kernel.org>
References: <20251020122944.3074811-21-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158265876.2601451.9726565488830970827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4cdf4813f528cdadfc3778fed6b7783cfe1eb75a
Gitweb:        https://git.kernel.org/tip/4cdf4813f528cdadfc3778fed6b7783cfe1=
eb75a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:37 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:36 +01:00

coresight: trbe: Request specific affinities for per CPU interrupts

Let the TRBE driver request interrupts with an affinity mask matching the
TRBE implementation affinity.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://patch.msgid.link/20251020122944.3074811-21-maz@kernel.org
---
 drivers/hwtracing/coresight/coresight-trbe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing=
/coresight/coresight-trbe.c
index 8f17160..9f64f46 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1494,7 +1494,8 @@ static int arm_trbe_probe_irq(struct platform_device *p=
dev,
 	if (!drvdata->handle)
 		return -ENOMEM;
=20
-	ret =3D request_percpu_irq(drvdata->irq, arm_trbe_irq_handler, DRVNAME, drv=
data->handle);
+	ret =3D request_percpu_irq_affinity(drvdata->irq, arm_trbe_irq_handler, DRV=
NAME,
+					  affinity, drvdata->handle);
 	if (ret) {
 		free_percpu(drvdata->handle);
 		return ret;

