Return-Path: <linux-tip-commits+bounces-6522-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2AFB4A8FE
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 11:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEFAF7BE26E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C452D6621;
	Tue,  9 Sep 2025 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oABdvYC/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xyL5pzEk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1EB2D4B69;
	Tue,  9 Sep 2025 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411524; cv=none; b=Jjz3fbisPhNOag/MgopNuKOthfLI7VT+op91GQ3deju+PK9HBcpLy3fOPmV25ySpbQNDhwPuIex6O+s4+Q6zhwl22MI505AqkCvi9yURjy3sa7ci/qRlrrwLU4DFeV3Z4xQQIgAShUfsKoUeNmzmH6q5SXzST9zvojw7j7IUY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411524; c=relaxed/simple;
	bh=FptIBKAZmRUtquKzQoFIIlVtbXsjQ1RwURcbr1w25Ko=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L87i6TCeBiZs+ecM39gDsuGtHoNnwPLuQwQyUj8S2K8feREizC2SiaP5+E/im8bIp6P8D0qigEknfEPdb9txA/ruCK1sPsRKxlKmlkaKPbySQKA/MKYScg+IytelR5wUTQpW26sJWCX8vFUIylZTNQVC9/sWr1ZWRssEQ56eZWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oABdvYC/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xyL5pzEk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 09:52:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757411521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzVvxnTQ8gPknCX9zGWhsZoUk7y/1oG7oBWjA3ERIyI=;
	b=oABdvYC/IvGtP6devdXpcnFxBKMq5nuplBUxCz3/OeEqAwZMTIgFM+EnE1HQLEqP/xo7PC
	lXIdbArd4m4P/vgrA3QuXvUYlFci+ABF5TjLJYxRotK+ry9RXhjaoGyB47iibbkvESZYbC
	adNIC5pOaTQtHIKQTEQiAeGsy/kz54ZWGlDpk2dPPwWLo49nrnmbBXd/cFFfbEXo92dSvA
	LRo4XdlqhWXVrwVXeQ0PBQYOzjStEqyhIbbd1owUw3uSnphoL9aBmn6qWVoL5NclQdbBKZ
	7yyWECA4JOua+ud9bIjnlepJ0UIY6af7jYmptAv16u9zuGo2Yj8TzPw7DDIoYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757411521;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MzVvxnTQ8gPknCX9zGWhsZoUk7y/1oG7oBWjA3ERIyI=;
	b=xyL5pzEkyYQS//PRpAnazsc4iX3N91IDYh2dMO7/G4u8P4rMyYkotmySlMPGf4l5xzC6dp
	8lgMDrWrKJtL6zBA==
From: "tip-bot2 for Dan Carpenter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/gic-v5: Delete a stray tab
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Zenghui Yu <yuzenghui@huawei.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908082745.113718-2-lpieralisi@kernel.org>
References: <20250908082745.113718-2-lpieralisi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175741152058.1920.15323704771012674241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     5a5c48e870ed8d8aa9349be625c72f57bde45a4f
Gitweb:        https://git.kernel.org/tip/5a5c48e870ed8d8aa9349be625c72f57bde=
45a4f
Author:        Dan Carpenter <dan.carpenter@linaro.org>
AuthorDate:    Mon, 08 Sep 2025 10:27:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 11:51:08 +02:00

irqchip/gic-v5: Delete a stray tab

Delete a stray tab that is indenting the code erroneously.

[ lpieralisi: Reworded commit message]

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Link: https://lore.kernel.org/all/20250908082745.113718-2-lpieralisi@kernel.o=
rg

---
 drivers/irqchip/irq-gic-v5-irs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-ir=
s.c
index f845415..ad1435a 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -568,7 +568,7 @@ static void __init gicv5_irs_init_bases(struct gicv5_irs_=
chip_data *irs_data,
 			FIELD_PREP(GICV5_IRS_CR1_IST_RA, GICV5_NO_READ_ALLOC)	|
 			FIELD_PREP(GICV5_IRS_CR1_IC, GICV5_NON_CACHE)		|
 			FIELD_PREP(GICV5_IRS_CR1_OC, GICV5_NON_CACHE);
-			irs_data->flags |=3D IRS_FLAGS_NON_COHERENT;
+		irs_data->flags |=3D IRS_FLAGS_NON_COHERENT;
 	} else {
 		cr1 =3D FIELD_PREP(GICV5_IRS_CR1_VPED_WA, GICV5_WRITE_ALLOC)	|
 			FIELD_PREP(GICV5_IRS_CR1_VPED_RA, GICV5_READ_ALLOC)	|

