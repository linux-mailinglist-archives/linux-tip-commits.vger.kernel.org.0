Return-Path: <linux-tip-commits+bounces-7400-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE7AC6B716
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 20:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 864C72C0F6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93892EFDA4;
	Tue, 18 Nov 2025 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GCEKrafo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fJj2uPgy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A62EBDD6;
	Tue, 18 Nov 2025 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494125; cv=none; b=jvFTdh3FtxeIM33mWsXNOkqQkLpFqpL+an6cJ1PNvmxQXVL++dKreGoZM5s1sCjxXNoIaH99yY77IvNGxMdls49VAES3dlvJDFtrVQUoeYpaeJ5dOplrLrEEZz8EmnFtZ+No2jKQB1rj4nOou8DhdaRHF4uoOz8G1HzZG+ZAAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494125; c=relaxed/simple;
	bh=phiJQKHu4wGaAK5hPHJbf1CGT9I+ZRW9YzIu9w7IIgQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=COU7QsvQvF4L1eZYf+UHEuM3nI47Pjq55gxoKkY9/K2CAA0jcpIlUAJj3cGds5JmEUlflBOIthTzzGCpJdA5j8XgMOtubCpaPKgE+DbMwdGuSpzLAtjKCIt+bfN2FeyQgNm47lE+i9M0DMMDqOiDWInXCAlPWEIle/RqTx11J4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GCEKrafo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fJj2uPgy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 19:28:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763494122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jBzFOuz+sWlMZoXDWQHxFx0t/fw72wbNSFLTPeTIYWE=;
	b=GCEKrafoLGD99lh3tHtpxgmXkWo9MRnloFnWT7so1wNXTfYU1dCfP6BsgaxQXRHo/Pbk3j
	icMc2fd+YMljGqgySdaLj2pRDE7gq3y5EPewhojZuYyvPyRNc0+efwxRFEPuI6WKm2vFcw
	luxu3kJeDs4YBWOIOiD3SDgSUy0Re/qgwCXvNqhQDA0QhbMuR7xQDCJQ7KkhfbKCqeFZQP
	kLvjd+VxcRJNEL6OwDQQu3OgKDCqioHy9vpWWjlx1t6mx5qMIIvxi+mgZwWH21ezwUrOnx
	TuVk9dQBG7s5Q35UToScQWaUCcXcIp68VFptQfxJvemc7ODSgCCXM3jDPBxnPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763494122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jBzFOuz+sWlMZoXDWQHxFx0t/fw72wbNSFLTPeTIYWE=;
	b=fJj2uPgyHeXPf/Lo5mBM5hLnNNYZ9Fxv7LU/H0FNgWjVv/Y/cFA27GiZAszlqrkTpBgrut
	TxZWXiTah65GUZAQ==
From: "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/asm: Introduce inline memcpy and memset
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176349412131.498.8740854149108904471.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d9a96cc18bec65c39822ee0a1672d7dc3fda150a
Gitweb:        https://git.kernel.org/tip/d9a96cc18bec65c39822ee0a1672d7dc3fd=
a150a
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Tue, 18 Nov 2025 10:29:05 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 18 Nov 2025 10:38:26 -08:00

x86/asm: Introduce inline memcpy and memset

Provide inline memcpy and memset functions that can be used instead of
the GCC builtins when necessary. The immediate use case is for the text
poking functions to avoid the standard memcpy()/memset() calls because
objtool complains about such dynamic calls within an AC=3D1 region. See
tools/objtool/Documentation/objtool.txt, warning #9, regarding function
calls with UACCESS enabled.

Some user copy functions such as copy_user_generic() and __clear_user()
have similar rep_{movs,stos} usages. But, those are highly specialized
and hard to combine or reuse for other things. Define these new helpers
for all other usages that need a completely unoptimized, strictly inline
version of memcpy() or memset().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251118182911.2983253-4-sohil.mehta%40intel.c=
om
---
 arch/x86/include/asm/string.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/include/asm/string.h b/arch/x86/include/asm/string.h
index c3c2c19..9cb5aae 100644
--- a/arch/x86/include/asm/string.h
+++ b/arch/x86/include/asm/string.h
@@ -1,6 +1,32 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_STRING_H
+#define _ASM_X86_STRING_H
+
 #ifdef CONFIG_X86_32
 # include <asm/string_32.h>
 #else
 # include <asm/string_64.h>
 #endif
+
+static __always_inline void *__inline_memcpy(void *to, const void *from, siz=
e_t len)
+{
+	void *ret =3D to;
+
+	asm volatile("rep movsb"
+		     : "+D" (to), "+S" (from), "+c" (len)
+		     : : "memory");
+	return ret;
+}
+
+static __always_inline void *__inline_memset(void *s, int v, size_t n)
+{
+	void *ret =3D s;
+
+	asm volatile("rep stosb"
+		     : "+D" (s), "+c" (n)
+		     : "a" ((uint8_t)v)
+		     : "memory");
+	return ret;
+}
+
+#endif /* _ASM_X86_STRING_H */

