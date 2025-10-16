Return-Path: <linux-tip-commits+bounces-6872-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667DABE290F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25475546711
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D3432A3F2;
	Thu, 16 Oct 2025 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NvUkPoL5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QZpM3IGo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EBB2DE704;
	Thu, 16 Oct 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608357; cv=none; b=gR7+YcZVP12UGXyBYdHB6foHMZ37w+K9zjyYdNIoSpf/oe2ORd6Iuiho3LSsBd/pSI+Xsh4/hXHl81ZILMxjZxHlcPw1fJ+Sav6cep9PcH0FzKELhoiKMO/1qn0dYGlpM812u54huJ6HgO2evEiuOqt88gTRhAg6ftFi0K3uw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608357; c=relaxed/simple;
	bh=yL5t35uPRhWvW0Atd6itpWM2SzgfySdF2guK7B2jbcg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=rGCL5Ru+hHrC4KHzeGTFxnpuHXh/YsAjJSKN1OLI2YYW+KW48fJKpXFoYekBdk41XQomqg4H2FI0sHqe4NRbgzOq7sb+q7lWeDcGudF7mLysADm9PMB5l4yQU9X4udbUNw0VWgf5pasDnQ/gb9YWMF4wXuqnNg/O6FUOa6fHNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NvUkPoL5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QZpM3IGo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AL7W+unqanqQuC63Tc2YHz7cGpjhqFlU0mWjVEs3cKw=;
	b=NvUkPoL5xUZ8L84nw2YlAC5xDDYC3cBbs8lHd66vgf7ueza7PU3dZL5KHARSU1dBeQOWle
	/fEzrWZoKng31VmSRvTSQrvaeK13Ej+3dOHjeJafq81Iuug+N8yRmaJD5Y8r5lz6INIGqG
	38RckG8lhEhp9uC53dsfan99L0HR4vZ76gsEtruAd1Xf0/CMFlTaUqes1Z3WJc3l2C3p+Z
	MWL0qZyRWHTnIg+xh1+K6BAStOxwVe2XESQYpdDIfxvWrgTeyQeEb+xHdRT+szBl/tRH/p
	ThqQVzU+GajJ7jpzYCinLnhhunTFxmnlc0tl9qAckyZE0faLjmiJ+qvvHC+VQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=AL7W+unqanqQuC63Tc2YHz7cGpjhqFlU0mWjVEs3cKw=;
	b=QZpM3IGoGKKyElicuWGNdnZ5NvgOHUhk5Hp7mYnY+kaphbaSN01OPQoiJb+sYwLr5YmvY9
	k3aaJvXRXu3IT3CA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] kbuild,objtool: Defer objtool validation step for
 CONFIG_KLP_BUILD
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060832901.709179.13242002514226573125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f2c356d1d0f048e88c281a4178c8b2db138d3ac1
Gitweb:        https://git.kernel.org/tip/f2c356d1d0f048e88c281a4178c8b2db138=
d3ac1
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:04:05 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:19 -07:00

kbuild,objtool: Defer objtool validation step for CONFIG_KLP_BUILD

In preparation for klp-build, defer objtool validation for
CONFIG_KLP_BUILD kernels until the final pre-link archive (e.g.,
vmlinux.o, module-foo.o) is built.  This will simplify the process of
generating livepatch modules.

Delayed objtool is generally preferred anyway, and is already standard
for IBT and LTO.  Eventually the per-translation-unit mode will be
phased out.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/Makefile.lib    | 2 +-
 scripts/link-vmlinux.sh | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 15fee73..28a1c08 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -197,7 +197,7 @@ objtool-args =3D $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\
 	$(if $(part-of-module), --module)
=20
-delay-objtool :=3D $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT))
+delay-objtool :=3D $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT),$(CONFI=
G_KLP_BUILD))
=20
 cmd_objtool =3D $(if $(objtool-enabled), ; $(objtool) $(objtool-args) $@)
 cmd_gen_objtooldep =3D $(if $(objtool-enabled), { echo ; echo '$@: $$(wildca=
rd $(objtool))' ; } >> $(dot-target).cmd)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 433849f..2df714b 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -60,7 +60,8 @@ vmlinux_link()
 	# skip output file argument
 	shift
=20
-	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
+	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT ||
+	   is_enabled CONFIG_KLP_BUILD; then
 		# Use vmlinux.o instead of performing the slow LTO link again.
 		objs=3Dvmlinux.o
 		libs=3D

