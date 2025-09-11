Return-Path: <linux-tip-commits+bounces-6550-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AF6B52A23
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 09:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F3A18987D1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 07:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CCC274FCE;
	Thu, 11 Sep 2025 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GZ+5C4rY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2IVeBLf5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D0270551;
	Thu, 11 Sep 2025 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757576100; cv=none; b=R9E7ZxXGGTzZKvorB+pj9fXDrS11QgmJuRTVp7QRIrPzTQym5eL0XRfqYfWBZNV4lftrtfPDVQQfB+W27lH9mSXa9LiExy/tXKSeD3L0p0SJi7NkYJWBlW5LFAtUteb5xvFZDDSjoUbdTKHkFKBkwxJatKyP3BgCLOdJTlLtgQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757576100; c=relaxed/simple;
	bh=nx6GuDLCEB5Imf9p8IVHjW3S7stvA5GaYrOEtB2WNj8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MwL+SHvTEJMudIUzbjv1vf4gr2R+5FmzZixyaGpV+za3wfRFhUeJg4GbTNJIGmeRAe9SebCDDMT958sQ+Xa5J6fF6MYhT4BlHG94V6LjEbJ/HLPRbLagsOSv40fUcUgos9P9Cw1jabrxbh1QP+AWtqq/QroiPMHnJhgK2hxTkEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GZ+5C4rY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2IVeBLf5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 07:34:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757576096;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5AxggaBUu2K5XN75Srxhaxw1mkxT4u3JcXNtDDrjvbo=;
	b=GZ+5C4rYwxnayIY3ie1EhwavMfn+2JlXCe+WVjzg//gHO1eWhaluUBnC41pgSzAPE7lzl5
	Uecx9KWGq/c0M2GuvsvLi1e04Cj7im45dS0+OXXB4B0Z9jWoTrlM5q44l7yBHtB3UUwTev
	7sqLGh1bGc+kpemq9VAzL/zd0sWgsgR23YBVarOewZ9nEVw+6vr8aWjlDnlb96aMjoY4+Y
	NwuJ4z8X3F7KTVudQIVeBK+YbsqgDeNMeCktxPv1mFSR06qdFhs7O2xPcsp1VBDGsCAa6Y
	S54zDipAXWOk0V6ytuLQuPrxFe/XigG6NWWa9mtVN4P9ibvUqv8FHfdywlZZ+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757576096;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5AxggaBUu2K5XN75Srxhaxw1mkxT4u3JcXNtDDrjvbo=;
	b=2IVeBLf5K1sU75FGK8p6LpHw7zMtyoEtYEtT46T9YXWl8uQD6mdpdIEN6vLGOyBFQtt2mc
	SXTz0wlBr9v5mLBA==
From: "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cfi: Add "debug" option to "cfi=" bootparam
Cc: Kees Cook <kees@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175757609542.709179.13938862888547182704.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     026211c40b055485b4c65c10d644a92864623225
Gitweb:        https://git.kernel.org/tip/026211c40b055485b4c65c10d644a928646=
23225
Author:        Kees Cook <kees@kernel.org>
AuthorDate:    Wed, 03 Sep 2025 20:46:44 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Sep 2025 21:59:08 +02:00

x86/cfi: Add "debug" option to "cfi=3D" bootparam

Add "debug" option for "cfi=3D" bootparam to get details on early CFI
initialization steps so future Kees can find breakage easier.

Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250904034656.3670313-5-kees@kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  1 +-
 arch/x86/kernel/alternative.c                   | 16 ++++++++++++++++-
 2 files changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 8bbffbb..c8337d0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -624,6 +624,7 @@
 			bhi:	  Enable register poisoning to stop speculation
 				  across FineIBT. (Disabled by default.)
 			warn:	  Do not enforce CFI checking: warn only.
+			debug:    Report CFI initialization details.
=20
 	cgroup_disable=3D	[KNL] Disable a particular controller or optional feature
 			Format: {name of the controller(s) or feature(s) to disable}
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d8f4ac9..7d4a992 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1177,6 +1177,7 @@ void __init_or_module apply_seal_endbr(s32 *start, s32 =
*end) { }
 #endif
=20
 enum cfi_mode cfi_mode __ro_after_init =3D __CFI_DEFAULT;
+static bool cfi_debug __ro_after_init;
=20
 #ifdef CONFIG_FINEIBT_BHI
 bool cfi_bhi __ro_after_init =3D false;
@@ -1259,6 +1260,8 @@ static __init int cfi_parse_cmdline(char *str)
 		} else if (!strcmp(str, "off")) {
 			cfi_mode =3D CFI_OFF;
 			cfi_rand =3D false;
+		} else if (!strcmp(str, "debug")) {
+			cfi_debug =3D true;
 		} else if (!strcmp(str, "kcfi")) {
 			cfi_mode =3D CFI_KCFI;
 		} else if (!strcmp(str, "fineibt")) {
@@ -1707,6 +1710,8 @@ static int cfi_rewrite_callers(s32 *start, s32 *end)
 	return 0;
 }
=20
+#define pr_cfi_debug(X...) if (cfi_debug) pr_info(X)
+
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 			    s32 *start_cfi, s32 *end_cfi, bool builtin)
 {
@@ -1734,6 +1739,7 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *=
end_retpoline,
 	 * rewrite them. This disables all CFI. If this succeeds but any of the
 	 * later stages fails, we're without CFI.
 	 */
+	pr_cfi_debug("CFI: disabling all indirect call checking\n");
 	ret =3D cfi_disable_callers(start_retpoline, end_retpoline);
 	if (ret)
 		goto err;
@@ -1744,14 +1750,19 @@ static void __apply_fineibt(s32 *start_retpoline, s32=
 *end_retpoline,
 			cfi_bpf_hash =3D cfi_rehash(cfi_bpf_hash);
 			cfi_bpf_subprog_hash =3D cfi_rehash(cfi_bpf_subprog_hash);
 		}
+		pr_cfi_debug("CFI: cfi_seed: 0x%08x\n", cfi_seed);
=20
+		pr_cfi_debug("CFI: rehashing all preambles\n");
 		ret =3D cfi_rand_preamble(start_cfi, end_cfi);
 		if (ret)
 			goto err;
=20
+		pr_cfi_debug("CFI: rehashing all indirect calls\n");
 		ret =3D cfi_rand_callers(start_retpoline, end_retpoline);
 		if (ret)
 			goto err;
+	} else {
+		pr_cfi_debug("CFI: rehashing disabled\n");
 	}
=20
 	switch (cfi_mode) {
@@ -1761,6 +1772,7 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *=
end_retpoline,
 		return;
=20
 	case CFI_KCFI:
+		pr_cfi_debug("CFI: re-enabling all indirect call checking\n");
 		ret =3D cfi_enable_callers(start_retpoline, end_retpoline);
 		if (ret)
 			goto err;
@@ -1771,17 +1783,20 @@ static void __apply_fineibt(s32 *start_retpoline, s32=
 *end_retpoline,
 		return;
=20
 	case CFI_FINEIBT:
+		pr_cfi_debug("CFI: adding FineIBT to all preambles\n");
 		/* place the FineIBT preamble at func()-16 */
 		ret =3D cfi_rewrite_preamble(start_cfi, end_cfi);
 		if (ret)
 			goto err;
=20
 		/* rewrite the callers to target func()-16 */
+		pr_cfi_debug("CFI: rewriting indirect call sites to use FineIBT\n");
 		ret =3D cfi_rewrite_callers(start_retpoline, end_retpoline);
 		if (ret)
 			goto err;
=20
 		/* now that nobody targets func()+0, remove ENDBR there */
+		pr_cfi_debug("CFI: removing old endbr insns\n");
 		cfi_rewrite_endbr(start_cfi, end_cfi);
=20
 		if (builtin) {
@@ -2324,6 +2339,7 @@ void __init alternative_instructions(void)
=20
 	__apply_fineibt(__retpoline_sites, __retpoline_sites_end,
 			__cfi_sites, __cfi_sites_end, true);
+	cfi_debug =3D false;
=20
 	/*
 	 * Rewrite the retpolines, must be done before alternatives since

