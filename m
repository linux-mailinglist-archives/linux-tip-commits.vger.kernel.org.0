Return-Path: <linux-tip-commits+bounces-6714-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1002B9890C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Sep 2025 09:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A552E45CB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Sep 2025 07:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E936527C864;
	Wed, 24 Sep 2025 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Zq4tWPg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p5vn8pVU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DD627B34E;
	Wed, 24 Sep 2025 07:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758699372; cv=none; b=ZMgUOc/ftm/DsBEXSUHMEZP2AqjH5ODPlNOjU6pmFzrjgr0kmDopfFmrLAwnYrPks2lxJQQJXpK5jjXym9e8+0hXVkGp1cdj1cVotIoxq8zXPvci7OGj338cefygEJgxRVmol/YUlMCxs8me0pOpfnZEC7hZDWEd2Ng2c1Q99wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758699372; c=relaxed/simple;
	bh=vlwNLMn4Df7qDS7z7hBxJ7Bm22dfyKwXqz4M+/V4neM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nHZLvXMRybLLZtteO0lb9EghBGyoWRpXo/EJc0LV16Diq+aYbX3Y0pRGq+DGulN4LNitsNQl5j35JfHijAlZdoawWlNieOrWCdHDrSiLCVLejV8/ry4McUX3+ZyiQf29yEmPaHVpcLDdq7BHRRAalySuGl9WzqDXqiGzhzf8iIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Zq4tWPg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p5vn8pVU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Sep 2025 07:36:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758699368;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/srcOAjzIc7FkWkSN9CbHIlNte0ITmznxjbxIe35sI=;
	b=3Zq4tWPgEoUHsxiO2VvZxz1T8QhKYT5WzjWReUFyx6jcIxMVgXXoPyIN/NEeSs1wGKEh8a
	zxxc3HTr+v6vG4FnsKYLycOSGZnYy1CWIx5FhtpMhs1e94cTm0UggC9bEbaRivp49yjSm+
	iVtDASz4640+s+8Un4eTgvWeQs47BUBQQ+GeX03RtPUjlz4f4KPbA8V//C2H70D9SFcTGg
	mrBTSVJOrMcoJjuDhqZFLcHpMVYwrEH4T/SzRlEfg0ac7WNixG1cIVZ6pKZxsBBlTTbExo
	TlEXhGDJjHy3fmG4ux8ZaZWpsjS2b7oqrgwNRxWT35U/q6GgOPJ5HGqW6qib5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758699368;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9/srcOAjzIc7FkWkSN9CbHIlNte0ITmznxjbxIe35sI=;
	b=p5vn8pVULJ+mpEdQ4b0Lpe0IOp1+Sy+4DgGLgeqet9NyBUs00Lp798Vz2UxSpor5MczXKN
	XEB5fbg8VgpT91Aw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/urgent] kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang < 17
Cc: Nathan Chancellor <nathan@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87frcm9kvv.ffs@tglx>
References: <87frcm9kvv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175869936727.709179.123691710197377219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     e2ffa15b9baa447e444d654ffd47123ba6443ae4
Gitweb:        https://git.kernel.org/tip/e2ffa15b9baa447e444d654ffd47123ba64=
43ae4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 16 Sep 2025 15:21:51 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 24 Sep 2025 09:29:15 +02:00

kbuild: Disable CC_HAS_ASM_GOTO_OUTPUT on clang < 17

clang < 17 fails to use scope local labels with CONFIG_CC_HAS_ASM_GOTO_OUTPUT=
=3Dy:

     {
     	__label__ local_lbl;
	...
	unsafe_get_user(uval, uaddr, local_lbl);
	...
	return 0;
	local_lbl:
		return -EFAULT;
     }

when two such scopes exist in the same function:

  error: cannot jump from this asm goto statement to one of its possible targ=
ets

There are other failure scenarios. Shuffling code around slightly makes it
worse and fail even with one instance.

That issue prevents using local labels for a cleanup based user access
mechanism.

After failed attempts to provide a simple enough test case for the 'depends
on' test in Kconfig, the initial cure was to mark ASM goto broken on clang
versions < 17 to get this road block out of the way.

But Nathan pointed out that this is a known clang issue and indeed affects
clang < version 17 in combination with cleanup(). It's not even required to
use local labels for that.

The clang issue tracker has a small enough test case, which can be used as
a test in the 'depends on' section of CC_HAS_ASM_GOTO_OUTPUT:

void bar(void **);
void* baz(void);

int  foo (void) {
    {
	    asm goto("jmp %l0"::::l0);
	    return 0;
l0:
	    return 1;
    }
    void *x __attribute__((cleanup(bar))) =3D baz();
    {
	    asm goto("jmp %l0"::::l1);
	    return 42;
l1:
	    return 0xff;
    }
}

Add another dependency to config CC_HAS_ASM_GOTO_OUTPUT for it and use the
clang issue tracker test case for detection by condensing it to obfuscated
C-code contest format. This reliably catches the problem on clang < 17 and
did not show any issues on the non broken GCC versions.

That test might be sufficient to catch all issues and therefore could
replace the existing test, but keeping that around does no harm either.

Thanks to Nathan for pointing to the relevant clang issue!

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/1886
Link: https://github.com/llvm/llvm-project/commit/f023f5cdb2e6c19026f04a15b5a=
935c041835d14
---
 init/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index e3eb63e..ecddb94 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -99,7 +99,10 @@ config GCC_ASM_GOTO_OUTPUT_BROKEN
 config CC_HAS_ASM_GOTO_OUTPUT
 	def_bool y
 	depends on !GCC_ASM_GOTO_OUTPUT_BROKEN
+	# Detect basic support
 	depends on $(success,echo 'int foo(int x) { asm goto ("": "=3Dr"(x) ::: bar=
); return x; bar: return 0; }' | $(CC) -x c - -c -o /dev/null)
+	# Detect clang (< v17) scoped label issues
+	depends on $(success,echo 'void b(void **);void* c(void);int f(void){{asm g=
oto("jmp %l0"::::l0);return 0;l0:return 1;}void *x __attribute__((cleanup(b))=
)=3Dc();{asm goto("jmp %l0"::::l1);return 2;l1:return 3;}}' | $(CC) -x c - -c=
 -o /dev/null)
=20
 config CC_HAS_ASM_GOTO_TIED_OUTPUT
 	depends on CC_HAS_ASM_GOTO_OUTPUT

