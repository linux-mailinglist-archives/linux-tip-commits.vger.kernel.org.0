Return-Path: <linux-tip-commits+bounces-3154-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D898B9FF3D9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 12:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDBD161ABB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A7B1C5F34;
	Wed,  1 Jan 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q6SMM2Uc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eshNnEeg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497BD12C470;
	Wed,  1 Jan 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735731856; cv=none; b=dvTV1v+tW64Vp+c9HEtFzJurBW8bcVZqBqov0NSjxxKfzk2dyr+l0hqH0pUbKRTNDvcFrpHR2Yhu2Gi9iyWfaAFww/cHej2ptTyKSMQ/iSVWS4BGFbi/V1AgKOzCKnsT4AoRUsdgzk5Gbu89AN1IO/ptYtaB66htwnM91MFKvX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735731856; c=relaxed/simple;
	bh=gt9W6oXH9T2F+SPvhic3bWWRpUuvlWfw9o/U5psi4mI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K7hqkdcnWb8NIMT5eIRyF2MSYD7ron2pORjk8z5qnM4baZwKqlAESzbM9OiOhZ6MZrBntjTIJQgTtG2y/TgzcS5YG/3i2a4mKKit7yIo8NbspteIu06TdcFjmw9KcaLLaa4BaPOPTxzw3yCV5J0nMi2MPWboo7HLZCkwbfSEh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q6SMM2Uc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eshNnEeg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 Jan 2025 11:44:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735731848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYPP2+w0/0BiUDqB39JKPg7WqMy3K9/FhNadr34PegI=;
	b=q6SMM2UcYLUmKlsbGQKwI6Dkn/KNzi/7UA1HT4FBiylpDOlAM+8h0C/+jGEJmnLtRViQ9H
	PcaixaulPWP/TBoiSJHziTL0ECoW53po0B5/jW5OqQ2eSm/S9YgAibDf9ycQuHWxeog55Q
	CaXMef+GH1hFfxAnnP3kPDpS/Yidb81FRotv9KbWVcFpluT6tGrvB03KbkvygmCADYOPNx
	H3CCzHgMMY333jbQVXnqTVyYJJ+8GRKVzC6tDpvvJFhSpKCraeaMqM2gkuoADBpYn86oA4
	aI4Pw2lBqwOK/o4nTB1dtKlUe0kWE7joq2um+t1ioXwBexha6Xvwp+VHq7Mnww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735731848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AYPP2+w0/0BiUDqB39JKPg7WqMy3K9/FhNadr34PegI=;
	b=eshNnEeg7QAHr2g/8Z+bxhyf4BdTK6tC+qRhsHlxWsB8eiWzt373ex1Ps9ba0eab5q87DN
	Jc3vcmiEDuljIXDw==
From: "tip-bot2 for Qiuxu Zhuo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: ras/core] x86/mce: Remove the redundant mce_hygon_feature_init()
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241212140103.66964-7-qiuxu.zhuo@intel.com>
References: <20241212140103.66964-7-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173573184733.399.14070681087046735592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     053d18057e6292462f1b3f9460dd0c1e34609f67
Gitweb:        https://git.kernel.org/tip/053d18057e6292462f1b3f9460dd0c1e34609f67
Author:        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
AuthorDate:    Thu, 12 Dec 2024 22:01:02 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 31 Dec 2024 11:12:45 +01:00

x86/mce: Remove the redundant mce_hygon_feature_init()

Get HYGON to directly call mce_amd_feature_init() and remove the redundant
mce_hygon_feature_init().

Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lore.kernel.org/r/20241212140103.66964-7-qiuxu.zhuo@intel.com
---
 arch/x86/include/asm/mce.h     | 2 --
 arch/x86/kernel/cpu/mce/core.c | 8 ++------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index ea9ca76..eb2db07 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -386,8 +386,6 @@ static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 #endif
 
-static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
-
 unsigned long copy_mc_fragile_handle_tail(char *to, char *from, unsigned len);
 
 #endif /* _ASM_X86_MCE_H */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f90cbcb..0dc00c9 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2118,13 +2118,9 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_intel_feature_init(c);
 		break;
 
-	case X86_VENDOR_AMD: {
-		mce_amd_feature_init(c);
-		break;
-		}
-
+	case X86_VENDOR_AMD:
 	case X86_VENDOR_HYGON:
-		mce_hygon_feature_init(c);
+		mce_amd_feature_init(c);
 		break;
 
 	case X86_VENDOR_CENTAUR:

