Return-Path: <linux-tip-commits+bounces-1528-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B09155B7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 19:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F88B1C22EF1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Jun 2024 17:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D78D19F46F;
	Mon, 24 Jun 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4QOtCsKw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TmiJcag8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8524319F46B;
	Mon, 24 Jun 2024 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251263; cv=none; b=SiKicKkrEqJ5CnVX0mwRVS2tgvQ/OyI7G7g9OjP84qPjl45n0iCJGuJ55dcUhn3JqGLmEXBHJgbgRKfzdzqntxNAOYb/oOYr5hkRdeb60fb3i0OCyTEbi7s7JIOT4ApHKHZlKSE5wFXMGSotgVf+q9bXyqwjhk9copUku3UUFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251263; c=relaxed/simple;
	bh=JEaIiXfnY/mV/Ce/8Fid7LFugke9DWSB4FLgt0gYBxM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fq6kkD6YIK/GaNsOLqkcAKbPjSmQ0H0J+M/z+OlbLHoUXQy3cQ2WUoelY0hNIN44/NhuEI+3u913s4E66S5vUXTniu0943QUStRAa1YX6MnN4+aWqoabZzE+D+03gN/W7P5JshwNLUaRB/mZggcDGO3sThNsiT/k1b6/YvD9I6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4QOtCsKw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TmiJcag8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Jun 2024 17:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719251260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTo/IrPLzj2pj8acj6CNnMNbSezpJ/ZYJ7Ha9EV2T/8=;
	b=4QOtCsKwLZ1wuM+jHd4QjNEZ2S5iMp9U8n4TPGjsDcXzjmz0YEXwMLObXCRCjSuDSp/HGj
	38ThFza3+n+J1KS6M6lWzvZ3wHilXO6MHgb1kScwTQvfJvu+m77sljncBOzAVYM0+znCZN
	UJl+IAOWrdJj07nN6Qqk7dPPec3x4M6gCiG2UMp3cRIes83KwsGoNcxrxU1cEak6WFUTro
	sSHzGi1Ky2yAaN2DpXRG9BR9nzp2b4+Ci1jcFpWRRnUp6c9G/1R14fxoVaUEZLrNTvNIcL
	yGLysqwHL+2b5ba25jTRPO0aPbMbUBITo0sZxWb+Seroijj/4f2ApSongyqG8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719251260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kTo/IrPLzj2pj8acj6CNnMNbSezpJ/ZYJ7Ha9EV2T/8=;
	b=TmiJcag8TDPe7UnQ2F634ztL5k6EKfBOfjFv2So4YGO3KIHtNmGROeXxD5WubAwTKRhZbS
	JKJq4s65ozMVoTDw==
From: tip-bot2 for Ilpo =?utf-8?q?J=C3=A4rvinen?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/misc] x86/pci/intel_mid_pci: Fix PCIBIOS_* return code handling
Cc: ilpo.jarvinen@linux.intel.com, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240527125538.13620-2-ilpo.jarvinen@linux.intel.com>
References: <20240527125538.13620-2-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171925126055.10875.9999726721914543171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     724852059e97c48557151b3aa4af424614819752
Gitweb:        https://git.kernel.org/tip/724852059e97c48557151b3aa4af4246148=
19752
Author:        Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
AuthorDate:    Mon, 27 May 2024 15:55:36 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 24 Jun 2024 19:19:55 +02:00

x86/pci/intel_mid_pci: Fix PCIBIOS_* return code handling

intel_mid_pci_irq_enable() uses pci_read_config_byte() that returns
PCIBIOS_* codes. The error handling, however, assumes the codes are
normal errnos because it checks for < 0.

intel_mid_pci_irq_enable() also returns the PCIBIOS_* code back to the
caller but the function is used as the (*pcibios_enable_irq) function
which should return normal errnos.

Convert the error check to plain non-zero check which works for
PCIBIOS_* return codes and convert the PCIBIOS_* return code using
pcibios_err_to_errno() into normal errno before returning it.

Fixes: 5b395e2be6c4 ("x86/platform/intel-mid: Make IRQ allocation a bit more =
flexible")
Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20240527125538.13620-2-ilpo.jarvinen@linux.in=
tel.com
---
 arch/x86/pci/intel_mid_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 8edd622..722a33b 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -233,9 +233,9 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		return 0;
=20
 	ret =3D pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &gsi);
-	if (ret < 0) {
+	if (ret) {
 		dev_warn(&dev->dev, "Failed to read interrupt line: %d\n", ret);
-		return ret;
+		return pcibios_err_to_errno(ret);
 	}
=20
 	id =3D x86_match_cpu(intel_mid_cpu_ids);

