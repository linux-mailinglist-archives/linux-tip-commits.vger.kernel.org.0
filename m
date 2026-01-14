Return-Path: <linux-tip-commits+bounces-7966-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C27A1D1BC4C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 01:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81461300F9E0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 00:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34AA17BA2;
	Wed, 14 Jan 2026 00:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AKUwsW1/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/AE3iEgL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4974414A8E;
	Wed, 14 Jan 2026 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768348891; cv=none; b=u+azuLWidCSPk+DzN5DFYcoFrqUx+0vUtW64PtiQbOUpqy+/We9vmOqAu5x0mMQKOD3rBSGDd5ePIsOmLmryxmCfS1Ip0BQ4vEMfNu/oBUPMJ8buEONap5iIcpvjc5QfiSqNGZ1SPeRQT36iRWOgKUdNKT0Bx2JutNJQvFwn68I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768348891; c=relaxed/simple;
	bh=MiViuB4+N4kRVviey0Pd0OU/L5OFXwHhqH1tzktZONA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y4cMSZldTC6IcjBQFtD8tVByzMZIzZW99mhPl9oDpM+Aor3vr0Nib+CEsowbiY9szsWJlavVAnLkySZjps95pr93hj1AIYUnfmY2DDw+qjW+t7/vVE3lMaX29RMVf30p7Er7GA87PEjC2E8DwIR4WnLtcK5zZWKW3p16y/8YsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AKUwsW1/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/AE3iEgL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 00:01:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768348886;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eefmrXe6DWAQUN+nvxSBIokomEAo6aBWtPCrqXRQ6e4=;
	b=AKUwsW1/e//Q7ipHox9Xn9p2AxEd+fzHEOxJ0BMSvK2oebvIfRK++eG0ujXRXNzu7ShnPY
	3FEhnZ0zdr5i9fQL2wec5ZO94x3TnICsVVG190QK3GvtslkuM6wFeK6+jgTsbwmikJTTQY
	ekIa4GwNAP/LU7tLXD9II1y1Gonvu1vZuB1aVYmgclkcWdmMWseLOdRs13/rMtO4K7mwll
	rLk66zt87f0qaQXFyzWvwdbLLvuGKGz4CE+8NCbBobE0nZA2x0uAS0IiHlTbioZ7xIya0I
	8GiLFXaQBQ0tGjLL2WHLWLlkEU5hQAuqoVPuVCETZJK4M/CdXSMiwc4ZTVX0Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768348886;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eefmrXe6DWAQUN+nvxSBIokomEAo6aBWtPCrqXRQ6e4=;
	b=/AE3iEgL9UNwgkjTrxIBrhAwVMAvPIAyK9lxNbHR4iot4wL8nBPkes2xSVjguMQwwCSXtq
	gDep9LMV+HhvlRCg==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/vdso: Move vdso2c to arch/x86/tools
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251216212606.1325678-3-hpa@zytor.com>
References: <20251216212606.1325678-3-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176834888556.510.1391225459380426538.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     a76108d05ee13cddb72b620752a80b2c3e87aee1
Gitweb:        https://git.kernel.org/tip/a76108d05ee13cddb72b620752a80b2c3e8=
7aee1
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Tue, 16 Dec 2025 13:25:56 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 13 Jan 2026 15:33:20 -08:00

x86/entry/vdso: Move vdso2c to arch/x86/tools

It is generally better to build tools in arch/x86/tools to keep host
cflags proliferation down, and to reduce makefile sequencing issues.
Move the vdso build tool vdso2c into arch/x86/tools in preparation for
refactoring the vdso makefiles.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251216212606.1325678-3-hpa@zytor.com
---
 arch/x86/Makefile            |   2 +-
 arch/x86/entry/vdso/Makefile |   7 +-
 arch/x86/entry/vdso/vdso2c.c | 233 +----------------------------------
 arch/x86/entry/vdso/vdso2c.h | 208 +------------------------------
 arch/x86/tools/Makefile      |  15 +-
 arch/x86/tools/vdso2c.c      | 233 ++++++++++++++++++++++++++++++++++-
 arch/x86/tools/vdso2c.h      | 208 ++++++++++++++++++++++++++++++-
 7 files changed, 455 insertions(+), 451 deletions(-)
 delete mode 100644 arch/x86/entry/vdso/vdso2c.c
 delete mode 100644 arch/x86/entry/vdso/vdso2c.h
 create mode 100644 arch/x86/tools/vdso2c.c
 create mode 100644 arch/x86/tools/vdso2c.h

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1d403a3..9ab7522 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -252,7 +252,7 @@ endif
=20
=20
 archscripts: scripts_basic
-	$(Q)$(MAKE) $(build)=3Darch/x86/tools relocs
+	$(Q)$(MAKE) $(build)=3Darch/x86/tools relocs vdso2c
=20
 ###
 # Syscall table generation
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 7f83302..3d9b09f 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -38,13 +38,12 @@ VDSO_LDFLAGS_vdso.lds =3D -m elf_x86_64 -soname linux-vds=
o.so.1 \
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso_and_check)
=20
-HOST_EXTRACFLAGS +=3D -I$(srctree)/tools/include -I$(srctree)/include/uapi -=
I$(srctree)/arch/$(SUBARCH)/include/uapi
-hostprogs +=3D vdso2c
+VDSO2C =3D $(objtree)/arch/x86/tools/vdso2c
=20
 quiet_cmd_vdso2c =3D VDSO2C  $@
-      cmd_vdso2c =3D $(obj)/vdso2c $< $(<:%.dbg=3D%) $@
+      cmd_vdso2c =3D $(VDSO2C) $< $(<:%.dbg=3D%) $@
=20
-$(obj)/vdso%-image.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
+$(obj)/vdso%-image.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(VDSO2C) FORCE
 	$(call if_changed,vdso2c)
=20
 #
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
deleted file mode 100644
index f84e8f8..0000000
--- a/arch/x86/entry/vdso/vdso2c.c
+++ /dev/null
@@ -1,233 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * vdso2c - A vdso image preparation tool
- * Copyright (c) 2014 Andy Lutomirski and others
- *
- * vdso2c requires stripped and unstripped input.  It would be trivial
- * to fully strip the input in here, but, for reasons described below,
- * we need to write a section table.  Doing this is more or less
- * equivalent to dropping all non-allocatable sections, but it's
- * easier to let objcopy handle that instead of doing it ourselves.
- * If we ever need to do something fancier than what objcopy provides,
- * it would be straightforward to add here.
- *
- * We're keep a section table for a few reasons:
- *
- * The Go runtime had a couple of bugs: it would read the section
- * table to try to figure out how many dynamic symbols there were (it
- * shouldn't have looked at the section table at all) and, if there
- * were no SHT_SYNDYM section table entry, it would use an
- * uninitialized value for the number of symbols.  An empty DYNSYM
- * table would work, but I see no reason not to write a valid one (and
- * keep full performance for old Go programs).  This hack is only
- * needed on x86_64.
- *
- * The bug was introduced on 2012-08-31 by:
- * https://code.google.com/p/go/source/detail?r=3D56ea40aac72b
- * and was fixed on 2014-06-13 by:
- * https://code.google.com/p/go/source/detail?r=3Dfc1cd5e12595
- *
- * Binutils has issues debugging the vDSO: it reads the section table to
- * find SHT_NOTE; it won't look at PT_NOTE for the in-memory vDSO, which
- * would break build-id if we removed the section table.  Binutils
- * also requires that shstrndx !=3D 0.  See:
- * https://sourceware.org/bugzilla/show_bug.cgi?id=3D17064
- *
- * elfutils might not look for PT_NOTE if there is a section table at
- * all.  I don't know whether this matters for any practical purpose.
- *
- * For simplicity, rather than hacking up a partial section table, we
- * just write a mostly complete one.  We omit non-dynamic symbols,
- * though, since they're rather large.
- *
- * Once binutils gets fixed, we might be able to drop this for all but
- * the 64-bit vdso, since build-id only works in kernel RPMs, and
- * systems that update to new enough kernel RPMs will likely update
- * binutils in sync.  build-id has never worked for home-built kernel
- * RPMs without manual symlinking, and I suspect that no one ever does
- * that.
- */
-
-#include <inttypes.h>
-#include <stdint.h>
-#include <unistd.h>
-#include <stdarg.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <fcntl.h>
-#include <err.h>
-
-#include <sys/mman.h>
-#include <sys/types.h>
-
-#include <tools/le_byteshift.h>
-
-#include <linux/elf.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-
-const char *outfilename;
-
-struct vdso_sym {
-	const char *name;
-	bool export;
-};
-
-struct vdso_sym required_syms[] =3D {
-	{"VDSO32_NOTE_MASK", true},
-	{"__kernel_vsyscall", true},
-	{"__kernel_sigreturn", true},
-	{"__kernel_rt_sigreturn", true},
-	{"int80_landing_pad", true},
-	{"vdso32_rt_sigreturn_landing_pad", true},
-	{"vdso32_sigreturn_landing_pad", true},
-};
-
-__attribute__((format(printf, 1, 2))) __attribute__((noreturn))
-static void fail(const char *format, ...)
-{
-	va_list ap;
-	va_start(ap, format);
-	fprintf(stderr, "Error: ");
-	vfprintf(stderr, format, ap);
-	if (outfilename)
-		unlink(outfilename);
-	exit(1);
-	va_end(ap);
-}
-
-/*
- * Evil macros for little-endian reads and writes
- */
-#define GLE(x, bits, ifnot)						\
-	__builtin_choose_expr(						\
-		(sizeof(*(x)) =3D=3D bits/8),				\
-		(__typeof__(*(x)))get_unaligned_le##bits(x), ifnot)
-
-extern void bad_get_le(void);
-#define LAST_GLE(x)							\
-	__builtin_choose_expr(sizeof(*(x)) =3D=3D 1, *(x), bad_get_le())
-
-#define GET_LE(x)							\
-	GLE(x, 64, GLE(x, 32, GLE(x, 16, LAST_GLE(x))))
-
-#define PLE(x, val, bits, ifnot)					\
-	__builtin_choose_expr(						\
-		(sizeof(*(x)) =3D=3D bits/8),				\
-		put_unaligned_le##bits((val), (x)), ifnot)
-
-extern void bad_put_le(void);
-#define LAST_PLE(x, val)						\
-	__builtin_choose_expr(sizeof(*(x)) =3D=3D 1, *(x) =3D (val), bad_put_le())
-
-#define PUT_LE(x, val)					\
-	PLE(x, val, 64, PLE(x, val, 32, PLE(x, val, 16, LAST_PLE(x, val))))
-
-
-#define NSYMS ARRAY_SIZE(required_syms)
-
-#define BITSFUNC3(name, bits, suffix) name##bits##suffix
-#define BITSFUNC2(name, bits, suffix) BITSFUNC3(name, bits, suffix)
-#define BITSFUNC(name) BITSFUNC2(name, ELF_BITS, )
-
-#define INT_BITS BITSFUNC2(int, ELF_BITS, _t)
-
-#define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
-#define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
-#define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
-
-#define ELF_BITS 64
-#include "vdso2c.h"
-#undef ELF_BITS
-
-#define ELF_BITS 32
-#include "vdso2c.h"
-#undef ELF_BITS
-
-static void go(void *raw_addr, size_t raw_len,
-	       void *stripped_addr, size_t stripped_len,
-	       FILE *outfile, const char *name)
-{
-	Elf64_Ehdr *hdr =3D (Elf64_Ehdr *)raw_addr;
-
-	if (hdr->e_ident[EI_CLASS] =3D=3D ELFCLASS64) {
-		go64(raw_addr, raw_len, stripped_addr, stripped_len,
-		     outfile, name);
-	} else if (hdr->e_ident[EI_CLASS] =3D=3D ELFCLASS32) {
-		go32(raw_addr, raw_len, stripped_addr, stripped_len,
-		     outfile, name);
-	} else {
-		fail("unknown ELF class\n");
-	}
-}
-
-static void map_input(const char *name, void **addr, size_t *len, int prot)
-{
-	off_t tmp_len;
-
-	int fd =3D open(name, O_RDONLY);
-	if (fd =3D=3D -1)
-		err(1, "open(%s)", name);
-
-	tmp_len =3D lseek(fd, 0, SEEK_END);
-	if (tmp_len =3D=3D (off_t)-1)
-		err(1, "lseek");
-	*len =3D (size_t)tmp_len;
-
-	*addr =3D mmap(NULL, tmp_len, prot, MAP_PRIVATE, fd, 0);
-	if (*addr =3D=3D MAP_FAILED)
-		err(1, "mmap");
-
-	close(fd);
-}
-
-int main(int argc, char **argv)
-{
-	size_t raw_len, stripped_len;
-	void *raw_addr, *stripped_addr;
-	FILE *outfile;
-	char *name, *tmp;
-	int namelen;
-
-	if (argc !=3D 4) {
-		printf("Usage: vdso2c RAW_INPUT STRIPPED_INPUT OUTPUT\n");
-		return 1;
-	}
-
-	/*
-	 * Figure out the struct name.  If we're writing to a .so file,
-	 * generate raw output instead.
-	 */
-	name =3D strdup(argv[3]);
-	namelen =3D strlen(name);
-	if (namelen >=3D 3 && !strcmp(name + namelen - 3, ".so")) {
-		name =3D NULL;
-	} else {
-		tmp =3D strrchr(name, '/');
-		if (tmp)
-			name =3D tmp + 1;
-		tmp =3D strchr(name, '.');
-		if (tmp)
-			*tmp =3D '\0';
-		for (tmp =3D name; *tmp; tmp++)
-			if (*tmp =3D=3D '-')
-				*tmp =3D '_';
-	}
-
-	map_input(argv[1], &raw_addr, &raw_len, PROT_READ);
-	map_input(argv[2], &stripped_addr, &stripped_len, PROT_READ);
-
-	outfilename =3D argv[3];
-	outfile =3D fopen(outfilename, "w");
-	if (!outfile)
-		err(1, "fopen(%s)", outfilename);
-
-	go(raw_addr, raw_len, stripped_addr, stripped_len, outfile, name);
-
-	munmap(raw_addr, raw_len);
-	munmap(stripped_addr, stripped_len);
-	fclose(outfile);
-
-	return 0;
-}
diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
deleted file mode 100644
index 78ed1c1..0000000
--- a/arch/x86/entry/vdso/vdso2c.h
+++ /dev/null
@@ -1,208 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This file is included twice from vdso2c.c.  It generates code for 32-bit
- * and 64-bit vDSOs.  We need both for 64-bit builds, since 32-bit vDSOs
- * are built for 32-bit userspace.
- */
-
-static void BITSFUNC(copy)(FILE *outfile, const unsigned char *data, size_t =
len)
-{
-	size_t i;
-
-	for (i =3D 0; i < len; i++) {
-		if (i % 10 =3D=3D 0)
-			fprintf(outfile, "\n\t");
-		fprintf(outfile, "0x%02X, ", (int)(data)[i]);
-	}
-}
-
-
-/*
- * Extract a section from the input data into a standalone blob.  Used to
- * capture kernel-only data that needs to persist indefinitely, e.g. the
- * exception fixup tables, but only in the kernel, i.e. the section can
- * be stripped from the final vDSO image.
- */
-static void BITSFUNC(extract)(const unsigned char *data, size_t data_len,
-			      FILE *outfile, ELF(Shdr) *sec, const char *name)
-{
-	unsigned long offset;
-	size_t len;
-
-	offset =3D (unsigned long)GET_LE(&sec->sh_offset);
-	len =3D (size_t)GET_LE(&sec->sh_size);
-
-	if (offset + len > data_len)
-		fail("section to extract overruns input data");
-
-	fprintf(outfile, "static const unsigned char %s[%zu] =3D {", name, len);
-	BITSFUNC(copy)(outfile, data + offset, len);
-	fprintf(outfile, "\n};\n\n");
-}
-
-static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
-			 void *stripped_addr, size_t stripped_len,
-			 FILE *outfile, const char *image_name)
-{
-	int found_load =3D 0;
-	unsigned long load_size =3D -1;  /* Work around bogus warning */
-	unsigned long mapping_size;
-	ELF(Ehdr) *hdr =3D (ELF(Ehdr) *)raw_addr;
-	unsigned long i, syms_nr;
-	ELF(Shdr) *symtab_hdr =3D NULL, *strtab_hdr, *secstrings_hdr,
-		*alt_sec =3D NULL, *extable_sec =3D NULL;
-	ELF(Dyn) *dyn =3D 0, *dyn_end =3D 0;
-	const char *secstrings;
-	INT_BITS syms[NSYMS] =3D {};
-
-	ELF(Phdr) *pt =3D (ELF(Phdr) *)(raw_addr + GET_LE(&hdr->e_phoff));
-
-	if (GET_LE(&hdr->e_type) !=3D ET_DYN)
-		fail("input is not a shared object\n");
-
-	/* Walk the segment table. */
-	for (i =3D 0; i < GET_LE(&hdr->e_phnum); i++) {
-		if (GET_LE(&pt[i].p_type) =3D=3D PT_LOAD) {
-			if (found_load)
-				fail("multiple PT_LOAD segs\n");
-
-			if (GET_LE(&pt[i].p_offset) !=3D 0 ||
-			    GET_LE(&pt[i].p_vaddr) !=3D 0)
-				fail("PT_LOAD in wrong place\n");
-
-			if (GET_LE(&pt[i].p_memsz) !=3D GET_LE(&pt[i].p_filesz))
-				fail("cannot handle memsz !=3D filesz\n");
-
-			load_size =3D GET_LE(&pt[i].p_memsz);
-			found_load =3D 1;
-		} else if (GET_LE(&pt[i].p_type) =3D=3D PT_DYNAMIC) {
-			dyn =3D raw_addr + GET_LE(&pt[i].p_offset);
-			dyn_end =3D raw_addr + GET_LE(&pt[i].p_offset) +
-				GET_LE(&pt[i].p_memsz);
-		}
-	}
-	if (!found_load)
-		fail("no PT_LOAD seg\n");
-
-	if (stripped_len < load_size)
-		fail("stripped input is too short\n");
-
-	if (!dyn)
-		fail("input has no PT_DYNAMIC section -- your toolchain is buggy\n");
-
-	/* Walk the dynamic table */
-	for (i =3D 0; dyn + i < dyn_end &&
-		     GET_LE(&dyn[i].d_tag) !=3D DT_NULL; i++) {
-		typeof(dyn[i].d_tag) tag =3D GET_LE(&dyn[i].d_tag);
-		if (tag =3D=3D DT_REL || tag =3D=3D DT_RELSZ || tag =3D=3D DT_RELA ||
-		    tag =3D=3D DT_RELENT || tag =3D=3D DT_TEXTREL)
-			fail("vdso image contains dynamic relocations\n");
-	}
-
-	/* Walk the section table */
-	secstrings_hdr =3D raw_addr + GET_LE(&hdr->e_shoff) +
-		GET_LE(&hdr->e_shentsize)*GET_LE(&hdr->e_shstrndx);
-	secstrings =3D raw_addr + GET_LE(&secstrings_hdr->sh_offset);
-	for (i =3D 0; i < GET_LE(&hdr->e_shnum); i++) {
-		ELF(Shdr) *sh =3D raw_addr + GET_LE(&hdr->e_shoff) +
-			GET_LE(&hdr->e_shentsize) * i;
-		if (GET_LE(&sh->sh_type) =3D=3D SHT_SYMTAB)
-			symtab_hdr =3D sh;
-
-		if (!strcmp(secstrings + GET_LE(&sh->sh_name),
-			    ".altinstructions"))
-			alt_sec =3D sh;
-		if (!strcmp(secstrings + GET_LE(&sh->sh_name), "__ex_table"))
-			extable_sec =3D sh;
-	}
-
-	if (!symtab_hdr)
-		fail("no symbol table\n");
-
-	strtab_hdr =3D raw_addr + GET_LE(&hdr->e_shoff) +
-		GET_LE(&hdr->e_shentsize) * GET_LE(&symtab_hdr->sh_link);
-
-	syms_nr =3D GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
-	/* Walk the symbol table */
-	for (i =3D 0; i < syms_nr; i++) {
-		unsigned int k;
-		ELF(Sym) *sym =3D raw_addr + GET_LE(&symtab_hdr->sh_offset) +
-			GET_LE(&symtab_hdr->sh_entsize) * i;
-		const char *sym_name =3D raw_addr +
-				       GET_LE(&strtab_hdr->sh_offset) +
-				       GET_LE(&sym->st_name);
-
-		for (k =3D 0; k < NSYMS; k++) {
-			if (!strcmp(sym_name, required_syms[k].name)) {
-				if (syms[k]) {
-					fail("duplicate symbol %s\n",
-					     required_syms[k].name);
-				}
-
-				/*
-				 * Careful: we use negative addresses, but
-				 * st_value is unsigned, so we rely
-				 * on syms[k] being a signed type of the
-				 * correct width.
-				 */
-				syms[k] =3D GET_LE(&sym->st_value);
-			}
-		}
-	}
-
-	if (!image_name) {
-		fwrite(stripped_addr, stripped_len, 1, outfile);
-		return;
-	}
-
-	mapping_size =3D (stripped_len + 4095) / 4096 * 4096;
-
-	fprintf(outfile, "/* AUTOMATICALLY GENERATED -- DO NOT EDIT */\n\n");
-	fprintf(outfile, "#include <linux/linkage.h>\n");
-	fprintf(outfile, "#include <linux/init.h>\n");
-	fprintf(outfile, "#include <asm/page_types.h>\n");
-	fprintf(outfile, "#include <asm/vdso.h>\n");
-	fprintf(outfile, "\n");
-	fprintf(outfile,
-		"static unsigned char raw_data[%lu] __ro_after_init __aligned(PAGE_SIZE) =
=3D {",
-		mapping_size);
-	for (i =3D 0; i < stripped_len; i++) {
-		if (i % 10 =3D=3D 0)
-			fprintf(outfile, "\n\t");
-		fprintf(outfile, "0x%02X, ",
-			(int)((unsigned char *)stripped_addr)[i]);
-	}
-	fprintf(outfile, "\n};\n\n");
-	if (extable_sec)
-		BITSFUNC(extract)(raw_addr, raw_len, outfile,
-				  extable_sec, "extable");
-
-	fprintf(outfile, "const struct vdso_image %s =3D {\n", image_name);
-	fprintf(outfile, "\t.data =3D raw_data,\n");
-	fprintf(outfile, "\t.size =3D %lu,\n", mapping_size);
-	if (alt_sec) {
-		fprintf(outfile, "\t.alt =3D %lu,\n",
-			(unsigned long)GET_LE(&alt_sec->sh_offset));
-		fprintf(outfile, "\t.alt_len =3D %lu,\n",
-			(unsigned long)GET_LE(&alt_sec->sh_size));
-	}
-	if (extable_sec) {
-		fprintf(outfile, "\t.extable_base =3D %lu,\n",
-			(unsigned long)GET_LE(&extable_sec->sh_offset));
-		fprintf(outfile, "\t.extable_len =3D %lu,\n",
-			(unsigned long)GET_LE(&extable_sec->sh_size));
-		fprintf(outfile, "\t.extable =3D extable,\n");
-	}
-
-	for (i =3D 0; i < NSYMS; i++) {
-		if (required_syms[i].export && syms[i])
-			fprintf(outfile, "\t.sym_%s =3D %" PRIi64 ",\n",
-				required_syms[i].name, (int64_t)syms[i]);
-	}
-	fprintf(outfile, "};\n\n");
-	fprintf(outfile, "static __init int init_%s(void) {\n", image_name);
-	fprintf(outfile, "\treturn init_vdso_image(&%s);\n", image_name);
-	fprintf(outfile, "};\n");
-	fprintf(outfile, "subsys_initcall(init_%s);\n", image_name);
-
-}
diff --git a/arch/x86/tools/Makefile b/arch/x86/tools/Makefile
index 7278e25..39a183f 100644
--- a/arch/x86/tools/Makefile
+++ b/arch/x86/tools/Makefile
@@ -38,9 +38,14 @@ $(obj)/insn_decoder_test.o: $(srctree)/tools/arch/x86/lib/=
insn.c $(srctree)/tool
=20
 $(obj)/insn_sanity.o: $(srctree)/tools/arch/x86/lib/insn.c $(srctree)/tools/=
arch/x86/lib/inat.c $(srctree)/tools/arch/x86/include/asm/inat_types.h $(srct=
ree)/tools/arch/x86/include/asm/inat.h $(srctree)/tools/arch/x86/include/asm/=
insn.h $(objtree)/arch/x86/lib/inat-tables.c
=20
-HOST_EXTRACFLAGS +=3D -I$(srctree)/tools/include
-hostprogs	+=3D relocs
-relocs-objs     :=3D relocs_32.o relocs_64.o relocs_common.o
-PHONY +=3D relocs
-relocs: $(obj)/relocs
+HOST_EXTRACFLAGS +=3D -I$(srctree)/tools/include -I$(srctree)/include/uapi \
+		    -I$(srctree)/arch/$(SUBARCH)/include/uapi
+
+hostprogs	+=3D relocs vdso2c
+relocs-objs	:=3D relocs_32.o relocs_64.o relocs_common.o
+
+always-y	:=3D $(hostprogs)
+
+PHONY +=3D $(hostprogs)
+$(hostprogs): %: $(obj)/%
 	@:
diff --git a/arch/x86/tools/vdso2c.c b/arch/x86/tools/vdso2c.c
new file mode 100644
index 0000000..f84e8f8
--- /dev/null
+++ b/arch/x86/tools/vdso2c.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vdso2c - A vdso image preparation tool
+ * Copyright (c) 2014 Andy Lutomirski and others
+ *
+ * vdso2c requires stripped and unstripped input.  It would be trivial
+ * to fully strip the input in here, but, for reasons described below,
+ * we need to write a section table.  Doing this is more or less
+ * equivalent to dropping all non-allocatable sections, but it's
+ * easier to let objcopy handle that instead of doing it ourselves.
+ * If we ever need to do something fancier than what objcopy provides,
+ * it would be straightforward to add here.
+ *
+ * We're keep a section table for a few reasons:
+ *
+ * The Go runtime had a couple of bugs: it would read the section
+ * table to try to figure out how many dynamic symbols there were (it
+ * shouldn't have looked at the section table at all) and, if there
+ * were no SHT_SYNDYM section table entry, it would use an
+ * uninitialized value for the number of symbols.  An empty DYNSYM
+ * table would work, but I see no reason not to write a valid one (and
+ * keep full performance for old Go programs).  This hack is only
+ * needed on x86_64.
+ *
+ * The bug was introduced on 2012-08-31 by:
+ * https://code.google.com/p/go/source/detail?r=3D56ea40aac72b
+ * and was fixed on 2014-06-13 by:
+ * https://code.google.com/p/go/source/detail?r=3Dfc1cd5e12595
+ *
+ * Binutils has issues debugging the vDSO: it reads the section table to
+ * find SHT_NOTE; it won't look at PT_NOTE for the in-memory vDSO, which
+ * would break build-id if we removed the section table.  Binutils
+ * also requires that shstrndx !=3D 0.  See:
+ * https://sourceware.org/bugzilla/show_bug.cgi?id=3D17064
+ *
+ * elfutils might not look for PT_NOTE if there is a section table at
+ * all.  I don't know whether this matters for any practical purpose.
+ *
+ * For simplicity, rather than hacking up a partial section table, we
+ * just write a mostly complete one.  We omit non-dynamic symbols,
+ * though, since they're rather large.
+ *
+ * Once binutils gets fixed, we might be able to drop this for all but
+ * the 64-bit vdso, since build-id only works in kernel RPMs, and
+ * systems that update to new enough kernel RPMs will likely update
+ * binutils in sync.  build-id has never worked for home-built kernel
+ * RPMs without manual symlinking, and I suspect that no one ever does
+ * that.
+ */
+
+#include <inttypes.h>
+#include <stdint.h>
+#include <unistd.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <fcntl.h>
+#include <err.h>
+
+#include <sys/mman.h>
+#include <sys/types.h>
+
+#include <tools/le_byteshift.h>
+
+#include <linux/elf.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+const char *outfilename;
+
+struct vdso_sym {
+	const char *name;
+	bool export;
+};
+
+struct vdso_sym required_syms[] =3D {
+	{"VDSO32_NOTE_MASK", true},
+	{"__kernel_vsyscall", true},
+	{"__kernel_sigreturn", true},
+	{"__kernel_rt_sigreturn", true},
+	{"int80_landing_pad", true},
+	{"vdso32_rt_sigreturn_landing_pad", true},
+	{"vdso32_sigreturn_landing_pad", true},
+};
+
+__attribute__((format(printf, 1, 2))) __attribute__((noreturn))
+static void fail(const char *format, ...)
+{
+	va_list ap;
+	va_start(ap, format);
+	fprintf(stderr, "Error: ");
+	vfprintf(stderr, format, ap);
+	if (outfilename)
+		unlink(outfilename);
+	exit(1);
+	va_end(ap);
+}
+
+/*
+ * Evil macros for little-endian reads and writes
+ */
+#define GLE(x, bits, ifnot)						\
+	__builtin_choose_expr(						\
+		(sizeof(*(x)) =3D=3D bits/8),				\
+		(__typeof__(*(x)))get_unaligned_le##bits(x), ifnot)
+
+extern void bad_get_le(void);
+#define LAST_GLE(x)							\
+	__builtin_choose_expr(sizeof(*(x)) =3D=3D 1, *(x), bad_get_le())
+
+#define GET_LE(x)							\
+	GLE(x, 64, GLE(x, 32, GLE(x, 16, LAST_GLE(x))))
+
+#define PLE(x, val, bits, ifnot)					\
+	__builtin_choose_expr(						\
+		(sizeof(*(x)) =3D=3D bits/8),				\
+		put_unaligned_le##bits((val), (x)), ifnot)
+
+extern void bad_put_le(void);
+#define LAST_PLE(x, val)						\
+	__builtin_choose_expr(sizeof(*(x)) =3D=3D 1, *(x) =3D (val), bad_put_le())
+
+#define PUT_LE(x, val)					\
+	PLE(x, val, 64, PLE(x, val, 32, PLE(x, val, 16, LAST_PLE(x, val))))
+
+
+#define NSYMS ARRAY_SIZE(required_syms)
+
+#define BITSFUNC3(name, bits, suffix) name##bits##suffix
+#define BITSFUNC2(name, bits, suffix) BITSFUNC3(name, bits, suffix)
+#define BITSFUNC(name) BITSFUNC2(name, ELF_BITS, )
+
+#define INT_BITS BITSFUNC2(int, ELF_BITS, _t)
+
+#define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
+#define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
+#define ELF(x) ELF_BITS_XFORM(ELF_BITS, x)
+
+#define ELF_BITS 64
+#include "vdso2c.h"
+#undef ELF_BITS
+
+#define ELF_BITS 32
+#include "vdso2c.h"
+#undef ELF_BITS
+
+static void go(void *raw_addr, size_t raw_len,
+	       void *stripped_addr, size_t stripped_len,
+	       FILE *outfile, const char *name)
+{
+	Elf64_Ehdr *hdr =3D (Elf64_Ehdr *)raw_addr;
+
+	if (hdr->e_ident[EI_CLASS] =3D=3D ELFCLASS64) {
+		go64(raw_addr, raw_len, stripped_addr, stripped_len,
+		     outfile, name);
+	} else if (hdr->e_ident[EI_CLASS] =3D=3D ELFCLASS32) {
+		go32(raw_addr, raw_len, stripped_addr, stripped_len,
+		     outfile, name);
+	} else {
+		fail("unknown ELF class\n");
+	}
+}
+
+static void map_input(const char *name, void **addr, size_t *len, int prot)
+{
+	off_t tmp_len;
+
+	int fd =3D open(name, O_RDONLY);
+	if (fd =3D=3D -1)
+		err(1, "open(%s)", name);
+
+	tmp_len =3D lseek(fd, 0, SEEK_END);
+	if (tmp_len =3D=3D (off_t)-1)
+		err(1, "lseek");
+	*len =3D (size_t)tmp_len;
+
+	*addr =3D mmap(NULL, tmp_len, prot, MAP_PRIVATE, fd, 0);
+	if (*addr =3D=3D MAP_FAILED)
+		err(1, "mmap");
+
+	close(fd);
+}
+
+int main(int argc, char **argv)
+{
+	size_t raw_len, stripped_len;
+	void *raw_addr, *stripped_addr;
+	FILE *outfile;
+	char *name, *tmp;
+	int namelen;
+
+	if (argc !=3D 4) {
+		printf("Usage: vdso2c RAW_INPUT STRIPPED_INPUT OUTPUT\n");
+		return 1;
+	}
+
+	/*
+	 * Figure out the struct name.  If we're writing to a .so file,
+	 * generate raw output instead.
+	 */
+	name =3D strdup(argv[3]);
+	namelen =3D strlen(name);
+	if (namelen >=3D 3 && !strcmp(name + namelen - 3, ".so")) {
+		name =3D NULL;
+	} else {
+		tmp =3D strrchr(name, '/');
+		if (tmp)
+			name =3D tmp + 1;
+		tmp =3D strchr(name, '.');
+		if (tmp)
+			*tmp =3D '\0';
+		for (tmp =3D name; *tmp; tmp++)
+			if (*tmp =3D=3D '-')
+				*tmp =3D '_';
+	}
+
+	map_input(argv[1], &raw_addr, &raw_len, PROT_READ);
+	map_input(argv[2], &stripped_addr, &stripped_len, PROT_READ);
+
+	outfilename =3D argv[3];
+	outfile =3D fopen(outfilename, "w");
+	if (!outfile)
+		err(1, "fopen(%s)", outfilename);
+
+	go(raw_addr, raw_len, stripped_addr, stripped_len, outfile, name);
+
+	munmap(raw_addr, raw_len);
+	munmap(stripped_addr, stripped_len);
+	fclose(outfile);
+
+	return 0;
+}
diff --git a/arch/x86/tools/vdso2c.h b/arch/x86/tools/vdso2c.h
new file mode 100644
index 0000000..78ed1c1
--- /dev/null
+++ b/arch/x86/tools/vdso2c.h
@@ -0,0 +1,208 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This file is included twice from vdso2c.c.  It generates code for 32-bit
+ * and 64-bit vDSOs.  We need both for 64-bit builds, since 32-bit vDSOs
+ * are built for 32-bit userspace.
+ */
+
+static void BITSFUNC(copy)(FILE *outfile, const unsigned char *data, size_t =
len)
+{
+	size_t i;
+
+	for (i =3D 0; i < len; i++) {
+		if (i % 10 =3D=3D 0)
+			fprintf(outfile, "\n\t");
+		fprintf(outfile, "0x%02X, ", (int)(data)[i]);
+	}
+}
+
+
+/*
+ * Extract a section from the input data into a standalone blob.  Used to
+ * capture kernel-only data that needs to persist indefinitely, e.g. the
+ * exception fixup tables, but only in the kernel, i.e. the section can
+ * be stripped from the final vDSO image.
+ */
+static void BITSFUNC(extract)(const unsigned char *data, size_t data_len,
+			      FILE *outfile, ELF(Shdr) *sec, const char *name)
+{
+	unsigned long offset;
+	size_t len;
+
+	offset =3D (unsigned long)GET_LE(&sec->sh_offset);
+	len =3D (size_t)GET_LE(&sec->sh_size);
+
+	if (offset + len > data_len)
+		fail("section to extract overruns input data");
+
+	fprintf(outfile, "static const unsigned char %s[%zu] =3D {", name, len);
+	BITSFUNC(copy)(outfile, data + offset, len);
+	fprintf(outfile, "\n};\n\n");
+}
+
+static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
+			 void *stripped_addr, size_t stripped_len,
+			 FILE *outfile, const char *image_name)
+{
+	int found_load =3D 0;
+	unsigned long load_size =3D -1;  /* Work around bogus warning */
+	unsigned long mapping_size;
+	ELF(Ehdr) *hdr =3D (ELF(Ehdr) *)raw_addr;
+	unsigned long i, syms_nr;
+	ELF(Shdr) *symtab_hdr =3D NULL, *strtab_hdr, *secstrings_hdr,
+		*alt_sec =3D NULL, *extable_sec =3D NULL;
+	ELF(Dyn) *dyn =3D 0, *dyn_end =3D 0;
+	const char *secstrings;
+	INT_BITS syms[NSYMS] =3D {};
+
+	ELF(Phdr) *pt =3D (ELF(Phdr) *)(raw_addr + GET_LE(&hdr->e_phoff));
+
+	if (GET_LE(&hdr->e_type) !=3D ET_DYN)
+		fail("input is not a shared object\n");
+
+	/* Walk the segment table. */
+	for (i =3D 0; i < GET_LE(&hdr->e_phnum); i++) {
+		if (GET_LE(&pt[i].p_type) =3D=3D PT_LOAD) {
+			if (found_load)
+				fail("multiple PT_LOAD segs\n");
+
+			if (GET_LE(&pt[i].p_offset) !=3D 0 ||
+			    GET_LE(&pt[i].p_vaddr) !=3D 0)
+				fail("PT_LOAD in wrong place\n");
+
+			if (GET_LE(&pt[i].p_memsz) !=3D GET_LE(&pt[i].p_filesz))
+				fail("cannot handle memsz !=3D filesz\n");
+
+			load_size =3D GET_LE(&pt[i].p_memsz);
+			found_load =3D 1;
+		} else if (GET_LE(&pt[i].p_type) =3D=3D PT_DYNAMIC) {
+			dyn =3D raw_addr + GET_LE(&pt[i].p_offset);
+			dyn_end =3D raw_addr + GET_LE(&pt[i].p_offset) +
+				GET_LE(&pt[i].p_memsz);
+		}
+	}
+	if (!found_load)
+		fail("no PT_LOAD seg\n");
+
+	if (stripped_len < load_size)
+		fail("stripped input is too short\n");
+
+	if (!dyn)
+		fail("input has no PT_DYNAMIC section -- your toolchain is buggy\n");
+
+	/* Walk the dynamic table */
+	for (i =3D 0; dyn + i < dyn_end &&
+		     GET_LE(&dyn[i].d_tag) !=3D DT_NULL; i++) {
+		typeof(dyn[i].d_tag) tag =3D GET_LE(&dyn[i].d_tag);
+		if (tag =3D=3D DT_REL || tag =3D=3D DT_RELSZ || tag =3D=3D DT_RELA ||
+		    tag =3D=3D DT_RELENT || tag =3D=3D DT_TEXTREL)
+			fail("vdso image contains dynamic relocations\n");
+	}
+
+	/* Walk the section table */
+	secstrings_hdr =3D raw_addr + GET_LE(&hdr->e_shoff) +
+		GET_LE(&hdr->e_shentsize)*GET_LE(&hdr->e_shstrndx);
+	secstrings =3D raw_addr + GET_LE(&secstrings_hdr->sh_offset);
+	for (i =3D 0; i < GET_LE(&hdr->e_shnum); i++) {
+		ELF(Shdr) *sh =3D raw_addr + GET_LE(&hdr->e_shoff) +
+			GET_LE(&hdr->e_shentsize) * i;
+		if (GET_LE(&sh->sh_type) =3D=3D SHT_SYMTAB)
+			symtab_hdr =3D sh;
+
+		if (!strcmp(secstrings + GET_LE(&sh->sh_name),
+			    ".altinstructions"))
+			alt_sec =3D sh;
+		if (!strcmp(secstrings + GET_LE(&sh->sh_name), "__ex_table"))
+			extable_sec =3D sh;
+	}
+
+	if (!symtab_hdr)
+		fail("no symbol table\n");
+
+	strtab_hdr =3D raw_addr + GET_LE(&hdr->e_shoff) +
+		GET_LE(&hdr->e_shentsize) * GET_LE(&symtab_hdr->sh_link);
+
+	syms_nr =3D GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
+	/* Walk the symbol table */
+	for (i =3D 0; i < syms_nr; i++) {
+		unsigned int k;
+		ELF(Sym) *sym =3D raw_addr + GET_LE(&symtab_hdr->sh_offset) +
+			GET_LE(&symtab_hdr->sh_entsize) * i;
+		const char *sym_name =3D raw_addr +
+				       GET_LE(&strtab_hdr->sh_offset) +
+				       GET_LE(&sym->st_name);
+
+		for (k =3D 0; k < NSYMS; k++) {
+			if (!strcmp(sym_name, required_syms[k].name)) {
+				if (syms[k]) {
+					fail("duplicate symbol %s\n",
+					     required_syms[k].name);
+				}
+
+				/*
+				 * Careful: we use negative addresses, but
+				 * st_value is unsigned, so we rely
+				 * on syms[k] being a signed type of the
+				 * correct width.
+				 */
+				syms[k] =3D GET_LE(&sym->st_value);
+			}
+		}
+	}
+
+	if (!image_name) {
+		fwrite(stripped_addr, stripped_len, 1, outfile);
+		return;
+	}
+
+	mapping_size =3D (stripped_len + 4095) / 4096 * 4096;
+
+	fprintf(outfile, "/* AUTOMATICALLY GENERATED -- DO NOT EDIT */\n\n");
+	fprintf(outfile, "#include <linux/linkage.h>\n");
+	fprintf(outfile, "#include <linux/init.h>\n");
+	fprintf(outfile, "#include <asm/page_types.h>\n");
+	fprintf(outfile, "#include <asm/vdso.h>\n");
+	fprintf(outfile, "\n");
+	fprintf(outfile,
+		"static unsigned char raw_data[%lu] __ro_after_init __aligned(PAGE_SIZE) =
=3D {",
+		mapping_size);
+	for (i =3D 0; i < stripped_len; i++) {
+		if (i % 10 =3D=3D 0)
+			fprintf(outfile, "\n\t");
+		fprintf(outfile, "0x%02X, ",
+			(int)((unsigned char *)stripped_addr)[i]);
+	}
+	fprintf(outfile, "\n};\n\n");
+	if (extable_sec)
+		BITSFUNC(extract)(raw_addr, raw_len, outfile,
+				  extable_sec, "extable");
+
+	fprintf(outfile, "const struct vdso_image %s =3D {\n", image_name);
+	fprintf(outfile, "\t.data =3D raw_data,\n");
+	fprintf(outfile, "\t.size =3D %lu,\n", mapping_size);
+	if (alt_sec) {
+		fprintf(outfile, "\t.alt =3D %lu,\n",
+			(unsigned long)GET_LE(&alt_sec->sh_offset));
+		fprintf(outfile, "\t.alt_len =3D %lu,\n",
+			(unsigned long)GET_LE(&alt_sec->sh_size));
+	}
+	if (extable_sec) {
+		fprintf(outfile, "\t.extable_base =3D %lu,\n",
+			(unsigned long)GET_LE(&extable_sec->sh_offset));
+		fprintf(outfile, "\t.extable_len =3D %lu,\n",
+			(unsigned long)GET_LE(&extable_sec->sh_size));
+		fprintf(outfile, "\t.extable =3D extable,\n");
+	}
+
+	for (i =3D 0; i < NSYMS; i++) {
+		if (required_syms[i].export && syms[i])
+			fprintf(outfile, "\t.sym_%s =3D %" PRIi64 ",\n",
+				required_syms[i].name, (int64_t)syms[i]);
+	}
+	fprintf(outfile, "};\n\n");
+	fprintf(outfile, "static __init int init_%s(void) {\n", image_name);
+	fprintf(outfile, "\treturn init_vdso_image(&%s);\n", image_name);
+	fprintf(outfile, "};\n");
+	fprintf(outfile, "subsys_initcall(init_%s);\n", image_name);
+
+}

