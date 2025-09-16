Return-Path: <linux-tip-commits+bounces-6652-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3EBB596AE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 14:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A18324D4C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DD621D5B0;
	Tue, 16 Sep 2025 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AItK9Rpm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZP6g26eY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDA719E992;
	Tue, 16 Sep 2025 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027274; cv=none; b=P5TWTqNkEFLNqcJptQJNT8cJ4ThU7FAvVmEh1VUturelOSjB3SpMAeyVrkuWICgTGn7K46RPBoJ4GYyLVh7mVCFYWm3v8ENeV7AR+WkISaDSV4joUxeBGxQ5SZzhr4eqIFl5aWXKfkZmOVF2z+StAScpPc7Qq+cRUm72VpAf3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027274; c=relaxed/simple;
	bh=EcixBwyEQ8LxE1bEM9IMz9/yUaZLS/zh9nXM+xNMuzo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iV/p1/RjjGHkFbxxxj0GZmLmPAOzOsiQ5JrfbYsNMo5b09oGUM2wa9mWCAQfV/gQ1zdZkgBvuZIZDGqV7cIomEGC/edBmQ9rU0fQoK9OdZld0VKE6e/1yS4OpaL4/y4Rfb30bdnkeIbwCAggPGa1HqJ3BcDLszgbt9AvVqyHXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AItK9Rpm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZP6g26eY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 12:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758027270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4qqC3PfzJvpDpqiQzNA3WnhrxoarhxuynbO++9ORjU=;
	b=AItK9RpmH5s2H0FaquLaQRRF/4oO8FxxN7DUIgTzSb14ELJbOI/3qaj5sVHWJYW4fcre0J
	Oz22T0hsQCuGRHMWL2fDFiXaZbq/Z0oA/PKISPAVquUQicFaiv+uJJNR5p28EyJlDs2+JW
	GYKMRswCQolcPq4Z3zPQOgAxR0FtKPiKpfxz291kSKJyjtN3IdA511FAIbyetUBldfx8GJ
	WCMzUH+KCGNYcXRY8JfRqXclmwQBnsiFyUmoq0JS8U5tks98v/F7YQHOrgbfL4NXd9XGQo
	jE/Gc+fsEczXMrHb+kc4J+mI0TmxkIJ4xRsHdAVd0QAn/zZSuFPE9Sy+9PR0cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758027270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4qqC3PfzJvpDpqiQzNA3WnhrxoarhxuynbO++9ORjU=;
	b=ZP6g26eYtfx2Vn6/Hgz+AL3O5PJUzrG/VJ7AVDyClb7d2Qxb5YY85RlI7xgdGMGxuK5JMV
	mHIL85J9mSa/RMDg==
From: "tip-bot2 for David Kaplan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Fix reporting of LFENCE retpoline
Cc: David Kaplan <david.kaplan@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250915134706.3201818-7-david.kaplan@amd.com>
References: <20250915134706.3201818-7-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175802726885.709179.3510577496146687695.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     d1cc1baef67ac6c09b74629ca053bf3fb812f7dc
Gitweb:        https://git.kernel.org/tip/d1cc1baef67ac6c09b74629ca053bf3fb81=
2f7dc
Author:        David Kaplan <david.kaplan@amd.com>
AuthorDate:    Mon, 15 Sep 2025 08:47:05 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 16 Sep 2025 13:21:21 +02:00

x86/bugs: Fix reporting of LFENCE retpoline

The LFENCE retpoline mitigation is not secure but the kernel prints
inconsistent messages about this fact.  The dmesg log says 'Mitigation:
LFENCE', implying the system is mitigated.  But sysfs reports 'Vulnerable:
LFENCE' implying the system (correctly) is not mitigated.

Fix this by printing a consistent 'Vulnerable: LFENCE' string everywhere
when this mitigation is selected.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250915134706.3201818-1-david.kaplan@amd.com
---
 arch/x86/kernel/cpu/bugs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 145f877..66dbb3b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2032,7 +2032,7 @@ static void __init spectre_v2_user_apply_mitigation(voi=
d)
 static const char * const spectre_v2_strings[] =3D {
 	[SPECTRE_V2_NONE]			=3D "Vulnerable",
 	[SPECTRE_V2_RETPOLINE]			=3D "Mitigation: Retpolines",
-	[SPECTRE_V2_LFENCE]			=3D "Mitigation: LFENCE",
+	[SPECTRE_V2_LFENCE]			=3D "Vulnerable: LFENCE",
 	[SPECTRE_V2_EIBRS]			=3D "Mitigation: Enhanced / Automatic IBRS",
 	[SPECTRE_V2_EIBRS_LFENCE]		=3D "Mitigation: Enhanced / Automatic IBRS + LFE=
NCE",
 	[SPECTRE_V2_EIBRS_RETPOLINE]		=3D "Mitigation: Enhanced / Automatic IBRS + =
Retpolines",
@@ -3559,9 +3559,6 @@ static const char *spectre_bhi_state(void)
=20
 static ssize_t spectre_v2_show_state(char *buf)
 {
-	if (spectre_v2_enabled =3D=3D SPECTRE_V2_LFENCE)
-		return sysfs_emit(buf, "Vulnerable: LFENCE\n");
-
 	if (spectre_v2_enabled =3D=3D SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled=
())
 		return sysfs_emit(buf, "Vulnerable: eIBRS with unprivileged eBPF\n");
=20

