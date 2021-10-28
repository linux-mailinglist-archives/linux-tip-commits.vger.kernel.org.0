Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9643E23E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Oct 2021 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhJ1NcF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Oct 2021 09:32:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47750 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhJ1NcE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Oct 2021 09:32:04 -0400
Date:   Thu, 28 Oct 2021 13:29:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635427776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=etrM+laYrcfChaWgjrwRvOcJu32RWsw/ME+hL0QYaFE=;
        b=l+59glzWMZ8iqQnzLrw9Zhr0fBCRRali3EVv/dXFNxYnUQwTaHFkaBtl5taikKOYFIHz2f
        6mGhJ9MK+WwuJMvHmcaGtazsUgcUZehbeux8lHVy0nQXfYo+S/A4ooAVBEy8cgEVXQYgGZ
        ZEq9OTjNQ7xqeNDWnbCg2Um+kq7uh2EJ2EF9FjxGOv6bQgwlXIZXiUKsFcQNZm01VoeefV
        fIZyySCLbrB5eJ3+sfh/FUPiFbtCV7pA4MKTKXPWsF3HPjK8m9i1dAek0Xc/rdinD0XNxC
        DBFLpqUvEtRlaZeV61wuFoAzxI3KYVagyPd8axDmLPqwXB6+g1kGpycKDl4qAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635427776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=etrM+laYrcfChaWgjrwRvOcJu32RWsw/ME+hL0QYaFE=;
        b=ENTnLK5bs0ZW85Kb9ap/HN1lhsdTzLkKAfNaxGwqvVfCk7MbzaqhcRIEieKzhtupCOE2wl
        NLnvFGEbP5KheoAw==
From:   "tip-bot2 for Kristen Carlson Accardi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/tools/relocs: Support >64K section headers
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211013175742.1197608-2-keescook@chromium.org>
References: <20211013175742.1197608-2-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <163542777535.626.8659747442562324842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     a54c401ae66fc78f3f0002938b3465ebd6379009
Gitweb:        https://git.kernel.org/tip/a54c401ae66fc78f3f0002938b3465ebd6379009
Author:        Kristen Carlson Accardi <kristen@linux.intel.com>
AuthorDate:    Wed, 13 Oct 2021 10:57:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 27 Oct 2021 11:07:58 +02:00

x86/tools/relocs: Support >64K section headers

While the relocs tool already supports finding the total number of
section headers if vmlinux exceeds 64K sections, it fails to read the
extended symbol table to get section header indexes for symbols, causing
incorrect symbol table indexes to be used when there are > 64K symbols.

Parse the ELF file to read the extended symbol table info, and then
replace all direct references to st_shndx with calls to sym_index(),
which will determine whether the value can be read directly or whether
the value should be pulled out of the extended table.

This is needed for future FGKASLR support, which uses a separate section
per function.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20211013175742.1197608-2-keescook@chromium.org
---
 arch/x86/tools/relocs.c | 103 +++++++++++++++++++++++++++++----------
 1 file changed, 78 insertions(+), 25 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 27c8220..3f5d397 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -14,6 +14,10 @@
 static Elf_Ehdr		ehdr;
 static unsigned long	shnum;
 static unsigned int	shstrndx;
+static unsigned int	shsymtabndx;
+static unsigned int	shxsymtabndx;
+
+static int sym_index(Elf_Sym *sym);
 
 struct relocs {
 	uint32_t	*offset;
@@ -35,6 +39,7 @@ struct section {
 	Elf_Shdr       shdr;
 	struct section *link;
 	Elf_Sym        *symtab;
+	Elf32_Word     *xsymtab;
 	Elf_Rel        *reltab;
 	char           *strtab;
 };
@@ -268,7 +273,7 @@ static const char *sym_name(const char *sym_strtab, Elf_Sym *sym)
 		name = sym_strtab + sym->st_name;
 	}
 	else {
-		name = sec_name(sym->st_shndx);
+		name = sec_name(sym_index(sym));
 	}
 	return name;
 }
@@ -338,6 +343,23 @@ static uint64_t elf64_to_cpu(uint64_t val)
 #define elf_xword_to_cpu(x)	elf32_to_cpu(x)
 #endif
 
+static int sym_index(Elf_Sym *sym)
+{
+	Elf_Sym *symtab = secs[shsymtabndx].symtab;
+	Elf32_Word *xsymtab = secs[shxsymtabndx].xsymtab;
+	unsigned long offset;
+	int index;
+
+	if (sym->st_shndx != SHN_XINDEX)
+		return sym->st_shndx;
+
+	/* calculate offset of sym from head of table. */
+	offset = (unsigned long)sym - (unsigned long)symtab;
+	index = offset / sizeof(*sym);
+
+	return elf32_to_cpu(xsymtab[index]);
+}
+
 static void read_ehdr(FILE *fp)
 {
 	if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1) {
@@ -471,31 +493,60 @@ static void read_strtabs(FILE *fp)
 static void read_symtabs(FILE *fp)
 {
 	int i,j;
+
 	for (i = 0; i < shnum; i++) {
 		struct section *sec = &secs[i];
-		if (sec->shdr.sh_type != SHT_SYMTAB) {
+		int num_syms;
+
+		switch (sec->shdr.sh_type) {
+		case SHT_SYMTAB_SHNDX:
+			sec->xsymtab = malloc(sec->shdr.sh_size);
+			if (!sec->xsymtab) {
+				die("malloc of %" FMT " bytes for xsymtab failed\n",
+				    sec->shdr.sh_size);
+			}
+			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
+				die("Seek to %" FMT " failed: %s\n",
+				    sec->shdr.sh_offset, strerror(errno));
+			}
+			if (fread(sec->xsymtab, 1, sec->shdr.sh_size, fp)
+			    != sec->shdr.sh_size) {
+				die("Cannot read extended symbol table: %s\n",
+				    strerror(errno));
+			}
+			shxsymtabndx = i;
+			continue;
+
+		case SHT_SYMTAB:
+			num_syms = sec->shdr.sh_size / sizeof(Elf_Sym);
+
+			sec->symtab = malloc(sec->shdr.sh_size);
+			if (!sec->symtab) {
+				die("malloc of %" FMT " bytes for symtab failed\n",
+				    sec->shdr.sh_size);
+			}
+			if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
+				die("Seek to %" FMT " failed: %s\n",
+				    sec->shdr.sh_offset, strerror(errno));
+			}
+			if (fread(sec->symtab, 1, sec->shdr.sh_size, fp)
+			    != sec->shdr.sh_size) {
+				die("Cannot read symbol table: %s\n",
+				    strerror(errno));
+			}
+			for (j = 0; j < num_syms; j++) {
+				Elf_Sym *sym = &sec->symtab[j];
+
+				sym->st_name  = elf_word_to_cpu(sym->st_name);
+				sym->st_value = elf_addr_to_cpu(sym->st_value);
+				sym->st_size  = elf_xword_to_cpu(sym->st_size);
+				sym->st_shndx = elf_half_to_cpu(sym->st_shndx);
+			}
+			shsymtabndx = i;
+			continue;
+
+		default:
 			continue;
-		}
-		sec->symtab = malloc(sec->shdr.sh_size);
-		if (!sec->symtab) {
-			die("malloc of %" FMT " bytes for symtab failed\n",
-			    sec->shdr.sh_size);
-		}
-		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0) {
-			die("Seek to %" FMT " failed: %s\n",
-			    sec->shdr.sh_offset, strerror(errno));
-		}
-		if (fread(sec->symtab, 1, sec->shdr.sh_size, fp)
-		    != sec->shdr.sh_size) {
-			die("Cannot read symbol table: %s\n",
-				strerror(errno));
-		}
-		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Sym); j++) {
-			Elf_Sym *sym = &sec->symtab[j];
-			sym->st_name  = elf_word_to_cpu(sym->st_name);
-			sym->st_value = elf_addr_to_cpu(sym->st_value);
-			sym->st_size  = elf_xword_to_cpu(sym->st_size);
-			sym->st_shndx = elf_half_to_cpu(sym->st_shndx);
 		}
 	}
 }
@@ -762,7 +813,9 @@ static void percpu_init(void)
  */
 static int is_percpu_sym(ElfW(Sym) *sym, const char *symname)
 {
-	return (sym->st_shndx == per_cpu_shndx) &&
+	int shndx = sym_index(sym);
+
+	return (shndx == per_cpu_shndx) &&
 		strcmp(symname, "__init_begin") &&
 		strcmp(symname, "__per_cpu_load") &&
 		strncmp(symname, "init_per_cpu_", 13);
@@ -1095,7 +1148,7 @@ static int do_reloc_info(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 		sec_name(sec->shdr.sh_info),
 		rel_type(ELF_R_TYPE(rel->r_info)),
 		symname,
-		sec_name(sym->st_shndx));
+		sec_name(sym_index(sym)));
 	return 0;
 }
 
