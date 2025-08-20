Return-Path: <linux-tip-commits+bounces-6302-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2B0B2E57A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 21:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E8F3AA34D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5818627FD78;
	Wed, 20 Aug 2025 19:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0HkSkeQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cLscu8/K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006A827D77B;
	Wed, 20 Aug 2025 19:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755716806; cv=none; b=adQ8gdngnY3wK4Pud61ZckMN8fFoVja+HCI9LdfUFXyUhTsjTTwekgInhQwAqWpwZW2BqWJ7yDQvOFXtRKxG05X7UtmTEE4wuuCFYjTeV02NPwkNfXfzeivwyokuOI+RxlddlMMRo+Az3iKtS4FeeOvYhbMv7XNaSqv3fMdhRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755716806; c=relaxed/simple;
	bh=Os62u2sQMcVTSyhn30PEilGJF82f4vpw68m94U+L0sM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ncCCQ8lbNJk2aSIpA6xO8SvB2rXnCZGqhLGmkSYbpMSyenpAFUdmNvEIO6HNSC6i4php2qnVNtyVaKkPFRjEg2xIu/jj9AfkVwVGt2XbVixpqJZh/RLhFh37bQ7npf3ZFluHYEvZNwdI9sCbT3IzG2GI3VHB1bm7pVIp6COsl84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0HkSkeQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cLscu8/K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 19:06:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755716801;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTBIERNtsurrG/0R75WCrYzdLp8++dP9SW4Xus5PPK4=;
	b=n0HkSkeQ4VJPueyNHlDiDwB4ACc9+dKsgspl9suGdkkJrBbHsSS91XgtfxZnY9cCbnwacH
	dPDa9A3GQ0pP2pYttvPJQ6Ims4GPrOMeruUDxiJpXS+exA6fnIHc8ZFkDAs/JwtszcoLBd
	Xmu5p+yDV5du74uAa6ksuJ1dcY4yIEHvvxAIoVdJHvEhUlJatm2vRC5g5e5H8X1uofmgxc
	NvFMoMC1W+CvKh7LicEhIU7BXGvHE4iUxgtxEdmeRidT8plEIUfZw27iwKDxfFu87KLsY9
	VETruXaRoNMxLarWojX2Sz7f9PugOfftMNZDQTolJUDDmP5x1RcXOkZNnuL6oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755716801;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTBIERNtsurrG/0R75WCrYzdLp8++dP9SW4Xus5PPK4=;
	b=cLscu8/K+yJEGmB4taH6opBNZ7XtqiHLJo5fLs6+PafSphUyMAlIxjPbXv0QFuymGHU4Aa
	OSNRtNp7PHZEOdCQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] crypto: x86 - Remove CONFIG_AS_GFNI
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250819085855.333380-1-ubizjak@gmail.com>
References: <20250819085855.333380-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175571680036.1420.12539403815169376797.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     a35da57357221a989e59ced9407ba4f2d4d6d2d2
Gitweb:        https://git.kernel.org/tip/a35da57357221a989e59ced9407ba4f2d4d=
6d2d2
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 19 Aug 2025 10:57:49 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 20 Aug 2025 20:48:07 +02:00

crypto: x86 - Remove CONFIG_AS_GFNI

Current minimum required version of binutils is 2.30, which supports GFNI
instruction mnemonics.

Remove check for assembler support of GFNI instructions and all relevant
macros for conditional compilation.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/20250819085855.333380-1-ubizjak@gmail.com
---
 arch/x86/Kconfig.assembler               |  5 -----
 arch/x86/crypto/Kconfig                  |  2 +-
 arch/x86/crypto/aria-aesni-avx-asm_64.S  | 10 ----------
 arch/x86/crypto/aria-aesni-avx2-asm_64.S | 10 +---------
 arch/x86/crypto/aria_aesni_avx2_glue.c   |  4 +---
 arch/x86/crypto/aria_aesni_avx_glue.c    |  4 +---
 6 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index c827f69..6b95be0 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -6,11 +6,6 @@ config AS_AVX512
 	help
 	  Supported by binutils >=3D 2.25 and LLVM integrated assembler
=20
-config AS_GFNI
-	def_bool $(as-instr,vgf2p8mulb %xmm0$(comma)%xmm1$(comma)%xmm2)
-	help
-	  Supported by binutils >=3D 2.30 and LLVM integrated assembler
-
 config AS_VAES
 	def_bool $(as-instr,vaesenc %ymm0$(comma)%ymm1$(comma)%ymm2)
 	help
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 94016c6..2f8a447 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -319,7 +319,7 @@ config CRYPTO_ARIA_AESNI_AVX2_X86_64
=20
 config CRYPTO_ARIA_GFNI_AVX512_X86_64
 	tristate "Ciphers: ARIA with modes: ECB, CTR (AVX512/GFNI)"
-	depends on 64BIT && AS_GFNI
+	depends on 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ALGAPI
 	select CRYPTO_ARIA
diff --git a/arch/x86/crypto/aria-aesni-avx-asm_64.S b/arch/x86/crypto/aria-a=
esni-avx-asm_64.S
index 9556dac..932fb17 100644
--- a/arch/x86/crypto/aria-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/aria-aesni-avx-asm_64.S
@@ -295,7 +295,6 @@
 	vpshufb t1, t0, t2;				\
 	vpxor t2, x7, x7;
=20
-#ifdef CONFIG_AS_GFNI
 #define aria_sbox_8way_gfni(x0, x1, x2, x3,		\
 			    x4, x5, x6, x7,		\
 			    t0, t1, t2, t3,		\
@@ -318,8 +317,6 @@
 	vgf2p8affineinvqb $0, t2, x3, x3;		\
 	vgf2p8affineinvqb $0, t2, x7, x7
=20
-#endif /* CONFIG_AS_GFNI */
-
 #define aria_sbox_8way(x0, x1, x2, x3,            	\
 		       x4, x5, x6, x7,			\
 		       t0, t1, t2, t3,			\
@@ -561,7 +558,6 @@
 			     y4, y5, y6, y7,		\
 			     mem_tmp, 8);
=20
-#ifdef CONFIG_AS_GFNI
 #define aria_fe_gfni(x0, x1, x2, x3,			\
 		     x4, x5, x6, x7,			\
 		     y0, y1, y2, y3,			\
@@ -719,8 +715,6 @@
 			     y4, y5, y6, y7,		\
 			     mem_tmp, 8);
=20
-#endif /* CONFIG_AS_GFNI */
-
 /* NB: section is mergeable, all elements must be aligned 16-byte blocks */
 .section	.rodata.cst16, "aM", @progbits, 16
 .align 16
@@ -772,7 +766,6 @@
 .Ltf_hi__x2__and__fwd_aff:
 	.octa 0x3F893781E95FE1576CDA64D2BA0CB204
=20
-#ifdef CONFIG_AS_GFNI
 /* AES affine: */
 #define tf_aff_const BV8(1, 1, 0, 0, 0, 1, 1, 0)
 .Ltf_aff_bitmatrix:
@@ -871,7 +864,6 @@
 		    BV8(0, 0, 0, 0, 0, 1, 0, 0),
 		    BV8(0, 0, 0, 0, 0, 0, 1, 0),
 		    BV8(0, 0, 0, 0, 0, 0, 0, 1))
-#endif /* CONFIG_AS_GFNI */
=20
 /* 4-bit mask */
 .section	.rodata.cst4.L0f0f0f0f, "aM", @progbits, 4
@@ -1140,7 +1132,6 @@ SYM_TYPED_FUNC_START(aria_aesni_avx_ctr_crypt_16way)
 	RET;
 SYM_FUNC_END(aria_aesni_avx_ctr_crypt_16way)
=20
-#ifdef CONFIG_AS_GFNI
 SYM_FUNC_START_LOCAL(__aria_aesni_avx_gfni_crypt_16way)
 	/* input:
 	*      %r9: rk
@@ -1359,4 +1350,3 @@ SYM_TYPED_FUNC_START(aria_aesni_avx_gfni_ctr_crypt_16wa=
y)
 	FRAME_END
 	RET;
 SYM_FUNC_END(aria_aesni_avx_gfni_ctr_crypt_16way)
-#endif /* CONFIG_AS_GFNI */
diff --git a/arch/x86/crypto/aria-aesni-avx2-asm_64.S b/arch/x86/crypto/aria-=
aesni-avx2-asm_64.S
index c60fa29..ed53d4f 100644
--- a/arch/x86/crypto/aria-aesni-avx2-asm_64.S
+++ b/arch/x86/crypto/aria-aesni-avx2-asm_64.S
@@ -302,7 +302,6 @@
 	vpbroadcastb ((round * 16) + idx + 4)(rk), t0;	\
 	vpxor t0, x7, x7;
=20
-#ifdef CONFIG_AS_GFNI
 #define aria_sbox_8way_gfni(x0, x1, x2, x3,		\
 			    x4, x5, x6, x7,		\
 			    t0, t1, t2, t3,		\
@@ -325,7 +324,6 @@
 	vgf2p8affineinvqb $0, t2, x3, x3;		\
 	vgf2p8affineinvqb $0, t2, x7, x7
=20
-#endif /* CONFIG_AS_GFNI */
 #define aria_sbox_8way(x0, x1, x2, x3,			\
 		       x4, x5, x6, x7,			\
 		       t0, t1, t2, t3,			\
@@ -598,7 +596,7 @@
 	aria_load_state_8way(y0, y1, y2, y3,		\
 			     y4, y5, y6, y7,		\
 			     mem_tmp, 8);
-#ifdef CONFIG_AS_GFNI
+
 #define aria_fe_gfni(x0, x1, x2, x3,			\
 		     x4, x5, x6, x7,			\
 		     y0, y1, y2, y3,			\
@@ -752,7 +750,6 @@
 	aria_load_state_8way(y0, y1, y2, y3,		\
 			     y4, y5, y6, y7,		\
 			     mem_tmp, 8);
-#endif /* CONFIG_AS_GFNI */
=20
 .section        .rodata.cst32.shufb_16x16b, "aM", @progbits, 32
 .align 32
@@ -806,7 +803,6 @@
 .Ltf_hi__x2__and__fwd_aff:
 	.octa 0x3F893781E95FE1576CDA64D2BA0CB204
=20
-#ifdef CONFIG_AS_GFNI
 .section	.rodata.cst8, "aM", @progbits, 8
 .align 8
 /* AES affine: */
@@ -868,8 +864,6 @@
 		    BV8(0, 0, 0, 0, 0, 0, 1, 0),
 		    BV8(0, 0, 0, 0, 0, 0, 0, 1))
=20
-#endif /* CONFIG_AS_GFNI */
-
 /* 4-bit mask */
 .section	.rodata.cst4.L0f0f0f0f, "aM", @progbits, 4
 .align 4
@@ -1219,7 +1213,6 @@ SYM_TYPED_FUNC_START(aria_aesni_avx2_ctr_crypt_32way)
 	RET;
 SYM_FUNC_END(aria_aesni_avx2_ctr_crypt_32way)
=20
-#ifdef CONFIG_AS_GFNI
 SYM_FUNC_START_LOCAL(__aria_aesni_avx2_gfni_crypt_32way)
 	/* input:
 	 *      %r9: rk
@@ -1438,4 +1431,3 @@ SYM_TYPED_FUNC_START(aria_aesni_avx2_gfni_ctr_crypt_32w=
ay)
 	FRAME_END
 	RET;
 SYM_FUNC_END(aria_aesni_avx2_gfni_ctr_crypt_32way)
-#endif /* CONFIG_AS_GFNI */
diff --git a/arch/x86/crypto/aria_aesni_avx2_glue.c b/arch/x86/crypto/aria_ae=
sni_avx2_glue.c
index 007b250..1487a49 100644
--- a/arch/x86/crypto/aria_aesni_avx2_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx2_glue.c
@@ -26,7 +26,6 @@ asmlinkage void aria_aesni_avx2_ctr_crypt_32way(const void =
*ctx, u8 *dst,
 						const u8 *src,
 						u8 *keystream, u8 *iv);
 EXPORT_SYMBOL_GPL(aria_aesni_avx2_ctr_crypt_32way);
-#ifdef CONFIG_AS_GFNI
 asmlinkage void aria_aesni_avx2_gfni_encrypt_32way(const void *ctx, u8 *dst,
 						   const u8 *src);
 EXPORT_SYMBOL_GPL(aria_aesni_avx2_gfni_encrypt_32way);
@@ -37,7 +36,6 @@ asmlinkage void aria_aesni_avx2_gfni_ctr_crypt_32way(const =
void *ctx, u8 *dst,
 						     const u8 *src,
 						     u8 *keystream, u8 *iv);
 EXPORT_SYMBOL_GPL(aria_aesni_avx2_gfni_ctr_crypt_32way);
-#endif /* CONFIG_AS_GFNI */
=20
 static struct aria_avx_ops aria_ops;
=20
@@ -213,7 +211,7 @@ static int __init aria_avx2_init(void)
 		return -ENODEV;
 	}
=20
-	if (boot_cpu_has(X86_FEATURE_GFNI) && IS_ENABLED(CONFIG_AS_GFNI)) {
+	if (boot_cpu_has(X86_FEATURE_GFNI)) {
 		aria_ops.aria_encrypt_16way =3D aria_aesni_avx_gfni_encrypt_16way;
 		aria_ops.aria_decrypt_16way =3D aria_aesni_avx_gfni_decrypt_16way;
 		aria_ops.aria_ctr_crypt_16way =3D aria_aesni_avx_gfni_ctr_crypt_16way;
diff --git a/arch/x86/crypto/aria_aesni_avx_glue.c b/arch/x86/crypto/aria_aes=
ni_avx_glue.c
index 4c88ef4..e4e3d78 100644
--- a/arch/x86/crypto/aria_aesni_avx_glue.c
+++ b/arch/x86/crypto/aria_aesni_avx_glue.c
@@ -26,7 +26,6 @@ asmlinkage void aria_aesni_avx_ctr_crypt_16way(const void *=
ctx, u8 *dst,
 					       const u8 *src,
 					       u8 *keystream, u8 *iv);
 EXPORT_SYMBOL_GPL(aria_aesni_avx_ctr_crypt_16way);
-#ifdef CONFIG_AS_GFNI
 asmlinkage void aria_aesni_avx_gfni_encrypt_16way(const void *ctx, u8 *dst,
 						  const u8 *src);
 EXPORT_SYMBOL_GPL(aria_aesni_avx_gfni_encrypt_16way);
@@ -37,7 +36,6 @@ asmlinkage void aria_aesni_avx_gfni_ctr_crypt_16way(const v=
oid *ctx, u8 *dst,
 						    const u8 *src,
 						    u8 *keystream, u8 *iv);
 EXPORT_SYMBOL_GPL(aria_aesni_avx_gfni_ctr_crypt_16way);
-#endif /* CONFIG_AS_GFNI */
=20
 static struct aria_avx_ops aria_ops;
=20
@@ -199,7 +197,7 @@ static int __init aria_avx_init(void)
 		return -ENODEV;
 	}
=20
-	if (boot_cpu_has(X86_FEATURE_GFNI) && IS_ENABLED(CONFIG_AS_GFNI)) {
+	if (boot_cpu_has(X86_FEATURE_GFNI)) {
 		aria_ops.aria_encrypt_16way =3D aria_aesni_avx_gfni_encrypt_16way;
 		aria_ops.aria_decrypt_16way =3D aria_aesni_avx_gfni_decrypt_16way;
 		aria_ops.aria_ctr_crypt_16way =3D aria_aesni_avx_gfni_ctr_crypt_16way;

