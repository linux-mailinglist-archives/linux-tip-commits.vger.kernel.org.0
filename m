Return-Path: <linux-tip-commits+bounces-6457-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4925FB439C8
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB547B067F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C702FABFF;
	Thu,  4 Sep 2025 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o9kqkH41";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lxUgnsdV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C692FABE2;
	Thu,  4 Sep 2025 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984848; cv=none; b=hDjGkF6RWjQY3Q76BiRIGhKezU7giCjFBQyc8uo9RfXPIEWcB0c8QSHwYM2KNAWjS72Y5XQCTNYWs6U22K5GySQbot5/iH/H5jHLfsWGlUjfMo3CgHPcXD5NrWSTzApZvwv6GVbO2nzbylOYYd+mdDlwyYuLED5vKRYCoTTf6F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984848; c=relaxed/simple;
	bh=3BJ1iS550fspzjxDgBbG05We6vr3ElOhkNbJ/wTvRW4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ucmSw19I9+7QkEodoLyf7y9joXpCcz4PrBQTV/X68esxkE+L2taWD0GN3UyDOYfYHbunedYfXMGUvg0j8rMo5FzgML9tKXf0dJvLDodI26lZIixQrvk4978++js7ngjx4hpw8T76EiLgYzQAZmqH4x4RK3NT4DjUcWXB3vZb+Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o9kqkH41; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lxUgnsdV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=MdJ/dgFSanydI8i3QzyUU4DaeCLK5diXTNkljag2+L4=;
	b=o9kqkH41g2wSdxaBYZCQQKvRnYxaOyRRmjD87jwcBOCSJ5RpEGtP0yLdoNHaJcokQNEV7i
	JPdrqc39d2cg/POTqsLhbXG1y2kVFiyvQaR5ul+JZNUd8QLcs/aehRosVfiJeItVQx5kd5
	neXa8xAmKMCXpYvtnm/OSFSYQql83JMGYIujuAyXe8yAiwFMEa5sDaA+xLU0eagHU4yRjl
	loh1xuGFmKehaUGkGtRHbc/zsKHrpu0Kj1Dfh6F4MxQtr4u8AWtvLuTJhBbE9fXKEZRIsz
	n6dGpFlmABUzRj2T6ED23jyrve5WzgeQGrHufBvtdN3c+wdyP4hWNbp5VSMeKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=MdJ/dgFSanydI8i3QzyUU4DaeCLK5diXTNkljag2+L4=;
	b=lxUgnsdV9bl6eBi5Tf4ZgPNzAOeYh6wXHTiTm1RCoffkyO2u7WCjd9KiZ9v9zNGyp0qqZ4
	juNM0iBSyIU0/vBg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Zap snp_abort()
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698484439.1920.8373998293291474848.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     9f8d92a1fbb5a08e17f9d405a1ab27be64096d8c
Gitweb:        https://git.kernel.org/tip/9f8d92a1fbb5a08e17f9d405a1ab27be640=
96d8c
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 03 Sep 2025 18:14:54 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 04 Sep 2025 13:15:59 +02:00

x86/sev: Zap snp_abort()

It is a silly oneliner anyway. Replace it with its equivalent.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/boot/startup/sev-startup.c | 7 +------
 arch/x86/boot/startup/sme.c         | 2 +-
 arch/x86/include/asm/sev.h          | 2 --
 tools/objtool/noreturns.h           | 1 -
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-=
startup.c
index 39465a0..a9b0a9c 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -144,7 +144,7 @@ static struct cc_blob_sev_info *__init find_cc_blob(struc=
t boot_params *bp)
=20
 found_cc_info:
 	if (cc_info->magic !=3D CC_BLOB_SEV_HDR_MAGIC)
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
=20
 	return cc_info;
 }
@@ -218,8 +218,3 @@ bool __init snp_init(struct boot_params *bp)
=20
 	return true;
 }
-
-void __init __noreturn snp_abort(void)
-{
-	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
-}
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 2ddde90..e7ea65f 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -532,7 +532,7 @@ void __init sme_enable(struct boot_params *bp)
 	 * enablement abort the guest.
 	 */
 	if (snp_en ^ !!(msr & MSR_AMD64_SEV_SNP_ENABLED))
-		snp_abort();
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
=20
 	/* Check if memory encryption is enabled */
 	if (feature_mask =3D=3D AMD_SME_BIT) {
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f222bef..32c7dd9 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -512,7 +512,6 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned =
long npages);
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages);
 void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
-void __noreturn snp_abort(void);
 void snp_dmi_setup(void);
 int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct sv=
sm_attest_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
@@ -597,7 +596,6 @@ static inline void snp_set_memory_shared(unsigned long va=
ddr, unsigned long npag
 static inline void snp_set_memory_private(unsigned long vaddr, unsigned long=
 npages) { }
 static inline void snp_set_wakeup_secondary_cpu(void) { }
 static inline bool snp_init(struct boot_params *bp) { return false; }
-static inline void snp_abort(void) { }
 static inline void snp_dmi_setup(void) { }
 static inline int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *c=
all, struct svsm_attest_call *input)
 {
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 6a922d0..802895f 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -45,7 +45,6 @@ NORETURN(rewind_stack_and_make_dead)
 NORETURN(rust_begin_unwind)
 NORETURN(rust_helper_BUG)
 NORETURN(sev_es_terminate)
-NORETURN(snp_abort)
 NORETURN(start_kernel)
 NORETURN(stop_this_cpu)
 NORETURN(usercopy_abort)

