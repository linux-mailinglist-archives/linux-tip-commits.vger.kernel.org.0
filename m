Return-Path: <linux-tip-commits+bounces-6092-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D898B02163
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2723C3B9DF5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 16:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620922F4323;
	Fri, 11 Jul 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GYA8flFn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YpVD+efJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A492E2F3C1B;
	Fri, 11 Jul 2025 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250188; cv=none; b=NlWT8GKQJLu4sgBJrner8XRDnuMsgVQjPIv9/ZtWdCwXAiMzBi2qgEFdO8TbcSaM+iDw7HaD4/ouwFtxOtiS+4oH5G6rxQ/8Tl2qOdxWKOrzPnmL/l8xlwarDoGA5yvW2HMpDRagFZAmnVDwEPIO3xOHvnExta5SAmDLEwDZE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250188; c=relaxed/simple;
	bh=HAX+miLbvicdBUhVQGpyCZtaYo/YbZv3ppaXXUKKZWk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RVJ30zza+2wOXas2+hhQQdK9wvJYz9NbF6ilqzCw9EPLGCUS805XgFBN2gTsKykEtVcT+X5QlhfMR5NjeRrqcQXz/N4mFtwpICYJQMtIO4z0/4kxO5VxJNvlWdGNU8XtggvW9dOHkPraGJ9vWK1h/goYGzO1MaD3dGt5Br5kPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GYA8flFn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YpVD+efJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 16:09:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752250184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vv+O7YGbkgvIayM6HUE6tHCpbZNrpmc/HAQwlWAcSMw=;
	b=GYA8flFnXti/JSrc1sbOYDeptz8bb1Fx1k9nUYHGZoxwI5Z1H2y02lb4iSWWSeFhUMYmGi
	pGLe7TORcRok8iuvWkK1NzhUZeY43BzXtuAwKqx0Xl6A0IZs5K3N4eh+U/OY3ylwFkGisF
	vlTYsMHCNCxmO1j/CeA+Ay+P4tuB0eMsdrslNCPmkoEhEwyIDMjMn8QslAd5K/elqPmBEE
	xxASsNZzpPh4ijHYFYvfTLPkzt8NYfRCU2TFpT5LaIW42J79kBtiuWzwRaFXAhzC1cT4LT
	XV95iBc9aJXQK3vljB99oP2RWy6w1Xc4zePtwBthXZCeiGUH9VyQG4IIDC9dOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752250184;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vv+O7YGbkgvIayM6HUE6tHCpbZNrpmc/HAQwlWAcSMw=;
	b=YpVD+efJ5NauM4tu5A0X+y0l2CJHcvQ22SFXvdj4xnw4kn0yGc+jE4sFdn+ciVGPPl4DKy
	THrMWLnnP2lTQxAQ==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Define attack vectors relevant for each bug
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250707183316.1349127-5-david.kaplan@amd.com>
References: <20250707183316.1349127-5-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225018389.406.12657174970653843515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     2d31d2874663cde2cab8c18bfb52ed8be6dfa958
Gitweb:        https://git.kernel.org/tip/2d31d2874663cde2cab8c18bfb52ed8be6dfa958
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 07 Jul 2025 13:32:59 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 11 Jul 2025 17:56:40 +02:00

x86/bugs: Define attack vectors relevant for each bug

Add a function which defines which vulnerabilities should be mitigated
based on the selected attack vector controls.  The selections here are
based on the individual characteristics of each vulnerability.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250707183316.1349127-5-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 56 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 88769c4..b083e7e 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -332,6 +332,62 @@ static void x86_amd_ssb_disable(void)
 #undef pr_fmt
 #define pr_fmt(fmt)	"MDS: " fmt
 
+/*
+ * Returns true if vulnerability should be mitigated based on the
+ * selected attack vector controls.
+ *
+ * See Documentation/admin-guide/hw-vuln/attack_vector_controls.rst
+ */
+static bool __init should_mitigate_vuln(unsigned int bug)
+{
+	switch (bug) {
+	/*
+	 * The only runtime-selected spectre_v1 mitigations in the kernel are
+	 * related to SWAPGS protection on kernel entry.  Therefore, protection
+	 * is only required for the user->kernel attack vector.
+	 */
+	case X86_BUG_SPECTRE_V1:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL);
+
+	case X86_BUG_SPECTRE_V2:
+	case X86_BUG_RETBLEED:
+	case X86_BUG_SRSO:
+	case X86_BUG_L1TF:
+	case X86_BUG_ITS:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST);
+
+	case X86_BUG_SPECTRE_V2_USER:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST);
+
+	/*
+	 * All the vulnerabilities below allow potentially leaking data
+	 * across address spaces.  Therefore, mitigation is required for
+	 * any of these 4 attack vectors.
+	 */
+	case X86_BUG_MDS:
+	case X86_BUG_TAA:
+	case X86_BUG_MMIO_STALE_DATA:
+	case X86_BUG_RFDS:
+	case X86_BUG_SRBDS:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST);
+
+	case X86_BUG_GDS:
+		return cpu_attack_vector_mitigated(CPU_MITIGATE_USER_KERNEL) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_HOST) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_USER_USER) ||
+		       cpu_attack_vector_mitigated(CPU_MITIGATE_GUEST_GUEST) ||
+		       (smt_mitigations != SMT_MITIGATIONS_OFF);
+	default:
+		WARN(1, "Unknown bug %x\n", bug);
+		return false;
+	}
+}
+
 /* Default mitigation for MDS-affected CPUs */
 static enum mds_mitigations mds_mitigation __ro_after_init =
 	IS_ENABLED(CONFIG_MITIGATION_MDS) ? MDS_MITIGATION_AUTO : MDS_MITIGATION_OFF;

