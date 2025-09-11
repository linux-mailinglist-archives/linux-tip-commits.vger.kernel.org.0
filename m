Return-Path: <linux-tip-commits+bounces-6569-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895E7B52E66
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519C2483C03
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D049E316901;
	Thu, 11 Sep 2025 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2gxM4Vtz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yhp4Vr/y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29532315789;
	Thu, 11 Sep 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586548; cv=none; b=m5TeP9NbABTGPhQtiROw50oCl4vIlJK39pSDAweXAnfe/lCf6+4Zq/6y8Ro6Dnm9rhNZK2k5AtQtS6fDG7LW7QHW/P1OhUy+KmvM5WE/6FqEYCKIjZyhYB0Bs5aiL8tFz/wekxlO/ZL2UL58VchVdYHylBVAS5G9+HbN0OREnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586548; c=relaxed/simple;
	bh=CvTwIwObffw2f/flWXoMkBXXTqr5z2Qx7zAdMWCSfYw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Y8dg8mDqOM8bSM4kvCJDVSndDBKDNoCHjd315W8LpMnQXNTtNQWREHIiAB8+iebJ15R8dgRI1jPJdB81HBcBaOkwQ6P7GDrZDMHJZ71zcsj2KWLjhefgzC5vjoy/76VU5YVvYDxvDz6JFQSi0kmd3gMr3tPMFIiziIY0yH5hucE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2gxM4Vtz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yhp4Vr/y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:29:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586545;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J3S5S9vSIUYpWkseec4Pgq0mxxpUs4WEJRoqEUyKSDQ=;
	b=2gxM4VtzQVKv+jMYKiLe0clsHc9Mq66O8kp+nnFxZtXo34ut15G8c4VFC+tHB6gdkFzAcK
	H0eVO2vNJDUD8+A17TeztDE6Juw4N5i25WNn3RNnl//6+SQ5sZJGuxYroQcqJ8Mw0MdpJt
	UAV/O2qlPEvfWb2+zdudSrXiYPhF+Le3GRGNei/C3Qpi6K00Rzj7/Uwq9GdJEEEE9WGWQE
	tShvMs/umcoAYLBsUkuN7sHuSHrmkj39FClM0eBnXua3g3pfIqV6T7yXS9vmkGnkcv7Pn7
	qdH5yiopUILkTTtJvnzEnihxOWcJ9RyLgho1ehVdxOKZMTH9eAdQTEdAXpsYhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586545;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=J3S5S9vSIUYpWkseec4Pgq0mxxpUs4WEJRoqEUyKSDQ=;
	b=Yhp4Vr/yy5dX00xyD+U7eqDEpLRutKbIolk7klIVZDF50Tuy9WY8fh1Mff1bjds78q3e50
	FSdvRcTt8e1vmNDw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Set CR4.MCE last during init
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175758654433.709179.12735346460717574219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     cfffcf97997bd35f4a59e035523d1762568bdbad
Gitweb:        https://git.kernel.org/tip/cfffcf97997bd35f4a59e035523d1762568=
bdbad
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:30=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:22:20 +02:00

x86/mce: Set CR4.MCE last during init

Set the CR4.MCE bit as the last step during init. This brings the MCA
init order closer to what is described in the x86 docs.

x86 docs:
  AMD		Intel
  		MCG_CTL
  MCA_CONFIG	MCG_EXT_CTL
  MCi_CTL	MCi_CTL
  MCG_CTL
  CR4.MCE	CR4.MCE

Current Linux:
  AMD		Intel
  CR4.MCE	CR4.MCE
  MCG_CTL	MCG_CTL
  MCA_CONFIG	MCG_EXT_CTL
  MCi_CTL	MCi_CTL

Updated Linux:
  AMD		Intel
  MCG_CTL	MCG_CTL
  MCA_CONFIG	MCG_EXT_CTL
  MCi_CTL	MCi_CTL
  CR4.MCE	CR4.MCE

The new init flow will match Intel's docs, but there will still be a
mismatch for AMD regarding MCG_CTL. However, there is no known issue with this
ordering, so leave it for now.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/kernel/cpu/mce/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0326fbb..9e31834 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1850,8 +1850,6 @@ static void __mcheck_cpu_init_generic(void)
 {
 	u64 cap;
=20
-	cr4_set_bits(X86_CR4_MCE);
-
 	rdmsrq(MSR_IA32_MCG_CAP, cap);
 	if (cap & MCG_CTL_P)
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
@@ -2276,6 +2274,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_setup_timer();
+	cr4_set_bits(X86_CR4_MCE);
 }
=20
 /*
@@ -2443,6 +2442,7 @@ static void mce_syscore_resume(void)
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
 	__mcheck_cpu_init_prepare_banks();
+	cr4_set_bits(X86_CR4_MCE);
 }
=20
 static struct syscore_ops mce_syscore_ops =3D {
@@ -2462,6 +2462,7 @@ static void mce_cpu_restart(void *data)
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_init_timer();
+	cr4_set_bits(X86_CR4_MCE);
 }
=20
 /* Reinit MCEs after user configuration changes */

