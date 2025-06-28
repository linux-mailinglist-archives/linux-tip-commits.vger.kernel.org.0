Return-Path: <linux-tip-commits+bounces-5939-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA936AEC6AD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Jun 2025 13:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605E81BC3BA6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Jun 2025 11:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B75C242D8F;
	Sat, 28 Jun 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ti1et861";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZnPwvgV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFB219597F;
	Sat, 28 Jun 2025 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751110415; cv=none; b=LtbhZJs5tiTuCKAg3TekKTncGF8dOp9mJr6TZlr3HO7mzRZnBwkUT8FuliSWyO0ANNGGm/eljlPKJzQAFIDjQckAzgoAYi7lSkTJNLFtjGfiT2s4aMIQL40170qUTVvcOla5Oy+d0Q58NxpXFuGPUsDZ33ALXQLj4ptqE8PsUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751110415; c=relaxed/simple;
	bh=u/EvpI/ppZ5VWDLCcad6ywOT31+Uo83S9aUJeLbK91s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ma1qJqY20Y/CxgmxOwT5pN+o/dziTukCS6PKadxwNKjb9J94VJG/RVP0V5KUo6YiXzUkedbpDewHJf/G3YrzBKXPm9wNfDcg/mkkdyGdD2kaKGLp5Xw3bouJTXJIjX/nVaP4GkC9ySEJY20aj66CD99zlz82TinDDK+bZ7gCJlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ti1et861; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yZnPwvgV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Jun 2025 11:33:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751110405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUBW8poWorXqtJjJchiKXweiDiKRifLJh5YPqc6vU3I=;
	b=Ti1et861octp1nYuRe+D9UGyAUUeEYZ/d0ZETUk6DgUDuFPLFQko1cOwJ05VNAiEMFc3bc
	6UQonsvr0MTS+rK2tGJMoxSOVb/pn5e6f5qMyNi/tSAjMw5jaFrpnoZTkb4o0IoJ3JJG6b
	m9l+nDRWDiLOaKsSYdlOQpk7b7EvtwJ+BFAd0QK2SqmpYnuceZe6/nDxFN4OQrE8o+mXQj
	0V9WN2v3MxKwbhlXS/UQ5H478WHA+RiQa2ahTRvurkr46aS1f7206+JFJktC8yzNjCbvAl
	HNKPqKEp9jEOuAR8AmG0KUYkSik/ui3FoNMTyPtmGvAPJrvryYDsYT15SissFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751110405;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUBW8poWorXqtJjJchiKXweiDiKRifLJh5YPqc6vU3I=;
	b=yZnPwvgVoy+YKVilfNHVqUEHzOOAE8HTBsZ3p0UTpbR6pg1MPH5Ue6eKHVk5JPyjp2mRxq
	ZKE0WtSNz6W6y0Aw==
From: "tip-bot2 for JP Kobryn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/urgent] x86/mce: Make sure CMCI banks are cleared during
 shutdown on Intel
Cc: Aijay Adams <aijay@meta.com>, JP Kobryn <inwardvessel@gmail.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>,  <stable@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250627174935.95194-1-inwardvessel@gmail.com>
References: <20250627174935.95194-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175111040376.406.17564735803136963525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/urgent branch of tip:

Commit-ID:     30ad231a5029bfa16e46ce868497b1a5cdd3c24d
Gitweb:        https://git.kernel.org/tip/30ad231a5029bfa16e46ce868497b1a5cdd3c24d
Author:        JP Kobryn <inwardvessel@gmail.com>
AuthorDate:    Fri, 27 Jun 2025 10:49:35 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 28 Jun 2025 12:45:48 +02:00

x86/mce: Make sure CMCI banks are cleared during shutdown on Intel

CMCI banks are not cleared during shutdown on Intel CPUs. As a side effect,
when a kexec is performed, CPUs coming back online are unable to
rediscover/claim these occupied banks which breaks MCE reporting.

Clear the CPU ownership during shutdown via cmci_clear() so the banks can
be reclaimed and MCE reporting will become functional once more.

  [ bp: Massage commit message. ]

Reported-by: Aijay Adams <aijay@meta.com>
Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/20250627174935.95194-1-inwardvessel@gmail.com
---
 arch/x86/kernel/cpu/mce/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index efcf21e..9b149b9 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -478,6 +478,7 @@ void mce_intel_feature_init(struct cpuinfo_x86 *c)
 void mce_intel_feature_clear(struct cpuinfo_x86 *c)
 {
 	intel_clear_lmce();
+	cmci_clear();
 }
 
 bool intel_filter_mce(struct mce *m)

