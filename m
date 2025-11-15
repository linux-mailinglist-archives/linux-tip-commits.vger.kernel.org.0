Return-Path: <linux-tip-commits+bounces-7368-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D516FC606B7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Nov 2025 15:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AC574E1C47
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Nov 2025 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E9C222582;
	Sat, 15 Nov 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vCp3JV7H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rxkq6TYr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D2018EAB;
	Sat, 15 Nov 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763215893; cv=none; b=KxLu/rXnYnybVQPnVjbTiEWzXA0HjH8/SnwGQnMZoHQr+YI+IV38vb+B4SwhnXpldj+wYJCuZxj+zzXnfgQ6wUFlyKKBEXX9joxEX1vgSHszukr3Wesv11f1xpfJjXJlat4SJwDfWbXOo4KUwIpa+47o/sluWqV2ZroiGKfODHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763215893; c=relaxed/simple;
	bh=72IhNiZ7eDecZVXjjhwdab//VSJZIMmIPimvDA1MA3M=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=j5vWI6/MK0Gshvzn53IlMcfNodJtA17cpRSNi9XE82oP+3C9Us9aDvlT4HPAyNNHbK+mgaw7U5UVwTHO6MUmltkDm7Gm+sUYo8h/BpCzP1zHa0ihjaHfiZU0k4t++UGcLioIObjrEsx9PLCT/2XXeeKtrLnsm9Bi6HY4HEcQM4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vCp3JV7H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rxkq6TYr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Nov 2025 14:11:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763215883;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=y9EHfUgfuBcr1irICEPB+zpPNxOeY2EDuyUbg2OMrTA=;
	b=vCp3JV7Hlo/VIoNMQ/D9hu/swzKco3mwsev2K/y9fufZQNKLnHaJ5bfmkQGyuyP/3ciG2s
	/siWhvM6eCksSIFubO1WNFiPHao42FMiuBA4j4KM+RLDLsan2u7VbtyM0nvjiRllPIVvq1
	EnBRLCWxWhII661oUHgYX0rTnTCT+QTDdFUoXdzGMwicGVKYt+TZHYq4SaLR+mQRajEFcD
	VmQTw7iAuGhpD31793G09vSanCli5y4iTQlkpnkDoAu7BfZg/XN9516Tt6IXOtZcC6PHlK
	nYvSrV8jXbe1keMFEVjm9qUvhFIQYPejpx74wzghgpGDUocVsiSgrYSHmVx81g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763215883;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=y9EHfUgfuBcr1irICEPB+zpPNxOeY2EDuyUbg2OMrTA=;
	b=rxkq6TYr3vc3gwO99brVBVITMLcLLMYR8TWgMb204qKLQUPkMckh0IC9wtRs4DdBbMJhqo
	GAWZUUDbQ+NnIdDA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Get rid of the forward declarations
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176321587992.498.4946350631422084160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     e67997021fd0d73f230ee0473da3ad4e3d3ce37c
Gitweb:        https://git.kernel.org/tip/e67997021fd0d73f230ee0473da3ad4e3d3=
ce37c
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 14 Nov 2025 18:10:04 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 14 Nov 2025 20:32:21 +01:00

x86/bugs: Get rid of the forward declarations

Get rid of the forward declarations of the mitigation functions by
moving their single caller below them.

No functional changes.

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20251105200447.GBaQut3w4dLilZrX-z@fat_crate.l=
ocal
---
 arch/x86/kernel/cpu/bugs.c | 233 ++++++++++++++----------------------
 1 file changed, 93 insertions(+), 140 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6a526ae..27f6860 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -53,53 +53,6 @@
  * mitigation option.
  */
=20
-static void __init spectre_v1_select_mitigation(void);
-static void __init spectre_v1_apply_mitigation(void);
-static void __init spectre_v2_select_mitigation(void);
-static void __init spectre_v2_update_mitigation(void);
-static void __init spectre_v2_apply_mitigation(void);
-static void __init retbleed_select_mitigation(void);
-static void __init retbleed_update_mitigation(void);
-static void __init retbleed_apply_mitigation(void);
-static void __init spectre_v2_user_select_mitigation(void);
-static void __init spectre_v2_user_update_mitigation(void);
-static void __init spectre_v2_user_apply_mitigation(void);
-static void __init ssb_select_mitigation(void);
-static void __init ssb_apply_mitigation(void);
-static void __init l1tf_select_mitigation(void);
-static void __init l1tf_apply_mitigation(void);
-static void __init mds_select_mitigation(void);
-static void __init mds_update_mitigation(void);
-static void __init mds_apply_mitigation(void);
-static void __init taa_select_mitigation(void);
-static void __init taa_update_mitigation(void);
-static void __init taa_apply_mitigation(void);
-static void __init mmio_select_mitigation(void);
-static void __init mmio_update_mitigation(void);
-static void __init mmio_apply_mitigation(void);
-static void __init rfds_select_mitigation(void);
-static void __init rfds_update_mitigation(void);
-static void __init rfds_apply_mitigation(void);
-static void __init srbds_select_mitigation(void);
-static void __init srbds_apply_mitigation(void);
-static void __init l1d_flush_select_mitigation(void);
-static void __init srso_select_mitigation(void);
-static void __init srso_update_mitigation(void);
-static void __init srso_apply_mitigation(void);
-static void __init gds_select_mitigation(void);
-static void __init gds_apply_mitigation(void);
-static void __init bhi_select_mitigation(void);
-static void __init bhi_update_mitigation(void);
-static void __init bhi_apply_mitigation(void);
-static void __init its_select_mitigation(void);
-static void __init its_update_mitigation(void);
-static void __init its_apply_mitigation(void);
-static void __init tsa_select_mitigation(void);
-static void __init tsa_apply_mitigation(void);
-static void __init vmscape_select_mitigation(void);
-static void __init vmscape_update_mitigation(void);
-static void __init vmscape_apply_mitigation(void);
-
 /* The base value of the SPEC_CTRL MSR without task-specific bits set */
 u64 x86_spec_ctrl_base;
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
@@ -233,99 +186,6 @@ static void __init cpu_print_attack_vectors(void)
 	}
 }
=20
-void __init cpu_select_mitigations(void)
-{
-	/*
-	 * Read the SPEC_CTRL MSR to account for reserved bits which may
-	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
-	 * init code as it is not enumerated and depends on the family.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_MSR_SPEC_CTRL)) {
-		rdmsrq(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
-
-		/*
-		 * Previously running kernel (kexec), may have some controls
-		 * turned ON. Clear them and let the mitigations setup below
-		 * rediscover them based on configuration.
-		 */
-		x86_spec_ctrl_base &=3D ~SPEC_CTRL_MITIGATIONS_MASK;
-	}
-
-	x86_arch_cap_msr =3D x86_read_arch_cap_msr();
-
-	cpu_print_attack_vectors();
-
-	/* Select the proper CPU mitigations before patching alternatives: */
-	spectre_v1_select_mitigation();
-	spectre_v2_select_mitigation();
-	retbleed_select_mitigation();
-	spectre_v2_user_select_mitigation();
-	ssb_select_mitigation();
-	l1tf_select_mitigation();
-	mds_select_mitigation();
-	taa_select_mitigation();
-	mmio_select_mitigation();
-	rfds_select_mitigation();
-	srbds_select_mitigation();
-	l1d_flush_select_mitigation();
-	srso_select_mitigation();
-	gds_select_mitigation();
-	its_select_mitigation();
-	bhi_select_mitigation();
-	tsa_select_mitigation();
-	vmscape_select_mitigation();
-
-	/*
-	 * After mitigations are selected, some may need to update their
-	 * choices.
-	 */
-	spectre_v2_update_mitigation();
-	/*
-	 * retbleed_update_mitigation() relies on the state set by
-	 * spectre_v2_update_mitigation(); specifically it wants to know about
-	 * spectre_v2=3Dibrs.
-	 */
-	retbleed_update_mitigation();
-	/*
-	 * its_update_mitigation() depends on spectre_v2_update_mitigation()
-	 * and retbleed_update_mitigation().
-	 */
-	its_update_mitigation();
-
-	/*
-	 * spectre_v2_user_update_mitigation() depends on
-	 * retbleed_update_mitigation(), specifically the STIBP
-	 * selection is forced for UNRET or IBPB.
-	 */
-	spectre_v2_user_update_mitigation();
-	mds_update_mitigation();
-	taa_update_mitigation();
-	mmio_update_mitigation();
-	rfds_update_mitigation();
-	bhi_update_mitigation();
-	/* srso_update_mitigation() depends on retbleed_update_mitigation(). */
-	srso_update_mitigation();
-	vmscape_update_mitigation();
-
-	spectre_v1_apply_mitigation();
-	spectre_v2_apply_mitigation();
-	retbleed_apply_mitigation();
-	spectre_v2_user_apply_mitigation();
-	ssb_apply_mitigation();
-	l1tf_apply_mitigation();
-	mds_apply_mitigation();
-	taa_apply_mitigation();
-	mmio_apply_mitigation();
-	rfds_apply_mitigation();
-	srbds_apply_mitigation();
-	srso_apply_mitigation();
-	gds_apply_mitigation();
-	its_apply_mitigation();
-	bhi_apply_mitigation();
-	tsa_apply_mitigation();
-	vmscape_apply_mitigation();
-}
-
 /*
  * NOTE: This function is *only* called for SVM, since Intel uses
  * MSR_IA32_SPEC_CTRL for SSBD.
@@ -3376,6 +3236,99 @@ void cpu_bugs_smt_update(void)
 	mutex_unlock(&spec_ctrl_mutex);
 }
=20
+void __init cpu_select_mitigations(void)
+{
+	/*
+	 * Read the SPEC_CTRL MSR to account for reserved bits which may
+	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
+	 * init code as it is not enumerated and depends on the family.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_MSR_SPEC_CTRL)) {
+		rdmsrq(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+
+		/*
+		 * Previously running kernel (kexec), may have some controls
+		 * turned ON. Clear them and let the mitigations setup below
+		 * rediscover them based on configuration.
+		 */
+		x86_spec_ctrl_base &=3D ~SPEC_CTRL_MITIGATIONS_MASK;
+	}
+
+	x86_arch_cap_msr =3D x86_read_arch_cap_msr();
+
+	cpu_print_attack_vectors();
+
+	/* Select the proper CPU mitigations before patching alternatives: */
+	spectre_v1_select_mitigation();
+	spectre_v2_select_mitigation();
+	retbleed_select_mitigation();
+	spectre_v2_user_select_mitigation();
+	ssb_select_mitigation();
+	l1tf_select_mitigation();
+	mds_select_mitigation();
+	taa_select_mitigation();
+	mmio_select_mitigation();
+	rfds_select_mitigation();
+	srbds_select_mitigation();
+	l1d_flush_select_mitigation();
+	srso_select_mitigation();
+	gds_select_mitigation();
+	its_select_mitigation();
+	bhi_select_mitigation();
+	tsa_select_mitigation();
+	vmscape_select_mitigation();
+
+	/*
+	 * After mitigations are selected, some may need to update their
+	 * choices.
+	 */
+	spectre_v2_update_mitigation();
+	/*
+	 * retbleed_update_mitigation() relies on the state set by
+	 * spectre_v2_update_mitigation(); specifically it wants to know about
+	 * spectre_v2=3Dibrs.
+	 */
+	retbleed_update_mitigation();
+	/*
+	 * its_update_mitigation() depends on spectre_v2_update_mitigation()
+	 * and retbleed_update_mitigation().
+	 */
+	its_update_mitigation();
+
+	/*
+	 * spectre_v2_user_update_mitigation() depends on
+	 * retbleed_update_mitigation(), specifically the STIBP
+	 * selection is forced for UNRET or IBPB.
+	 */
+	spectre_v2_user_update_mitigation();
+	mds_update_mitigation();
+	taa_update_mitigation();
+	mmio_update_mitigation();
+	rfds_update_mitigation();
+	bhi_update_mitigation();
+	/* srso_update_mitigation() depends on retbleed_update_mitigation(). */
+	srso_update_mitigation();
+	vmscape_update_mitigation();
+
+	spectre_v1_apply_mitigation();
+	spectre_v2_apply_mitigation();
+	retbleed_apply_mitigation();
+	spectre_v2_user_apply_mitigation();
+	ssb_apply_mitigation();
+	l1tf_apply_mitigation();
+	mds_apply_mitigation();
+	taa_apply_mitigation();
+	mmio_apply_mitigation();
+	rfds_apply_mitigation();
+	srbds_apply_mitigation();
+	srso_apply_mitigation();
+	gds_apply_mitigation();
+	its_apply_mitigation();
+	bhi_apply_mitigation();
+	tsa_apply_mitigation();
+	vmscape_apply_mitigation();
+}
+
 #ifdef CONFIG_SYSFS
=20
 #define L1TF_DEFAULT_MSG "Mitigation: PTE Inversion"

