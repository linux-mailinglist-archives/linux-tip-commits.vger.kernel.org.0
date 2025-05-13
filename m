Return-Path: <linux-tip-commits+bounces-5530-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4074AB5E4B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 23:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7937B1B44C79
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 21:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB631F8676;
	Tue, 13 May 2025 21:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VB+XZ/MT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uB+X+f1k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300C1CD0C;
	Tue, 13 May 2025 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747170899; cv=none; b=l13QfPcrP96YqXsPO32tI2g0t96dPnwKWfm6puTEBJ0cyFcBOx1CjSEWYfs9kg6PR+8EjW9JACb4Tbd7wPwMnt/VUKkABxKxw9mShcHpsBoKWVtIY7YDpYtlDZlpMUmKTTVhGMTojS1cEZZckkJeVuw7H5hOjm6zb5vMQVTLR/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747170899; c=relaxed/simple;
	bh=nb0IBU8fM3KpiYHeRD5KQGKwXUTP25haX5PMAaGtQpY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BSPt4MJQEcz68nv5uYhu9pYclvxDUxXpGC4mbJIDfDO35cakGOrxvXRMBDAL6KCUyi9dph8ozL9B6a2wEgPQiinVck6ScOk0owhqk2hOc39ZrAM/Oh0tI2kYUXFr8C7HFSGHvy8B+51TsAPnsmNMvL3gPHudmusVpp4cesk7R1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VB+XZ/MT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uB+X+f1k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 May 2025 21:14:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747170896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9M5qlKxWjDCgcBUgAOXWSXRjrRLc6NYXb/p9uKE1Ls=;
	b=VB+XZ/MTkJ9mQxREQW0f4FBAqk1FvzwYB4D/XvRkAMDRvXQ2SibsXR2bKkDDlFOd9azsmm
	Fkbp3So6CCEPJRJIEuQcc6Rm2F4Noh6URMseIHmEWlgZ7c6Xn4z02R+emV0f7x0gKwyKLq
	qq7ZOQsA9mtKhHFvtpbFKStVMFqci2BfKzUuUCEGxYb4XE7V0tO7z5LAgaqLrvCbHfIwzT
	/RKgqsXaUIPafcl9tZME8I00m1m5071q6SGv/Ob20v12udaCk5Yq+4KJP0wFhtHIsaktYo
	CtJ6eV7dNdZRhj3R0+Qb5gAprLByesn2jmj5uCPgUvWQ7ExNHm+lj8nu/Arz0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747170896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9M5qlKxWjDCgcBUgAOXWSXRjrRLc6NYXb/p9uKE1Ls=;
	b=uB+X+f1kR9AexJC+5yfkoeFWsSixkQTpUuBlsFklbvpeyGuuFe8Tv0ZHPYA+wzPReGRtFR
	prG8lQrk4qvIKtCQ==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/CPU/AMD: Add X86_FEATURE_ZEN6
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250513204857.3376577-1-yazen.ghannam@amd.com>
References: <20250513204857.3376577-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174717089530.406.2420743698265122757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     24ee8d9432b5744fce090af3d829a39aa4abf63f
Gitweb:        https://git.kernel.org/tip/24ee8d9432b5744fce090af3d829a39aa4abf63f
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 13 May 2025 20:48:57 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 13 May 2025 22:59:11 +02:00

x86/CPU/AMD: Add X86_FEATURE_ZEN6

Add a synthetic feature flag for Zen6.

  [  bp: Move the feature flag to a free slot and avoid future merge
     conflicts from incoming stuff. ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250513204857.3376577-1-yazen.ghannam@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/kernel/cpu/amd.c          | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6c2c152..9bb17c7 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -75,7 +75,7 @@
 #define X86_FEATURE_CENTAUR_MCR		( 3*32+ 3) /* "centaur_mcr" Centaur MCRs (= MTRRs) */
 #define X86_FEATURE_K8			( 3*32+ 4) /* Opteron, Athlon64 */
 #define X86_FEATURE_ZEN5		( 3*32+ 5) /* CPU based on Zen5 microarchitecture */
-/* Free                                 ( 3*32+ 6) */
+#define X86_FEATURE_ZEN6		( 3*32+ 6) /* CPU based on Zen6 microarchitecture */
 /* Free                                 ( 3*32+ 7) */
 #define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* "constant_tsc" TSC ticks at a constant rate */
 #define X86_FEATURE_UP			( 3*32+ 9) /* "up" SMP kernel running on UP */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2b36379..4e06baa 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -472,6 +472,11 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		case 0x60 ... 0x7f:
 			setup_force_cpu_cap(X86_FEATURE_ZEN5);
 			break;
+		case 0x50 ... 0x5f:
+		case 0x90 ... 0xaf:
+		case 0xc0 ... 0xcf:
+			setup_force_cpu_cap(X86_FEATURE_ZEN6);
+			break;
 		default:
 			goto warn;
 		}

