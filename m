Return-Path: <linux-tip-commits+bounces-7122-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73083C27E4A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 13:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B55344E05B9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 12:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D7526ED45;
	Sat,  1 Nov 2025 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="XrraMPtP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55C54763;
	Sat,  1 Nov 2025 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762001099; cv=none; b=cbAxxHYeEnrYPQojQ57jvtQuAzVvFQulZaWLc/Ja4y3/EGohLJNlIdcbsc/8Y56pbZHgATCFuLygPcJb02VQ041KGVLdS560ubjL6CTrOwpaxYsv714amS9HvyKdLb1CZvk2YKjgA5wJK8evpbL1S18qjloOzYT/eIthGWtywxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762001099; c=relaxed/simple;
	bh=nFl4NJ6phhRXj1GOmZxAmKelEwgrnNQgsWxQ8GmlmXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntlv+btFZpX6nCpyCnficQrznOq5PS7DECyDTqIpUyOe5wyOFCph55NITTjMY1WytuIhM9WNeGLN9YUN7FOUiPQ/wSSF7CnsYf9+HpbGyJjaw52TV6PMbW8wZR3H9ozmkW5wTSKKXay6tt6YRMp9xtWPNZMRSHLIRQLTTY1M0hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=XrraMPtP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 355C540E0200;
	Sat,  1 Nov 2025 12:44:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DrM_EKOnMZ_3; Sat,  1 Nov 2025 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762001088; bh=N4BOLLoJpHCqamHMqtxMixX7XoGo/cMXwO0xAm9y68w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XrraMPtPqsH9UjOKErD4x6QZWo8r5bvm8ascTfwRLY1jE0D/mdXOkRuudd5w8fBjk
	 pvHJeLvmhnVoVUccyxbspFrSc7u/+t11wKw/bNDTASO30p+WuPEOzw9FT8eY+JYjmv
	 54zzAxGObD4m0/PS1w+M2xXBGUaiOQT74EAvIeggHmbFuN1l286W5tQZYdbXc02jj5
	 PpJLPkkVqjc14qgGhRh3Um4FHzJiflEpinwoRVmmnlskK4E+my26oFoyhMTAfpaCLj
	 EmlRZVPrwEsf2bwOXRxPHPKd9zoABA0N9dknj+9eO4ilcIdOWad44x0283n7DlGGJI
	 QeT0LICPC+qVsIqqXLcG0cR5fuzEWpQrb8H2G/XKiTU7xOxVuUhoL+i+1kS/S9wIEb
	 frqi5ovdiKYD3A1CJWuy8tAU7y6FuZuSb9hv54+K1d2i/PXhIDE7awIdM46COEoX6T
	 KK5zkVzKo25ETjIrLf71wWXcfwEAvrKqnY4gpciHvkv6VliQliDVYBvjyAMLzD9Kkk
	 gfP8q/Y/dtwZ6FGVQ7CKIG7Fjs5Ae7bKr5S8+l4Kmx5Rlxk3xqtCLvL9FcQSbVvygO
	 ncvPVakmHck+74BhJu7wd9GPR0+uygI2fC30LIpDaKkKaeXIU0KlGLfJEbPKR81pH6
	 u5gyi2ouXkFH2KU5PdKUeeuQ=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id EF1E440E015B;
	Sat,  1 Nov 2025 12:44:40 +0000 (UTC)
Date: Sat, 1 Nov 2025 13:44:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
	Joe Lawrence <joe.lawrence@redhat.com>, x86@kernel.org
Subject: [PATCH] tools/objtool: Copy the __cleanup unused variable fix for
 older clang
Message-ID: <20251101124432.GBaQYAsK3mcvrB9cqm@fat_crate.local>
References: <176060833509.709179.4619457534479145477.tip-bot2@tip-bot2>
 <20251031114919.GBaQSiPxZrziOs3RCW@fat_crate.local>
 <20251031140944.GA3022331@ax162>
 <20251031142100.GEaQTFzKD-nV3kQkhj@fat_crate.local>
 <wi54qqmdbzuajt7f5krknhcibs7pj45zhf42n3z5nyqujoabgz@hbduuwymyufh>
 <20251031202526.GB2486902@ax162>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251031202526.GB2486902@ax162>

From: "Borislav Petkov (AMD)" <bp@alien8.de>
Date: Sat, 1 Nov 2025 13:37:51 +0100

Copy from

  54da6a092431 ("locking: Introduce __cleanup() based infrastructure")

the bits which mark the variable with a cleanup attribute unused so that my
clang 15 can dispose of it properly instead of warning that it is unused which
then fails the build due to -Werror.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20251031114919.GBaQSiPxZrziOs3RCW@fat_crate.local
---
 tools/objtool/include/objtool/warn.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index e88322d97573..a1e3927d8e7c 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -107,6 +107,15 @@ extern int indent;
 
 static inline void unindent(int *unused) { indent--; }
 
+/*
+ * Clang prior to 17 is being silly and considers many __cleanup() variables
+ * as unused (because they are, their sole purpose is to go out of scope).
+ *
+ * https://github.com/llvm/llvm-project/commit/877210faa447f4cc7db87812f8ed80e398fedd61
+ */
+#undef __cleanup
+#define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
+
 #define __dbg(format, ...)						\
 	fprintf(stderr,							\
 		"DEBUG: %s%s" format "\n",				\
@@ -127,7 +136,7 @@ static inline void unindent(int *unused) { indent--; }
 })
 
 #define dbg_indent(args...)						\
-	int __attribute__((cleanup(unindent))) __dummy_##__COUNTER__;	\
+	int __cleanup(unindent) __dummy_##__COUNTER__;			\
 	__dbg_indent(args);						\
 	indent++
 
-- 
2.51.0


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

