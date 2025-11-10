Return-Path: <linux-tip-commits+bounces-7280-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F9AC46789
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Nov 2025 13:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D7DFC348302
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Nov 2025 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A33630DEAD;
	Mon, 10 Nov 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4LWOVlt2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gOj+opjC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524662F690D;
	Mon, 10 Nov 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776550; cv=none; b=PocJ/EaXRP4zVbJMsSjh4Opl1NgQHyznpMxEpqWFqcyGIoMqclojJPZOauBlYK6aisSt6N6WvMgaoFJA7i5oYQrZBTRKOtmCgrFDjdE0he8Q+NFMw+nCiWY7Eq9cFTPwGDzUpLqDUyusvXfhjDx4Venh1h6nrClvNFfXJ9/sIZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776550; c=relaxed/simple;
	bh=lJKQuFJah+EsG+CPkoV2em+UfrxxkEmfjIlSEWygWOc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=DHA/ZpNNZlVTuw8/uYd3TzOyIum2r+uWnpXTywYYH55/4clmMJSds9YmgPZLLxJ+4R5Tf6DgugyAtl903HNf4G7GJZm3/4Xryev5aeFUjTdRO9vlxdMAUt/aVThrXp7EkYj6ff0qZHNXyfdj2DSxpqRC8+yyAM4MtASNfu64N1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4LWOVlt2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gOj+opjC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Nov 2025 12:09:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762776541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kKZAlCkPZ4+k5uew767/LTIzgtO1fCFu3Y5ZfWvnKWU=;
	b=4LWOVlt2s39iJtxdFWQvd+zwT+VGzbQybshRRzliY3xfvO7xnhBQlz+KiQQdGaojVlFOYo
	3AJAYhC1Ctmp7SUYoTJWv+Z7ks+sKtomK5JsGfuht8z+VowHTGb0HO/kD2MPUK/JkO+d6E
	4lX3kRJzdgKQ1n5CrY5BZI/eQTdOyNG+XlYTZ7E8hU61C579klDHsgcYTBSwfYfrJuO7SU
	8nCaPj0g2gLMnTCHhX8s/RfdGkdTouNHZgS7gPcIBJbipFmHvR0ccierzEjzAvlx39jN/9
	fEernGqvYCg+Nh9pTWEFCXaqaxCf2MHj3gzUljXxSMMEpFLqGfY4zCHyJ6V1Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762776541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=kKZAlCkPZ4+k5uew767/LTIzgtO1fCFu3Y5ZfWvnKWU=;
	b=gOj+opjC3BS1E0Yy5uvmueXnVvjiVYp2nm4xcrcFcQkfOYqt1C8Gcz4DU3HwW7t3pSGPzE
	Bkt/7sp4+RSMjWDA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] tools/objtool: Copy the __cleanup unused variable
 fix for older clang
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176277654045.498.2136004615232510398.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     249092174caa3fe9fb8f7914991a8c0de484bcf8
Gitweb:        https://git.kernel.org/tip/249092174caa3fe9fb8f7914991a8c0de48=
4bcf8
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Sat, 01 Nov 2025 13:37:51 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 10 Nov 2025 12:46:08 +01:00

tools/objtool: Copy the __cleanup unused variable fix for older clang

Copy from

  54da6a092431 ("locking: Introduce __cleanup() based infrastructure")

the bits which mark the variable with a cleanup attribute unused so that my
clang 15 can dispose of it properly instead of warning that it is unused which
then fails the build due to -Werror.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/r/20251031114919.GBaQSiPxZrziOs3RCW@fat_crate.l=
ocal
---
 tools/objtool/include/objtool/warn.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/obj=
tool/warn.h
index e88322d..a1e3927 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -107,6 +107,15 @@ extern int indent;
=20
 static inline void unindent(int *unused) { indent--; }
=20
+/*
+ * Clang prior to 17 is being silly and considers many __cleanup() variables
+ * as unused (because they are, their sole purpose is to go out of scope).
+ *
+ * https://github.com/llvm/llvm-project/commit/877210faa447f4cc7db87812f8ed8=
0e398fedd61
+ */
+#undef __cleanup
+#define __cleanup(func) __maybe_unused __attribute__((__cleanup__(func)))
+
 #define __dbg(format, ...)						\
 	fprintf(stderr,							\
 		"DEBUG: %s%s" format "\n",				\
@@ -127,7 +136,7 @@ static inline void unindent(int *unused) { indent--; }
 })
=20
 #define dbg_indent(args...)						\
-	int __attribute__((cleanup(unindent))) __dummy_##__COUNTER__;	\
+	int __cleanup(unindent) __dummy_##__COUNTER__;			\
 	__dbg_indent(args);						\
 	indent++
=20

