Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D493880C2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 May 2021 21:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351955AbhERTv6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 18 May 2021 15:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240654AbhERTv5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 18 May 2021 15:51:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14708C061573;
        Tue, 18 May 2021 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zbtV+ZW1lothGAMzlfC3VBUebJDk40/F89AsWOkOsbc=; b=a1sKjbiEqm1ilmcxrPUJv93tml
        D+bNo+eQFW6BOiMPJUoNmulruFyzn8dgprUKpM2+NLZGyjAa7CVtQyjcXvZXovzRNQ93fP13XyQCF
        ka+m+oflP/9JQynPxhe6C9g2wqF3+L35djwiTgQhWAUOl57HCHVT8gaSJTWwcCX5XRe6H43g9pVM8
        ShND4umOutiZ9twNh7d0aeReGGTimLbsRoP9wAFYu2MChB/GI33DSauLRf5IPvCOz6aDf0h1gv1lj
        R+3+idhub8NZGy5mvEiw6ybo3cTisizHTYWddoFHMbo6UG1tHFQnniKiYLfvGzEygh3hj/JOakOmg
        Z+qm2cxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lj5jB-00EIn7-N5; Tue, 18 May 2021 19:50:09 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 988A1986465; Tue, 18 May 2021 21:50:04 +0200 (CEST)
Date:   Tue, 18 May 2021 21:50:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, willy@infradead.org
Subject: Re: [tip: objtool/core] jump_label, x86: Allow short NOPs
Message-ID: <20210518195004.GD21560@worktop.programming.kicks-ass.net>
References: <20210506194158.216763632@infradead.org>
 <162082558708.29796.10992563428983424866.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162082558708.29796.10992563428983424866.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, May 12, 2021 at 01:19:47PM -0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the objtool/core branch of tip:
> 
> Commit-ID:     ab3257042c26d0cd44793c741e2f89bf38b21fe8
> Gitweb:        https://git.kernel.org/tip/ab3257042c26d0cd44793c741e2f89bf38b21fe8
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Thu, 06 May 2021 21:34:05 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Wed, 12 May 2021 14:54:56 +02:00
> 
> jump_label, x86: Allow short NOPs
> 
> Now that objtool is able to rewrite jump_label instructions, have the
> compiler emit a JMP, such that it can decide on the optimal encoding,
> and set jump_entry::key bit1 to indicate that objtool should rewrite
> the instruction to a matching NOP.
> 
> For x86_64-allyesconfig this gives:
> 
>   jl\     NOP     JMP
>   short:  22997   124
>   long:   30874   90
> 
> IOW, we save (22997+124) * 3 bytes of kernel text in hotpaths.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lore.kernel.org/r/20210506194158.216763632@infradead.org

So Willy is having some trouble with this commit; for some reason his
kernel is no longer booting in his qemu thing, but I can't reproduce.

I've hacked up the below vmlinux.o validation, willy can you run this on
your vmlinux.o, something like:

	build/tools/objtool/objtool check -abdJsuld build/vmlinux.o

Where I'm assuming you build with O=build/. When I run it on my build
(with your .config) I get absolutely nothing :/

Alternatively, can you get me your vmlinux.o + bzImage ?

Also helpful might be trying to attach gdb to the qemu gdbstub and
looking where the boot fails.

---

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 8b38b5d6fec7..100f3efa6136 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -20,7 +20,7 @@
 #include <objtool/objtool.h>
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-     validate_dup, vmlinux, mcount, noinstr, backup;
+     validate_dup, vmlinux, mcount, noinstr, backup, validate_jl;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -45,6 +45,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
 	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
 	OPT_BOOLEAN('B', "backup", &backup, "create .orig files before modification"),
+	OPT_BOOLEAN('J', "jump-label", &validate_jl, "validate jump-label tables"),
 	OPT_END(),
 };
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2c6a93edf27e..c3c82e40cbee 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1225,6 +1225,33 @@ static int handle_jump_alt(struct objtool_file *file,
 			   struct instruction *orig_insn,
 			   struct instruction **new_insn)
 {
+	if (validate_jl) {
+#if 0
+		if (special_alt->key_addend & 2) {
+			WARN_FUNC("jump-label mod: %s", orig_insn->sec, orig_insn->offset,
+				  orig_insn->type == INSN_NOP ? "nop" : "jmp");
+		}
+#endif
+
+		if (orig_insn->len == 2) {
+			s32 disp;
+
+			if (special_alt->orig_sec != special_alt->new_sec) {
+				WARN_FUNC("short jump-label cannot cross sections",
+					  orig_insn->sec, orig_insn->offset);
+				return -1;
+			}
+
+			disp = special_alt->new_off - (special_alt->orig_off + 2);
+
+			if ((disp >> 31) != (disp >> 7)) {
+				WARN_FUNC("short jump-label, displacement too large: 0x%08x",
+					  orig_insn->sec, orig_insn->offset, disp);
+				return -1;
+			}
+		}
+	}
+
 	if (orig_insn->type == INSN_NOP) {
 do_nop:
 		if (orig_insn->len == 2)
@@ -1244,6 +1271,11 @@ static int handle_jump_alt(struct objtool_file *file,
 	if (special_alt->key_addend & 2) {
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
+		if (validate_jl) {
+			WARN_FUNC("jump-label unpatched", orig_insn->sec, orig_insn->offset);
+			return -1;
+		}
+
 		if (reloc) {
 			reloc->type = R_NONE;
 			elf_write_reloc(file->elf, reloc);
@@ -1341,6 +1373,8 @@ static int add_special_section_alts(struct objtool_file *file)
 	}
 
 	if (stats) {
+		if (validate_jl)
+			printf("validate-");
 		printf("jl\\\tNOP\tJMP\n");
 		printf("short:\t%ld\t%ld\n", file->jl_nop_short, file->jl_short);
 		printf("long:\t%ld\t%ld\n", file->jl_nop_long, file->jl_long);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 15ac0b7d3d6a..c9a00423ebd5 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,7 +9,7 @@
 
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-            validate_dup, vmlinux, mcount, noinstr, backup;
+            validate_dup, vmlinux, mcount, noinstr, backup, validate_jl;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
