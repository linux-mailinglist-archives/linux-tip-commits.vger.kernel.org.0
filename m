Return-Path: <linux-tip-commits+bounces-2622-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AB39B3270
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 15:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5D25B22994
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Oct 2024 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A141DB372;
	Mon, 28 Oct 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cBgTyEO0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hwoZP+Y9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4134A1DB95F;
	Mon, 28 Oct 2024 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124225; cv=none; b=owj2CiFsK0gsrefGGD+AKdYa7kh7UdChKM+Y8+K63eqW3PkpXNy/+WLnh1eyH133etpYJIpM9rOxF02KdGcQTcjH1i8zin19L0cZvbdYZDjK2oC3vrZhpOLd5Jtg9Z0/omYpgUf2LZScRg9IyY+enDr5c8Ho1BsIGRGpPiK2XLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124225; c=relaxed/simple;
	bh=cprADRHW2KMKuJmzL9CjVfM3Mlf1EMT1uHkzezQOo3A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QeLZFDN357vk/e2xaXBy2QC/acnWNQ9xxLBjxgNdtqCd4FN0gt6OqUNTuKeHlaUAfdGu+t6Q90eyFcAjWT3tdW+eXVB6KDwaKkxmRGnaUDHe/2Jc5W4MTwLO3iiP4gCxQS7zJuIySB/tCO3xC6p7arRX84ncf0duiuN3JkJo6Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cBgTyEO0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hwoZP+Y9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 28 Oct 2024 14:03:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730124221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ciPcXIFXMkCv/DwKs830BmdB+U2FhXRzX7u7tKg3Cw=;
	b=cBgTyEO0nPHENnM0MdnlNL1UCtViBWDJ4emReB2HRss+8DSE1Q0eUBlDacTQxx3QvSiFT7
	uvcda98SZRTNcE9QDtrtH9tWNeJxDFXVs6dTwHdNE/RMCSWc63AEH2NokbztwRddjPRs6Z
	UHXDI/rDt2eF14WekOK3Qxzd4mXADRJ5bE0rE3/ECG2amaxdz3Nws9uf2J74oobtT5p9Gx
	x5Jji+7+IJZjsalcVesgN6Js4/WTvkNXQEWs27NCpCyp6YhylhBThTL7JVdcmJg/PY6cTH
	1QqaoKDSrzTc7xpz7tkIOqZqyE7aVio7L6WMIXJL1wmnwbntrpt9LeTvAA5OYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730124221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ciPcXIFXMkCv/DwKs830BmdB+U2FhXRzX7u7tKg3Cw=;
	b=hwoZP+Y9d/zXR7VcNLEtC6KlOHYGh0dfpA6tiwVIJ++sACJYXaZ0RgDeTpzb+4VlckdRxS
	s3PT3HCHHH2GsxDQ==
From: "tip-bot2 for Qiuxu Zhuo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/intel: Use MCG_BANKCNT_MASK instead of 0xff
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tony Luck <tony.luck@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241025024602.24318-3-qiuxu.zhuo@intel.com>
References: <20241025024602.24318-3-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173012422075.1442.15350639883981860592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     754269ccf03d68da15b9e5cdd26a6464b81cec67
Gitweb:        https://git.kernel.org/tip/754269ccf03d68da15b9e5cdd26a6464b81cec67
Author:        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
AuthorDate:    Fri, 25 Oct 2024 10:45:54 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 28 Oct 2024 14:27:34 +01:00

x86/mce/intel: Use MCG_BANKCNT_MASK instead of 0xff

Use the predefined MCG_BANKCNT_MASK macro instead of the hardcoded
0xff to mask the bank number bits.

No functional changes intended.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20241025024602.24318-3-qiuxu.zhuo@intel.com
---
 arch/x86/kernel/cpu/mce/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index f6103e6..b3cd2c6 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -94,7 +94,7 @@ static int cmci_supported(int *banks)
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
 		return 0;
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
-	*banks = min_t(unsigned, MAX_NR_BANKS, cap & 0xff);
+	*banks = min_t(unsigned, MAX_NR_BANKS, cap & MCG_BANKCNT_MASK);
 	return !!(cap & MCG_CMCI_P);
 }
 

