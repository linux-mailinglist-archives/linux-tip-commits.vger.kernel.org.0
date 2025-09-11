Return-Path: <linux-tip-commits+bounces-6567-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E97B52E5F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64045686CB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4BC3164A6;
	Thu, 11 Sep 2025 10:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TkrDybqt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nLINQWRl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2575314A97;
	Thu, 11 Sep 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586547; cv=none; b=U6WB1zgiQMkMkuzQSNWyVyNVzHOkI+MTQrSIZduGbAtVDm++wJFE5dsR01Q8RQF1wRXQBbfOzqP4cq+VpUACrP3wx5e1NN8+h2vC5yfjoYvIPIOlBO2ML/ldcTf9IB2kuhQfk9cIwJlTxutWdwGOn7g9YDBbHmpJlRoF09VPaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586547; c=relaxed/simple;
	bh=4d94dUSb3MSmeYCwK69CoRMP0sYkDTmkdVZQ11s/5Hc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=p6Ar/SqqrfzMlj/m10B2KTd3JpQEHLO9UujZK2Iju/WITdK4vHgZYsJzzQ/PPRZZgqukOM0W5xogab2imorzeW2ZZZeQPUrORn+tzeGRAenm8PugF+zt8aDmP/whK5prSVbjAKX1jfQAxaerLiHvj8WM18xYyQzpMNDhPyTGdpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TkrDybqt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nLINQWRl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:29:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586543;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=oSe1Pcvla0pkC9OaG76p/a+w1t0q/OqFf2NLFl2PuWg=;
	b=TkrDybqtDnu04xweIRxBUXiAKUGDsqK/LglAGrysHFFc1hsS1+gFlLbGbDJw0gYJxv3WaW
	1gzLSYVpeaHw0WBKQWvrinYf1Z+ceMHhVvfV1G1xJcRICiU4AcpvObL3WROvEVEdyBWher
	av2lPOPUSJjOxMPGDxDeu9ZlTFW6AHC5LELtfeTSTZp9QUGZBZffxfaa8KqRinoHz+DCuq
	AyxjKyWixoqGXO+R87caQGnoZ/ienzB220354E64FvSrltGlqMCkgnRpCEb7lo3RWjw0UA
	KUT0nI4M+kdWGQnnY84zi471oJ28wI0xO3+oELBN8j3TZo2qO74LVj15ox6IPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586543;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=oSe1Pcvla0pkC9OaG76p/a+w1t0q/OqFf2NLFl2PuWg=;
	b=nLINQWRlk73hnsxppcxs+BpaI+vmJhBPZ2QvaU+nJgq3+zhiK89t68Cf25BwRK+5SXGJ+a
	ENFzaHnfMfBwCgDQ==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Define BSP-only SMCA init
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
Message-ID: <175758654222.709179.12409305584307949414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     c6e465b8d45a1bc717d196ee769ee5a9060de8e2
Gitweb:        https://git.kernel.org/tip/c6e465b8d45a1bc717d196ee769ee5a9060=
de8e2
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:32=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:22:50 +02:00

x86/mce: Define BSP-only SMCA init

Currently, on AMD systems, MCA interrupt handler functions are set during CPU
init. However, the functions only need to be set once for the whole system.

Assign the handlers only during BSP init. Do so only for SMCA systems to
maintain the old behavior for legacy systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c      | 6 ++++++
 arch/x86/kernel/cpu/mce/core.c     | 3 +++
 arch/x86/kernel/cpu/mce/internal.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3c6c19e..7345e24 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -684,6 +684,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		deferred_error_interrupt_enable(c);
 }
=20
+void smca_bsp_init(void)
+{
+	mce_threshold_vector	  =3D amd_threshold_interrupt;
+	deferred_error_int_vector =3D amd_deferred_error_interrupt;
+}
+
 /*
  * DRAM ECC errors are reported in the Northbridge (bank 4) with
  * Extended Error Code 8.
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 79f3dd7..a8cb7ff 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2244,6 +2244,9 @@ void mca_bsp_init(struct cpuinfo_x86 *c)
 	mce_flags.succor	 =3D cpu_feature_enabled(X86_FEATURE_SUCCOR);
 	mce_flags.smca		 =3D cpu_feature_enabled(X86_FEATURE_SMCA);
=20
+	if (mce_flags.smca)
+		smca_bsp_init();
+
 	rdmsrq(MSR_IA32_MCG_CAP, cap);
=20
 	/* Use accurate RIP reporting if available. */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/int=
ernal.h
index 64ac25b..6cb2995 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -294,12 +294,14 @@ static __always_inline void smca_extract_err_addr(struc=
t mce *m)
 	m->addr &=3D GENMASK_ULL(55, lsb);
 }
=20
+void smca_bsp_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }
+static inline void smca_bsp_init(void) { }
 #endif
=20
 #ifdef CONFIG_X86_ANCIENT_MCE

