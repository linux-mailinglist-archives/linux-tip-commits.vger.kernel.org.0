Return-Path: <linux-tip-commits+bounces-7133-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB18C286DD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AF718939BA
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A1E303A35;
	Sat,  1 Nov 2025 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ocIvmn+d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NTJaA332"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003630274A;
	Sat,  1 Nov 2025 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026457; cv=none; b=H9teRWQxe1j40U531PGPul82VpKsxZllDWnpZHtllbASWA8LrUcfWoX6DT9SppXE+4LNYisrPTjAgZ1n+CdJqEQYdcXEmzCLhsLhURvqAVtCc2T0RppNT8BgThUYNCBC7mpZKyR4psUt1h6/TaV3v61VMuniH9gMiEOxgPjpC2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026457; c=relaxed/simple;
	bh=Ifd0TncWLdvKLtn6jujVwsVBOsCE2XkoC75+kE/9UTY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FaMrI3rqcqvlcrefu3J1PAp8xvqBfiTZnz2drAj+BKN2lejB5I217vNlDw4S5/aDOZcgXTLMqh9vL5nDJHZ3YaZVUkuIURgNUdbh8jO18JHILnmxJTHMdbgq48S3Fspp0PoGgV41Z1/lOcHL0PW2q3k50bAHOB1UvBr3kV2S1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ocIvmn+d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NTJaA332; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veEupL/AGRk4Rm+7KEVHGHOjm5xtpjfa2U0Imkbd0MM=;
	b=ocIvmn+dxf41KyFgsg3bjhDVANss+Wxpim+eMonCooZkmZavIh4O2FJRD5kJMD8Tf8bXWu
	gWOYMiRxi0XlxQgoTe8McRNYYmP5E8nNv9Xc7XFMOv7fkNuCXhUKEpnTQOe8hf0p+Q7MCm
	KWerI0jIAclsnqoWZS9uEe2jjSGnMCxOco7OmFJcUgobosBmzUsEScWt8t83PEx2BufkAK
	8tMRyvGC1io6SFQXFsyDTGFA0N89ndbDqqbhLNNszDcDQi+A1aA+ihFD2hAGBfc743GovC
	ChdmihL5yk6685+POvZqK6PXc7cOQYTbvzbkYPx+pYf+E2umttNFndE3xNvqCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=veEupL/AGRk4Rm+7KEVHGHOjm5xtpjfa2U0Imkbd0MM=;
	b=NTJaA332NkquzJBjFYbZfkcp61W0qRlETT2ldqUpIgKdp1lUrCxc2Te/VAs5JZ1cmBDm1I
	C9WIyYduxjseB0Ag==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] sparc64: vdso2c: Remove symbol handling
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-33-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-33-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202645219.2601451.5430404432229422858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     6457c3778e4676550fff4d6b039123a0fdaf4fc4
Gitweb:        https://git.kernel.org/tip/6457c3778e4676550fff4d6b039123a0fda=
f4fc4
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:08 +01:00

sparc64: vdso2c: Remove symbol handling

There are no handled symbols left.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-33-e0607bf4=
9dea@linutronix.de
---
 arch/sparc/vdso/vdso2c.c | 10 +----------
 arch/sparc/vdso/vdso2c.h | 41 +---------------------------------------
 2 files changed, 1 insertion(+), 50 deletions(-)

diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index 70b14a4..e5c6121 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -58,14 +58,6 @@
=20
 const char *outfilename;
=20
-struct vdso_sym {
-	const char *name;
-	int export;
-};
-
-struct vdso_sym required_syms[] =3D {
-};
-
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))
 static void fail(const char *format, ...)
 {
@@ -105,8 +97,6 @@ static void fail(const char *format, ...)
 #define PUT_BE(x, val)					\
 	PBE(x, val, 64, PBE(x, val, 32, PBE(x, val, 16, LAST_PBE(x, val))))
=20
-#define NSYMS ARRAY_SIZE(required_syms)
-
 #define BITSFUNC3(name, bits, suffix) name##bits##suffix
 #define BITSFUNC2(name, bits, suffix) BITSFUNC3(name, bits, suffix)
 #define BITSFUNC(name) BITSFUNC2(name, ELF_BITS, )
diff --git a/arch/sparc/vdso/vdso2c.h b/arch/sparc/vdso/vdso2c.h
index ba07946..bad6a05 100644
--- a/arch/sparc/vdso/vdso2c.h
+++ b/arch/sparc/vdso/vdso2c.h
@@ -17,11 +17,9 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long mapping_size;
 	int i;
 	unsigned long j;
-	ELF(Shdr) *symtab_hdr =3D NULL, *strtab_hdr;
+	ELF(Shdr) *symtab_hdr =3D NULL;
 	ELF(Ehdr) *hdr =3D (ELF(Ehdr) *)raw_addr;
 	ELF(Dyn) *dyn =3D 0, *dyn_end =3D 0;
-	INT_BITS syms[NSYMS] =3D {};
-
 	ELF(Phdr) *pt =3D (ELF(Phdr) *)(raw_addr + GET_BE(&hdr->e_phoff));
=20
 	/* Walk the segment table. */
@@ -72,38 +70,6 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	if (!symtab_hdr)
 		fail("no symbol table\n");
=20
-	strtab_hdr =3D raw_addr + GET_BE(&hdr->e_shoff) +
-		GET_BE(&hdr->e_shentsize) * GET_BE(&symtab_hdr->sh_link);
-
-	/* Walk the symbol table */
-	for (i =3D 0;
-	     i < GET_BE(&symtab_hdr->sh_size) / GET_BE(&symtab_hdr->sh_entsize);
-	     i++) {
-		int k;
-
-		ELF(Sym) *sym =3D raw_addr + GET_BE(&symtab_hdr->sh_offset) +
-			GET_BE(&symtab_hdr->sh_entsize) * i;
-		const char *name =3D raw_addr + GET_BE(&strtab_hdr->sh_offset) +
-			GET_BE(&sym->st_name);
-
-		for (k =3D 0; k < NSYMS; k++) {
-			if (!strcmp(name, required_syms[k].name)) {
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
-				syms[k] =3D GET_BE(&sym->st_value);
-			}
-		}
-	}
-
 	if (!name) {
 		fwrite(stripped_addr, stripped_len, 1, outfile);
 		return;
@@ -129,10 +95,5 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	fprintf(outfile, "const struct vdso_image %s_builtin =3D {\n", name);
 	fprintf(outfile, "\t.data =3D raw_data,\n");
 	fprintf(outfile, "\t.size =3D %lu,\n", mapping_size);
-	for (i =3D 0; i < NSYMS; i++) {
-		if (required_syms[i].export && syms[i])
-			fprintf(outfile, "\t.sym_%s =3D %" PRIi64 ",\n",
-				required_syms[i].name, (int64_t)syms[i]);
-	}
 	fprintf(outfile, "};\n");
 }

