Return-Path: <linux-tip-commits+bounces-2351-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CC199374A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Oct 2024 21:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEC81F23DBF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Oct 2024 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F90F1DDA09;
	Mon,  7 Oct 2024 19:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D0Jdte3a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LQzvb2Qs"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9035D13B797;
	Mon,  7 Oct 2024 19:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728329152; cv=none; b=qRsiCnaJ8eX2XxBgrPwBzrdnNBRY8Xwr0WFxxtmU6sYmHt0beExqQbgAS9sjQ4yZ7GlAHaidxsyj0H1hnaM1e6Tc0iIk59C0vw8MST4Fr+ue7gQSYqgwA1uFTk9QH14Dnyxa7oEQSFvIcfZftY/eSCLfhMirkYuMxU04i7Jp6uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728329152; c=relaxed/simple;
	bh=c8btmeMjYsYPwLqpJH85iJIWtaCIkCZf+plIlI3EOQ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tIv7ZxPu3KU1kmXsV+fqE2kzjuO8J+k5wkOzL4J6oBXafI/Gn9uDl9+fksEDRGghH4PBu4h+jLdHLWgGSNo0+tzye04+fFg0uHrcjr1WrH+v9BRgPgrrXbp+ou1xvlPgiSOew/AxFNDxIXkRJL0sogylnmk7cSPI25X6qCpf4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D0Jdte3a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQzvb2Qs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Oct 2024 19:25:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728329141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hfd22iVVDzMgiBCZz6Mh/Yyew0iF3xO2ZcDQHuJPhaU=;
	b=D0Jdte3atUuYrp39Tu/KZjAJLTH7krWaDugwCcee4ExrtRGR8py5pHoNElQ3iNRZqudRX3
	uvsaRedeoy+HJPPnYG1qHh38gDg7WyQ6LOwIMQ2lhp3TstBH3Uwm0HeIVLf9v2iMaBysW4
	xgKUZjGfcIXLsg5/y5JSXhKh4af/aBCgFKrzPvi5Mx9jgifZbuMrZtSp/H8903CQhQ2d3F
	ok4tVPTDL5Bwa0LSV3TwmY9u9aYcA3reYN7LZf+kmBlsrqBFsfRjIQlB0VC8J/J0ZLjDfh
	rrath9o1BLFpCHANaKfXcIHcnVexmMlVw2JvpWLwFJpz6fOFa3xseua1LHaaTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728329141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hfd22iVVDzMgiBCZz6Mh/Yyew0iF3xO2ZcDQHuJPhaU=;
	b=LQzvb2QsOsvrTBRGDMh85geiRhQZrHWHTyXK6BYJt4uA28E9ep2iq7fxarOlmNd3HeXBqP
	CJ8JpkLExdfsLIAg==
From: "tip-bot2 for Richard Gong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/amd_nb: Add new PCI ID for AMD family 1Ah model 20h
Cc: Richard Gong <richard.gong@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Yazen Ghannam <yazen.ghannam@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240913162903.649519-1-richard.gong@amd.com>
References: <20240913162903.649519-1-richard.gong@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172832914079.1442.3300358639052918176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     f8bc84b6096f1ffa67252f0f88d86e77f6bbe348
Gitweb:        https://git.kernel.org/tip/f8bc84b6096f1ffa67252f0f88d86e77f6bbe348
Author:        Richard Gong <richard.gong@amd.com>
AuthorDate:    Fri, 13 Sep 2024 11:29:03 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Oct 2024 21:04:28 +02:00

x86/amd_nb: Add new PCI ID for AMD family 1Ah model 20h

Add new PCI ID for Device 18h and Function 4.

Signed-off-by: Richard Gong <richard.gong@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20240913162903.649519-1-richard.gong@amd.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/amd_nb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index dc5d321..9fe9972 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -44,6 +44,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4	0x12c4
+#define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F4	0x16fc
 #define PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4	0x124c
 #define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4	0x12bc
 #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
@@ -127,6 +128,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M60H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },

