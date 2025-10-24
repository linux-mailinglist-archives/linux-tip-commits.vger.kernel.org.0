Return-Path: <linux-tip-commits+bounces-6990-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C99D2C0765B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 18:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5EEEA34F611
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 16:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09188337699;
	Fri, 24 Oct 2025 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E25NU4mv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v4Yr9Jgu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1D5C96;
	Fri, 24 Oct 2025 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324635; cv=none; b=S8jRRZJNaTfKGephloK4yMi71YxBNALUOdbzq3r9yw7soB1vnryfgFuuXaFFs/dBIdR6/IGoGptPZsMWG6WVY+KRJA9leZGxr6UM6psjeXx3d+t9ac2HHLoKJTRBSxk/WCXxXhtimEESWVMurSz/GzCo7JXD16qOFX+4hJE/owA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324635; c=relaxed/simple;
	bh=802Y4tmgxbBWx3dUu8zf4xr92S7/bulKZ8RxUVea3po=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=O5Fbgzvx+BZzDzfdunYa0HRpElhXr8rq/L26srB6r2vrQvMLpq85Ucj4pskaSgyA/v4yLYwkSTQPwQcQqhFjxMenS8w/DH/MT8mzaBsOV3Bq8voxgFuavPXvkOu56O13Z5BCWBvjUpedPmJWNzCUNULNvOcnfLdQ/AywIiYoxu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E25NU4mv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v4Yr9Jgu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 16:50:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761324632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/srfrGB95F8KsTWpfmYi+eWdpXirMsAzyK/nFRRhmZc=;
	b=E25NU4mvqavYGGIAu9UGt43rQMbOcQbBc92QA1VTe35zJ3iTDavQgm9ZICsTdBJNiSfyL7
	7z2rgihuLbXlM3i1w3dIsWAmQcUQZCfVPQL/qQaW8T6D+JgWi154Zuce3WyVX45YqYGGsL
	2zNg9caG5jQnUbYsy6b7eYO5ghJO8ezD8l9h3/RIaGgWoSGSkwZgiaVCAQl0YS9yTDj7N7
	dJA+VngeTqwd8/CTST2PIKRrriCvp18QlSyxky+MoIDJ7caZGbGAQMPamjY8WcwVLOlAlk
	Jr7fjvWg8KsHn69ikwx2vs5Rsol80k12w5MUXOXALkjWPL8kVbaZWIr4wjLDPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761324632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/srfrGB95F8KsTWpfmYi+eWdpXirMsAzyK/nFRRhmZc=;
	b=v4Yr9JguQx8dSm4ZWwn0O33aKPQyVDzj0s9wJ565cxhpiJ9b0mUE/1kK/IBoVrhdYkXfLp
	lYxOtMK06F215iAQ==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Remove dead code which might prevent from
 building
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176132463064.2601451.4359851782380550403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     84dfce65a7ae7b11c7b13285a1b23e9a94ad37b7
Gitweb:        https://git.kernel.org/tip/84dfce65a7ae7b11c7b13285a1b23e9a94a=
d37b7
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 24 Oct 2025 14:59:59 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 24 Oct 2025 09:42:00 -07:00

x86/bugs: Remove dead code which might prevent from building

Clang, in particular, is not happy about dead code:

arch/x86/kernel/cpu/bugs.c:1830:20: error: unused function 'match_option' [-W=
error,-Wunused-function]
 1830 | static inline bool match_option(const char *arg, int arglen, const ch=
ar *opt)
      |                    ^~~~~~~~~~~~
1 error generated.

Remove a leftover from the previous cleanup.

Fixes: 02ac6cc8c5a1 ("x86/bugs: Simplify SSB cmdline parsing")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251024125959.1526277-1-andriy.shevchenko%40l=
inux.intel.com
---
 arch/x86/kernel/cpu/bugs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e08de5b..d7fa03b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1827,13 +1827,6 @@ void unpriv_ebpf_notify(int new_state)
 }
 #endif
=20
-static inline bool match_option(const char *arg, int arglen, const char *opt)
-{
-	int len =3D strlen(opt);
-
-	return len =3D=3D arglen && !strncmp(arg, opt, len);
-}
-
 /* The kernel command line selection for spectre v2 */
 enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_NONE,

