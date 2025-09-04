Return-Path: <linux-tip-commits+bounces-6465-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE2B439D6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B78637AC69C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1A52FFDD2;
	Thu,  4 Sep 2025 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JQqa9tuq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D+Vm7sSj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CAE2FF164;
	Thu,  4 Sep 2025 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984858; cv=none; b=PfNyx5bJw63DooHPRONEMrybXckMCmCN9T66AZiR3eDxWAzyhxZJO0GpdURKo0KB4Fc65kP5qJYJEZfpwBp1YR20OftEVyAYkWUZu+KGZx6EPr2St/QB+MzzjAT7TN6X4CbjB1kUtZt02uT8ZTxvYiSdxg2O4Lf54sDNodYw/ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984858; c=relaxed/simple;
	bh=dcNhU0UyGM2dnvJ8oArXq1MhkjsW2F/YDGwz/sqqmew=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cMe34bKSM/u/DuG8wOycMFgZ22C0H3rB0Y4Av4BAhl2uqoPjtlbWc7r6a3nmCrqr8ghEV3UMb+G/OBV4bVrcUta6PGpaH8IaRDAtRVDZ/nGK8TC38sD13C9c00PEKGeW9F7djdkNBG+Q7IVbUoxa77T73kLBtc3vZFFTCw1SIUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JQqa9tuq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D+Vm7sSj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984854;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Och9wevWPJ2YGzobfYy0DepBwYh1xpyNWtCaHrw+rOI=;
	b=JQqa9tuq+sW8tO2x45HxA4lFh2nwoeewvGFXZacATcsIA8T9DPXQ1P/EIixhv9dthJrgYL
	WtwiGoT0nuCBzkgxBLODAmfbBZhHbmjlU/8VpwDLp5dwktrF/Hsdf6YVAYAU62XWMPIh/D
	gYRwCBEKU6P+G++JNquYOIV717CZT2JEC4aq3wmNrzMDNGZb8d0ylqRnIwT+9KtlJOZyYq
	QV4oLEsJYK2u4OygKO8K62ZZQVgx1Mr4tnommH4wwaHs7J2cthd/JNMdkQV66BkJnhbUMz
	rvHSK4X50MRUabr609ZnENIZ4FRQ2qquK9srlaso/Rn3X2lxfzfHQcE9TBUBNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984854;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Och9wevWPJ2YGzobfYy0DepBwYh1xpyNWtCaHrw+rOI=;
	b=D+Vm7sSjsltCF/FZkT/Xj1T6Cck9KUfHqQhd7WjHlHcghS9nzDVyWmGlK3ZXCqCaGul+1z
	1vQ9N1sjCmzySBDw==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] objtool: Add action to check for absence of absolute
 relocations
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-39-ardb+git@google.com>
References: <20250828102202.1849035-39-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698485365.1920.10716712976693381870.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     0d6e4563fc03d83f948e6a6f7963cc31a4c81914
Gitweb:        https://git.kernel.org/tip/0d6e4563fc03d83f948e6a6f7963cc31a4c=
81914
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:18 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 17:59:51 +02:00

objtool: Add action to check for absence of absolute relocations

The x86 startup code must not use absolute references to code or data,
as it executes before the kernel virtual mapping is up.

Add an action to objtool to check all allocatable sections (with the
exception of __patchable_function_entries, which uses absolute
references for nebulous reasons) and raise an error if any absolute
references are found.

Note that debug sections typically contain lots of absolute references
too, but those are not allocatable so they will be ignored.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/20250828102202.1849035-39-ardb+git@google.com
---
 tools/objtool/arch/x86/decode.c         | 12 +++++++-
 tools/objtool/builtin-check.c           |  2 +-
 tools/objtool/check.c                   | 44 ++++++++++++++++++++++++-
 tools/objtool/include/objtool/arch.h    |  1 +-
 tools/objtool/include/objtool/builtin.h |  1 +-
 5 files changed, 60 insertions(+)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 98c4713..0ad5cc7 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -880,3 +880,15 @@ unsigned int arch_reloc_size(struct reloc *reloc)
 		return 8;
 	}
 }
+
+bool arch_absolute_reloc(struct elf *elf, struct reloc *reloc)
+{
+	switch (reloc_type(reloc)) {
+	case R_X86_64_32:
+	case R_X86_64_32S:
+	case R_X86_64_64:
+		return true;
+	default:
+		return false;
+	}
+}
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 8023984..0f6b197 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -87,6 +87,7 @@ static const struct option check_options[] =3D {
 	OPT_BOOLEAN('t', "static-call", &opts.static_call, "annotate static calls"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP=
"),
 	OPT_BOOLEAN(0  , "cfi", &opts.cfi, "annotate kernel control flow integrity =
(kCFI) function preambles"),
+	OPT_BOOLEAN(0  , "noabs", &opts.noabs, "reject absolute references in alloc=
atable sections"),
 	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_du=
mp),
=20
 	OPT_GROUP("Options:"),
@@ -162,6 +163,7 @@ static bool opts_valid(void)
 	    opts.hack_noinstr		||
 	    opts.ibt			||
 	    opts.mcount			||
+	    opts.noabs			||
 	    opts.noinstr		||
 	    opts.orc			||
 	    opts.retpoline		||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d14f20e..fb47327 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4644,6 +4644,47 @@ static void disas_warned_funcs(struct objtool_file *fi=
le)
 		disas_funcs(funcs);
 }
=20
+__weak bool arch_absolute_reloc(struct elf *elf, struct reloc *reloc)
+{
+	unsigned int type =3D reloc_type(reloc);
+	size_t sz =3D elf_addr_size(elf);
+
+	return (sz =3D=3D 8) ? (type =3D=3D R_ABS64) : (type =3D=3D R_ABS32);
+}
+
+static int check_abs_references(struct objtool_file *file)
+{
+	struct section *sec;
+	struct reloc *reloc;
+	int ret =3D 0;
+
+	for_each_sec(file, sec) {
+		/* absolute references in non-loadable sections are fine */
+		if (!(sec->sh.sh_flags & SHF_ALLOC))
+			continue;
+
+		/* section must have an associated .rela section */
+		if (!sec->rsec)
+			continue;
+
+		/*
+		 * Special case for compiler generated metadata that is not
+		 * consumed until after boot.
+		 */
+		if (!strcmp(sec->name, "__patchable_function_entries"))
+			continue;
+
+		for_each_reloc(sec->rsec, reloc) {
+			if (arch_absolute_reloc(file->elf, reloc)) {
+				WARN("section %s has absolute relocation at offset 0x%lx",
+				     sec->name, reloc_offset(reloc));
+				ret++;
+			}
+		}
+	}
+	return ret;
+}
+
 struct insn_chunk {
 	void *addr;
 	struct insn_chunk *next;
@@ -4777,6 +4818,9 @@ int check(struct objtool_file *file)
 			goto out;
 	}
=20
+	if (opts.noabs)
+		warnings +=3D check_abs_references(file);
+
 	if (opts.orc && nr_insns) {
 		ret =3D orc_create(file);
 		if (ret)
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/obj=
tool/arch.h
index 01ef6f4..be33c7b 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -97,6 +97,7 @@ bool arch_is_embedded_insn(struct symbol *sym);
 int arch_rewrite_retpolines(struct objtool_file *file);
=20
 bool arch_pc_relative_reloc(struct reloc *reloc);
+bool arch_absolute_reloc(struct elf *elf, struct reloc *reloc);
=20
 unsigned int arch_reloc_size(struct reloc *reloc);
 unsigned long arch_jump_table_sym_offset(struct reloc *reloc, struct reloc *=
table);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/=
objtool/builtin.h
index 6b08666..ab22673 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -26,6 +26,7 @@ struct opts {
 	bool uaccess;
 	int prefix;
 	bool cfi;
+	bool noabs;
=20
 	/* options: */
 	bool backtrace;

