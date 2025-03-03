Return-Path: <linux-tip-commits+bounces-3826-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C00A4CBC1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52250170FA4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068A423A562;
	Mon,  3 Mar 2025 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i3GMjmPy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y7GpeSVz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F469236A62;
	Mon,  3 Mar 2025 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029185; cv=none; b=eJKlytXo5Trz9CwhFYvgj0ezdPO+x/4uKPdzwKD06cgblxfwEP5Ee691y7aSdw8dOOJ8sNE1ROEN4FatNJSsUFtzhzriyFLhJhsOVWF1kI+UeD4RpLEm1r4QlR5KZtdCS3wF5Ee95ZazAxCdnvZKe1A3ZPsyIUInO0W6fvi28rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029185; c=relaxed/simple;
	bh=ZTBqo9UaDgrVjCS0yWK2OV42Svnt67+ltTiMK1w4qoM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OPFJPZSOt4Kti7wJS/Nj1hLezGloLrQ7BkUpSSmInYHzIM1FqEbRYEfZU06OTHHi9AXKzucirJ/HzZAxd1a5mwKSCOsrTx/YLuYUs5JUE8ip6050d4oT7HcZUbPVmxI2Mg4oQV9/vILTC9dC0qiubiu5vfNmECR2T4g9fpyqMvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i3GMjmPy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y7GpeSVz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:13:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KyN1BYr26dZNXG6H7D2b5b/YYem+xHRjAKE0AGLTT1A=;
	b=i3GMjmPyV+GDaI1pJcXKtPRSQUFEw1P3xS2qpltKlPfWRXJ8jbS4CkXfcw7+QrF3lKN8hl
	hQGeOLzZ8FF6Zdzkk7f8OCWmecW3qxQWasmHGuVESQGMZarpmaSihPr+16ULWdIsfJk26X
	aCFgTjFpun2sPoChqGgtwv4A/zwJmo7TdzseHoXLUi1EmPxEjmFtCtFwpIg8aP8ePTSHOu
	/LRm26fQxNtkawjKwcZK0rr8d2XumAuS6Ux2n2jky94NGG9PWTwkLn8hRjR2ftpXvMI454
	J49GL9u0h/vQl1kFLxqVcI+ayyPE8QufyM9AHYht9n7hI3wQ3FjYRdlE0QONmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KyN1BYr26dZNXG6H7D2b5b/YYem+xHRjAKE0AGLTT1A=;
	b=y7GpeSVz65R0sZjdKSfjp0XqrYq3kttClOm9KrBjPoUvMq474tU7W/eAWvB5HZLss8iYJq
	gMXTBuMS1yV56dDg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] tools/include: Add uapi/linux/elf.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-7-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-7-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102918132.14745.5795605184739472499.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     626fd35278295fbb21f2da331cd8028e9738d965
Gitweb:        https://git.kernel.org/tip/626fd35278295fbb21f2da331cd8028e973=
8d965
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:12 +01:00

tools/include: Add uapi/linux/elf.h

It will be used by the vDSO selftests.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-7-28e14e031ed=
8@linutronix.de
---
 tools/include/uapi/linux/elf.h | 524 ++++++++++++++++++++++++++++++++-
 1 file changed, 524 insertions(+)
 create mode 100644 tools/include/uapi/linux/elf.h

diff --git a/tools/include/uapi/linux/elf.h b/tools/include/uapi/linux/elf.h
new file mode 100644
index 0000000..5834b83
--- /dev/null
+++ b/tools/include/uapi/linux/elf.h
@@ -0,0 +1,524 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_ELF_H
+#define _LINUX_ELF_H
+
+#include <linux/types.h>
+#include <linux/elf-em.h>
+
+/* 32-bit ELF base types. */
+typedef __u32	Elf32_Addr;
+typedef __u16	Elf32_Half;
+typedef __u32	Elf32_Off;
+typedef __s32	Elf32_Sword;
+typedef __u32	Elf32_Word;
+typedef __u16	Elf32_Versym;
+
+/* 64-bit ELF base types. */
+typedef __u64	Elf64_Addr;
+typedef __u16	Elf64_Half;
+typedef __s16	Elf64_SHalf;
+typedef __u64	Elf64_Off;
+typedef __s32	Elf64_Sword;
+typedef __u32	Elf64_Word;
+typedef __u64	Elf64_Xword;
+typedef __s64	Elf64_Sxword;
+typedef __u16	Elf64_Versym;
+
+/* These constants are for the segment types stored in the image headers */
+#define PT_NULL    0
+#define PT_LOAD    1
+#define PT_DYNAMIC 2
+#define PT_INTERP  3
+#define PT_NOTE    4
+#define PT_SHLIB   5
+#define PT_PHDR    6
+#define PT_TLS     7		/* Thread local storage segment */
+#define PT_LOOS    0x60000000	/* OS-specific */
+#define PT_HIOS    0x6fffffff	/* OS-specific */
+#define PT_LOPROC  0x70000000
+#define PT_HIPROC  0x7fffffff
+#define PT_GNU_EH_FRAME	(PT_LOOS + 0x474e550)
+#define PT_GNU_STACK	(PT_LOOS + 0x474e551)
+#define PT_GNU_RELRO	(PT_LOOS + 0x474e552)
+#define PT_GNU_PROPERTY	(PT_LOOS + 0x474e553)
+
+
+/* ARM MTE memory tag segment type */
+#define PT_AARCH64_MEMTAG_MTE	(PT_LOPROC + 0x2)
+
+/*
+ * Extended Numbering
+ *
+ * If the real number of program header table entries is larger than
+ * or equal to PN_XNUM(0xffff), it is set to sh_info field of the
+ * section header at index 0, and PN_XNUM is set to e_phnum
+ * field. Otherwise, the section header at index 0 is zero
+ * initialized, if it exists.
+ *
+ * Specifications are available in:
+ *
+ * - Oracle: Linker and Libraries.
+ *   Part No: 817=E2=80=931984=E2=80=9319, August 2011.
+ *   https://docs.oracle.com/cd/E18752_01/pdf/817-1984.pdf
+ *
+ * - System V ABI AMD64 Architecture Processor Supplement
+ *   Draft Version 0.99.4,
+ *   January 13, 2010.
+ *   http://www.cs.washington.edu/education/courses/cse351/12wi/supp-docs/ab=
i.pdf
+ */
+#define PN_XNUM 0xffff
+
+/* These constants define the different elf file types */
+#define ET_NONE   0
+#define ET_REL    1
+#define ET_EXEC   2
+#define ET_DYN    3
+#define ET_CORE   4
+#define ET_LOPROC 0xff00
+#define ET_HIPROC 0xffff
+
+/* This is the info that is needed to parse the dynamic section of the file =
*/
+#define DT_NULL		0
+#define DT_NEEDED	1
+#define DT_PLTRELSZ	2
+#define DT_PLTGOT	3
+#define DT_HASH		4
+#define DT_STRTAB	5
+#define DT_SYMTAB	6
+#define DT_RELA		7
+#define DT_RELASZ	8
+#define DT_RELAENT	9
+#define DT_STRSZ	10
+#define DT_SYMENT	11
+#define DT_INIT		12
+#define DT_FINI		13
+#define DT_SONAME	14
+#define DT_RPATH	15
+#define DT_SYMBOLIC	16
+#define DT_REL		17
+#define DT_RELSZ	18
+#define DT_RELENT	19
+#define DT_PLTREL	20
+#define DT_DEBUG	21
+#define DT_TEXTREL	22
+#define DT_JMPREL	23
+#define DT_ENCODING	32
+#define OLD_DT_LOOS	0x60000000
+#define DT_LOOS		0x6000000d
+#define DT_HIOS		0x6ffff000
+#define DT_VALRNGLO	0x6ffffd00
+#define DT_VALRNGHI	0x6ffffdff
+#define DT_ADDRRNGLO	0x6ffffe00
+#define DT_GNU_HASH	0x6ffffef5
+#define DT_ADDRRNGHI	0x6ffffeff
+#define DT_VERSYM	0x6ffffff0
+#define DT_RELACOUNT	0x6ffffff9
+#define DT_RELCOUNT	0x6ffffffa
+#define DT_FLAGS_1	0x6ffffffb
+#define DT_VERDEF	0x6ffffffc
+#define	DT_VERDEFNUM	0x6ffffffd
+#define DT_VERNEED	0x6ffffffe
+#define	DT_VERNEEDNUM	0x6fffffff
+#define OLD_DT_HIOS     0x6fffffff
+#define DT_LOPROC	0x70000000
+#define DT_HIPROC	0x7fffffff
+
+/* This info is needed when parsing the symbol table */
+#define STB_LOCAL  0
+#define STB_GLOBAL 1
+#define STB_WEAK   2
+
+#define STN_UNDEF 0
+
+#define STT_NOTYPE  0
+#define STT_OBJECT  1
+#define STT_FUNC    2
+#define STT_SECTION 3
+#define STT_FILE    4
+#define STT_COMMON  5
+#define STT_TLS     6
+
+#define VER_FLG_BASE 0x1
+#define VER_FLG_WEAK 0x2
+
+#define ELF_ST_BIND(x)		((x) >> 4)
+#define ELF_ST_TYPE(x)		((x) & 0xf)
+#define ELF32_ST_BIND(x)	ELF_ST_BIND(x)
+#define ELF32_ST_TYPE(x)	ELF_ST_TYPE(x)
+#define ELF64_ST_BIND(x)	ELF_ST_BIND(x)
+#define ELF64_ST_TYPE(x)	ELF_ST_TYPE(x)
+
+typedef struct {
+  Elf32_Sword d_tag;
+  union {
+    Elf32_Sword	d_val;
+    Elf32_Addr	d_ptr;
+  } d_un;
+} Elf32_Dyn;
+
+typedef struct {
+  Elf64_Sxword d_tag;		/* entry tag value */
+  union {
+    Elf64_Xword d_val;
+    Elf64_Addr d_ptr;
+  } d_un;
+} Elf64_Dyn;
+
+/* The following are used with relocations */
+#define ELF32_R_SYM(x) ((x) >> 8)
+#define ELF32_R_TYPE(x) ((x) & 0xff)
+
+#define ELF64_R_SYM(i)			((i) >> 32)
+#define ELF64_R_TYPE(i)			((i) & 0xffffffff)
+
+typedef struct elf32_rel {
+  Elf32_Addr	r_offset;
+  Elf32_Word	r_info;
+} Elf32_Rel;
+
+typedef struct elf64_rel {
+  Elf64_Addr r_offset;	/* Location at which to apply the action */
+  Elf64_Xword r_info;	/* index and type of relocation */
+} Elf64_Rel;
+
+typedef struct elf32_rela {
+  Elf32_Addr	r_offset;
+  Elf32_Word	r_info;
+  Elf32_Sword	r_addend;
+} Elf32_Rela;
+
+typedef struct elf64_rela {
+  Elf64_Addr r_offset;	/* Location at which to apply the action */
+  Elf64_Xword r_info;	/* index and type of relocation */
+  Elf64_Sxword r_addend;	/* Constant addend used to compute value */
+} Elf64_Rela;
+
+typedef struct elf32_sym {
+  Elf32_Word	st_name;
+  Elf32_Addr	st_value;
+  Elf32_Word	st_size;
+  unsigned char	st_info;
+  unsigned char	st_other;
+  Elf32_Half	st_shndx;
+} Elf32_Sym;
+
+typedef struct elf64_sym {
+  Elf64_Word st_name;		/* Symbol name, index in string tbl */
+  unsigned char	st_info;	/* Type and binding attributes */
+  unsigned char	st_other;	/* No defined meaning, 0 */
+  Elf64_Half st_shndx;		/* Associated section index */
+  Elf64_Addr st_value;		/* Value of the symbol */
+  Elf64_Xword st_size;		/* Associated symbol size */
+} Elf64_Sym;
+
+
+#define EI_NIDENT	16
+
+typedef struct elf32_hdr {
+  unsigned char	e_ident[EI_NIDENT];
+  Elf32_Half	e_type;
+  Elf32_Half	e_machine;
+  Elf32_Word	e_version;
+  Elf32_Addr	e_entry;  /* Entry point */
+  Elf32_Off	e_phoff;
+  Elf32_Off	e_shoff;
+  Elf32_Word	e_flags;
+  Elf32_Half	e_ehsize;
+  Elf32_Half	e_phentsize;
+  Elf32_Half	e_phnum;
+  Elf32_Half	e_shentsize;
+  Elf32_Half	e_shnum;
+  Elf32_Half	e_shstrndx;
+} Elf32_Ehdr;
+
+typedef struct elf64_hdr {
+  unsigned char	e_ident[EI_NIDENT];	/* ELF "magic number" */
+  Elf64_Half e_type;
+  Elf64_Half e_machine;
+  Elf64_Word e_version;
+  Elf64_Addr e_entry;		/* Entry point virtual address */
+  Elf64_Off e_phoff;		/* Program header table file offset */
+  Elf64_Off e_shoff;		/* Section header table file offset */
+  Elf64_Word e_flags;
+  Elf64_Half e_ehsize;
+  Elf64_Half e_phentsize;
+  Elf64_Half e_phnum;
+  Elf64_Half e_shentsize;
+  Elf64_Half e_shnum;
+  Elf64_Half e_shstrndx;
+} Elf64_Ehdr;
+
+/* These constants define the permissions on sections in the program
+   header, p_flags. */
+#define PF_R		0x4
+#define PF_W		0x2
+#define PF_X		0x1
+
+typedef struct elf32_phdr {
+  Elf32_Word	p_type;
+  Elf32_Off	p_offset;
+  Elf32_Addr	p_vaddr;
+  Elf32_Addr	p_paddr;
+  Elf32_Word	p_filesz;
+  Elf32_Word	p_memsz;
+  Elf32_Word	p_flags;
+  Elf32_Word	p_align;
+} Elf32_Phdr;
+
+typedef struct elf64_phdr {
+  Elf64_Word p_type;
+  Elf64_Word p_flags;
+  Elf64_Off p_offset;		/* Segment file offset */
+  Elf64_Addr p_vaddr;		/* Segment virtual address */
+  Elf64_Addr p_paddr;		/* Segment physical address */
+  Elf64_Xword p_filesz;		/* Segment size in file */
+  Elf64_Xword p_memsz;		/* Segment size in memory */
+  Elf64_Xword p_align;		/* Segment alignment, file & memory */
+} Elf64_Phdr;
+
+/* sh_type */
+#define SHT_NULL	0
+#define SHT_PROGBITS	1
+#define SHT_SYMTAB	2
+#define SHT_STRTAB	3
+#define SHT_RELA	4
+#define SHT_HASH	5
+#define SHT_DYNAMIC	6
+#define SHT_NOTE	7
+#define SHT_NOBITS	8
+#define SHT_REL		9
+#define SHT_SHLIB	10
+#define SHT_DYNSYM	11
+#define SHT_NUM		12
+#define SHT_LOPROC	0x70000000
+#define SHT_HIPROC	0x7fffffff
+#define SHT_LOUSER	0x80000000
+#define SHT_HIUSER	0xffffffff
+
+/* sh_flags */
+#define SHF_WRITE		0x1
+#define SHF_ALLOC		0x2
+#define SHF_EXECINSTR		0x4
+#define SHF_RELA_LIVEPATCH	0x00100000
+#define SHF_RO_AFTER_INIT	0x00200000
+#define SHF_MASKPROC		0xf0000000
+
+/* special section indexes */
+#define SHN_UNDEF	0
+#define SHN_LORESERVE	0xff00
+#define SHN_LOPROC	0xff00
+#define SHN_HIPROC	0xff1f
+#define SHN_LIVEPATCH	0xff20
+#define SHN_ABS		0xfff1
+#define SHN_COMMON	0xfff2
+#define SHN_HIRESERVE	0xffff
+
+typedef struct elf32_shdr {
+  Elf32_Word	sh_name;
+  Elf32_Word	sh_type;
+  Elf32_Word	sh_flags;
+  Elf32_Addr	sh_addr;
+  Elf32_Off	sh_offset;
+  Elf32_Word	sh_size;
+  Elf32_Word	sh_link;
+  Elf32_Word	sh_info;
+  Elf32_Word	sh_addralign;
+  Elf32_Word	sh_entsize;
+} Elf32_Shdr;
+
+typedef struct elf64_shdr {
+  Elf64_Word sh_name;		/* Section name, index in string tbl */
+  Elf64_Word sh_type;		/* Type of section */
+  Elf64_Xword sh_flags;		/* Miscellaneous section attributes */
+  Elf64_Addr sh_addr;		/* Section virtual addr at execution */
+  Elf64_Off sh_offset;		/* Section file offset */
+  Elf64_Xword sh_size;		/* Size of section in bytes */
+  Elf64_Word sh_link;		/* Index of another section */
+  Elf64_Word sh_info;		/* Additional section information */
+  Elf64_Xword sh_addralign;	/* Section alignment */
+  Elf64_Xword sh_entsize;	/* Entry size if section holds table */
+} Elf64_Shdr;
+
+#define	EI_MAG0		0		/* e_ident[] indexes */
+#define	EI_MAG1		1
+#define	EI_MAG2		2
+#define	EI_MAG3		3
+#define	EI_CLASS	4
+#define	EI_DATA		5
+#define	EI_VERSION	6
+#define	EI_OSABI	7
+#define	EI_PAD		8
+
+#define	ELFMAG0		0x7f		/* EI_MAG */
+#define	ELFMAG1		'E'
+#define	ELFMAG2		'L'
+#define	ELFMAG3		'F'
+#define	ELFMAG		"\177ELF"
+#define	SELFMAG		4
+
+#define	ELFCLASSNONE	0		/* EI_CLASS */
+#define	ELFCLASS32	1
+#define	ELFCLASS64	2
+#define	ELFCLASSNUM	3
+
+#define ELFDATANONE	0		/* e_ident[EI_DATA] */
+#define ELFDATA2LSB	1
+#define ELFDATA2MSB	2
+
+#define EV_NONE		0		/* e_version, EI_VERSION */
+#define EV_CURRENT	1
+#define EV_NUM		2
+
+#define ELFOSABI_NONE	0
+#define ELFOSABI_LINUX	3
+
+#ifndef ELF_OSABI
+#define ELF_OSABI ELFOSABI_NONE
+#endif
+
+/*
+ * Notes used in ET_CORE. Architectures export some of the arch register sets
+ * using the corresponding note types via the PTRACE_GETREGSET and
+ * PTRACE_SETREGSET requests.
+ * The note name for these types is "LINUX", except NT_PRFPREG that is named
+ * "CORE".
+ */
+#define NT_PRSTATUS	1
+#define NT_PRFPREG	2
+#define NT_PRPSINFO	3
+#define NT_TASKSTRUCT	4
+#define NT_AUXV		6
+/*
+ * Note to userspace developers: size of NT_SIGINFO note may increase
+ * in the future to accomodate more fields, don't assume it is fixed!
+ */
+#define NT_SIGINFO      0x53494749
+#define NT_FILE		0x46494c45
+#define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/co=
mmon.h */
+#define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
+#define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
+#define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
+#define NT_PPC_TAR	0x103		/* Target Address Register */
+#define NT_PPC_PPR	0x104		/* Program Priority Register */
+#define NT_PPC_DSCR	0x105		/* Data Stream Control Register */
+#define NT_PPC_EBB	0x106		/* Event Based Branch Registers */
+#define NT_PPC_PMU	0x107		/* Performance Monitor Registers */
+#define NT_PPC_TM_CGPR	0x108		/* TM checkpointed GPR Registers */
+#define NT_PPC_TM_CFPR	0x109		/* TM checkpointed FPR Registers */
+#define NT_PPC_TM_CVMX	0x10a		/* TM checkpointed VMX Registers */
+#define NT_PPC_TM_CVSX	0x10b		/* TM checkpointed VSX Registers */
+#define NT_PPC_TM_SPR	0x10c		/* TM Special Purpose Registers */
+#define NT_PPC_TM_CTAR	0x10d		/* TM checkpointed Target Address Register */
+#define NT_PPC_TM_CPPR	0x10e		/* TM checkpointed Program Priority Register */
+#define NT_PPC_TM_CDSCR	0x10f		/* TM checkpointed Data Stream Control Regist=
er */
+#define NT_PPC_PKEY	0x110		/* Memory Protection Keys registers */
+#define NT_PPC_DEXCR	0x111		/* PowerPC DEXCR registers */
+#define NT_PPC_HASHKEYR	0x112		/* PowerPC HASHKEYR register */
+#define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
+#define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=3Ddeny) */
+#define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
+/* Old binutils treats 0x203 as a CET state */
+#define NT_X86_SHSTK	0x204		/* x86 SHSTK state */
+#define NT_X86_XSAVE_LAYOUT	0x205	/* XSAVE layout description */
+#define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
+#define NT_S390_TIMER	0x301		/* s390 timer register */
+#define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
+#define NT_S390_TODPREG	0x303		/* s390 TOD programmable register */
+#define NT_S390_CTRS	0x304		/* s390 control registers */
+#define NT_S390_PREFIX	0x305		/* s390 prefix register */
+#define NT_S390_LAST_BREAK	0x306	/* s390 breaking event address */
+#define NT_S390_SYSTEM_CALL	0x307	/* s390 system call restart data */
+#define NT_S390_TDB	0x308		/* s390 transaction diagnostic block */
+#define NT_S390_VXRS_LOW	0x309	/* s390 vector registers 0-15 upper half */
+#define NT_S390_VXRS_HIGH	0x30a	/* s390 vector registers 16-31 */
+#define NT_S390_GS_CB	0x30b		/* s390 guarded storage registers */
+#define NT_S390_GS_BC	0x30c		/* s390 guarded storage broadcast control block=
 */
+#define NT_S390_RI_CB	0x30d		/* s390 runtime instrumentation */
+#define NT_S390_PV_CPU_DATA	0x30e	/* s390 protvirt cpu dump data */
+#define NT_ARM_VFP	0x400		/* ARM VFP/NEON registers */
+#define NT_ARM_TLS	0x401		/* ARM TLS register */
+#define NT_ARM_HW_BREAK	0x402		/* ARM hardware breakpoint registers */
+#define NT_ARM_HW_WATCH	0x403		/* ARM hardware watchpoint registers */
+#define NT_ARM_SYSTEM_CALL	0x404	/* ARM system call number */
+#define NT_ARM_SVE	0x405		/* ARM Scalable Vector Extension registers */
+#define NT_ARM_PAC_MASK		0x406	/* ARM pointer authentication code masks */
+#define NT_ARM_PACA_KEYS	0x407	/* ARM pointer authentication address keys */
+#define NT_ARM_PACG_KEYS	0x408	/* ARM pointer authentication generic key */
+#define NT_ARM_TAGGED_ADDR_CTRL	0x409	/* arm64 tagged address control (prctl=
()) */
+#define NT_ARM_PAC_ENABLED_KEYS	0x40a	/* arm64 ptr auth enabled keys (prctl(=
)) */
+#define NT_ARM_SSVE	0x40b		/* ARM Streaming SVE registers */
+#define NT_ARM_ZA	0x40c		/* ARM SME ZA registers */
+#define NT_ARM_ZT	0x40d		/* ARM SME ZT registers */
+#define NT_ARM_FPMR	0x40e		/* ARM floating point mode register */
+#define NT_ARM_POE	0x40f		/* ARM POE registers */
+#define NT_ARM_GCS	0x410		/* ARM GCS state */
+#define NT_ARC_V2	0x600		/* ARCv2 accumulator/extra registers */
+#define NT_VMCOREDD	0x700		/* Vmcore Device Dump Note */
+#define NT_MIPS_DSP	0x800		/* MIPS DSP ASE registers */
+#define NT_MIPS_FP_MODE	0x801		/* MIPS floating-point mode */
+#define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
+#define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
+#define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
+#define NT_RISCV_TAGGED_ADDR_CTRL 0x902	/* RISC-V tagged address control (pr=
ctl()) */
+#define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
+#define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
+#define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension register=
s */
+#define NT_LOONGARCH_LASX	0xa03	/* LoongArch Loongson Advanced SIMD Extensio=
n registers */
+#define NT_LOONGARCH_LBT	0xa04	/* LoongArch Loongson Binary Translation regi=
sters */
+#define NT_LOONGARCH_HW_BREAK	0xa05   /* LoongArch hardware breakpoint regis=
ters */
+#define NT_LOONGARCH_HW_WATCH	0xa06   /* LoongArch hardware watchpoint regis=
ters */
+
+/* Note types with note name "GNU" */
+#define NT_GNU_PROPERTY_TYPE_0	5
+
+/* Note header in a PT_NOTE section */
+typedef struct elf32_note {
+  Elf32_Word	n_namesz;	/* Name size */
+  Elf32_Word	n_descsz;	/* Content size */
+  Elf32_Word	n_type;		/* Content type */
+} Elf32_Nhdr;
+
+/* Note header in a PT_NOTE section */
+typedef struct elf64_note {
+  Elf64_Word n_namesz;	/* Name size */
+  Elf64_Word n_descsz;	/* Content size */
+  Elf64_Word n_type;	/* Content type */
+} Elf64_Nhdr;
+
+/* .note.gnu.property types for EM_AARCH64: */
+#define GNU_PROPERTY_AARCH64_FEATURE_1_AND	0xc0000000
+
+/* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
+#define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
+
+typedef struct {
+  Elf32_Half	vd_version;
+  Elf32_Half	vd_flags;
+  Elf32_Half	vd_ndx;
+  Elf32_Half	vd_cnt;
+  Elf32_Word	vd_hash;
+  Elf32_Word	vd_aux;
+  Elf32_Word	vd_next;
+} Elf32_Verdef;
+
+typedef struct {
+  Elf64_Half	vd_version;
+  Elf64_Half	vd_flags;
+  Elf64_Half	vd_ndx;
+  Elf64_Half	vd_cnt;
+  Elf64_Word	vd_hash;
+  Elf64_Word	vd_aux;
+  Elf64_Word	vd_next;
+} Elf64_Verdef;
+
+typedef struct {
+  Elf32_Word    vda_name;
+  Elf32_Word    vda_next;
+} Elf32_Verdaux;
+
+typedef struct {
+  Elf64_Word    vda_name;
+  Elf64_Word    vda_next;
+} Elf64_Verdaux;
+
+#endif /* _LINUX_ELF_H */

