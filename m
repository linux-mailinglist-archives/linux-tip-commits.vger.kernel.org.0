Return-Path: <linux-tip-commits+bounces-1434-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F0B90C844
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 13:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E187828BA94
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 11:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200EF3DABEB;
	Tue, 18 Jun 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m6PTTcU1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0FRhheNr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA221C18B;
	Tue, 18 Jun 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718703904; cv=none; b=r/0Yg2G9Aegs03JRrVSbgvzxWXcyMa8FzemRVpZWBc6YnKjzdWbmXOdQOrwShFygNJgCujFmiOdWRRoKPkubq4TqUewosafp0I7XjOt8iRq/btCtksREhxuVqW226zFK4VRJA1OLD4IOtRYVkB8tOStvQGKCPJOW2PmfcrDpEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718703904; c=relaxed/simple;
	bh=oebKwrttUVmM73oSc9jZm7usikhxVRW/WzcwhemPhHI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WkL2Cn9r7Jq5pFqCWIhNHDQQLrokbdJv4Xv3j1H7VicoB8kAhY7GkEhu/TlpjF8e3PyR8TjFkRX8K5RQD67+eKn5y+B9fPye/48uvwu47Ty5f7O6usscYkQv2051yqvgzo5uSXGHc72NVv97Yu31menGtDkHHNOmqwkA4Uje2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m6PTTcU1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0FRhheNr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 09:44:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718703899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wkq8JiVWcCZS2htfaDq2Clk1dHBhz/mqnOH3zj5SLms=;
	b=m6PTTcU1/HutWPcCWl2wFikw3dWbbvVaZqAI/gBmHAvVm+npTghUe9CYSXSsNxGIIXvynY
	RAzNBLUoqOBYOTPBuq9zKRwAiEHsju6qdz7LKV2Y94XO8vYtjjlkg6mFjOop6BLBYrkMXv
	VQ/BpnZmeuRkO8GaAjSyCI02fot/CdLcApjVgEkF1uohRivG0SfcDM2qIEvV580S+koKZ6
	43V0c8mvVhJidfR3zF9eifgvLZx4LN3w/ErJx4xpk+O6dEskSKl3g2+tONsZ6Lg/GEXXgg
	tke3ppO/6R3awu4/x/L9pldsOPHTjXQmOPVincc4UxjMW8XY+szw8whmScZmPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718703899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wkq8JiVWcCZS2htfaDq2Clk1dHBhz/mqnOH3zj5SLms=;
	b=0FRhheNryaTteMaPPpy1YtOT2P5gmGP5aWnnarIkGySTZ7/ubquN6O/RpSH0APo0zkYd7L
	FUcWQYB9PNoATPDA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] sev-guest: configfs-tsm: Allow the privlevel_floor
 attribute to be updated
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C5a736be9384aebd98a0b7c929660f8a97cbdc366=2E17176?=
 =?utf-8?q?00736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C5a736be9384aebd98a0b7c929660f8a97cbdc366=2E171760?=
 =?utf-8?q?0736=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171870389891.10875.4510448661656384300.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     614dc0fb76327dbd81abd4612fbc2e4ba8f205e6
Gitweb:        https://git.kernel.org/tip/614dc0fb76327dbd81abd4612fbc2e4ba8f205e6
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 05 Jun 2024 10:18:52 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 20:42:57 +02:00

sev-guest: configfs-tsm: Allow the privlevel_floor attribute to be updated

With the introduction of an SVSM, Linux will be running at a non-zero
VMPL. Any request for an attestation report at a higher privilege VMPL
than what Linux is currently running will result in an error. Allow for
the privlevel_floor attribute to be updated dynamically.

  [ bp: Trim commit message. ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/5a736be9384aebd98a0b7c929660f8a97cbdc366.1717600736.git.thomas.lendacky@amd.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 5 ++++-
 include/linux/tsm.h                     | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 4597042..3560b3a 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -892,7 +892,7 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	return 0;
 }
 
-static const struct tsm_ops sev_tsm_ops = {
+static struct tsm_ops sev_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = sev_report_new,
 };
@@ -979,6 +979,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
+	/* Set the privlevel_floor attribute based on the vmpck_id */
+	sev_tsm_ops.privlevel_floor = vmpck_id;
+
 	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
 	if (ret)
 		goto e_free_cert_data;
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index de8324a..50c5769 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -54,7 +54,7 @@ struct tsm_report {
  */
 struct tsm_ops {
 	const char *name;
-	const unsigned int privlevel_floor;
+	unsigned int privlevel_floor;
 	int (*report_new)(struct tsm_report *report, void *data);
 };
 

