Return-Path: <linux-tip-commits+bounces-4889-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CF5A85949
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BE73B6F83
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277A9278E74;
	Fri, 11 Apr 2025 10:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zowzIRpD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u0f6+hG9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C6B278E67;
	Fri, 11 Apr 2025 10:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744366545; cv=none; b=KGPvKzxIxi8Z2Tf/13IczCnYbj83mUkDow69ndonJL+HJ4L0n2bwe0YLlLI0BhIRUXlypEV8FyGvlnZfrB+ETtuEzyF9JrWWyzyg/QlbAHDY/gVn0i64aQTp0YD+HeuwNf2idaBJgOWLY554MNBf4T9SfSS168dvPC40QMc8nzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744366545; c=relaxed/simple;
	bh=yhff2Dmm7Y8iOFKE1r2qu5UNquNChag6ePG9LM3UbjY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rAV0aLgOAXPoS3zVmlFyE24rEgXB8ju+AP9FrQCaPHZnfItnAD06u+xXdtzEDYCevBKHnjxxI071oLvi060+8g+garQLNoAUdm/OWmezonkiH9NbaCCPk8cOBxF+4QkSU/wwej0V4X2cdlrAZHb0EZDDWlSuM4DHU4P9fmmjeVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zowzIRpD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u0f6+hG9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:15:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744366541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aV56czXmq+FjwpZJwMSAMnCvlza5YySdc4rI5nQxInw=;
	b=zowzIRpDebDAgoNk8aGy754Iko1ithVzsjyHqdGw4eEuxaS3UGBKRGn6mhgW3f65VYk1fb
	DK67iKJr43iKV1R4iw/Pt1ZiDghze27d1ixhBQ1yZIsrNtzjQuRxr93qp8rv+nxQAL26LT
	3wBaxVmzjZAvxZLv8VAM1jR8FPTsiZkMOGNdOwBffkLTZ2BqPrXdbNbLHrCwJ+hXnP3czb
	7ihuNiOnryg4mEZlLxDvDNPTjIqCn/4QupuFCG5oeSm9SJACQsw1rYubl5qi+a0+z4WZng
	nV44jQEVTuHtA7TD7Y8oEd66I/JM8whqejLUY8yO1YjE4y1sAyZJ+CudMttouw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744366541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aV56czXmq+FjwpZJwMSAMnCvlza5YySdc4rI5nQxInw=;
	b=u0f6+hG9MftXdw1j3Xwqo9VgLuX/Ge9LblJffHLX2jXE4LO3Xa6UPkVYnc/m5amB6CQUQN
	gcILudLjTJKUH5CQ==
From: "tip-bot2 for Stefano Garzarella" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Register tpm-svsm platform device
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250410135118.133240-5-sgarzare@redhat.com>
References: <20250410135118.133240-5-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436653445.31282.8324011808720867533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     e396dd85172c6098e3b70b17e91424edc7bb2d8f
Gitweb:        https://git.kernel.org/tip/e396dd85172c6098e3b70b17e91424edc7bb2d8f
Author:        Stefano Garzarella <sgarzare@redhat.com>
AuthorDate:    Thu, 10 Apr 2025 15:51:16 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 10 Apr 2025 16:25:33 +02:00

x86/sev: Register tpm-svsm platform device

SNP platform can provide a vTPM device emulated by SVSM.

The "tpm-svsm" device can be handled by the platform driver registered by the
x86/sev core code.

Register the platform device only when SVSM is available and it supports vTPM
commands as checked by snp_svsm_vtpm_probe().

  [ bp: Massage commit message. ]

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20250410135118.133240-5-sgarzare@redhat.com
---
 arch/x86/coco/sev/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index ecd09da..654a4cc 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2688,6 +2688,11 @@ static struct platform_device sev_guest_device = {
 	.id		= -1,
 };
 
+static struct platform_device tpm_svsm_device = {
+	.name		= "tpm-svsm",
+	.id		= -1,
+};
+
 static int __init snp_init_platform_device(void)
 {
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
@@ -2696,7 +2701,11 @@ static int __init snp_init_platform_device(void)
 	if (platform_device_register(&sev_guest_device))
 		return -ENODEV;
 
-	pr_info("SNP guest platform device initialized.\n");
+	if (snp_svsm_vtpm_probe() &&
+	    platform_device_register(&tpm_svsm_device))
+		return -ENODEV;
+
+	pr_info("SNP guest platform devices initialized.\n");
 	return 0;
 }
 device_initcall(snp_init_platform_device);

