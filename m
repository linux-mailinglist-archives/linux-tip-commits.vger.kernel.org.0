Return-Path: <linux-tip-commits+bounces-6304-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 040DDB2F82A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Aug 2025 14:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF8E3A4DAE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Aug 2025 12:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C69E7080E;
	Thu, 21 Aug 2025 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nq52vWs+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ooTRpss7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025519E97B;
	Thu, 21 Aug 2025 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779738; cv=none; b=GIvvbkB6kjpgSKa+Vp9jrPihbRn0OMLRCrvLuViGtpRB+sQsuALiAQnoQeso2tI1uty5i3wsTEUdYXaUh7An0AJFybpfRb+HfXAiqWKIQlw0gJePcx9KpmepZfYIvGNmyhcPjdHY9/F+ibziLzTAzbmLdcc4mCsd+Toitz1DmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779738; c=relaxed/simple;
	bh=TTa27fT782KENDYVOB1DbUeYEfEEWDokk0496JvgmQo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fhriadKM/vczqmI7vGLcB2cl5bkxxD7J/aJ5LteBAUMsKJmn01qEC6tb8eJjEz7ssuuQj+mgFCrLx6PxiReZVIrxWGtPEq+YguVEPEv9MvgO1ssq8vmESNLV0mT8paUu+6UnCnL4CfKT44wQELWWoJgGNSQq/8xZ9FtXoMzMA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nq52vWs+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ooTRpss7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Aug 2025 12:35:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755779734;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QyGVwt8Hd64SM9hFkMH+cSzM05fEAG3kGAYSrf6r+w=;
	b=Nq52vWs+QQ1ZWbL1jBGe9pqkdlvvJwa2ldQ7vpCq0CtLLkDErNJfVWwdvDegZlfnwrJUO5
	Zw4yUZTuqRish7Rly8/p7eqkLWDe8EmtPyruqxN9XQWTlumi+rMIA7TTBzPzGv/uteoptr
	Xe4KnT171wQmnbM+Q6eHdW3SV+CVr5dfuZQMTnpqw/Gva06R1DjuZ0lP/3f6rfbFKlvqmb
	eq/DcL0sCVG8oahzjEV6ViZB9ktpFtvcy6XMJcGksvJ4eJMn7VO06tFLtYsUYrfo1N2I/9
	Uo4GlrR++m0USCuzpygBeqN3XYhGndME8tvf6+VdSQZxJyMbpoh4X4KJG6lVBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755779734;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QyGVwt8Hd64SM9hFkMH+cSzM05fEAG3kGAYSrf6r+w=;
	b=ooTRpss7MesjdZhguV5ooabytyyNBoVB3m+XtmanodNeAePLGGQWq64c44Nhj/UNF1h7sk
	LE6gZqOqMyNh24CQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] crypto: X86 - Remove CONFIG_AS_VAES
Cc: Uros Bizjak <ubizjak@gmail.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250819085855.333380-2-ubizjak@gmail.com>
References: <20250819085855.333380-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175577973263.1420.12918884895191770948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     4593311290006793a38a9cbd91d4a65b63cd7b76
Gitweb:        https://git.kernel.org/tip/4593311290006793a38a9cbd91d4a65b63c=
d7b76
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Tue, 19 Aug 2025 10:57:50 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 21 Aug 2025 12:23:28 +02:00

crypto: X86 - Remove CONFIG_AS_VAES

Current minimum required version of binutils is 2.30, which supports VAES
instruction mnemonics.

Remove check for assembler support of VAES instructions and all relevant macr=
os
for conditional compilation.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/20250819085855.333380-2-ubizjak@gmail.com
---
 arch/x86/Kconfig.assembler           |  5 -----
 arch/x86/crypto/Makefile             |  2 +-
 arch/x86/crypto/aes-ctr-avx-x86_64.S |  4 ++--
 arch/x86/crypto/aes-xts-avx-x86_64.S |  4 ++--
 arch/x86/crypto/aesni-intel_glue.c   | 14 +++++++-------
 5 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/x86/Kconfig.assembler b/arch/x86/Kconfig.assembler
index 6b95be0..8d18084 100644
--- a/arch/x86/Kconfig.assembler
+++ b/arch/x86/Kconfig.assembler
@@ -6,11 +6,6 @@ config AS_AVX512
 	help
 	  Supported by binutils >=3D 2.25 and LLVM integrated assembler
=20
-config AS_VAES
-	def_bool $(as-instr,vaesenc %ymm0$(comma)%ymm1$(comma)%ymm2)
-	help
-	  Supported by binutils >=3D 2.30 and LLVM integrated assembler
-
 config AS_VPCLMULQDQ
 	def_bool $(as-instr,vpclmulqdq \$0x10$(comma)%ymm0$(comma)%ymm1$(comma)%ymm=
2)
 	help
diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index d402963..50f1c04 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -47,7 +47,7 @@ aesni-intel-y :=3D aesni-intel_asm.o aesni-intel_glue.o
 aesni-intel-$(CONFIG_64BIT) +=3D aes-ctr-avx-x86_64.o \
 			       aes-gcm-aesni-x86_64.o \
 			       aes-xts-avx-x86_64.o
-ifeq ($(CONFIG_AS_VAES)$(CONFIG_AS_VPCLMULQDQ),yy)
+ifeq ($(CONFIG_AS_VPCLMULQDQ),y)
 aesni-intel-$(CONFIG_64BIT) +=3D aes-gcm-avx10-x86_64.o
 endif
=20
diff --git a/arch/x86/crypto/aes-ctr-avx-x86_64.S b/arch/x86/crypto/aes-ctr-a=
vx-x86_64.S
index bbbfd80..ec957b2 100644
--- a/arch/x86/crypto/aes-ctr-avx-x86_64.S
+++ b/arch/x86/crypto/aes-ctr-avx-x86_64.S
@@ -552,7 +552,7 @@ SYM_TYPED_FUNC_START(aes_xctr_crypt_aesni_avx)
 	_aes_ctr_crypt	1
 SYM_FUNC_END(aes_xctr_crypt_aesni_avx)
=20
-#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+#if defined(CONFIG_AS_VPCLMULQDQ)
 .set	VL, 32
 .set	USE_AVX512, 0
 SYM_TYPED_FUNC_START(aes_ctr64_crypt_vaes_avx2)
@@ -570,4 +570,4 @@ SYM_FUNC_END(aes_ctr64_crypt_vaes_avx512)
 SYM_TYPED_FUNC_START(aes_xctr_crypt_vaes_avx512)
 	_aes_ctr_crypt	1
 SYM_FUNC_END(aes_xctr_crypt_vaes_avx512)
-#endif // CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ
+#endif // CONFIG_AS_VPCLMULQDQ
diff --git a/arch/x86/crypto/aes-xts-avx-x86_64.S b/arch/x86/crypto/aes-xts-a=
vx-x86_64.S
index db79cdf..e44e568 100644
--- a/arch/x86/crypto/aes-xts-avx-x86_64.S
+++ b/arch/x86/crypto/aes-xts-avx-x86_64.S
@@ -886,7 +886,7 @@ SYM_TYPED_FUNC_START(aes_xts_decrypt_aesni_avx)
 	_aes_xts_crypt	0
 SYM_FUNC_END(aes_xts_decrypt_aesni_avx)
=20
-#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+#if defined(CONFIG_AS_VPCLMULQDQ)
 .set	VL, 32
 .set	USE_AVX512, 0
 SYM_TYPED_FUNC_START(aes_xts_encrypt_vaes_avx2)
@@ -904,4 +904,4 @@ SYM_FUNC_END(aes_xts_encrypt_vaes_avx512)
 SYM_TYPED_FUNC_START(aes_xts_decrypt_vaes_avx512)
 	_aes_xts_crypt	0
 SYM_FUNC_END(aes_xts_decrypt_vaes_avx512)
-#endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
+#endif /* CONFIG_AS_VPCLMULQDQ */
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel=
_glue.c
index 061b1ce..d5a2f5b 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -828,7 +828,7 @@ static struct skcipher_alg skcipher_algs_##suffix[] =3D {=
{		       \
 }}
=20
 DEFINE_AVX_SKCIPHER_ALGS(aesni_avx, "aesni-avx", 500);
-#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+#if defined(CONFIG_AS_VPCLMULQDQ)
 DEFINE_AVX_SKCIPHER_ALGS(vaes_avx2, "vaes-avx2", 600);
 DEFINE_AVX_SKCIPHER_ALGS(vaes_avx512, "vaes-avx512", 800);
 #endif
@@ -912,7 +912,7 @@ struct aes_gcm_key_avx10 {
 #define FLAG_RFC4106	BIT(0)
 #define FLAG_ENC	BIT(1)
 #define FLAG_AVX	BIT(2)
-#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+#if defined(CONFIG_AS_VPCLMULQDQ)
 #  define FLAG_AVX10_256	BIT(3)
 #  define FLAG_AVX10_512	BIT(4)
 #else
@@ -1519,7 +1519,7 @@ DEFINE_GCM_ALGS(aesni_avx, FLAG_AVX,
 		"generic-gcm-aesni-avx", "rfc4106-gcm-aesni-avx",
 		AES_GCM_KEY_AESNI_SIZE, 500);
=20
-#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+#if defined(CONFIG_AS_VPCLMULQDQ)
 /* aes_gcm_algs_vaes_avx10_256 */
 DEFINE_GCM_ALGS(vaes_avx10_256, FLAG_AVX10_256,
 		"generic-gcm-vaes-avx10_256", "rfc4106-gcm-vaes-avx10_256",
@@ -1529,7 +1529,7 @@ DEFINE_GCM_ALGS(vaes_avx10_256, FLAG_AVX10_256,
 DEFINE_GCM_ALGS(vaes_avx10_512, FLAG_AVX10_512,
 		"generic-gcm-vaes-avx10_512", "rfc4106-gcm-vaes-avx10_512",
 		AES_GCM_KEY_AVX10_SIZE, 800);
-#endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
+#endif /* CONFIG_AS_VPCLMULQDQ */
=20
 static int __init register_avx_algs(void)
 {
@@ -1551,7 +1551,7 @@ static int __init register_avx_algs(void)
 	 * Similarly, the assembler support was added at about the same time.
 	 * For simplicity, just always check for VAES and VPCLMULQDQ together.
 	 */
-#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+#if defined(CONFIG_AS_VPCLMULQDQ)
 	if (!boot_cpu_has(X86_FEATURE_AVX2) ||
 	    !boot_cpu_has(X86_FEATURE_VAES) ||
 	    !boot_cpu_has(X86_FEATURE_VPCLMULQDQ) ||
@@ -1592,7 +1592,7 @@ static int __init register_avx_algs(void)
 				    ARRAY_SIZE(aes_gcm_algs_vaes_avx10_512));
 	if (err)
 		return err;
-#endif /* CONFIG_AS_VAES && CONFIG_AS_VPCLMULQDQ */
+#endif /* CONFIG_AS_VPCLMULQDQ */
 	return 0;
 }
=20
@@ -1607,7 +1607,7 @@ static void unregister_avx_algs(void)
 {
 	unregister_skciphers(skcipher_algs_aesni_avx);
 	unregister_aeads(aes_gcm_algs_aesni_avx);
-#if defined(CONFIG_AS_VAES) && defined(CONFIG_AS_VPCLMULQDQ)
+#if defined(CONFIG_AS_VPCLMULQDQ)
 	unregister_skciphers(skcipher_algs_vaes_avx2);
 	unregister_skciphers(skcipher_algs_vaes_avx512);
 	unregister_aeads(aes_gcm_algs_vaes_avx10_256);

