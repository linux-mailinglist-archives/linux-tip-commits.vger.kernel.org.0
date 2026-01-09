Return-Path: <linux-tip-commits+bounces-7833-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CB4D09239
	for <lists+linux-tip-commits@lfdr.de>; Fri, 09 Jan 2026 12:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 299EE300EE5C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Jan 2026 11:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DEE33B97F;
	Fri,  9 Jan 2026 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rABCeQ1J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6MdnquZ6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8932BF21;
	Fri,  9 Jan 2026 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959979; cv=none; b=hD5nK/7rWJXVVNvw5ecub4RjFyB5vFSPu/jNAX6CVHH7gGocZUF0sd85kFiTyzNGtIR9670MlN4mH39pdOsj4MFsOvY9BqEUaZQhcXEYaYNrev1lbI2lj2Sx6gnsJEEtcb92HAROnSdiVefiC+jLUOo/fO7oxs3IEv9/FUD6Cqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959979; c=relaxed/simple;
	bh=pXewJvJfcozGbSkzrVZdEH5x/8YAS2ORxIbXp4l85iU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Db8xshhqbH8NXh+Ew4OF6kKctIaWpDxBVR8oUIY/2i4JplEytkZeydEdMns1LzDFftqHydBg7nQIR+lDiBZPWljqKsV9GwYitV6w6kNcraFqJS3+bo3FuqyFAymUyRF95nt2y2Ssy/FLftg5RkyBuUIWQFUSTkHIw5qwc/Gi6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rABCeQ1J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6MdnquZ6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 09 Jan 2026 11:59:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767959976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQtqVrOcsKxZXdQMgP9v1sTAW+d+vNo+PcB8ndI9YKE=;
	b=rABCeQ1JYzBAqTAhd3w6VCbcn+LLF5PXCASqTon1RGSchCW9xG05axPmZ90fgH+1eNmwK0
	jJis6AAOTsjLEbKWyv4qjVe4N+U+eqoMURwgPyiKZagk4Vil6cWsxs40EzE3L3x0vSoUOy
	LMHUGgUJBIUZDaZ7uI2QkdtNdRRP+DZZkwRXESf5LPasXcjLKlzYBRL/o47llc42A9oUOL
	+IgEmajfO3nFOrbiti2VjruLm+QyzPmNKrTOVYivQLc7aCisfW3elTfHZe6n2jCfV8lsR7
	ozc8Wt/ARcZcd+bu3LTKhJGVA2q6QmsXaLKP+X+tf5FGJdJDGisSDfHkj6XvEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767959976;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQtqVrOcsKxZXdQMgP9v1sTAW+d+vNo+PcB8ndI9YKE=;
	b=6MdnquZ6kEAC/ThE5rEIeBZFXrNZ1xgE4yFBi/AgcGkpnRVcsg8ZfO8OUn27xTh/7t4NE5
	sogZNbGIelLGamDg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/CPU/AMD: Simplify the spectral chicken fix
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251230110731.28108-1-bp@kernel.org>
References: <20251230110731.28108-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176795997185.510.4581421302854856357.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     736a2dcfdae72483a36793bc92182f33bd61d30e
Gitweb:        https://git.kernel.org/tip/736a2dcfdae72483a36793bc92182f33bd6=
1d30e
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Tue, 30 Dec 2025 12:07:31 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 11:36:52 +01:00

x86/CPU/AMD: Simplify the spectral chicken fix

msr_set_bit() takes a bit number to set but MSR_ZEN2_SPECTRAL_CHICKEN_BIT
is a bit mask. The usual pattern that code uses is a _BIT-named type
macro instead of a mask.

So convert it to a bit number to reflect that.

Also, msr_set_bit() already does the reading and checking whether the
bit needs to be set so use that instead of a local variable.

Fixup tabbing while at it.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://patch.msgid.link/20251230110731.28108-1-bp@kernel.org
---
 arch/x86/include/asm/msr-index.h       |  4 ++--
 arch/x86/kernel/cpu/amd.c              | 10 ++--------
 tools/arch/x86/include/asm/msr-index.h |  4 ++--
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-inde=
x.h
index 3d0a095..43adc38 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -794,8 +794,8 @@
 #define MSR_F19H_UMC_PERF_CTR           0xc0010801
=20
 /* Zen 2 */
-#define MSR_ZEN2_SPECTRAL_CHICKEN       0xc00110e3
-#define MSR_ZEN2_SPECTRAL_CHICKEN_BIT   BIT_ULL(1)
+#define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
+#define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	1
=20
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index bc94ff1..ab9158c 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -900,20 +900,14 @@ static void fix_erratum_1386(struct cpuinfo_x86 *c)
 void init_spectral_chicken(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_MITIGATION_UNRET_ENTRY
-	u64 value;
-
 	/*
 	 * On Zen2 we offer this chicken (bit) on the altar of Speculation.
 	 *
 	 * This suppresses speculation from the middle of a basic block, i.e. it
 	 * suppresses non-branch predictions.
 	 */
-	if (!cpu_has(c, X86_FEATURE_HYPERVISOR)) {
-		if (!rdmsrq_safe(MSR_ZEN2_SPECTRAL_CHICKEN, &value)) {
-			value |=3D MSR_ZEN2_SPECTRAL_CHICKEN_BIT;
-			wrmsrq_safe(MSR_ZEN2_SPECTRAL_CHICKEN, value);
-		}
-	}
+	if (!cpu_has(c, X86_FEATURE_HYPERVISOR))
+		msr_set_bit(MSR_ZEN2_SPECTRAL_CHICKEN, MSR_ZEN2_SPECTRAL_CHICKEN_BIT);
 #endif
 }
=20
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/=
asm/msr-index.h
index 9e1720d..d4137a3 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -770,8 +770,8 @@
 #define MSR_F19H_UMC_PERF_CTR           0xc0010801
=20
 /* Zen 2 */
-#define MSR_ZEN2_SPECTRAL_CHICKEN       0xc00110e3
-#define MSR_ZEN2_SPECTRAL_CHICKEN_BIT   BIT_ULL(1)
+#define MSR_ZEN2_SPECTRAL_CHICKEN	0xc00110e3
+#define MSR_ZEN2_SPECTRAL_CHICKEN_BIT	1
=20
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9

