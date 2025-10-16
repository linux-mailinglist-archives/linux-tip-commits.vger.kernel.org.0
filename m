Return-Path: <linux-tip-commits+bounces-6876-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8461ABE292E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F41504275FF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1A4320A04;
	Thu, 16 Oct 2025 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AWkcZFpy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYflN6NH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4531B105;
	Thu, 16 Oct 2025 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608363; cv=none; b=LWSAMufTGQVGJcpii1EB/0z9/J0xRzhjbBvsQMykdqyTUYFFZd2LfA4pWAxG7xAwBiPPbHvAaDz9q1JFzHH0j56HfROcDUo1E/yLVoQ+QJWQp2cRVGONEBFssoRMMR7jNs/3dIsCQ6zArLMzIVEJplAE9+1YsL0Jd7u9uB30RrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608363; c=relaxed/simple;
	bh=U0w1GqNw9HdBCFIg4X4xkl9FLqWM5wjCdJCU/ALAxJU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=OEfdLGMLp+oEq48+EUM/Zl8Jc8WjWkS2EJYJoR32ps4B+t7OhflliyZ6jPUTGNPP4ip5zebu8Ee8/+S5xazD3+7Im7DmwtRBCOcUpZolezrz5sx7Q5hUxrsb1Q4C3QKwtwt1t4mhvN1gy1wUD14lq5J/h61k662dWrB8GqdlAQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AWkcZFpy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYflN6NH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608339;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0oCY3k22AGmCTQ9t/MTTX0vofSRKbPZnggMztISIFj4=;
	b=AWkcZFpy+0wqHMwUEYDWE06d/D1cMa935Yn/TG06VfTtyo7HRXb2UBGFv9l1FG90GLA8Jk
	niQrC4kzZgSi/1++v9eYJtl0pe1ssYypzXngQd0TKQQcMRTth5Ic9LYuynmDc+KY1RQSdS
	bo497jtg/yWICB906h+AaEAHuimgHJuv8RS9laZHK4eI1qiT/4bRhja0ntGlBm6zPGaBCQ
	dUCHRKCpwKAYa6dKtwTAsUihSm+EZVUeumI4NQBk7rMHrjwfOAauLYjfpdBalXCup9EHt7
	rv4RLySwWNtDHDjt59hUnm+CynvypJ1PoCDQqTARSZSl6EvdBhDrzaAq28tS+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608339;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0oCY3k22AGmCTQ9t/MTTX0vofSRKbPZnggMztISIFj4=;
	b=cYflN6NHk+GrcH4OTvUeTTkOIIwVIThsLr0X+EMN3mToLkL0uozs/foBBYRDh/wqVM/dWJ
	xbMop3NXzhSZ7xDw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool/klp: Add --debug-checksum=<funcs> to show
 per-instruction checksums
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060833794.709179.12170959624692745095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     a3493b33384a01a1f0e38b420d1a4766aec903a6
Gitweb:        https://git.kernel.org/tip/a3493b33384a01a1f0e38b420d1a4766aec=
903a6
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:58 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:50:18 -07:00

objtool/klp: Add --debug-checksum=3D<funcs> to show per-instruction checksums

Add a --debug-checksum=3D<funcs> option to the check subcommand to print
the calculated checksum of each instruction in the given functions.

This is useful for determining where two versions of a function begin to
diverge.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c            |  6 +++-
 tools/objtool/check.c                    | 42 +++++++++++++++++++++++-
 tools/objtool/include/objtool/builtin.h  |  1 +-
 tools/objtool/include/objtool/checksum.h |  1 +-
 tools/objtool/include/objtool/elf.h      |  1 +-
 tools/objtool/include/objtool/warn.h     | 19 ++++++++++-
 6 files changed, 70 insertions(+)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 14daa13..7b6fd60 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -94,6 +94,7 @@ static const struct option check_options[] =3D {
 	OPT_GROUP("Options:"),
 	OPT_BOOLEAN(0,		 "backtrace", &opts.backtrace, "unwind on error"),
 	OPT_BOOLEAN(0,		 "backup", &opts.backup, "create backup (.orig) file on war=
ning/error"),
+	OPT_STRING(0,		 "debug-checksum", &opts.debug_checksum,  "funcs", "enable c=
hecksum debug output"),
 	OPT_BOOLEAN(0,		 "dry-run", &opts.dryrun, "don't write modifications"),
 	OPT_BOOLEAN(0,		 "link", &opts.link, "object is a linked object"),
 	OPT_BOOLEAN(0,		 "module", &opts.module, "object is part of a kernel module=
"),
@@ -168,6 +169,11 @@ static bool opts_valid(void)
 	}
 #endif
=20
+	if (opts.debug_checksum && !opts.checksum) {
+		ERROR("--debug-checksum requires --checksum");
+		return false;
+	}
+
 	if (opts.checksum		||
 	    opts.hack_jump_label	||
 	    opts.hack_noinstr		||
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index f5adbd2..0f52781 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3580,6 +3580,44 @@ static bool skip_alt_group(struct instruction *insn)
 	return alt_insn->type =3D=3D INSN_CLAC || alt_insn->type =3D=3D INSN_STAC;
 }
=20
+static int checksum_debug_init(struct objtool_file *file)
+{
+	char *dup, *s;
+
+	if (!opts.debug_checksum)
+		return 0;
+
+	dup =3D strdup(opts.debug_checksum);
+	if (!dup) {
+		ERROR_GLIBC("strdup");
+		return -1;
+	}
+
+	s =3D dup;
+	while (*s) {
+		struct symbol *func;
+		char *comma;
+
+		comma =3D strchr(s, ',');
+		if (comma)
+			*comma =3D '\0';
+
+		func =3D find_symbol_by_name(file->elf, s);
+		if (!func || !is_func_sym(func))
+			WARN("--debug-checksum: can't find '%s'", s);
+		else
+			func->debug_checksum =3D 1;
+
+		if (!comma)
+			break;
+
+		s =3D comma + 1;
+	}
+
+	free(dup);
+	return 0;
+}
+
 static void checksum_update_insn(struct objtool_file *file, struct symbol *f=
unc,
 				 struct instruction *insn)
 {
@@ -4818,6 +4856,10 @@ int check(struct objtool_file *file)
 	cfi_hash_add(&init_cfi);
 	cfi_hash_add(&func_cfi);
=20
+	ret =3D checksum_debug_init(file);
+	if (ret)
+		goto out;
+
 	ret =3D decode_sections(file);
 	if (ret)
 		goto out;
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/=
objtool/builtin.h
index 338bdab..cee9fc0 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -32,6 +32,7 @@ struct opts {
 	/* options: */
 	bool backtrace;
 	bool backup;
+	const char *debug_checksum;
 	bool dryrun;
 	bool link;
 	bool mnop;
diff --git a/tools/objtool/include/objtool/checksum.h b/tools/objtool/include=
/objtool/checksum.h
index 927ca74..7fe2160 100644
--- a/tools/objtool/include/objtool/checksum.h
+++ b/tools/objtool/include/objtool/checksum.h
@@ -19,6 +19,7 @@ static inline void checksum_update(struct symbol *func,
 				   const void *data, size_t size)
 {
 	XXH3_64bits_update(func->csum.state, data, size);
+	dbg_checksum(func, insn, XXH3_64bits_digest(func->csum.state));
 }
=20
 static inline void checksum_finish(struct symbol *func)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index bc7d8a6..a1f1762 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -82,6 +82,7 @@ struct symbol {
 	u8 nocfi             : 1;
 	u8 cold		     : 1;
 	u8 prefix	     : 1;
+	u8 debug_checksum    : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 	struct section *group_sec;
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/obj=
tool/warn.h
index cb8fe84..29173a1 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -102,4 +102,23 @@ static inline char *offstr(struct section *sec, unsigned=
 long offset)
 #define ERROR_FUNC(sec, offset, format, ...) __WARN_FUNC(ERROR_STR, sec, off=
set, format, ##__VA_ARGS__)
 #define ERROR_INSN(insn, format, ...) WARN_FUNC(insn->sec, insn->offset, for=
mat, ##__VA_ARGS__)
=20
+
+#define __dbg(format, ...)						\
+	fprintf(stderr,							\
+		"DEBUG: %s%s" format "\n",				\
+		objname ?: "",						\
+		objname ? ": " : "",					\
+		##__VA_ARGS__)
+
+#define dbg_checksum(func, insn, checksum)				\
+({									\
+	if (unlikely(insn->sym && insn->sym->pfunc &&			\
+		     insn->sym->pfunc->debug_checksum)) {		\
+		char *insn_off =3D offstr(insn->sec, insn->offset);	\
+		__dbg("checksum: %s %s %016lx",				\
+		      func->name, insn_off, checksum);			\
+		free(insn_off);						\
+	}								\
+})
+
 #endif /* _WARN_H */

