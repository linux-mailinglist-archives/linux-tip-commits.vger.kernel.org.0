Return-Path: <linux-tip-commits+bounces-1478-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AAA911153
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jun 2024 20:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756201C20EBE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jun 2024 18:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0F51B3741;
	Thu, 20 Jun 2024 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XJ8wt9bD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hA1VS0ps"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128BB38389;
	Thu, 20 Jun 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909157; cv=none; b=E25UTHqE67xlVCatQmCxoQHk9jHF2o5uRG2PM7aJmdGqAZTyxq5rYEzonvSncxTBcqzVSXmhdKEYTUKmIycvSBmZ0ae2dQJbyoix26k2zrQIedXHKAYbKTmE0q9o6SiwvrnlPFtS0W17k7xMqEwcAcj0dPxYhJ6L5unsIFN1GI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909157; c=relaxed/simple;
	bh=wY+4CyvaDlwldDVaLoGpDs/ojADaVXDaA4pyAkvKSKg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CTof+4WWGnOH4jzJ91qvnHFfVJeon0SVwsjEY1TnR8YcqBKf6yG1oBm+hIRBZ4ggThb49IikO4lWZp4CH7nNb1ZDuUln3DKxieq4+AeD3knd1Lg7FRQS59pJX5BcbmYjiPNW8WBDP1fD30BnuRX+IRbq6ByVsOxGGVDUxb6XkmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XJ8wt9bD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hA1VS0ps; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Jun 2024 18:45:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718909152;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SuBNIBz8C0hSgawS+mYo0y1zvu1KO2bpIYfQtCr/7I=;
	b=XJ8wt9bDsWAV+FvWZx7Yk9QEfQHPOJb4AObIlYkHrnF4Lm0Ug4oZ9I1XXy3QYZLqiB4d7d
	rtNczY+rXCF3slxHmHqSODQnPR7CnZKSGCAeWii11wN8GpqGYxwyfSyuuk5XrGw8sqkeNo
	67CiXeVbBsxNYogNdGXnMcI2Uphv/exFrJeOVrXVayFo1UEc3ph7ed3FXh7nkvjd8veuYD
	2TQGTTiRVxK+cB30yJ0SLzm7WkK8+/w/Q+XgSpAtsYz4MVmyp+uZBzUcZQAS+kdRN8rqE1
	mkD+EpZukyFIdyE3iG7gP9u37K2SACRfesweHil+45aw5rEbHZQ4zMJRwiHeWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718909152;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SuBNIBz8C0hSgawS+mYo0y1zvu1KO2bpIYfQtCr/7I=;
	b=hA1VS0ps6pKUmygHHL64RU1lBkWidS0F/kYhGlcw7iSxsnstuYvNkdlxmaLhvl37XRBgnv
	YIteeFs4Ah0FzvAg==
From:
 tip-bot2 for Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sev-guest: Mark driver struct with __refdata to
 prevent section mismatch
Cc: u.kleine-koenig@pengutronix.de, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C4a81b0e87728a58904283e2d1f18f73abc69c2a1=2E17117?=
 =?utf-8?q?48999=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
References: =?utf-8?q?=3C4a81b0e87728a58904283e2d1f18f73abc69c2a1=2E171174?=
 =?utf-8?q?8999=2Egit=2Eu=2Ekleine-koenig=40pengutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171890915224.10875.8611592654168813177.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     3991b04d4870fd334b77b859a8642ca7fb592603
Gitweb:        https://git.kernel.org/tip/3991b04d4870fd334b77b859a8642ca7fb5=
92603
Author:        Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
AuthorDate:    Fri, 29 Mar 2024 22:54:41 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 20 Jun 2024 20:28:50 +02:00

virt: sev-guest: Mark driver struct with __refdata to prevent section mismatch

As described in the added code comment, a reference to .exit.text is ok for
drivers registered via module_platform_driver_probe(). Make this explicit to
prevent the following section mismatch warning:

  WARNING: modpost: drivers/virt/coco/sev-guest/sev-guest: section mismatch i=
n reference: \
    sev_guest_driver+0x10 (section: .data) -> sev_guest_remove (section: .exi=
t.text)

that triggers on an allmodconfig W=3D1 build.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.int=
el.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/4a81b0e87728a58904283e2d1f18f73abc69c2a1.1711=
748999.git.u.kleine-koenig@pengutronix.de
---
 drivers/virt/coco/sev-guest/sev-guest.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-=
guest/sev-guest.c
index 3752288..f714009 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -1203,8 +1203,13 @@ static void __exit sev_guest_remove(struct platform_de=
vice *pdev)
  * This driver is meant to be a common SEV guest interface driver and to
  * support any SEV guest API. As such, even though it has been introduced
  * with the SEV-SNP support, it is named "sev-guest".
+ *
+ * sev_guest_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound
+ * at runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
  */
-static struct platform_driver sev_guest_driver =3D {
+static struct platform_driver sev_guest_driver __refdata =3D {
 	.remove_new	=3D __exit_p(sev_guest_remove),
 	.driver		=3D {
 		.name =3D "sev-guest",

