Return-Path: <linux-tip-commits+bounces-7906-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1091D18205
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F398E304EFA5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D2B349B18;
	Tue, 13 Jan 2026 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="huGcHIag";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FUjqRRlA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A9349AF8;
	Tue, 13 Jan 2026 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301027; cv=none; b=n7wHB65IGGv9ENMZz6+0CyRG9ekPHhxrdqUKAlddAqhi8R8Ho32yj85mKB/i9cA+BVE4P2W3Ue77zWdv9RRMNyab0zjah4Uu0gr7ndLycjbt/OyPR6KSbiHQiKV0WMTE3sgAvlHkfU9bO2GhXybIpXRSVdO+0UwRPvivLmGEUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301027; c=relaxed/simple;
	bh=/GOs+rtIVK8eNoMI5u07TKPkmYKizqlOTMiM8t1ca9c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p80MLpPqJB5yZt0EmKPWrRUNk6lHNPuRTs01Cq7oRMKJsz1nu23hlFhSZiJouXoAFwTeaE2uWiHHMwMsdDzKxMYZWU1kIUPYk0okBYMkAdBn3H2PBi9RWt+jn8Vw58IUM1iIbtbVhmXxEHIwNAKSJwPzydibCfwzHmLyLsz7aqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=huGcHIag; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FUjqRRlA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:43:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJJU9ybEOHIaynyT125IN+Ki54en41Jq326mBFGzKq8=;
	b=huGcHIagpM0pq6367AtMWsHWONmFmO0Z/81C8ARBJ1qZWROUA03g9KYhX7Ncn+tDiYscNI
	aMMs7ZkiOYyLf/s4wx1maexXJ6PqWNPrm1IAc9xrRYAAw1ApRg8F1sk/SLIBrmLaelB9RG
	u2gzAv/jIUt++O9wETCJ3mytuUt0chwQNcndVrb7t6wPa4k/XX9qrT7mNHDw8Ndl4Si4s6
	TlH5jdknNKIU/sGdwPwPaBKmIF8rV0wuCUUm/fJ0YH42cTHO9s6/b+nQJlWQq/NouQvJSC
	qKaCOOiucK11ignksg3+Tu9nM6VjEOKWJBki5vkvJgvSXwUXJPNoqIh6wkAjTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OJJU9ybEOHIaynyT125IN+Ki54en41Jq326mBFGzKq8=;
	b=FUjqRRlAOvoOubrLzktFRXwCMmzSoSRbWRRvXonC2rAoN5XexPoYC7MoJtRw/XRVs8w08K
	Kvx3W7ls+0RDYqAw==
From: "tip-bot2 for Sasha Levin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: fix build failure due to missing
 libopcodes check
Cc: Sasha Levin <sashal@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251223120357.2492008-1-sashal@kernel.org>
References: <20251223120357.2492008-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830101373.510.4477595745511482785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     436326bc525d467e38db1da576139ec5f28268c5
Gitweb:        https://git.kernel.org/tip/436326bc525d467e38db1da576139ec5f28=
268c5
Author:        Sasha Levin <sashal@kernel.org>
AuthorDate:    Tue, 23 Dec 2025 07:03:57 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 13 Jan 2026 11:37:51 +01:00

objtool: fix build failure due to missing libopcodes check

Commit 59953303827e ("objtool: Disassemble code with libopcodes instead
of running objdump") added support for using libopcodes for disassembly.
However, the feature detection checks for libbfd availability but then
unconditionally links against libopcodes:

  ifeq ($(feature-libbfd),1)
      OBJTOOL_LDFLAGS +=3D -lopcodes
  endif

This causes build failures in environments where libbfd is installed but
libopcodes is not, since the test-libbfd.c feature test only links
against -lbfd and -ldl, not -lopcodes:

  /usr/bin/ld: cannot find -lopcodes: No such file or directory
  collect2: error: ld returned 1 exit status
  make[4]: *** [Makefile:109: objtool] Error 1

Additionally, the shared feature framework uses $(CC) which is the
cross-compiler in cross-compilation builds. Since objtool is a host tool
that links with $(HOSTCC) against host libraries, the feature detection
can falsely report libopcodes as available when the cross-compiler's
sysroot has it but the host system doesn't.

Fix this by replacing the feature framework check with a direct inline
test that uses $(HOSTCC) to compile and link a test program against
libopcodes, similar to how xxhash availability is detected.

Fixes: 59953303827e ("objtool: Disassemble code with libopcodes instead of ru=
nning objdump")
Assisted-by: claude-opus-4-5-20251101
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251223120357.2492008-1-sashal@kernel.org
---
 tools/objtool/Makefile | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index ad6e1ec..9b45031 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -72,23 +72,27 @@ HOST_OVERRIDES :=3D CC=3D"$(HOSTCC)" LD=3D"$(HOSTLD)" AR=
=3D"$(HOSTAR)"
=20
 #
 # To support disassembly, objtool needs libopcodes which is provided
-# with libbdf (binutils-dev or binutils-devel package).
+# with libbfd (binutils-dev or binutils-devel package).
 #
-FEATURE_USER =3D .objtool
-FEATURE_TESTS =3D libbfd disassembler-init-styled
-FEATURE_DISPLAY =3D
-include $(srctree)/tools/build/Makefile.feature
+# We check using HOSTCC directly rather than the shared feature framework
+# because objtool is a host tool that links against host libraries.
+#
+HAVE_LIBOPCODES :=3D $(shell echo 'int main(void) { return 0; }' | \
+			$(HOSTCC) -xc - -o /dev/null -lopcodes 2>/dev/null && echo y)
=20
-ifeq ($(feature-disassembler-init-styled), 1)
-	OBJTOOL_CFLAGS +=3D -DDISASM_INIT_STYLED
-endif
+# Styled disassembler support requires binutils >=3D 2.39
+HAVE_DISASM_STYLED :=3D $(shell echo '$(pound)include <dis-asm.h>' | \
+			$(HOSTCC) -E -xc - 2>/dev/null | grep -q disassembler_style && echo y)
=20
 BUILD_DISAS :=3D n
=20
-ifeq ($(feature-libbfd),1)
+ifeq ($(HAVE_LIBOPCODES),y)
 	BUILD_DISAS :=3D y
-	OBJTOOL_CFLAGS +=3D -DDISAS -DPACKAGE=3D"objtool"
+	OBJTOOL_CFLAGS +=3D -DDISAS -DPACKAGE=3D'"objtool"'
 	OBJTOOL_LDFLAGS +=3D -lopcodes
+ifeq ($(HAVE_DISASM_STYLED),y)
+	OBJTOOL_CFLAGS +=3D -DDISASM_INIT_STYLED
+endif
 endif
=20
 export BUILD_DISAS

