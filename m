Return-Path: <linux-tip-commits+bounces-6874-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA634BE2925
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0563B3148
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1410632C33B;
	Thu, 16 Oct 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0xdMx4p+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DRzyh7NP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2CA319871;
	Thu, 16 Oct 2025 09:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608362; cv=none; b=MpGPi+SHr5ZQMlp5a5tn0XxIHthQo4ZVySHHeZTllameJNoMHPrTYDgEGnPMil09ty2zVjB4c2GUdfAVcoNBVvevIIoWmDNeyVJE28oY4lRxs5vmCc4JRXh5NGJfXZ2/rFmK34R+wm8u0qLF+pcXw+0dIfDjx4docbfFNazjFKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608362; c=relaxed/simple;
	bh=5frRLsPmGxDHGl0lvwhQqDKmY2OsGPxt//tTu2fT6Mk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dNeufNcwGAfQePk+ogL/rOlsZ/KvVkJsGPEL9s8qD6d/zi1/4elrePwPGvtIYokBGNvngdrtSQRyENuQxTSRried3tJx2V+tSZiism9ownrj/1LBjcWjKJ+YUL3EUOiJ9FD7QcNN3bJjQNvfYM2efSbD/XKMvGbOATnlTwlBwwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0xdMx4p+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DRzyh7NP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608346;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JkSkm2PnMaLOPshIt+784gMNVBB1GaOgkxzasPQS1AI=;
	b=0xdMx4p+ZybPMBJOJOr6lZTkU3xEGbdnb4chWgg1cUhqtgqFBqNK/todRaNOl5fcLKRdOd
	UCaWteGhHxiMLjrlgpzwGUVtzLYbIsJzJg08gVcNVf/cH6XwyNLpOPoK5hkUnA06bF0DPb
	nbiBefhE6s7t1fELnN4pf94O4MrS2v5nKxOrMoyhiq0BojW5VnQulmIrF/oXdrJXxeWUFV
	aethvcWmr+Mb+RXAkV5Kxkj1FtArVWhbIRIYeqNGrKpkZ4F1JMu4EFxW+TF5l79cT/4Kk0
	pUHoUN3omJpwBcT3AE+DscK8VUvhiraz6HgAnmN6rYLIDf6WxV2fdREHK+GP2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608346;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=JkSkm2PnMaLOPshIt+784gMNVBB1GaOgkxzasPQS1AI=;
	b=DRzyh7NP6ZSNrBKraZNdZftTU+fb8kd2kBXGfuOD3HKQ9uxQsE+Ckfg9cj1Nuhl5/qaEjR
	qiIyOAGb/XK1y4Dw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add annotype() helper
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060834547.709179.306878811425430527.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     3b92486fa1a905cf4be81c0b65961f547fcf7be3
Gitweb:        https://git.kernel.org/tip/3b92486fa1a905cf4be81c0b65961f547fc=
f7be3
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:52 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:49 -07:00

objtool: Add annotype() helper

... for reading annotation types.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/loongarch/orc.c         |  1 -
 tools/objtool/arch/powerpc/decode.c        |  1 -
 tools/objtool/arch/x86/decode.c            |  1 -
 tools/objtool/arch/x86/orc.c               |  1 -
 tools/objtool/check.c                      |  5 +----
 tools/objtool/include/objtool/elf.h        | 13 +++++++++++++
 tools/objtool/include/objtool/endianness.h |  9 ++++-----
 tools/objtool/orc_dump.c                   |  1 -
 tools/objtool/orc_gen.c                    |  1 -
 tools/objtool/special.c                    |  1 -
 10 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/tools/objtool/arch/loongarch/orc.c b/tools/objtool/arch/loongarc=
h/orc.c
index b58c5ff..ffd3a3c 100644
--- a/tools/objtool/arch/loongarch/orc.c
+++ b/tools/objtool/arch/loongarch/orc.c
@@ -5,7 +5,6 @@
 #include <objtool/check.h>
 #include <objtool/orc.h>
 #include <objtool/warn.h>
-#include <objtool/endianness.h>
=20
 int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi, struct inst=
ruction *insn)
 {
diff --git a/tools/objtool/arch/powerpc/decode.c b/tools/objtool/arch/powerpc=
/decode.c
index d4cb021..3a9b748 100644
--- a/tools/objtool/arch/powerpc/decode.c
+++ b/tools/objtool/arch/powerpc/decode.c
@@ -7,7 +7,6 @@
 #include <objtool/arch.h>
 #include <objtool/warn.h>
 #include <objtool/builtin.h>
-#include <objtool/endianness.h>
=20
 int arch_ftrace_match(const char *name)
 {
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 6bb46d9..b2c320f 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -19,7 +19,6 @@
 #include <objtool/elf.h>
 #include <objtool/arch.h>
 #include <objtool/warn.h>
-#include <objtool/endianness.h>
 #include <objtool/builtin.h>
 #include <arch/elf.h>
=20
diff --git a/tools/objtool/arch/x86/orc.c b/tools/objtool/arch/x86/orc.c
index 7176b9e..735e150 100644
--- a/tools/objtool/arch/x86/orc.c
+++ b/tools/objtool/arch/x86/orc.c
@@ -5,7 +5,6 @@
 #include <objtool/check.h>
 #include <objtool/orc.h>
 #include <objtool/warn.h>
-#include <objtool/endianness.h>
=20
 int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi, struct inst=
ruction *insn)
 {
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 65a359c..13ccfe0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -14,7 +14,6 @@
 #include <objtool/check.h>
 #include <objtool/special.h>
 #include <objtool/warn.h>
-#include <objtool/endianness.h>
=20
 #include <linux/objtool_types.h>
 #include <linux/hashtable.h>
@@ -2273,9 +2272,7 @@ static int read_annotate(struct objtool_file *file,
 	}
=20
 	for_each_reloc(sec->rsec, reloc) {
-		type =3D *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * sec->sh.sh_entsiz=
e) + 4);
-		type =3D bswap_if_needed(file->elf, type);
-
+		type =3D annotype(file->elf, sec, reloc);
 		offset =3D reloc->sym->offset + reloc_addend(reloc);
 		insn =3D find_insn(file, reloc->sym->sec, offset);
=20
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objt=
ool/elf.h
index 9f135c2..814cfc0 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -13,10 +13,14 @@
 #include <linux/hashtable.h>
 #include <linux/rbtree.h>
 #include <linux/jhash.h>
+
+#include <objtool/endianness.h>
 #include <arch/elf.h>
=20
 #define SYM_NAME_LEN		512
=20
+#define bswap_if_needed(elf, val) __bswap_if_needed(&elf->ehdr, val)
+
 #ifdef LIBELF_USE_DEPRECATED
 # define elf_getshdrnum    elf_getshnum
 # define elf_getshdrstrndx elf_getshstrndx
@@ -401,6 +405,15 @@ static inline void set_reloc_type(struct elf *elf, struc=
t reloc *reloc, unsigned
 	mark_sec_changed(elf, reloc->sec, true);
 }
=20
+static inline unsigned int annotype(struct elf *elf, struct section *sec,
+				    struct reloc *reloc)
+{
+	unsigned int type;
+
+	type =3D *(u32 *)(sec->data->d_buf + (reloc_idx(reloc) * 8) + 4);
+	return bswap_if_needed(elf, type);
+}
+
 #define RELOC_JUMP_TABLE_BIT 1UL
=20
 /* Does reloc mark the beginning of a jump table? */
diff --git a/tools/objtool/include/objtool/endianness.h b/tools/objtool/inclu=
de/objtool/endianness.h
index 4d2aa9b..aebcd23 100644
--- a/tools/objtool/include/objtool/endianness.h
+++ b/tools/objtool/include/objtool/endianness.h
@@ -4,7 +4,6 @@
=20
 #include <linux/kernel.h>
 #include <endian.h>
-#include <objtool/elf.h>
=20
 /*
  * Does a byte swap if target file endianness doesn't match the host, i.e. c=
ross
@@ -12,16 +11,16 @@
  * To be used for multi-byte values conversion, which are read from / about
  * to be written to a target native endianness ELF file.
  */
-static inline bool need_bswap(struct elf *elf)
+static inline bool need_bswap(GElf_Ehdr *ehdr)
 {
 	return (__BYTE_ORDER =3D=3D __LITTLE_ENDIAN) ^
-	       (elf->ehdr.e_ident[EI_DATA] =3D=3D ELFDATA2LSB);
+	       (ehdr->e_ident[EI_DATA] =3D=3D ELFDATA2LSB);
 }
=20
-#define bswap_if_needed(elf, val)					\
+#define __bswap_if_needed(ehdr, val)					\
 ({									\
 	__typeof__(val) __ret;						\
-	bool __need_bswap =3D need_bswap(elf);				\
+	bool __need_bswap =3D need_bswap(ehdr);				\
 	switch (sizeof(val)) {						\
 	case 8:								\
 		__ret =3D __need_bswap ? bswap_64(val) : (val); break;	\
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index 1dd9fc1..5a979f5 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -8,7 +8,6 @@
 #include <objtool/objtool.h>
 #include <objtool/orc.h>
 #include <objtool/warn.h>
-#include <objtool/endianness.h>
=20
 int orc_dump(const char *filename)
 {
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 9d380ab..1045e13 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -12,7 +12,6 @@
 #include <objtool/check.h>
 #include <objtool/orc.h>
 #include <objtool/warn.h>
-#include <objtool/endianness.h>
=20
 struct orc_list_entry {
 	struct list_head list;
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index fc2cf8d..e262af9 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -15,7 +15,6 @@
 #include <objtool/builtin.h>
 #include <objtool/special.h>
 #include <objtool/warn.h>
-#include <objtool/endianness.h>
=20
 struct special_entry {
 	const char *sec;

